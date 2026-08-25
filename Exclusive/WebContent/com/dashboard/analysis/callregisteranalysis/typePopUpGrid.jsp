
 <%@ page import="com.dashboard.analysis.callregisteranalysis.ClscallregisterAnalysisDAO" %>
 
 <%
   ClscallregisterAnalysisDAO cab=new ClscallregisterAnalysisDAO();
 %> 
 <% String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();%>
         	  
 
<script type="text/javascript">
<%--  var temp4='<%=barchval%>'; --%>
var data,exceldata;

	 data='<%=cab.typegridload(type)%>'; 
$(document).ready(function () { 	
            
             var num = 0; 
             
             
             var cellclassname = function (row, column, value, data) {
         		/* if (data.qty==0) {
         			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                     return "redClass";
                 }
         		else{
         			//document.getElementById("errormsg").innetText="";
         		} */
         		};
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'number'  },
							{name : 'callby', type: 'String' },
							{name : 'client', type: 'String' },
							{name : 'date', type: 'date' },
							{name : 'mob', type: 'String' },
     						{name : 'remarks', type: 'String' },
     						
                 ],
                 localdata: data,
                
                
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
            $("#typepopupGrid").jqxGrid(
            {
            	width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [ 
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'DOCNO', datafield: 'doc_no', width: '10%' },
					{ text: 'DATE', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'CLIENT',  datafield: 'client', width: '20%' },
					{ text: 'CALLED BY',  datafield: 'callby', width: '20%' },
					{ text: 'MOBILE',  datafield: 'mob', width: '16%' },
					{ text: 'REMARKS',  datafield: 'remarks', width: '20%' },
	              ]
            });


                 
                //$('#typewindow').jqxWindow('close');
                                   
//              });
        });
    </script>
    <div id="typepopupGrid"></div>
