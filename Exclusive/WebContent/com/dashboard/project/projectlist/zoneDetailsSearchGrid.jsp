
<%@page import="com.dashboard.project.projectlist.projectlistDAO"%>
<%projectlistDAO DAO= new projectlistDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 %>
<script type="text/javascript">
        
       var data1= '<%=DAO.zoneDetails( partyname)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'grpcode', type: 'string'   },
     						
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#zoneSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no', width: '20%' },
							{ text: 'Zone', datafield: 'grpcode', width: '80%' },
							
						]
            });
            
             $('#zoneSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("zoneid").value = $('#zoneSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
            	document.getElementById("txtzone").value = $('#zoneSearch').jqxGrid('getcellvalue', rowindex1, "grpcode");
    	       	
            	$('#zoneDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="zoneSearch"></div>
 