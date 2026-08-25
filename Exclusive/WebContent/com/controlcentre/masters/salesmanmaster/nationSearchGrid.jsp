<%@page import="com.controlcentre.masters.salesmanmaster.driver.ClsDriverDAO" %>
<%ClsDriverDAO cd=new ClsDriverDAO(); %>

<script type="text/javascript">
        
        var national= '<%= cd.nationSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'nation', type: 'string' }
                        ],
                		 localdata: national, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxNationSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                
                columns: [
							{ text: 'Nation', datafield: 'nation', width: '100%' }
						]
            });
            
            $('#jqxNationSearch').on('celldoubleclick', function (event) {
            	var rowindex11 =document.getElementById("gridrowindex").value;
                var rowindex2 = event.args.rowindex;
                var tempnation=$('#jqxNationSearch').jqxGrid('getcellvalue', rowindex2, 'nation');
             //  alert("TempNation"+tempnation);
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex11, 'nation1' ,tempnation);
               $('#nationalityWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxNationSearch"></div>
 