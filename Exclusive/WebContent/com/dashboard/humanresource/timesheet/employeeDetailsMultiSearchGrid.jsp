<%@page import="com.dashboard.humanresource.timesheet.ClsTimeSheetDAO"%>
<%ClsTimeSheetDAO DAO= new ClsTimeSheetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
 String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");%>
<script type="text/javascript">
	   
       var data2= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno)%>';  
       
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'codeno', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'pmmob', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'costperhour', type: 'String'  }
                        ],
                		 localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailsMultiSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Employee Id', datafield: 'codeno', width: '20%' },
							{ text: 'Employee Name', datafield: 'name' },
							{ text: 'Contact', datafield: 'pmmob', width: '20%' },
							{ text: 'Doc No',  datafield: 'doc_no', hidden: true, width: '5%' },
							{ text: 'Cost Per Hour', datafield: 'costperhour', hidden: true, width: '8%' },
						]
            });
            
        });
    </script>
    <div id="employeeDetailsMultiSearch"></div>
 