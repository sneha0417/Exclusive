<%@page import="com.finance.intercompanytransactions.icpettycash.ClsIcPettyCashDAO"%>
<% ClsIcPettyCashDAO DAO= new ClsIcPettyCashDAO(); %>
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
 
 			var data1='<%=DAO.icpcMainSearch(session, partyname, docNo, date, amount, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
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
            $("#jqxPettyCashSearch").jqxGrid(
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
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#jqxPettyCashSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtaccname").value= $('#jqxPettyCashSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxPettyCashSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmIcPettyCash select').attr('disabled', false);
                $('#icPettyCashDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmIcPettyCash").submit();
                $('#frmIcPettyCash select').attr('disabled', true);
                $('#icPettyCashDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxPettyCashSearch"></div>
    