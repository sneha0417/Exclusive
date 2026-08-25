<%@page import="com.project.execution.projectInvoice.ClsProjectInvoiceDAO"%>
<% ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO(); %>
<script type="text/javascript">
  
var costcode= '<%=DAO.costCodeSearch() %>';

  	 $(document).ready(function () { 	
  	
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
							{name : 'reg_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
         
		 
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true},
							  { text: 'Reg No.', datafield: 'reg_no', width: '20%'},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Cost Group', datafield: 'name' },
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("txtrefdetails").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "name");
                document.getElementById("costid").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("txtcontract").value=$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "name");
				
				
                $('#costCodeSearchWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 