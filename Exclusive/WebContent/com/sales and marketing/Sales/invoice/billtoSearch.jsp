 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();%>
<script type="text/javascript">

     var billto1= '<%=DAO.searchbillto(session) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",   	
                datafields: [
                              
                              {name : 'billto', type: 'string'  },
                              {name : 'trnno', type: 'string'  },
                              
                            ],
                       localdata: billto1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#biltosearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',  
                       
                columns: [
                              
                              { text: 'Bill To', datafield: 'billto', width: '60%' },
                              { text: 'TRN NO', datafield: 'trnno', width: '40%' },
                              
						]
            });
            
             
          $('#biltosearch').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
          
                document.getElementById("billto").value=$('#biltosearch').jqxGrid('getcellvalue', rowindex1, "billto");
                document.getElementById("btrno").value=$('#biltosearch').jqxGrid('getcellvalue', rowindex1, "trnno");
                
              $('#billtowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="biltosearch"></div> 