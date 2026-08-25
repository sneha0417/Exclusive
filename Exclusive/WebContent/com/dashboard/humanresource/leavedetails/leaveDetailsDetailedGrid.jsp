<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.leavedetails.ClsLeaveDetailsDAO"%>
<%ClsLeaveDetailsDAO DAO= new ClsLeaveDetailsDAO(); %>
<% 
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String leaveType = request.getParameter("leaveType")==null?"0":request.getParameter("leaveType");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #fff;
        }
         .greenClass
        {
           background-color: #BEFF33;
        }
</style>
<script type="text/javascript">
		var temp1='<%=check%>';
		
		var data1;
		
        $(document).ready(function () { 	
        	
        	if(temp1!='NA'){
        		data1='<%=DAO.leaveDetailsDetailedGridLoading(year,month,department,category,leaveType,empId,check)%>';
        		dataExcelExport1='<%=DAO.leaveDetailsDetailedExcelExport(year,month,department,category,leaveType,empId,check)%>';
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' },
     						{name : 'designation', type: 'String' },
     						{name : 'department', type: 'String' },
     						{name : 'category', type: 'String' },
     						{name : 'fromdate', type: 'date' },
     						{name : 'todate', type: 'date' },
     						{name : 'halfday', type: 'bool' },
     						{name : 'halfdaydate', type: 'date' },
     						{name : 'leaves', type: 'string' },
     						{name : 'description', type: 'string' },
     						{name : 'noofdays', type: 'number' }
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#leaveDetailsDetailedGridID").jqxGrid(
            {
            	width: '98%',
                height: 518,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                filtermode:'excel',
                filterable: true,
                sortable :true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sl No', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center', cellclassname: 'whiteClass',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Emp. ID', datafield: 'employeeid', editable: false, width: '6%' },
							{ text: 'Employee Name', datafield: 'employeename', editable: false },
							{ text: 'Designation', datafield: 'designation', editable: false, width: '7%', editable: false },
							{ text: 'Department', datafield: 'department', editable: false, width: '7%', editable: false },
							{ text: 'Category', datafield: 'category', editable: false, width: '7%' },
							{ text: 'From', datafield: 'fromdate', editable: false, cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'To', datafield: 'todate', editable: false, cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Half Day', datafield: 'halfday', columntype: 'checkbox', editable: false, checked: true, width: '5%',cellsalign: 'center', align: 'center' },
							{ text: 'Half Taken', datafield: 'halfdaydate', editable: false, cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Leave Type', datafield: 'leaves', editable: false, width: '7%' },
							{ text: 'Description', datafield: 'description', editable: false, width: '15%' },							
							{ text: 'No of Days', datafield: 'noofdays', editable: false, width: '7%', editable: false, cellsalign: 'center', align: 'center' },
						    ],
            });
            $("#overlay, #PleaseWait").hide();
        });  
        		  
        
    </script>
    <div id="leaveDetailsDetailedGridID"></div>
 