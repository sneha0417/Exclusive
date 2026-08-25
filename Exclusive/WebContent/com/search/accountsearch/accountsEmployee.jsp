<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>

<%--    <jsp:include page="../../../includes.jsp"></jsp:include> --%>   
<%String dtype=request.getParameter("dtype"); %>
<script type="text/javascript">
    var data= '<%=cas.accemployee()%>';
        $(document).ready(function () { 	
          var dtype='<%=dtype%>';  
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
                height: 313,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Account No', filtertype: 'number',datafield: 'doc_no', width: '10%' },
					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '90%' },
					{ text: 'Acno',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '90%',hidden:true }
	              ]
            });

            $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txtaccname").value= $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
		                document.getElementById("txtaccno").value = $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "acno");
		                document.getElementById("hidacno").value= $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                if(dtype=='SLM'){
		                	document.getElementById("salesmanname").value=$('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description");
		                	
		                }
		                else{
		                	document.getElementById("name").value=$('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
		                }
		              $('#accountWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxAccountsGrid"></div>
