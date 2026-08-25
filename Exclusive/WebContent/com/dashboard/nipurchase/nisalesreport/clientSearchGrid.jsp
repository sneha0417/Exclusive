<%@page import="com.dashboard.nipurchase.nisalesreport.ClsnisalesReportsDAO" %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 ClsnisalesReportsDAO  DAO=new  ClsnisalesReportsDAO();
 String clientname = request.getParameter("clientname")==null?"0":request.getParameter("clientname");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
<script type="text/javascript">
var data1;
        
       var data1= '<%=DAO.clientData(clientname, check)%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'},
     						{name : 'clientname', type: 'string'}
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientSearchGridID").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '20%' },
							{ text: 'Client', datafield: 'clientname', width: '80%' }
						]
            });
            
             $('#clientSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("cldocno").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("clientname").value = $('#clientSearchGridID').jqxGrid('getcellvalue', rowindex1, "clientname");
				
            	$('#clientSearchWindow').jqxWindow('close'); 
            });   
        });
    </script>
 <div id="clientSearchGridID"></div>