 
<%@page import="com.finance.transactions.multiplecashpurchase.ClsmultipleCashPurchaseDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%
 ClsmultipleCashPurchaseDAO DAO= new ClsmultipleCashPurchaseDAO();
  int rowindex =request.getParameter("rowindex")==null?0:Integer.parseInt(request.getParameter("rowindex").trim());
 String type =request.getParameter("tax")==null?"0":request.getParameter("tax");

%>

 <script type="text/javascript">
 
 var cadata;
  var rowindex = '<%=rowindex%>';
  var type = '<%=type%>';
  
  cadata='<%=DAO.vendorSearch(session) %>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'vendorid', type: 'String'  },
     						{name : 'vendor', type: 'String'  },
     						{name : 'tax', type: 'String'  },
     						{name : 'tinno', type: 'String'  },
     						{name : 'invno', type: 'String'  },
     						{name : 'invdate', type: 'String'  },
     						
     						
     						
     						
     						
                          	],
                          	localdata: cadata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxvendorSearch").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            	showfilterrow:true,
            	filterable:true,
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DocNo', datafield: 'vendorid', width: '16%' },
					{ text: 'Vendor Name', datafield: 'vendor', width: '78%' },
					{ text: 'tax', datafield: 'tax', width: '78%', hidden:true },
					{ text: 'tinno', datafield: 'tinno', width: '78%' },
					{ text: 'invno', datafield: 'invno', width: '78%', hidden:true },
					{ text: 'invdate', datafield: 'invdate',width: '78%', hidden:true },
					//{ text: 'dtype', datafield: 'dtype',width: '78%', hidden:true },
				
					
					]
            });
    
         		            
				           $('#jqxvendorSearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex2=event.args.rowindex;
				            	  
				                var tax=$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "tax");
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "vendor",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "vendor"));
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "vendorid",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "vendorid"));
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "tax",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "tinno",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "tinno"));
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "invno",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "invno"));
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "invdate",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "invdate"));
				                    //$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "dtype",$('#jqxvendorSearch').jqxGrid('getcellvalue', rowindex2, "dtype"));
				                
				                if(tax=="1"){
				               var taxamt=5;
				                	$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "srvtaxper",taxamt);
				                	 document.getElementById("taxchk").value=1;
				                }
				                
				               
						      
				                $('#vendorinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxvendorSearch"></div>
    
    </body>
</html>