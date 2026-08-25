<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String servicesdetails = request.getParameter("services")==null?"0":request.getParameter("services");
 String itemsdetails = request.getParameter("items")==null?"0":request.getParameter("items");
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
       var data9= '<%=DAO.serviceComplaintGridLoading(contractno, servicesdetails, itemsdetails, check)%>';  
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
            
            $("#callregisterGridServiceSearch").jqxGrid(
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
            
            $('#callregisterGridServiceSearch').on('rowdoubleclick', function (event) {
	              var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#callRegisterGridID').jqxGrid('setcellvalue', rowindex1, "stype" ,$('#callregisterGridServiceSearch').jqxGrid('getcellvalue', rowindex2, "groupname"));
	              $('#callRegisterGridID').jqxGrid('setcellvalue', rowindex1, "sertypeid" ,$('#callregisterGridServiceSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#callRegisterGridID').jqxGrid('setcellvalue', rowindex1, "item" ,$('#callregisterGridServiceSearch').jqxGrid('getcellvalue', rowindex2, "item"));
				  $('#callRegisterServiceGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="callregisterGridServiceSearch"></div>
 