<%@page import="com.controlcentre.masters.vehiclemaster.brand.ClsBrandAction" %>
<%ClsBrandAction cba=new ClsBrandAction(); %>


    <script type="text/javascript">
  		var data= '<%=cba.searchDetails() %>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'BRAND_NAME', type: 'String'  },
                          	{name : 'DATE', type: 'date'  }
                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxBrandSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
					{ text: 'DOC NO',filtertype:'number', datafield: 'DOC_NO', width: '10%' },
					{ text: 'BRAND',columntype: 'textbox', filtertype: 'input', datafield: 'BRAND_NAME', width: '50%' },
					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '40%',cellsformat:'dd.MM.yyyy' }
	              ]
            });
            $('#jqxBrandSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBrandSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("brand").value = $("#jqxBrandSearch").jqxGrid('getcellvalue', rowindex1, "BRAND_NAME");
                $("#date_brand").jqxDateTimeInput('val', $("#jqxBrandSearch").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxBrandSearch"></div>
