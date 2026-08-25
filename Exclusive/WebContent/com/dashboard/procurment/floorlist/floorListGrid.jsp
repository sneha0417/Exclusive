<%@page import="com.dashboard.procurment.floorlist.ClsFloorList"%>
<%
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
%>
<%ClsFloorList DAO= new ClsFloorList(); %>
<script type="text/javascript">
 
 var chk='<%=chk%>';
 
 	var data;
 	if(chk=="load")
	{
      data='<%=DAO.floorList(chk)%>'; 
 	  floorexceldata='<%=DAO.floorListExcelExport(chk)%>'; 
	}
        $(document).ready(function () { 
        	
            var source = 
            {
                datatype: "json",
                datafields: [
	     						{ name : 'flcode', type: 'String' },
	     						{ name : 'flname', type: 'String'  },
	     						{ name : 'rackcode', type: 'String'  }, 
	     						{ name : 'rackname', type: 'String'  },
	     						{ name : 'bincode', type: 'String'  },
	     						{ name : 'binname', type: 'String'  } 
                          	],
                          	localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#floorlist").jqxGrid(
            {
            	 width: '100%',
 				 height: 500,
                 source: dataAdapter,
                 groupable: true,
                 sortable:true,
                 selectionmode: 'singlecell',
                 groups: ['flcode','rackcode','bincode'],
     					
                columns: [
					
					    { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                          groupable: false, draggable: false, resizable: false,datafield: '',
                          columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                          cellsrenderer: function (row, column, value) {
                        	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                          }  
						 },
					     { text: 'Floor Code', groupable: true,datafield: 'flcode', width: '10%' },    
					     { text: 'Floor Name ',groupable: false, datafield: 'flname', width: '22%' }, 
					     { text: 'Rack Code',groupable: true, datafield: 'rackcode', width: '10%' }, 
					     { text: 'Rack Name',groupable: false, datafield: 'rackname', width: '22%' }, 
					     { text: 'Bin Code', groupable: true,datafield: 'bincode', width: '10%' },
						 { text: 'Bin Name',groupable: true, datafield: 'binname', width: '22%' },
					],
					 groupsrenderer: function (defaultText, group, state, params) {
							return false;
						}
            });
    
            $("#overlay, #PleaseWait").hide();
				           
}); 
                       
</script>
<div id="floorlist"></div>