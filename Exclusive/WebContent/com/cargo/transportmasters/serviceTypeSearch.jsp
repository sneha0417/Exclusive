<%@page import="com.cargo.transportmasters.servicetype.ClsServiceTypeAction" %>
<%ClsServiceTypeAction csa=new ClsServiceTypeAction(); %>
<script type="text/javascript">
  		
  		var srvcdata= '<%=csa.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date' }, 
     						{name : 'srvtype', type: 'string'   },
     						{name : 'modename', type: 'string'  },
     						{name : 'submode', type: 'string'   },
     						{name : 'shipment', type: 'String'   },
     						{name : 'modeid', type: 'int'  },
     						{name : 'smodeid', type: 'int'  },
     						{name : 'shipid', type: 'int'  }
                          	],
               localdata: srvcdata,
        
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
            $("#jqxServiceTypeSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
                
                columns: [
                      	{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '10%' },
                        { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '10%' },	
						{ text: 'Service Type', datafield: 'srvtype', editable: false, width: '20%' },
						{ text: 'Mode', datafield: 'modename', editable: false, width: '20%' },
						{ text: 'Mode Id', datafield: 'modeid', width: '20%',hidden: true,editable: false },
						{ text: 'Submode', datafield: 'submode', editable: false, width: '20%' },
						{ text: 'SubMode Id', datafield: 'smodeid', width: '20%',hidden: true,editable: false },
						{ text: 'Shipment', datafield: 'shipment', width: '20%',editable: false },
						{ text: 'Shipment Id', datafield: 'shipid', width: '20%',hidden: true,editable: false },
						]
            });
            $('#jqxServiceTypeSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxServiceTypeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#servicedate").jqxDateTimeInput('val', $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("servicetype").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "srvtype");
                document.getElementById("hidcmbmode").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("hidcmbsubmode").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "smodeid");
                document.getElementById("hidcmbshipment").value = $("#jqxServiceTypeSearch").jqxGrid('getcellvalue', rowindex1, "shipid");
                getMode();getShipment();
               
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxServiceTypeSearch"></div>
