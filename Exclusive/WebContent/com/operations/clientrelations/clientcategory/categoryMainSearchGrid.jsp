<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryAction"%>
<% ClsClientCategoryAction ACTION= new ClsClientCategoryAction(); %>  
<script type="text/javascript">
  
        var data1= '<%=ACTION.searchDetails() %>';
        $(document).ready(function () {
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no', type: 'int'  },
     						{name : 'category', type: 'String'  },
                          	{name : 'cat_name', type: 'String'  },
                          	{name : 'dtypes', type: 'String'  },
                          	{name : 'dtype', type: 'String'  },
    	                   	{ name: 'approval', type: 'int' },
    	                   	{name : 'acc_group', type: 'String'  }
                 ],
               localdata: data1,
                
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
            $("#jqxCategorySearch").jqxGrid(
            {
            	width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columnsresize: true,
               
                columns: [
					{ text: 'Doc No', hidden : true,datafield: 'doc_no', width: '10%' },
					{ text: 'Type',datafield: 'dtypes', width: '10%' },
					{ text: 'Category', datafield: 'category', width: '40%' },
					{ text: 'Category Name', datafield: 'cat_name', width: '50%' },
					{ text: 'Type',datafield: 'dtype', hidden: true, width: '10%' },
					{ text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width: '10%' },
					{ text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true, width: '10%' },
	              ]
            });
            $('#jqxCategorySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				getAccountGroup($("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "dtype"));
                document.getElementById("docno").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcategory").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "category");
                document.getElementById("txtcategoryname").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "cat_name");
                document.getElementById("cmbtype").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "dtype");
                document.getElementById("cmbaccountgroup").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "acc_group");
				document.getElementById("hidcmbaccountgroup").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "acc_group");
   	         	document.getElementById("hidchckapproval").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "approval");
                
	  	        if($("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "approval")==1){
	  	 			 document.getElementById("chckapproval").checked = true;
	  	 		}
	  	 		else if($("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "approval")==0){
	  	 			document.getElementById("chckapproval").checked = false;
	  	 		 }
   	         
                $('#window').jqxWindow('close');
            }); 
            
        });
    </script>
    <div id="jqxCategorySearch"></div>