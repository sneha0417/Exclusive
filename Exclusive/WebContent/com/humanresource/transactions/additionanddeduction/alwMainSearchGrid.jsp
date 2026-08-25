<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>
<% ClsAdditionandDeductionDAO DAO= new ClsAdditionandDeductionDAO(); %>
<%
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String year = request.getParameter("year")==null?"0":request.getParameter("year");
 String month = request.getParameter("month")==null?"0":request.getParameter("month");
 String description = request.getParameter("description")==null?"0":request.getParameter("description");
%> 

 <script type="text/javascript">
 
 			var data3='<%=DAO.alwMainSearch(session, date, docNo, year, month, description)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'}, 
							{name : 'date', type: 'date'},
							{name : 'year', type: 'String'}, 
							{name : 'month', type: 'String'}, 
							{name : 'refno', type: 'String'},
							{name : 'description', type: 'String'}
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
            $("#additionAndDeductionMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '8%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
					 { text: 'Ref No', datafield: 'refno', width: '22%' }, 
					 { text: 'Year', datafield: 'year', width: '8%'},
					 { text: 'Month', datafield: 'month', width: '12%' }, 
					 { text: 'Description', datafield: 'description', width: '40%'},
					]
            });
            
			  $('#additionAndDeductionMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#additionAndDeductionMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#frmalw select').attr('disabled', false);
                $('#masterdate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmalw").submit();
                $('#frmalw select').attr('disabled', true);
                $('#masterdate').jqxDateTimeInput({disabled: true});
                
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="additionAndDeductionMainSearch"></div>
    