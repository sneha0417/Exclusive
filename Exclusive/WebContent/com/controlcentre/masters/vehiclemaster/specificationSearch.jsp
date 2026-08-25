<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleDAO" %>
<% ClsVehicleDAO cvd =new ClsVehicleDAO();%>
<script type="text/javascript">
        $(document).ready(function () { 	
        	//var url = "specification.txt";
            var dataspec2='<%=cvd.getSpec()%>'; 
            //alert(dataspec);
        	var num = 0; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int'  },
     						{name : 'name', type: 'string'   },							
     						{name : 'details', type: 'string'   },
     						],
                 localdata: dataspec2,
                
                
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

            
            
            $("#specificationSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                //editable: true,
                altRows: true,
                /* showfilterrow: true, */
                /* filterable: true, */ 
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#specificationSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'details' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#specificationSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                },
                
                       
                columns: [
							{ text: 'Doc No',datafield: 'doc_no', width: '5%' },	
							{ text: 'Name', datafield: 'name', width: '25%' },			
							{ text: 'Details', datafield: 'details', width: '70%' },					
			              ]
            });
            $("#specificationSearch").on("rowdoubleclick", function (event) {
            	
                var row2=event.args.rowindex;
                document.getElementById("docno").value=$('#specificationSearch').jqxGrid('getcellvalue', row2, "doc_no");
                document.getElementById("specname").value= $('#specificationSearch').jqxGrid('getcellvalue', row2, "name");
                document.getElementById("specdetails").value=$('#specificationSearch').jqxGrid('getcellvalue', row2, "details");
              $('#window').jqxWindow('close'); 
                });
        });
    </script>
    <div id="specificationSearch"></div>
