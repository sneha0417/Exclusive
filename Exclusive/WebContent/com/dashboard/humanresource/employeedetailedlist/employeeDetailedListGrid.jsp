<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.employeedetailedlist.ClsEmployeeDetailedListDAO"%>
<% ClsEmployeeDetailedListDAO DAO= new ClsEmployeeDetailedListDAO(); %>
<% 
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 
 		var check='<%=check%>';
 		
 		$(document).ready(function () {
 			var data ="";
 			 
 			if(check=='1'){
 		   	    data = '<%=DAO.employeeListGridLoading(department, category, empId, check)%>'; 
 		   		dataExcelExport = '<%=DAO.employeeListExcelExport(department, category, empId, check)%>'; 
 		   	   
 			}else{
 				data = '[{"columns":[{"text":"Sr No.","datafield":"id","cellsAlign":"center","align":"center","width":"5%"},{"text":"Emp ID","columntype": "textbox","datafield":"empid","cellsAlign":"left","align":"left","width":"7%"},{"text":"Name","columntype": "textbox","datafield":"name","cellsAlign":"left","align":"left","width":"10%"},{"text":"Designation","columntype": "textbox","datafield":"designation","cellsAlign":"left","align":"left","width":"7%"},{"text":"Department","columntype": "textbox","datafield":"department","cellsAlign":"left","align":"left","width":"7%"},{"text":"Category","columntype": "textbox","datafield":"category","cellsAlign":"left","align":"left","width":"7%"},{"text":"Date of Join","columntype": "textbox","datafield":"dtjoin","cellsAlign":"left","align":"left","width":"10%"},{"text":"Address","columntype": "textbox","datafield":"address","cellsAlign":"left","align":"left","width":"7%"},{"text":"Mobile","columntype": "textbox","datafield":"mobile","cellsAlign":"left","align":"left","width":"7%"},{"text":"Email Id","columntype": "textbox","datafield":"email","cellsAlign":"left","align":"left","width":"10%"},{"text":"DOB","columntype": "textbox","datafield":"dob","cellsAlign":"left","align":"left","width":"9%"},{"text":"Gender","columntype": "textbox","datafield":"gender","cellsAlign":"left","align":"left","width":"7%"},{"text":"Bank Account","columntype": "textbox","datafield":"bankaccount","cellsAlign":"left","align":"left","width":"7%"},{"text":"IFSC Code","columntype": "textbox","datafield":"ifsccode","cellsAlign":"left","align":"left","width":"7%"},{"text":"Est. Code","columntype": "textbox","datafield":"estcode","cellsAlign":"left","align":"left","width":"7%"},{"text":"Company","columntype": "textbox","datafield":"compname","cellsAlign":"left","align":"left","width":"7%"},{"text":"Status","columntype": "textbox","datafield":"status","cellsAlign":"left","align":"left","width":"7%"},{"text":"Basic Salary","columntype": "textbox","datafield":"basicsalary","cellsAlign":"right","align":"right","width":"10%","cellsFormat":"d2"},{"text":"Allowance","columntype": "textbox","datafield":"allowance1","cellsAlign":"right","align":"right","width":"7%","cellsFormat":"d2"},{"text":"Document No","columntype": "textbox","datafield":"docidnum1","cellsAlign":"left","align":"left","width":"7%"},{"text":"Issue Date","columntype": "textbox","datafield":"issdt1","cellsAlign":"left","align":"left","width":"10%"},{"text":"Exp. Date","columntype": "textbox","datafield":"expdt1","cellsAlign":"left","align":"left","width":"10%"},{"text":"Place of Issue","columntype": "textbox","datafield":"placeofiss1","cellsAlign":"left","align":"left","width":"12%"}]},{"rows":[{"id":"1","empid":"","name":"","designation":"","department":"","category":"","dtjoin":"","address":"","mobile":"","email":"","dob":"","gender":"","bankaccount":"","ifsccode":"","estcode":"","compname":"","status":"","basicsalary":"","allowance1":"","docidnum1":"","issdt1":"","expdt1":"","placeofiss1":""}]}]';
 			}
 			
            var obj = $.parseJSON(data);
            var columns = obj[0].columns;
            var rows = obj[1].rows;
 			
            var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'id', type: "int" },
						{ name: 'empid', type: "string" },
	                    { name: 'name', type: "string" },
	                    { name: 'designation', type: "string" },
	                    { name: 'department', type: "string" },
	                    { name: 'category', type: "string" },
	                    { name: 'dtjoin', type: "date" },
	                    { name: 'address', type: "string" },
	                    { name: 'mobile', type: "string" },
	                    { name: 'email', type: "string" },
	                    { name: 'dob', type: "date" },
	                    { name: 'gender', type: "string" },
	                    { name: 'bankaccount', type: "string" },
	                    { name: 'ifsccode', type: "string" },
	                    { name: 'estcode', type: "string" },
	                    { name: 'compname', type: "string" },
	                    { name: 'status', type: "string" },
	                    {name : 'basicsalary', type: "number" },
 						{name : 'allowance1', type: "number"   },
 						{name : 'allowance2', type: "number"  },
 						{name : 'allowance3', type: "number"   },
 						{name : 'allowance4', type: "number"   },
 						{name : 'allowance5', type: "number" },
 						{name : 'allowance6', type: "number"  },
						{name : 'allowance7', type: "number" },
						{name : 'allowance8', type: "number"  },
 						{name : 'allowance9', type: "number" },
 						{name : 'allowance10', type: "number" },
 						{ name: 'docidnum1', type: "string" },
 						{ name: 'issdt1', type: "date" },
 						{ name: 'expdt1', type: "date" },
 						{ name: 'placeofiss1', type: "string" },
 						{ name: 'docidnum2', type: "string" },
 						{ name: 'issdt2', type: "date" },
 						{ name: 'expdt2', type: "date" },
 						{ name: 'placeofiss2', type: "string" },
 						{ name: 'docidnum3', type: "string" },
 						{ name: 'issdt3', type: "date" },
 						{ name: 'expdt3', type: "date" },
 						{ name: 'placeofiss3', type: "string" },
 						{ name: 'docidnum4', type: "string" },
 						{ name: 'issdt4', type: "date" },
 						{ name: 'expdt4', type: "date" },
 						{ name: 'placeofiss4', type: "string" },
 						{ name: 'docidnum5', type: "string" },
 						{ name: 'issdt5', type: "date" },
 						{ name: 'expdt5', type: "date" },
 						{ name: 'placeofiss5', type: "string" },
 						{ name: 'docidnum6', type: "string" },
 						{ name: 'issdt6', type: "date" },
 						{ name: 'expdt6', type: "date" },
 						{ name: 'placeofiss6', type: "string" },
 						{ name: 'docidnum7', type: "string" },
 						{ name: 'issdt7', type: "date" },
 						{ name: 'expdt7', type: "date" },
 						{ name: 'placeofiss7', type: "string" },
 						{ name: 'docidnum8', type: "string" },
 						{ name: 'issdt8', type: "date" },
 						{ name: 'expdt8', type: "date" },
 						{ name: 'placeofiss8', type: "string" },
 						{ name: 'docidnum9', type: "string" },
 						{ name: 'issdt9', type: "date" },
 						{ name: 'expdt9', type: "date" },
 						{ name: 'placeofiss9', type: "string" },
 						{ name: 'docidnum10', type: "string" },
 						{ name: 'issdt10', type: "date" },
 						{ name: 'expdt10', type: "date" },
 						{ name: 'placeofiss10', type: "string" }
                ],
                id: 'id',
                localdata: rows
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailedListGridId").jqxGrid(
            {
            	width: '99.5%',
                height: 515,
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
            	columns: columns
            });
            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="employeeDetailedListGridId"></div>
