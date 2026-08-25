<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<script type="text/javascript">
   
        var data= '<%=DAO.masterSearch(session)%>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'  },
     						{name : 'description', type: 'string'   },
     						{name : 'flag', type: 'int'   }
                        ],
                		  localdata: data, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
                if (data.flag == 1) {
                    return "redClass";
                };
            }; 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDashBoardMaster").jqxGrid(
            {
                width: '95%',
                height: 489,
                source: dataAdapter,
                selectionmode: 'singlecell',
                       
                columns: [
                          { text: '', sortable: false, filterable: false, editable: false,
                            groupable: false, draggable: false, resizable: false,datafield: '',
                            columntype: 'number', width: '5%',cellclassname: cellclassname ,cellsalign: 'center', align: 'center',
                            cellsrenderer: function (row, column, value) {
  	                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }  
	                       },
							{ text: 'Doc No', hidden:true, datafield: 'doc_no', cellclassname: cellclassname , width: '5%' },
							{ text: 'Description', datafield: 'description', cellclassname: cellclassname , width: '90%' },
							{ text: 'Flag', datafield: 'flag', hidden:true, cellclassname: cellclassname , width: '10%' },
						]
            });
            
            
            $('#jqxDashBoardMaster').on('celldoubleclick', function (event) {
            	if(event.args.columnindex == 2)
      		    { 
      		    var rowindextemp = event.args.rowindex;
      		
      	        var indexVal = $('#jqxDashBoardMaster').jqxGrid('getcellvalue', rowindextemp, "doc_no");  
				var indexDesc = $('#jqxDashBoardMaster').jqxGrid('getcellvalue', rowindextemp, "description");  
				
				var index="aaa mmm";
				var aa=index.replace(/ /g, "%20");
				$("#dashboardGridDetail1").load("dashboardGridDetails.jsp?txtdetail1="+indexVal+"&indexDesc="+indexDesc.replace(/ /g, "%20"));
      		  } 
            }); 
            
            
        });
    </script>
    <div id="jqxDashBoardMaster"></div>