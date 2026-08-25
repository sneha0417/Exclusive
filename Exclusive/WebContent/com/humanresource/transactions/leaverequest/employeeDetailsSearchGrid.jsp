<%@page import="com.humanresource.transactions.leaverequest.ClsLeaveRequestDAO"%>
<% ClsLeaveRequestDAO DAO= new ClsLeaveRequestDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <% String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
    String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
    String designation = request.getParameter("designation")==null?"0":request.getParameter("designation");
    String department = request.getParameter("department")==null?"0":request.getParameter("department");
    String category = request.getParameter("category")==null?"0":request.getParameter("category");
    String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno"); %>
<script type="text/javascript">

       var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno, designation, department, category)%>';  
       
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'codeno', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'pmmob', type: 'string'  },
     						{name : 'desc_id', type: 'int'   },
     						{name : 'dept_id', type: 'int'   },
     						{name : 'pay_catid', type: 'int'   },
     						{name : 'doc_no', type: 'int'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Employee Id', datafield: 'codeno', width: '20%' },
							{ text: 'Employee Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'pmmob', width: '20%' },
							{ text: 'Designation',  datafield: 'desc_id', hidden: true, width: '5%' },
							{ text: 'Department',  datafield: 'dept_id', hidden: true, width: '5%' },
							{ text: 'Category',  datafield: 'pay_catid', hidden: true, width: '5%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
						]
            });
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 = event.args.rowindex;
	              document.getElementById("txtemployeedocno").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	              document.getElementById("txtemployeeid").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "codeno");
	              document.getElementById("txtemployeename").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
	              document.getElementById("cmbempdesignation").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "desc_id");
	              document.getElementById("cmbempdepartment").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "dept_id");
	              document.getElementById("cmbpayrollcategory").value= $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "pay_catid");
	          	    
            	  $('#employeeDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="employeeDetailsSearch"></div>
 