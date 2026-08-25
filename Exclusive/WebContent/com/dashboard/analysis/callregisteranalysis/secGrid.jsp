
 <%@ page import="com.dashboard.analysis.callregisteranalysis.ClscallregisterAnalysisDAO" %>
 
 <%
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	
  	ClscallregisterAnalysisDAO cab=new ClscallregisterAnalysisDAO();
  	
 %> 
 <% String repeat =request.getParameter("repeated")==null?"0":request.getParameter("repeated").toString();%>
    <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String type =request.getParameter("type")==null?"0":request.getParameter("type").toString();%>
 <% String summtype =request.getParameter("summtype")==null?"0":request.getParameter("summtype").toString();%>
 <% String vehno =request.getParameter("vehno")==null?"0":request.getParameter("vehno").toString();%>
         	  
 
<script type="text/javascript">
<%--  var temp4='<%=barchval%>'; --%>
var data,exceldata;
var summtype='<%=summtype%>'
	 data='<%=cab.sumtypeload(barchval,fromdate,todate,clientid,vehno,type,repeat,summtype)%>'; 
<%-- 	 exceldata='<%=cab.sumgridloadexcel(barchval,fromdate,todate,clientid,vehno,type,repeat)%>'; --%>
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
							{name : 'client', type: 'String'  },
							{name : 'type', type: 'String' },
							{name : 'tottime', type: 'String' },
							{name : 'count', type: 'String' },
							{name : 'overdue', type: 'String' },
     						
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
            $("#secGrid").jqxGrid(
            {
            	width: '98%',
                height: 500,
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
					{ text: 'CLIENT', datafield: 'client', width: '30%' },
					{ text: 'TYPE', datafield: 'type', width: '30%' },
					{ text: 'COUNT', datafield: 'count', width: '21%' },
					{ text: 'TOTAL TIME TAKEN',  datafield: 'tottime', width: '25%' },
					{ text: 'OVER DUE HRS',  datafield: 'overdue', width: '20%' },
	              ]
            });

                 
            $("#overlay, #PleaseWait").hide();
           funsumm();
           
           $('#secGrid').on('rowdoubleclick', function(event) 
            		{
           	 //$('#followUpwindow').jqxWindow('open');
            	var rowBoundIndex1 = event.args.rowindex;    
            	var datafield = event.args.datafield;
            	var client=$('#secGrid').jqxGrid('getcellvalue', rowBoundIndex1, 'client');
                var type=$('#secGrid').jqxGrid('getcellvalue', rowBoundIndex1, 'type');
                if(summtype=='type')
                {
                	gettypedetails(type);
                    
                }
                else{
                	getclientdetails(client);
                    	
                }
                
                
                           
       });   
           
        });
    </script>
    <div id="secGrid"></div>
