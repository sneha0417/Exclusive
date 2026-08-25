<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <%@page import="com.dashboard.projectexecution.procurementfollowupnew.ClsProcurementFollowupnewDAO"%>
<%
ClsProcurementFollowupnewDAO sd=new ClsProcurementFollowupnewDAO();
%>
<%
String rowindex = request.getParameter("rowindex")==null?"0":request.getParameter("rowindex");
String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno");
 
%>
 <style type="text/css">
  .a0Class {background-color: #D5F5E3;}
  .a1Class {background-color: #FAE5D3;}
  .a2Class {background-color: #D6EAF8;}
  .a3Class {background-color: #E8DAEF;}
  .a4Class {background-color: #FADBD8;}
   
</style>
<script type="text/javascript">
 
var rowindex2='<%=rowindex%>';
     var datapurchase= '<%=sd.lastpurchaseSearch(session,psrno) %>';
     
    
		$(document).ready(function () { 	
			
 
           
			var source =
            {
                datatype: "json",  
                datafields: [
                             {name : 'date', type: 'date'  },
                             {name : 'account', type: 'string'  },
                             {name : 'description', type: 'string'  },  
                             {name : 'qty', type: 'number'  },
                             {name : 'unitprice', type: 'number'  },
                             {name : 'netunitprice', type: 'number'  },
                              
                            ],
                       localdata: datapurchase,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
			
	         
	         var cellclassname =  function (row, column, value, data) {

 
	         		          	if(parseFloat(row)==0)	{ 	return "a0Class";	}
	         		         	if(parseFloat(row)==1)	{ 	return "a1Class";	}
	         		       		if(parseFloat(row)==2)	{ 	return "a2Class";	}
	         		       		if(parseFloat(row)==3)	{ 	return "a3Class";	}
         		         		if(parseFloat(row)==4)	{ 	return "a4Class";	}
         		       		 
 
	         		          
	         		            
	         		       	} 
	         		          
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxlastgrid").jqxGrid(
            {
                width: '100%',
                height:180,
                source: dataAdapter,
               
                selectionmode: 'singlerow',
                       
                columns: [
                          
                          
                   

                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',cellclassname: cellclassname  ,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                           
                      	     { text: 'Date', datafield: 'date', width: '10%' ,cellsformat:'dd.MM.yyyy',cellclassname: cellclassname  },
                              { text: 'Account', datafield: 'account', width: '12%',cellclassname: cellclassname  },
                              { text: 'Account Name', datafield: 'description' ,cellclassname: cellclassname  },
                              
                              
                          	{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left' ,cellsformat:'d2',cellclassname: cellclassname },
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname  },
							{ text: 'Net Unit Price', datafield: 'netunitprice', width: '15%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2',cellclassname: cellclassname  },
                              
                              
						]
            });
            
             
          $('#jqxlastgrid').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                  $('#procurementSubGrid').jqxGrid('setcellvalue', rowindex2, "amount" ,$('#jqxlastgrid').jqxGrid('getcellvalue', rowindex1, "unitprice"));
                
                
              $('#lastpurchasewindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxlastgrid"></div> 