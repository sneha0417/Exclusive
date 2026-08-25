 <%@page import="com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleAction" %>
<% ClsVehicleAction cva =new ClsVehicleAction();%>
 <script type="text/javascript">
     var data= '<%=cva.searchDetails() %>'; 
     
        $(document).ready(function () { 	
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
                 ],
                localdata: data,
                //url: url,
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
            $("#jqxVehicleSearch").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'FLEET NO',columntype: 'textbox', filtertype: 'input',datafield: 'fleet_no', width: '20%' },
							{ text: 'FLEET NAME',columntype: 'textbox', filtertype: 'input', datafield: 'flname', width: '60%' },
							{ text: 'REG. NO.', columntype: 'textbox', filtertype: 'input',datafield: 'reg_no', width: '20%' }
	              ]
            });
           
            $('#jqxVehicleSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("fleetno").value= $('#jqxVehicleSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
                document.getElementById("fleetname").value = $("#jqxVehicleSearch").jqxGrid('getcellvalue', rowindex1, "flname");
                document.getElementById("regno").value = $("#jqxVehicleSearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
                $('#window').jqxWindow('hide');
                document.getElementById("frmVehicle").submit();
                //getGridDetails();
                
            });  
        });
    </script>
    <div id="jqxVehicleSearch"></div>
