<%@page import="com.humanresource.transactions.leaverequest.ClsLeaveRequestDAO"%>
<% ClsLeaveRequestDAO DAO= new ClsLeaveRequestDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo").toString();
String dates = request.getParameter("dates")==null?"0":request.getParameter("dates");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 	  
     var data;
        $(document).ready(function () { 
        	
        		data='<%=DAO.lrqMainSearch(docNo,dates,check)%>';
        	
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'codeno', type: 'string' },
     						{name : 'name', type: 'string' },
     						{name : 'leavetype', type: 'string' },
     						{name : 'days', type: 'number' },
     						{name : 'empid', type: 'int' }
                          	],
                          	localdata: data,
                
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
            $("#leaveRequestMainSearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '15%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '15%' },
							{ text: 'Emp ID', datafield: 'codeno', width: '15%' },
							{ text: 'Employee', datafield: 'name', width: '25%' },
							{ text: 'Leave', datafield: 'leavetype', width: '20%' },
							{ text: 'Days', datafield: 'days', cellsformat: 'd2', width: '10%' },
							{ text: 'empid', datafield: 'empid', hidden: true, width: '10%' },
					]
            });
    
            $('#leaveRequestMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                funReset();
                document.getElementById("docno").value= $('#leaveRequestMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#leaveRequestDate').jqxDateTimeInput({disabled: false});
                $("#leaveRequestDate").jqxDateTimeInput('val', $("#leaveRequestMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#leaveRequestDate').jqxDateTimeInput({disabled: true});
								
                $('#frmLeaveRequest select').attr('disabled', false);
                $('#leaveRequestDate').jqxDateTimeInput({disabled: false});
                $('#fromDate').jqxDateTimeInput({disabled: false});
                $('#toDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmLeaveRequest").submit();
                $('#frmLeaveRequest select').attr('disabled', true);
                $('#leaveRequestDate').jqxDateTimeInput({disabled: true});
                $('#fromDate').jqxDateTimeInput({disabled: true});
                $('#toDate').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
                });  	 
				           
}); 
</script>
<div id="leaveRequestMainSearch"></div>
    