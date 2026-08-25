<%@page import="com.dashboard.humanresource.deductionschedule.*"%>
<%ClsDeductionScheduleDAO DAO= new ClsDeductionScheduleDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno, check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'codeno', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'pmmob', type: 'string'  },
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
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						]
            });
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtemployeedocno").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtemployeeid").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "codeno");
            	document.getElementById("txtemployeename").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
    	       	
            	$('#employeeDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="employeeDetailsSearch"></div>
 