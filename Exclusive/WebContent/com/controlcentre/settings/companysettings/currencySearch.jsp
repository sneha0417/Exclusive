<%@page import="com.controlcentre.settings.companysettings.currency.ClsCurrencyAction"%>
<%ClsCurrencyAction cca=new ClsCurrencyAction();%>

    <script type="text/javascript">
    var data= '<%=cca.searchDetails() %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'code', type: 'String'  },
                          	{name : 'c_name', type: 'String'  },
                          	{name : 'decimals',type:'String'},
                          	{name : 'fraction', type:'String'},
                          	{name : 'country', type:'String'},
                          	
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
            $("#jqxCurrencySearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'code', width: '20%' },
					{text: 'Currency',datafield:'c_name',width:'70%'},
					{ text: 'Decimals', datafield: 'decimals', width: '20%' },
					{ text: 'Fraction', datafield: 'fraction', width: '20%' },
					{ text: 'Country', datafield: 'country', width: '20%' },
					

					]
            });
           $("#jqxCurrencySearch").jqxGrid('hidecolumn', 'decimals'); 
           $("#jqxCurrencySearch").jqxGrid('hidecolumn', 'fraction');
           $("#jqxCurrencySearch").jqxGrid('hidecolumn', 'country');
         

           
            $('#jqxCurrencySearch').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcode").value=$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtcodename").value=$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "c_name");
                document.getElementById("txtdecimal").value=$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "decimals");
                document.getElementById("txtfraction").value=$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "fraction");
                document.getElementById("txtcountry").value=$('#jqxCurrencySearch').jqxGrid('getcellvalue', rowindex1, "country");
                
                document.close();
            }); 
            $('#jqxCurrencySearch').on('rowdoubleclick', function (event) 
            		{ 
                $('#window').jqxWindow('hide');
            		 }); 
      
        });
    </script>
    <div id="jqxCurrencySearch"></div>
