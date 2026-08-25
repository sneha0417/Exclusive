 <%@page import="com.dashboard.procurment.reservedproduct.ClsReservedProductDAO" %>
<% ClsReservedProductDAO DAO= new ClsReservedProductDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno"); 
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 

 %>
 
<script type="text/javascript">
        
       var datajobcontract= '<%=DAO.contractDetailsSearch(session,cldocno, contracttype,refno,contractno)%>';  
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
                		 localdata: datajobcontract,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '98%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							
							{ text: 'Tr No',  datafield: 'tr_no', hidden: false, width: '29%' },
							{ text: 'Ref No', datafield: 'refno', width: '29%' },
						]
            });
            
             $('#contractDetailsSearch').on('rowdoubleclick', function (event) {
            	 
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcontract").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("contracttrno").value = $('#contractDetailsSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
    	       	
            	$('#contractwindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="contractDetailsSearch"></div>
 