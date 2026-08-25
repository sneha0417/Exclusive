<%@page import="com.controlcentre.legacydata.accountsopening.ClsAccountsOpeningDAO" %>
<%ClsAccountsOpeningDAO cad=new ClsAccountsOpeningDAO(); %>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
String accountNo = request.getParameter("accountNo")==null?"0":request.getParameter("accountNo").toString();
String accountName = request.getParameter("accountName")==null?"0":request.getParameter("accountName");
String total = request.getParameter("total")==null?"0":request.getParameter("total");
%> 

 <script type="text/javascript">
   
     var data4='<%=cad.opnMainSearch(session,accountNo, accountName, total)%>';
        $(document).ready(function () { 
        	
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'account', type: 'int' },
     						{name : 'description', type: 'String' }, 
     						{name : 'total', type: 'number'  },
     						{name : 'tr_no', type: 'int' }
                          	],
                          	localdata: data4,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxAccountsOpeningSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
               
                columns: [
					{ text: 'Account No', datafield: 'account', width: '30%' },
					{ text: 'Description', datafield: 'description', width: '50%' }, 
					{ text: 'Balance', datafield: 'total', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '20%' },
					{ text: 'Tr No', datafield: 'tr_no', hidden: true, width: '5%' },
					]
            });
    
            $('#jqxAccountsOpeningSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtaccid").value= $('#jqxAccountsOpeningSearch').jqxGrid('getcellvalue', rowindex1, "account");
                document.getElementById("txtaccname").value= $('#jqxAccountsOpeningSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtnettotal").value= $('#jqxAccountsOpeningSearch').jqxGrid('getcellvalue', rowindex1, "total");
                document.getElementById("txttrno").value= $('#jqxAccountsOpeningSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                
                $('#frmAccountsOpening select').attr('disabled', false);
                //$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmAccountsOpening").submit();
                $('#frmAccountsOpening select').attr('disabled', true);
                //$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
                });  	 
				           
}); 
</script>
<div id="jqxAccountsOpeningSearch"></div>
    