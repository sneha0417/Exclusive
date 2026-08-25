<%@page import="com.dashboard.audit.approvalRemove.ClsApprovalRemoveDAO" %>
<% ClsApprovalRemoveDAO card=new ClsApprovalRemoveDAO();%>

<%
String dtype = request.getParameter("dtype")==null?"":request.getParameter("dtype");
 %> 


       <script type="text/javascript">

        var docdata='<%=card.docSearch(dtype)%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'dtype', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'branchname', type: 'string'  },
                            {name : 'brhid', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#docsearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
                  
                columns: [
		                      { text: 'Doc Type', datafield: 'dtype', width: '30%'},
                              { text: 'Doc No', datafield: 'doc_no', width: '30%' },
                              { text: 'BranchName', datafield: 'branchname', width: '40%' },
                              { text: 'brhid', datafield: 'brhid', width: '10%',hidden:true },
						
						]
            });
            
          $('#docsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                //document.getElementById("doctype").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "dtype");
                document.getElementById("doc_no").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("brhid").value=$('#docsearch').jqxGrid('getcellvalue', rowindex2, "brhid");
                
                
                
                
           
              $('#docwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="docsearch"></div>