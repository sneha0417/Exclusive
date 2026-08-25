 <%@page import="com.dashboard.project.servicereportlist.serviceReportListDAO" %>
<% serviceReportListDAO DAO= new serviceReportListDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno"); 
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
 

 %>
 
<script type="text/javascript">
        
       var data5= '<%=DAO.contractDetailsSearch(session,cldocno, contracttype,refno,contractno)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'tr_no', type: 'int'   }
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '99.5%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							{ text: 'Ref No', datafield: 'refno', width: '70%' },
							{ text: 'Tr No',  datafield: 'tr_no', hidden: false, width: '5%' },
						]
            });
            
             $('#contractDetailsSearch').on('rowdoubleclick', function (event) {
            	 
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontract").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("trno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
    	       	
            	$('#contractwindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="contractDetailsSearch"></div>
 