<%@page import="com.cargo.transportmasters.shipment.ClsShipmentAction"%>
<%@page import="com.cargo.transportmasters.mode.ClsModeAction"%>
<%@page import="com.controlcentre.masters.salesmanmaster.staff.ClsStaffAction" %>
<%ClsShipmentAction csa=new ClsShipmentAction();  %>
<script type="text/javascript">
  		
  		var data= '<%=csa.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'date', type: 'date'  },
                          	{name : 'shipment', type: 'String'  },
                          	
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
            $("#jqxShipmentSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
					{ text: 'Date', datafield: 'date', width: '30%', cellsformat: 'dd.MM.yyyy'  },
					{ text: 'Shipment', datafield: 'shipment', width: '40%' },
					

					]
            });
            $('#jqxShipmentSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#jqxShipmentSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#shipmentdate").jqxDateTimeInput('val', $("#jqxShipmentSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("shipmentid").value = $("#jqxShipmentSearch").jqxGrid('getcellvalue', rowindex1, "shipment");
         
                
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxShipmentSearch"></div>
