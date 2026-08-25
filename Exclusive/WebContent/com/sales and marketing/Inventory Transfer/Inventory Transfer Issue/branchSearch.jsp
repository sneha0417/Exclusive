<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferIssue.ClsTransferIssueDAO"%>
<%ClsTransferIssueDAO DAO= new ClsTransferIssueDAO();%>


<%
String branchid=request.getParameter("branchfrmid")==null?"0":request.getParameter("branchfrmid").trim();
%>

<script type="text/javascript">

     var branchdata= '<%=DAO.searchBranch(session,branchid) %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'int'  },
                              {name : 'branch', type: 'string'  },
                              
                            ],
                       localdata: branchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#branchsearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc_no', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'Branch', datafield: 'branch', width: '100%' },
                              
						]
            });
            
             
          $('#branchsearch').on('rowdoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                
                document.getElementById("txttobranch").value=$('#branchsearch').jqxGrid('getcellvalue', rowindex1, "branch");
                document.getElementById("branchtoid").value=$('#branchsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("errormsg").innerText="";
              $('#branchwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="branchsearch"></div> 