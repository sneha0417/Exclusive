<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>
<% ClsAdditionandDeductionDAO DAO=new ClsAdditionandDeductionDAO(); %>
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
				 var rowindex1 =$('#rowindex').val();
                 var rowindex2 = event.args.rowindex;
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "acno" ,$('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "account" ,$('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "account"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "accountname" ,$('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "description"));
                 $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "grtype" ,$('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "grtype"));
                  
           		$('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="accountsSearch"></div>
    