<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO" %>
<%ClsEmployeeMasterDAO emd=new ClsEmployeeMasterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String employeedesignation = request.getParameter("employeedesignation")==null?"0":request.getParameter("employeedesignation");
 String employeedepartment = request.getParameter("employeedepartment")==null?"0":request.getParameter("employeedepartment");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String dob = request.getParameter("dob")==null?"0":request.getParameter("dob");
%> 

 <script type="text/javascript">
 
 		var data3='<%=emd.employeeMainSearch(session,empname,mob,employeedesignation,employeedepartment,empid,dob)%>';
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
     						{name : 'birthdate', type: 'String' },
     						{name : 'dtjoin', type: 'String' }
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
            $("#employeeMainSearch").jqxGrid(
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
					 { text: 'DOB', datafield: 'birthdate', width: '10%', hidden: true },
					 { text: 'DOJ', datafield: 'dtjoin', width: '10%', hidden: true },
					]
            });
            
			  $('#employeeMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtemployeename").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("docno").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				document.getElementById("hidempDateOfBirth").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "birthdate");
                document.getElementById("hidjoiningDate").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "dtjoin");
                
                $('#frmEmployeeMaster select').attr('disabled', false);
                $('#employeeDate').jqxDateTimeInput({disabled: false});
                $('#joiningDate').jqxDateTimeInput({disabled: false});
                $('#empDateOfBirth').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmEmployeeMaster").submit();
                $('#frmEmployeeMaster select').attr('disabled', true);
                $('#employeeDate').jqxDateTimeInput({disabled: true});
                $('#joiningDate').jqxDateTimeInput({disabled: true});
                $('#empDateOfBirth').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="employeeMainSearch"></div>
    