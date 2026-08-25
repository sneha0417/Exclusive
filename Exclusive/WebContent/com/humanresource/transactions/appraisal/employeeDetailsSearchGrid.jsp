<%@page import="com.humanresource.transactions.appraisal.ClsAppraisalDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsAppraisalDAO DAO=new ClsAppraisalDAO();
   String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno"); %>
<script type="text/javascript">
 
        var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno)%>';  
        
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtjoin', type: 'date'   },
     						{name : 'name', type: 'string'   },
     						{name : 'desc_id', type: 'string'  }, 
     						{name : 'desig', type: 'string'  },
     						{name : 'pay_catid', type: 'string'  },
     						{name : 'category', type: 'string'  },
     						{name : 'dept_id', type: 'string'  },
     						{name : 'dept', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'codeno', type: 'string'   },
     						{name : 'pmmob', type: 'string'   }
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
							{ text: 'desc_id', datafield: 'desc_id', width: '20%', hidden:true },
							{ text: 'desig', datafield: 'desig', width: '20%', hidden:true },
							{ text: 'pay_catid', datafield: 'pay_catid', width: '20%', hidden:true },
							{ text: 'category', datafield: 'category', width: '20%', hidden:true },
							{ text: 'dept_id', datafield: 'dept_id', width: '20%' , hidden:true},
							{ text: 'dept', datafield: 'dept', width: '20%', hidden:true },
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						]
            });  
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("empdocno").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("empid").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "codeno");
            	document.getElementById("empname").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
            	$("#joindate").jqxDateTimeInput('val', $("#employeeDetailsSearch").jqxGrid('getcellvalue', rowindex1, "dtjoin"));
                document.getElementById("category").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "category");
                document.getElementById("designation").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "desig");
            	document.getElementById("deprtment").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "dept");
                document.getElementById("hidcategory").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "pay_catid");
                document.getElementById("hiddesignation").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "desc_id");
            	document.getElementById("hiddeprtment").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "dept_id");
            	
            	$("#comdiv").load("compensationGrid.jsp?empdocno="+$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
            	 
            	$('#empsearchwndow').jqxWindow('close'); 
            });  
        });

</script>
<div id="employeeDetailsSearch"></div>
 