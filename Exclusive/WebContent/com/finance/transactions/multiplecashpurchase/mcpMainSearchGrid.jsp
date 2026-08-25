<%@page import="com.finance.transactions.multiplecashpurchase.ClsmultipleCashPurchaseDAO"%>
<% ClsmultipleCashPurchaseDAO DAO= new ClsmultipleCashPurchaseDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.mcpMainSearch(session, partyname, docNo, date, amount, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
                            {name : 'trno', type: 'int' },
                            {name : 'cldocno', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' }
                          	],
                          	localdata: data1,
                
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
            $("#jqxMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Party Name', datafield: 'description', width: '40%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'TR No', datafield: 'trno', width: '7%',hidden:true },
					 { text: 'cldocno', datafield: 'cldocno', width: '7%',hidden:true },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#jqxMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
				
                document.getElementById("txtaccname").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("trno").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "trno");
                document.getElementById("vendorid").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtvndortotal").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "amount");
                document.getElementById("vendor").value= $('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                //$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "txtaccname",$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "description"));
				//$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindex, "docno",$('#jqxMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
				                	
                $('#frmMultipleCashPurchase select').attr('disabled', false);
                $('#jqxmcpdate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmMultipleCashPurchase").submit();
                $('#frmMultipleCashPurchase select').attr('disabled', true);
                $('#jqxmcpdate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxMainSearch"></div>
    