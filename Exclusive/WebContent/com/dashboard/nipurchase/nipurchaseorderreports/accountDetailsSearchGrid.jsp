<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.nipurchase.nipurchasereports.ClsnipurchaseReportsDAO" %>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 ClsnipurchaseReportsDAO  ReportsDAO=new  ClsnipurchaseReportsDAO();
 
%> 

 <script type="text/javascript">
 
	var accountData='<%=ReportsDAO.accountsDetails(session, accountno, accountname,check)%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                         {name : 'doc_no', type: 'int'   },
						 {name : 'account', type: 'string'   },
						 {name : 'description', type: 'string'  },
						 
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '70%' },
			 
					]
        });
    	
    	//  acno accname accdocno
    	
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;

            document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
        	document.getElementById("accname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
        	document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
 
        	// txttypeatype txttypetype
            $('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    