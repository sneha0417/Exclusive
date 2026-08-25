<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.deductionschedule.ClsDeductionScheduleDAO"%>
<%ClsDeductionScheduleDAO DAO= new ClsDeductionScheduleDAO(); %>
 <%
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String employeedesignation = request.getParameter("employeedesignation")==null?"0":request.getParameter("employeedesignation");
 String employeedepartment = request.getParameter("employeedepartment")==null?"0":request.getParameter("employeedepartment");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
%> 

 <script type="text/javascript">
 
 		var data1='<%=DAO.employeeDetailsSearch(session,empname,mob,employeedesignation,employeedepartment,empid,dob)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'emp_id', type: 'int'  },
     						{name : 'name', type: 'String' },
     						{name : 'dob', type: 'date' },
     						{name : 'mob', type: 'String' }, 
     						{name : 'designation', type: 'String' },
     						{name : 'department', type: 'String'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'empinfo', type: 'string'  }
                          	],
                          	localdata: data1,
                
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
            $("#employeeDetailsSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Emp Id', datafield: 'emp_id', width: '10%' },
					 { text: 'Name', datafield: 'name', width: '30%' },
					 { text: 'DOB', datafield: 'dob', width: '10%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Mob', datafield: 'mob', width: '10%' }, 
					 { text: 'Designation', datafield: 'designation', width: '20%' },
					 { text: 'Department', datafield: 'department', width: '20%' },
					 { text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
					 { text: 'Emp Info', datafield: 'empinfo', hidden:true, width: '10%' },
					]
            });
            
			  $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("txtemployeedocno").value=$('#employeeDetailsSearch').jqxGrid('getcellvalue',rowindex1, "doc_no");
				var values= $('#employeeDetailsSearch').jqxGrid('getcellvalue',rowindex1, "empinfo");
                
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("txtemployeedetails").value=sum2;

                $('#employeeDetailsWindow').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="employeeDetailsSearch"></div>
    