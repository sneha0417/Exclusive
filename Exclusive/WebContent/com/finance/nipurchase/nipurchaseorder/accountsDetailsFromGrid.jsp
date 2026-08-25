<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>	
<% ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();%>

<script type="text/javascript">


	var nipurorder= '<%=viewDAO.accountsDetailsTo() %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'currency', type: 'string'  },
   						   	{name : 'mobile', type: 'string'  },
   						   	{name : 'curid', type: 'int'  },
   						   	{name : 'rate', type: 'string'  },
   						   	{name : 'type', type: 'string'  },
   						 {name : 'tax', type: 'string'  }
                        ],
                		localdata: nipurorder, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 359,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Account', datafield: 'account', width: '25%' },
							{ text: 'Account Name', datafield: 'description', width: '50%' },
							{ text: 'Currency', datafield: 'currency', width: '10%' },
							{ text: 'Mobile', datafield: 'mobile', width: '15%' },
							{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
							{ text: 'Rate', hidden: true, datafield: 'rate', width: '5%' },
							{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
							{ text: 'tax', datafield: 'tax', width: '5%' ,hidden:true},
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
               
                document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("puraccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("puraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
            	document.getElementById("cmbcurr").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
            	document.getElementById("currate").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate");
            	var tax=$('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "tax");
            	
            	if(parseInt(tax)>0)
            		{
            		document.getElementById("validates").value=1; 
   				 $('#txtproducttype').attr('readonly', true);
   				 
   				 
   				 $('#txtproducttype').attr('disabled', false);
            		
            		}
            	
            	else
            		{
            		document.getElementById("validates").value=0; 
            		 $('#txtproducttype').attr('readonly', true);
	   				 
	   				 
	   				 $('#txtproducttype').attr('disabled', true);
            		}
              $('#accountSearchwindow').jqxWindow('close');  
            
            }); 
             
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 