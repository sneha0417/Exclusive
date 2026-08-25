<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO accDAO = new ClsAllowancesDAO(); %> 

 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String formcode = request.getParameter("formcode")==null?"0":request.getParameter("formcode");
 
 
%> 

<script type="text/javascript">
        


   var data2= '<%=accDAO.accountsDetailsFrom(accountno,accountname,check) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						 
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
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '30%' },
							{ text: 'Account Name', datafield: 'description', width: '70%' },
							 
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
               
               var formcodes='<%=formcode%>'; 
                 
                if(formcodes=="ALC")
                	{
                
                document.getElementById("errormsg").innerText="";
                document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
                 document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
             	document.getElementById("accname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
                	}
                else if(formcodes=="STD")
                	{
                	  document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                      
                      document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
                  	document.getElementById("accname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
                	}
                
                
              $('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 