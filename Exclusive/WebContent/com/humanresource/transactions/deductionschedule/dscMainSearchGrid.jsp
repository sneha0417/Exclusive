<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.deductionschedule.ClsDeductionScheduleDAO"%>
<%ClsDeductionScheduleDAO DAO= new ClsDeductionScheduleDAO(); %>
 <%
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
%> 

 <script type="text/javascript">
 
 			var data3='<%=DAO.dscMainSearch(session, empname, docNo, date, amount)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'name', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' }
                          	],
                          	localdata: data3,
                
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
            $("#deductionScheduleMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Employee Name', datafield: 'name', width: '40%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#deductionScheduleMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#deductionScheduleMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmDeductionSchedule select').attr('disabled', false);
                $('#deductionScheduleDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmDeductionSchedule").submit();
                $('#frmDeductionSchedule select').attr('disabled', true);
                $('#deductionScheduleDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="deductionScheduleMainSearch"></div>
    