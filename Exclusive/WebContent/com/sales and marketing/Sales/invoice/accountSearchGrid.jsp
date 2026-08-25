<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();%>
<script type="text/javascript">
 	var uomrow='<%=request.getParameter("rowno") %>';
     var accsearch= '<%=DAO.searchAccount(session) %>';
		$(document).ready(function () { 	
            
			var source =
            {
                datatype: "json",  
                datafields: [
                             {name : 'acno', type: 'string'  },
                             {name : 'account', type: 'string'  },
                             {name : 'acc', type: 'string'  },
                             {name : 'description', type: 'string'  },
                             
                            ],
                       localdata: accsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#accsearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
									{ text: 'Account Number', datafield: 'acc', width: '40%'},
									{ text: 'Account Name', datafield: 'account', width: '60%' },
									{ text: 'Account docno', datafield: 'acno', width: '60%',hidden:true },
									{ text: 'description', datafield: 'description', width: '60%',hidden:true },
									
									
									
						]
            });
            
             
          $('#accsearch').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                $('#jqxserviceGrid').jqxGrid('setcellvalue', uomrow, 'acno',$('#accsearch').jqxGrid('getcellvalue', rowindex1, "acno"));
                $('#jqxserviceGrid').jqxGrid('setcellvalue', uomrow, 'account',$('#accsearch').jqxGrid('getcellvalue', rowindex1, "account"));
                
                $('#jqxserviceGrid').jqxGrid('setcellvalue', uomrow, 'description',$('#accsearch').jqxGrid('getcellvalue', rowindex1, "description"));
                
                
                
                
              $('#accountsearchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="accsearch"></div> 