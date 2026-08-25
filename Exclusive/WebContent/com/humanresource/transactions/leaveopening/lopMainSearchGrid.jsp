<%@page import="com.humanresource.transactions.leaveopening.ClsLeaveOpeningDAO"%>
<% ClsLeaveOpeningDAO DAO= new ClsLeaveOpeningDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo").toString();
String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 	  
     var data5;
        $(document).ready(function () { 
        	
        		data5='<%=DAO.lopMainSearch(docNo,dates,check)%>';
        	
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  }
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
            $("#leaveOpeningMainSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '50%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '50%' },
					]
            });
    
            $('#leaveOpeningMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("docno").value= $('#leaveOpeningMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#leaveOpeningDate').jqxDateTimeInput({disabled: false});
                $("#leaveOpeningDate").jqxDateTimeInput('val', $("#leaveOpeningMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#leaveOpeningDate').jqxDateTimeInput({disabled: true});
                
                var indexVal = document.getElementById("docno").value;
   			    if(indexVal>0){
   	             	$("#leaveOpeningDiv").load("leaveOpeningGrid.jsp?docno="+indexVal);
				 	getapprcount();
   			     }
								
                $('#window').jqxWindow('close');
                });  	 
				           
}); 
</script>
<div id="leaveOpeningMainSearch"></div>
    