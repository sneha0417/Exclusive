<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO(); %>
<script type="text/javascript">
      
      $(document).ready(function () { 	
    	  var datacomplaint='<%=inspdao.getComplaint()%>';
        // alert(datadamage); 
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [

							
							{name : 'compname' , type:'string'},
							{name : 'docno' , type:'string'}
							],
                
                localdata: datacomplaint,
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
            $("#complaintGrid").jqxGrid(
            {
                width: '100%',
                height: 345,
                source: dataAdapter,
                //rowsheight:18,
               // statusbarheight:25,
                columnsresize: true,
                //columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
               // disabled:true,
               //showstatusbar:true,
                //editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                   /* var cell = $('#newGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#newGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
               },
                columns: [
{ text: 'Doc No',  datafield: 'docno',  width: '15%'},
{ text: 'Complaint',  datafield: 'compname',  width: '85%'}

	              ], 
            });
            $('#complaintGrid').on('celldoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	var row2=document.getElementById("temprowcomplaint").value;
            	var compname=$('#complaintGrid').jqxGrid('getcellvalue', rowindex, "compname");
            	var doc=$('#complaintGrid').jqxGrid('getcellvalue', rowindex, "docno");
            	$("#newmaintenanceGrid").jqxGrid('setcellvalue', row2, "description", compname);
            	$("#newmaintenanceGrid").jqxGrid('setcellvalue', row2, "doc", doc);
            	//alert("Rowindex"+rowindex+"Row2"+row2);
            $('#newmaintenanceGrid').jqxGrid('focus');
            	 $('#newmaintenanceGrid').jqxGrid('selectcell', row2, 'remarks');
             	$('#newmaintenanceGrid').jqxGrid('focus',row2,'remarks'); 
             	// $("#newmaintenanceGrid").jqxGrid('begincelledit', row2, "remarks"); 
            	 $("#newmaintenanceGrid").jqxGrid('addrow', null, {});  
             	$('#maintenancewindow').jqxWindow('close');
            	          	 
            });
        });
            </script>
            <div id="complaintGrid"></div>
            