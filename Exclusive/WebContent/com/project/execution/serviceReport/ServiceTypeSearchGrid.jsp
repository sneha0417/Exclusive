<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String servicesdetails = request.getParameter("services")==null?"0":request.getParameter("services");
 String itemsdetails = request.getParameter("items")==null?"0":request.getParameter("items");
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 %>
<script type="text/javascript">
        
       var data9= '<%=DAO.serviceTypeSearch(contractno, servicesdetails, itemsdetails, check, dtype)%> ';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'groupname', type: 'string'   },
							{name : 'item', type: 'string'   }
                        ],
                		 localdata: data9,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#servicetypesearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
							{ text: 'Service Type', datafield: 'groupname', width: '60%' },
							{ text: 'Items', datafield: 'item', width: '40%' },
						]
            });
            
            $('#servicetypesearchGrid').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#activityDetailsGridID').jqxGrid('setcellvalue', rowindex1, "stype" ,$('#servicetypesearchGrid').jqxGrid('getcellvalue', rowindex2, "groupname"));
	              $('#activityDetailsGridID').jqxGrid('setcellvalue', rowindex1, "sertypeid" ,$('#servicetypesearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#activityDetailsGridID').jqxGrid('setcellvalue', rowindex1, "item" ,$('#servicetypesearchGrid').jqxGrid('getcellvalue', rowindex2, "item"));
				  $('#ServiceTypeWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="servicetypesearchGrid"></div>
 