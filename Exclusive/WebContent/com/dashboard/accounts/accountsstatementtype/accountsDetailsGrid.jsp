<%@page import="com.dashboard.accounts.accountsstatement.ClsAccountsStatementDAO" %>
<% ClsAccountsStatementDAO casd=new ClsAccountsStatementDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
 String contactNo = request.getParameter("contactNo")==null?"0":request.getParameter("contactNo");
 String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 String address = request.getParameter("address")==null?"0":request.getParameter("address");
 %>
<script type="text/javascript">
        
       var data1= '<%=casd.accountDetails(atype, accNo, partyname, contactNo, chk,address)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'  },
     						{name : 'per_mob', type: 'int'   },
     						{name : 'email', type: 'string'  },
     						{name : 'address', type: 'string'  },
     						{name : 'active', type: 'int'  },
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            var cellclassname = function (row, column, value, data) {
                if (data.active == 0) {
                    return "redClass";
                };
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsTypeFromSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                enabletooltips :true,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no',cellclassname: cellclassname, hidden: true, width: '5%' },
							{ text: 'Account', datafield: 'account',cellclassname: cellclassname, width: '10%' },
							{ text: 'Account Name',cellclassname: cellclassname, datafield: 'description' },
							{ text: 'Contact', datafield: 'per_mob',cellclassname: cellclassname, width: '20%' },
							{ text: 'Email',  datafield: 'email', hidden: true,cellclassname: cellclassname, width: '15%' },
							{ text: 'Owner',  datafield: 'address', cellclassname: cellclassname, width: '25%' },
							{ text: 'active',  datafield: 'active', hidden: true, cellclassname: cellclassname, width: '15%' },
						]
            });
            
             $('#jqxAccountsTypeFromSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtaccid").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("txtaccname").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "description");
            	document.getElementById("txtaccemail").value = $('#jqxAccountsTypeFromSearch').jqxGrid('getcellvalue', rowindex1, "email");
            	
				if(($('#lbldetailname').text()=='Accounts Statement AR')){
            		getClientStatus();
            	}
				
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
             
             
            if(($('#lbldetailname').text()=='Accounts Statement AR')){
      			$('#jqxAccountsTypeFromSearch').jqxGrid('hidecolumn', 'address');
      		}else if(($('#lbldetailname').text()=='Accounts Statement GL')){
      			$('#jqxAccountsTypeFromSearch').jqxGrid('hidecolumn', 'address');
      		}else if(($('#lbldetailname').text()=='Accounts Statement HR')){
      			$('#jqxAccountsTypeFromSearch').jqxGrid('hidecolumn', 'address');
      		}
        });
    </script>
    <div id="jqxAccountsTypeFromSearch"></div>
 