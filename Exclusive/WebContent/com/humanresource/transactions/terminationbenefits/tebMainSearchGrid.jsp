<%@page import="com.humanresource.transactions.terminationbenefits.ClsTerminationBenefitsDAO"%>
<% ClsTerminationBenefitsDAO DAO= new ClsTerminationBenefitsDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String tbamount = request.getParameter("tbamount")==null?"0":request.getParameter("tbamount");
 String lsamount = request.getParameter("lsamount")==null?"0":request.getParameter("lsamount");
 String travelamount = request.getParameter("travelamount")==null?"0":request.getParameter("travelamount");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 

 <script type="text/javascript">
 
 			var data3='<%=DAO.tebMainSearch(branch, partyname, docNo, date, tbamount, lsamount, travelamount)%>';
			
 			$(document).ready(function () { 
				 
        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'terminalbenefits_total', type: 'number' },
     						{name : 'leavesalary_total', type: 'number' },
     						{name : 'travels_total', type: 'number' },
     						{name : 'user_name', type: 'String' },
     						{name : 'tr_no', type: 'int' }
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
            $("#terminationBenefitsMainSearchGridID").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},

                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
					 { text: 'Terminal Benefits', datafield: 'terminalbenefits_total', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
					 { text: 'Leave Salary', datafield: 'leavesalary_total', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
					 { text: 'Travels', datafield: 'travels_total', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
					 { text: 'User Name', datafield: 'user_name', width: '45%' },
					 { text: 'Tr No', hidden: true, datafield: 'tr_no', width: '10%' },
					]
            });
            
			  $('#terminationBenefitsMainSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                $("#terminationBenefitsPostingDate").jqxDateTimeInput('val', $("#terminationBenefitsMainSearchGridID").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("docno").value= $('#terminationBenefitsMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txttrno").value= $('#terminationBenefitsMainSearchGridID').jqxGrid('getcellvalue', rowindex1, "tr_no");
                
                 var indexVal = document.getElementById("txttrno").value;
	   			 if(indexVal>0){
	   	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
	   			 }
	   	         
	   			 var indexVal1 = document.getElementById("docno").value;
	   	         var indexVal2 = document.getElementById("txttrno").value;
	   	         if(indexVal1>0){
	   	         $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
   	             } 
   	         
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="terminationBenefitsMainSearchGridID"></div>
    