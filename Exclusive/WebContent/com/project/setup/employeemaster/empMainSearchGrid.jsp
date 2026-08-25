<%@page import="com.project.setup.employeemaster.ClsEmployeeMasterDAO" %>
<%ClsEmployeeMasterDAO emd=new ClsEmployeeMasterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String empname = request.getParameter("empname")==null?"0":request.getParameter("empname");
 String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
%> 

 <script type="text/javascript">
 
 		var data1='<%=emd.employeeMainSearch(session,empname,empid)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'emp_id', type: 'int'  },
     						{name : 'name', type: 'String' },
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
            $("#employeeMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Emp Id', datafield: 'emp_id', width: '20%' },
					 { text: 'Name', datafield: 'name', width: '80%' },
					 { text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
					]
            });
            
			  $('#employeeMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txtemployeename").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("docno").value= $('#employeeMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmEmpMaster select').attr('disabled', false);
                $('#employeeDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmEmpMaster").submit();
                $('#frmEmpMaster select').attr('disabled', true);
                $('#employeeDate').jqxDateTimeInput({disabled: true});
                
                $('#window').jqxWindow('close');
            });  
				           
}); 
				       
                       
    </script>
    <div id="employeeMainSearch"></div>
    