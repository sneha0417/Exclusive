<%@page import="com.dashboard.humanresource.additionanddeduction.ClsAdditionAndDeductionDAO" %>
<% ClsAdditionAndDeductionDAO DAO=new ClsAdditionAndDeductionDAO();  %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.accountDetailsSearch(accountno,accountname,atype,check)%>'; 
	
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'grtype', type: 'int'  }
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#accountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '35%' },
						{ text: 'Account Name', datafield: 'description', width: '65%' },
						{ text: 'Group Type', datafield: 'grtype', hidden: true, width: '5%' },
					]
        });
        
         $('#accountsSearch').on('rowdoubleclick', function (event) {
        	 var rowindex1 = event.args.rowindex;  
        	 document.getElementById("txtaccountdocno").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             document.getElementById("txtaccountno").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
         	 document.getElementById("txtaccountname").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
 	       	
           	 $('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="accountsSearch"></div>
    