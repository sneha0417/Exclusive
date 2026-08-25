<%@page import="com.dashboard.analysis.ginreport.ClsginreportDAO"%>
<%ClsginreportDAO DAO= new ClsginreportDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String client = request.getParameter("client")==null?"NA":request.getParameter("client");
 String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno");
 String check = request.getParameter("check")==null?"NA":request.getParameter("check");%>
<script type="text/javascript">

       var data1= '<%=DAO.accountDetails(client,cldocno,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'int'   },
     						{name : 'refname', type: 'string'   },
     						
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientAccountSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'cldocno', width: '30%' },
							{ text: 'Client', datafield: 'refname', width: '700%' },
							,
						]
            });
            
             $('#clientAccountSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtclientname").value = $('#clientAccountSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                document.getElementById("cldocno").value = $('#clientAccountSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
            	
    	       	
            	$('#accountDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="clientAccountSearch"></div>
 