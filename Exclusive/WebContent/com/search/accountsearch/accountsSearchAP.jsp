<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>

<%--     <jsp:include page="../../../includes.jsp"></jsp:include>  
 --%> 
 <% String dtype=request.getParameter("dtype");%>
 <script type="text/javascript">
    var data= '<%= cas.accsearch_ap() %>';
    var dtype='<%=dtype%>';
    $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  },
     						{name : 'acno',type:'string'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxAccountsGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', filtertype: 'number',datafield: 'doc_no', width: '20%' },
					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '80%' },
					{ text: 'Acno',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '80%',hidden:true }
	              ]
            });

            $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                if(dtype=='VDR'){
		                	document.getElementById("dealername").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description");
			                document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
			                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                }
		                else if(dtype=='VIS'){
		                	document.getElementById("insurcompany").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description");
			                document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
			                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                }
		                else if(dtype=='SLA'){
		                	document.getElementById("name").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description");
			                document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
			                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "acno");
			                document.getElementById("hidacno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                }
						 else if(dtype=='GRG'){
		                	//document.getElementById("name").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description");
			                document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
			                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "acno");
			                document.getElementById("hidacno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                }
		                else{
		                	document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
			                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "acno");
		                }
		              $('#accountWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxAccountsGrid"></div>
