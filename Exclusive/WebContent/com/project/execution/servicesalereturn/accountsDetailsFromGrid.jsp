
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO" %>



	
<%
ClsServiceSaleDAO viewDAO=new ClsServiceSaleDAO();
String type=request.getParameter("types")==null || request.getParameter("types")==""?"NA":request.getParameter("types").trim();
String accountss = request.getParameter("accountss")==null || request.getParameter("accountss")=="" ?"NA":request.getParameter("accountss").trim();
String accnamess = request.getParameter("accnamess")==null || request.getParameter("accnamess")=="" ?"NA":request.getParameter("accnamess").trim();
String mobileno=request.getParameter("mobileno")==null || request.getParameter("mobileno")=="" ?"NA":request.getParameter("mobileno").trim();
String id=request.getParameter("id")==null || request.getParameter("id")=="" ?"0":request.getParameter("id").trim();
%>
<script type="text/javascript">
var nipur;
<%-- alert('<%=type%>'); --%>
var id='<%=id%>';
if(id=="1"){
	nipur= '<%=viewDAO.accountsDetailsTo(type,accountss,accnamess,mobileno,id) %>';
}
else{
	nipur=[];
}
        $(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name :  'curid' ,type:'String'},
     						{name :  'rate' ,type:'String'},
						{name :'mobno' ,type:'String'},
						{name :'nontax' ,type:'String'}
                        ],
                		localdata: nipur, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '99%',
                height: 387,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                theme: 'energyblue',
                columns: [
                            { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '20%' },
							{ text: 'Account Name', datafield: 'description', width: '60%' },
							{ text: 'Mobile', datafield: 'mobno', width: '20%' },
							{ text: 'Currency id', datafield: 'curid', width: '80%' , hidden : true},
							{ text: 'Currency Rate', datafield: 'rate', width: '80%' , hidden : true},
							
							{ text: 'nontax', datafield: 'nontax', width: '20%' ,hidden:true},
							
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
            	/*  getCurrencyIds($("#nipurchasedate").val()); */
                 var rowindex1 = event.args.rowindex;
               // document.getElementById("txtfromdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
             
                 $('#cmbcurr').val($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid"));
                 $('#currate').val($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"));
                 	
                 document.getElementById("accdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                 document.getElementById("nipuraccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
            	 document.getElementById("puraccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
            	 document.getElementById("taxpers").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "tax");
            	 $('#jqxAccountsSearch').jqxGrid('clear');
            	 $('#accountSearchwindow').jqxWindow('close');
                 
                 if($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "nontax")=="0"){
                	 $('#taxperc').val('0');
                 }
                 else{
                	 getNonTaxableEntity();
                 }
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 