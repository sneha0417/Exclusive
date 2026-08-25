<%@page import="com.dashboard.humanresource.employeedetails.ClsEmployeeListDAO"%>
<%ClsEmployeeListDAO DAO= new ClsEmployeeListDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
 	var temp='<%=check%>';
 
 	var data;
 	if(temp=="load") {
	 	data = '<%=DAO.employeeListGridLoading(check)%>';
     	var dataExcelExport='<%=DAO.employeeListExcelExport(check)%>';
	}
 
        $(document).ready(function () { 
        	
        	var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'empid', type: 'string' },
                    { name: 'name', type: 'string' },
                    { name: 'designation', type: 'string' },
                    { name: 'department', type: 'string' },
                    { name: 'category', type: 'string' },
                    { name: 'dtjoin', type: 'date' },
                    { name: 'address', type: 'string' },
                    { name: 'mobile', type: 'string' },
                    { name: 'email', type: 'string' },
                    { name: 'dob', type: 'date' },
                    { name: 'gender', type: 'string' },
                    { name: 'status', type: 'string' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // initialize jqxGrid 
            $("#employeeList").jqxGrid(
            {
            	width: '99.5%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
            	groupable: true,
                groups: ['designation','department','category'],
                columns: [
          
                  { text: 'Emp ID',columntype: 'textbox',groupable: false, datafield: 'empid', width: '6%' },
                  { text: 'Name',columntype: 'textbox', groupable: true, datafield: 'name', width: '20%' },
                  { text: 'Designation',columntype: 'textbox',groupable: true, datafield: 'designation', width: '10%' },
                  { text: 'Department',columntype: 'textbox', groupable: true, datafield: 'department', width: '9%' },
                  { text: 'Category',columntype: 'textbox', groupable: true, datafield: 'category', width: '9%' },
                  { text: 'Date of Join',columntype: 'textbox', groupable: false, datafield: 'dtjoin', cellsformat: 'dd-MM-yyyy' , width: '7%' },
                  { text: 'Address',columntype: 'textbox', groupable: false, datafield: 'address', width: '10%' },
                  { text: 'Mobile',columntype: 'textbox', groupable: false, datafield: 'mobile', width: '8%' },
                  { text: 'Email Id',columntype: 'textbox', groupable: false, datafield: 'email', width: '10%' },
                  { text: 'dob',columntype: 'textbox', groupable: false, datafield: 'dob', cellsformat: 'dd-MM-yyyy' , width: '7%' },
                  { text: 'Gender',columntype: 'textbox', groupable: false, datafield: 'gender', width: '4%' },
                  { text: 'Status',columntype: 'textbox', groupable: false, datafield: 'status', width: '4%' },
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
    
            $("#overlay, #PleaseWait").hide();
				           
        
}); 
				                              
</script>

<div id="employeeList"></div>