<%@page import="com.finance.intercompanytransactions.icjournalvouchers.ClsIcJournalVouchersDAO"%>
<% ClsIcJournalVouchersDAO DAO= new ClsIcJournalVouchersDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo").toString();
String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
String descriptions = request.getParameter("descriptions")==null?"0":request.getParameter("descriptions");
String refNo = request.getParameter("refNo")==null?"0":request.getParameter("refNo");
String amounts = request.getParameter("amounts")==null?"0":request.getParameter("amounts");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 	  
     var data5;
        $(document).ready(function () { 
        	
        		data5='<%=DAO.icjvMainSearch(session,docNo,dates,descriptions,refNo,amounts,check)%>';
        	
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'description', type: 'String' }, 
     						{name : 'refno', type: 'String' },
     						{name : 'drtot', type: 'number'  },
     						{name : 'tr_no', type: 'int'  },
							{name : 'menu_name', type: 'String' }
                          	],
                          	localdata: data5,
                
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
            $("#jqxJournalVouchersSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
               
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '10%' },
					{ text: 'Description', datafield: 'description', width: '50%' }, 
					{ text: 'Reference', datafield: 'refno', width: '15%' },
					{ text: 'Amount', datafield: 'drtot', cellsformat: 'd2', width: '15%' },
					{ text: 'Tr No', datafield: 'tr_no', hidden: true, width: '15%' },
					{ text: 'Menu Name', datafield: 'menu_name', hidden: true, width: '15%' }
					]
            });
    
            $('#jqxJournalVouchersSearch').on('rowdoubleclick', function (event) {
			    var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#jqxJournalVouchersSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txttrno").value= $('#jqxJournalVouchersSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                document.getElementById("txtdescription").value= $('#jqxJournalVouchersSearch').jqxGrid('getcellvalue', rowindex1, "description");
                
                $('#icJournalVouchersDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmIcJournalVoucher").submit();
                $('#icJournalVouchersDate').jqxDateTimeInput({disabled: true});
				
                $('#window').jqxWindow('close');
                });  	 
				           
}); 
</script>
<div id="jqxJournalVouchersSearch"></div>
    