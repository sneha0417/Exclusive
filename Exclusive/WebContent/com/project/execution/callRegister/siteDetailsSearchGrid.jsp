<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String site = request.getParameter("site")==null?"0":request.getParameter("site");
 String contract = request.getParameter("contract")==null?"0":request.getParameter("contract");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
        
        var data6= '<%=DAO.siteDetailsSearch(site,contract,check)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'site', type: 'string'   },
     						{name : 'rowno', type: 'int'   }
                        ],
                		 localdata: data6,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#siteDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Site', datafield: 'site', width: '100%' },
							{ text: 'Doc No',  datafield: 'rowno', hidden: true, width: '5%' },
						]
            });
            
             $('#siteDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtsiteid").value = $('#siteDetailsSearch').jqxGrid('getcellvalue', rowindex1, "rowno");
                document.getElementById("txtsite").value = $('#siteDetailsSearch').jqxGrid('getcellvalue', rowindex1, "site");
    	       	
            	$('#siteDetailsWindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="siteDetailsSearch"></div>
 