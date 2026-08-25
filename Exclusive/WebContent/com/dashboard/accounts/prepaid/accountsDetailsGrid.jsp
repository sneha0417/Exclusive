<%@page import="com.dashboard.accounts.prepaid.ClsPrepaid"%>
<% ClsPrepaid DAO= new ClsPrepaid(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo"); 
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var data1= '<%=DAO.accountsDetails(accNo, partyname,check)%>';
       
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'  }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsTypeFromSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
							{ text: 'Account', datafield: 'account', width: '30%' },
							{ text: 'Account Name', datafield: 'description', width: '70%' }
						]
            });
            
            //Add empty row
      	    $("#jqxAccountsTypeFromSearch").jqxGrid('addrow', null, {});   
            
             $('#jqxAccountsTypeFromSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtaccid").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("txtaccname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
    	       	
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxAccountsTypeFromSearch"></div>
 