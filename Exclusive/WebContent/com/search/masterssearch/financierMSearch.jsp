<%@page import="com.search.ClsMastersSearch" %>
<%ClsMastersSearch cms=new ClsMastersSearch(); %>


<%--    <jsp:include page="../../../includes.jsp"></jsp:include>  
 --%><script type="text/javascript">
    var data3= '<%= cms.financierMSearch()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'fname', type: 'String'  }
                 ],
                 localdata: data3,
                
                
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
            $("#jqxFinancierGrid").jqxGrid(
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
					{ text: 'Financier',columntype: 'textbox', filtertype: 'input', datafield: 'fname', width: '80%' }
	              ]
            });

            $('#jqxFinancierGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("financier").value= $('#jqxFinancierGrid').jqxGrid('getcellvalue', rowindex1, "fname"); 
		                document.getElementById("hidfinancier").value = $("#jqxFinancierGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		              $('#financierWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxFinancierGrid"></div>
