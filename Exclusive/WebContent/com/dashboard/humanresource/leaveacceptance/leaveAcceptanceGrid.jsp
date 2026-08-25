<%@page import="com.dashboard.humanresource.leaveacceptance.ClsLeaveAcceptanceDAO"%>
<% ClsLeaveAcceptanceDAO DAO= new ClsLeaveAcceptanceDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	 String department = request.getParameter("department")==null?"0":request.getParameter("department").trim();
	 String designation = request.getParameter("designation")==null?"0":request.getParameter("designation").trim();
	 String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	 String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>

<style>     
.leaveClass { color: #FF3333; }
.whiteClass { background-color: #FFFFFF; }
</style>
        
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		    data='<%=DAO.leaveAcceptanceGridLoading(branchval, upToDate, department, designation, category, employee, check)%>';   
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
            
            $("#leaveAcceptanceDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 540,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                rowsheight:25,
                columnsresize: true,
    	        selectionmode: 'checkbox',
    	        pagermode: 'default',
    	        sortable:false,
                
                columns: [
							
							{ text: 'Emp. ID', datafield: 'empid', width: '6%' },
							{ text: 'Employee', datafield: 'empname', width: '20%' },
							{ text: 'From', datafield: 'fromdate', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'To', datafield: 'todate', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Half', datafield: 'halfday', columntype: 'checkbox', checked: true, width: '4%',cellsalign: 'center', align: 'center' },
							{ text: 'Half Day', datafield: 'halfdaydate', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'No. of Days', datafield: 'noofdays', cellsalign:'center', align:'center', cellclassname: cellclassname, width: '6%' },
							{ text: 'Leave', datafield: 'leavetype', cellclassname: cellclassname, width: '10%' },
							{ text: 'Reason', datafield: 'description', cellclassname: cellclassname, width: '30%' },
							{ text: 'Emp. Doc No', datafield: 'empdocno', hidden: true, width: '8%' },
							{ text: 'Doc No', datafield: 'docno', hidden: true, width: '8%' },
					     ],
            });
            
            if(temp=='NA'){
                $("#leaveAcceptanceDetailsGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
  });
                       
</script>
<div id="leaveAcceptanceDetailsGridID"></div>