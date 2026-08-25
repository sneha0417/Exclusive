<%@page import="com.controlcentre.settings.currencybook.ClsCurrencyBookDAO" %>
<%ClsCurrencyBookDAO cbd=new ClsCurrencyBookDAO(); %>

<script type="text/javascript">
        
        var national= '<%= cbd.currencySearchGrid() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'c_name', type: 'string' },
     						{name : 'code', type: 'string' },
     						{name : 'country', type: 'string' },
     						{name : 'curid', type: 'int' }
                        ],
                		 localdata: national, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxCurrencySearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Currency', datafield: 'c_name', width: '30%' },
							{ text: 'Code', datafield: 'code', width: '20%' },
							{ text: 'Country', datafield: 'country', width: '50%' },
							{ text: 'Currency Id', datafield: 'curid', hidden:true, width: '10%' },
						]
            });
            
            $('#jqxCurrencySearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxCurrencyBook').jqxGrid('setcellvalue', rowindex1, "code" ,$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex2, "code"));
                $('#jqxCurrencyBook').jqxGrid('setcellvalue', rowindex1, "curid" ,$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex2, "curid"));
          	    
               $('#currencyWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxCurrencySearch"></div>
 