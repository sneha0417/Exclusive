<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 

 



%>

<script type="text/javascript">


var nipurorder;
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   }
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
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '80%' },
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
               document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
           
                document.getElementById("puraccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("puraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");

              $('#accountSearchwindow').jqxWindow('close');  
            
            }); 
             
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 