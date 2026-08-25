<%@page import="com.dashboard.leadmanagement.leadmngmntfollwup.ClsLeadMngmntFollwUpDAO"%>
<% ClsLeadMngmntFollwUpDAO DAO=new ClsLeadMngmntFollwUpDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<script type="text/javascript">
        
        var data6= '<%=DAO.salesmanDetailsSearch()%>';  
      
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'salname', type: 'string'   },
     						{name : 'mob', type: 'string'   },
     						{name : 'doc_no', type: 'string'   },
                        ],
                		 localdata: data6,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesmanDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Salesman', datafield: 'salname', width: '70%' },
							{ text: 'Mobile No.',  datafield: 'mob',  width: '30%' },
							{ text: 'doc_no',  datafield: 'doc_no', hidden: true, width: '10%' },
							
						]
            });
            
             $('#salesmanDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtsalesman").value = $('#salesmanDetailsSearch').jqxGrid('getcellvalue', rowindex1, "salname");
                document.getElementById("txtsalid").value = $('#salesmanDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               
            	$('#salesmanwindow').jqxWindow('close'); 
            });  
        });
 
</script>
<div id="salesmanDetailsSearch"></div>
 