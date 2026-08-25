<%@page import="com.search.ClsAccountSearch"%>
<%ClsAccountSearch DAO= new ClsAccountSearch(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
	var accountData='<%=DAO.accsearch_hr(accountno,accountname,check)%>';
	
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'curid', type: 'int'   }
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
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '35%' },
						{ text: 'Account Name', datafield: 'description', width: '65%' },
						{ text: 'Cur Id', datafield: 'curid', hidden:true, width: '10%' },
						
					]
        });
        
         $('#accountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            
	            document.getElementById("txtempaccdocno").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("txtempaccount").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
				document.getElementById("txtemployeename").value = $('#accountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
        	
           $('#accountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="accountsSearch"></div>
    