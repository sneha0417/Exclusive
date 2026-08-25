<%@page import="com.humanresource.transactions.leaveopening.ClsLeaveOpeningDAO"%>
<% ClsLeaveOpeningDAO DAO= new ClsLeaveOpeningDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
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
            	  var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindex1, "employeedocno" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindex1, "employeeid" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "codeno"));
	              $('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindex1, "employeename" ,$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                
	              var rows = $('#leaveOpeningGridID').jqxGrid('getrows');
	              var rowlength= rows.length;
	              var rowindex1 = rowlength - 1;
	          	  var empId=$("#leaveOpeningGridID").jqxGrid('getcellvalue', rowindex1, "employeedocno");
	          	  if(typeof(empId) != "undefined"){
	                $("#leaveOpeningGridID").jqxGrid('addrow', null, {});
	          	  }
	          	    
            	  $('#employeeDetailsGridWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="employeeDetailsSearch"></div>
 