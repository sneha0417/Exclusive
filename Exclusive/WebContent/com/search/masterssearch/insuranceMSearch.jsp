<%@page import="com.search.ClsMastersSearch" %>
<%ClsMastersSearch cms=new ClsMastersSearch(); %>

<%--     <jsp:include page="../../../includes.jsp"></jsp:include>  
 --%> <script type="text/javascript">
    var data= '<%= cms.insuranceMSearch()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'inname', type: 'String'  }
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
            $("#jqxInsuranceGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
               // pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', filtertype: 'number',datafield: 'doc_no', width: '20%' },
					{ text: 'Insurance',columntype: 'textbox', filtertype: 'input', datafield: 'inname', width: '80%' }
	              ]
            });

            $('#jqxInsuranceGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("insurance_comp").value= $('#jqxInsuranceGrid').jqxGrid('getcellvalue', rowindex1, "inname"); 
		                document.getElementById("hidinsurance_comp").value = $("#jqxInsuranceGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		              $('#insuranceWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxInsuranceGrid"></div>
