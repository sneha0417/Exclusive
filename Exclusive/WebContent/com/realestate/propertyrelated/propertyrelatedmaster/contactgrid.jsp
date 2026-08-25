 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO(); 


String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

%>
 
<script type="text/javascript">
   var data1 = '<%=DAO.maingridreload(docno) %>';   
       $(document).ready(function () { 	
       
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'name' , type: 'string' },
     						{name : 'mob', type: 'number'  },
     						{name : 'remarks', type:  'string'}
                          	
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#contactgrids").jqxGrid(
            {
                width: '100%',
                height: 100,
                source: dataAdapter,
                columnsresize: true,
                disabled:true,  //pageable: true,
              
                selectionmode: 'singlecell',
                //pagermode: 'default',
               
                editable: true,
                //Add row method
                columns: [
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
					{ text: 'Name' , datafield: 'name', width: '40%' }, 
					{ text: 'MOB'   , datafield: 'mob', width: '25%' },
					{ text: 'Remarks',datafield: 'remarks',width:'30%'}
	              ]
            });
            $("#contactgrids").jqxGrid('addrow', null, {});
 		if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    			
    			$("#contactgrids").jqxGrid({ disabled: false});
    			
    		}
         
            $("#contactgrids").on('cellvaluechanged', function (event) {   
            var rows = $('#contactgrids').jqxGrid('getrows');
            var rowlength= rows.length;
            var rowindex1=event.args.rowindex;
            
            if(rowindex1 == rowlength - 1)
            	{  
            $("#contactgrids").jqxGrid('addrow', null, {});
            	} 
            });
            
        });
    </script>
    <div id="contactgrids"></div>
