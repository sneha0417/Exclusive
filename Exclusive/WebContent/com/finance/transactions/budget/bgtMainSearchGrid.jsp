<%@page import="com.finance.transactions.budget.ClsBudgetDAO"%>
<% ClsBudgetDAO DAO= new ClsBudgetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String assessmentDate = request.getParameter("assessmentDt")==null?"0":request.getParameter("assessmentDt");
 String description = request.getParameter("description")==null?"0":request.getParameter("description");
%> 

 <script type="text/javascript">
 
 			var data3='<%=DAO.bgtMainSearch(session, docNo, date, assessmentDate, description)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'year', type: 'date' },
     						{name : 'description', type: 'String' } 
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
            $("#budgetMainSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '15%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '15%' },
					 { text: 'Assessment Year', datafield: 'year', cellsformat: 'MM.yyyy', width: '15%' },
					 { text: 'Description', datafield: 'description', width: '55%' },
					]
            });
            
			  $('#budgetMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtdescription").value= $('#budgetMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#budgetMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmBudget select').attr('disabled', false);
                $('#assessmentYearDate').jqxDateTimeInput({disabled: false});
                $('#budgetDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmBudget").submit();
                $('#frmBudget select').attr('disabled', true);
                $('#assessmentYearDate').jqxDateTimeInput({disabled: true});
                $('#budgetDate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="budgetMainSearchGridID"></div>
    