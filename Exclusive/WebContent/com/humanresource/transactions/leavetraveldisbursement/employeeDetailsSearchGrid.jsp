<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.leavetraveldisbursement.ClsLeaveTravelDisbursementDAO"%>
<% ClsLeaveTravelDisbursementDAO DAO= new ClsLeaveTravelDisbursementDAO(); %>
 <%
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 String employeedesignation = request.getParameter("employeedesignation")==null?"0":request.getParameter("employeedesignation");
 String employeedepartment = request.getParameter("employeedepartment")==null?"0":request.getParameter("employeedepartment");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String doj = request.getParameter("doj")==null?"0":request.getParameter("doj");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

 <script type="text/javascript">
 
 		var data1='<%=DAO.employeeDetailsSearch(session,empname,mob,employeedesignation,employeedepartment,empid,doj,check)%>';
        
 		$(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'empid', type: 'int'  },
     						{name : 'name', type: 'String' },
     						{name : 'mob', type: 'String' }, 
     						{name : 'designation', type: 'String' },
     						{name : 'department', type: 'String'  },
     						{name : 'dtjoin', type: 'date' },
     						{name : 'appriasal', type: 'date' },
     						{name : 'category', type: 'String'  },
     						{name : 'doc_no', type: 'int'  }
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
					 { text: 'Emp Id', datafield: 'empid', width: '10%' },
					 { text: 'Name', datafield: 'name', width: '30%' },
					 { text: 'Mob', datafield: 'mob', width: '10%' }, 
					 { text: 'Designation', datafield: 'designation', width: '20%' },
					 { text: 'Department', datafield: 'department', width: '20%' },
					 { text: 'Date of Join', datafield: 'dtjoin', width: '10%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Appriasal Date', datafield: 'appriasal', hidden: true, width: '10%', cellsformat: 'dd.MM.yyyy' },
					 { text: 'Category', datafield: 'category', hidden: true, width: '20%' },
					 { text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
					]
            });
            
			  $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("txtemployeedocno").value=$('#employeeDetailsSearch').jqxGrid('getcellvalue',rowindex1, "doc_no");
                document.getElementById("txtemployeeid").value=$('#employeeDetailsSearch').jqxGrid('getcellvalue',rowindex1, "empid");
                document.getElementById("txtemployeename").value=$('#employeeDetailsSearch').jqxGrid('getcellvalue',rowindex1, "name");
                
                $('#employeeDetailsWindow').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="employeeDetailsSearch"></div>
    