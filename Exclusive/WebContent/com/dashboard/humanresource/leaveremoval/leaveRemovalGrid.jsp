<%@page import="com.dashboard.humanresource.leaveremoval.ClsLeaveRemovalDAO"%>
<% ClsLeaveRemovalDAO DAO= new ClsLeaveRemovalDAO(); %>   
<%  String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
    String rptType = request.getParameter("rpttype")==null?"NA":request.getParameter("rpttype").trim();
	String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String department = request.getParameter("department")==null?"0":request.getParameter("department").trim();
	String designation = request.getParameter("designation")==null?"0":request.getParameter("designation").trim();
	String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>

<style>     
.leaveStatusClass { background-color: #F1F8E0; color: #FF3333; }    
.leaveClass { color: #FF3333; }
.whiteClass { background-color: #FFFFFF; }
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=DAO.leaveDetailsGridLoading(rptType, branchval, fromDate, toDate, department, designation, category, employee, check)%>';   
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							
							{name : 'empid', type: 'String'  },
							{name : 'empname', type: 'String'  },
							{name : 'fromdate', type: 'date' },
							{name : 'todate', type: 'date' },
							{name : 'halfday', type: 'bool' },
							{name : 'halfdaydate', type: 'date' },
							{name : 'noofdays' , type: 'number' },
							{name : 'leavetype' , type: 'String' },
						    {name : 'description', type: 'String'  },
						    {name : 'reqstatus', type: 'String'  },
						    {name : 'empdocno', type: 'int' },
							{name : 'docno', type: 'int' }
						    
	            			],
                			localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.noofdays != '') {
                    return "leaveClass";
                } else{
                	return "whiteClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#leaveRequestDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 540,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
							{ text: 'Emp. ID', datafield: 'empid', width: '6%' },
							{ text: 'Employee', datafield: 'empname', width: '22%' },
							{ text: 'From', datafield: 'fromdate', cellsformat: 'dd.MM.yyyy', width: '6%' },
							{ text: 'To', datafield: 'todate', cellsformat: 'dd.MM.yyyy', width: '6%' },
							{ text: 'Half', datafield: 'halfday', columntype: 'checkbox', checked: true, width: '4%',cellsalign: 'center', align: 'center' },
							{ text: 'Half Day', datafield: 'halfdaydate', cellsformat: 'dd.MM.yyyy', width: '6%' },
							{ text: 'No. of Days', datafield: 'noofdays', cellsalign:'center', align:'center', cellclassname: cellclassname, width: '6%' },
							{ text: 'Leave', datafield: 'leavetype', cellclassname: cellclassname, width: '8%' },
							{ text: 'Reason', datafield: 'description', cellclassname: cellclassname, width: '30%' },
							{ text: 'Status', datafield: 'reqstatus', cellclassname: 'leaveStatusClass', width: '6%' },
							{ text: 'Emp. Doc No', datafield: 'empdocno', hidden: true, width: '8%' },
							{ text: 'Doc No', datafield: 'docno', width: '8%' },
					     ],
            });
            $("#overlay, #PleaseWait").hide();  
            
            $('#leaveRequestDetailsGridID').on('rowdoubleclick', function (event) {
       		 var rowIndex = event.args.rowindex;
       		 $("#hiddocno").val($('#leaveRequestDetailsGridID').jqxGrid('getcellvalue',rowIndex, "docno"));
       		 $("#hidempdocno").val($('#leaveRequestDetailsGridID').jqxGrid('getcellvalue',rowIndex, "empdocno")); 
       		 $("#hidfromdate").val($('#leaveRequestDetailsGridID').jqxGrid('getcelltext',rowIndex, "fromdate")); 
       		 $("#hidtodate").val($('#leaveRequestDetailsGridID').jqxGrid('getcelltext',rowIndex, "todate"));    
       	});
  });
                       
</script>
<div id="leaveRequestDetailsGridID"></div>