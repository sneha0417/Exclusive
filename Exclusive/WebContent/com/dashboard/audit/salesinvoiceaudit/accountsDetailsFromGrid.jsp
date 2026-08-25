 <%@page import="com.dashboard.audit.salesinvoiceaudit.ClsSalesInvoiceAuditDAO"%>
 <% ClsSalesInvoiceAuditDAO searchDAO = new ClsSalesInvoiceAuditDAO(); 
 
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String masterdate = request.getParameter("masterdate")==null?"0":request.getParameter("masterdate");

 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

<script type="text/javascript">
        
        

   var data2= '<%=searchDAO.accountsDetailsFrom(masterdate,accountno,accountname,mob,check) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'curid', type: 'int'  },
     						{name : 'currency', type: 'string'  },
     						{name : 'rate', type: 'number'  },
     						{name : 'mobile', type: 'number'  },
     						
     						
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '55%' },
							{ text: 'MOB', datafield: 'mobile', width: '25%' },
							
							{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%', hidden : true},
							{ text: 'Currency', datafield: 'currency', width: '15%', hidden : true },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%', hidden : true  },
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
             
                document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
                 document.getElementById("account").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
             	document.getElementById("accname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
              $('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 