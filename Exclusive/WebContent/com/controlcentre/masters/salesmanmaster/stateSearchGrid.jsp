<%@page import="com.controlcentre.masters.salesmanmaster.driver.ClsDriverDAO" %>
<%ClsDriverDAO cd=new ClsDriverDAO(); %>

<script type="text/javascript">
        
        var state= '<%= cd.stateGridSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'state', type: 'string' }
                        ],
                		 localdata: state, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxStateSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'States', datafield: 'state', width: '100%' }
						]
            });
            
            $('#jqxStateSearch').on('celldoubleclick', function (event) {
            	var rowindex1 =$('#gridrowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#jqxDriver').jqxGrid('setcellvalue', rowindex1, "issfrm" ,$('#jqxStateSearch').jqxGrid('getcellvalue', rowindex2, "state"));
               $('#stateWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxStateSearch"></div>
 