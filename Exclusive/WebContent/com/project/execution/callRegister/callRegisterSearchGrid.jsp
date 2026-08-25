<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String complaintdetails = request.getParameter("complaintdetails")==null?"0":request.getParameter("complaintdetails");
 String complaintno = request.getParameter("complaintno")==null?"0":request.getParameter("complaintno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var data7= '<%=DAO.complaintsGridSearchLoading(complaintno, complaintdetails, check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'groupname', type: 'string'   }
                        ],
                		 localdata: data7,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#callregisterGridSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							{ text: 'Complaints', datafield: 'groupname', width: '70%' },
						]
            });
            
            $('#callregisterGridSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#callRegisterGridID').jqxGrid('setcellvalue', rowindex1, "complaint" ,$('#callregisterGridSearch').jqxGrid('getcellvalue', rowindex2, "groupname"));
	              $('#callRegisterGridID').jqxGrid('setcellvalue', rowindex1, "complaintid" ,$('#callregisterGridSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
				  $('#callRegisterGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="callregisterGridSearch"></div>
 