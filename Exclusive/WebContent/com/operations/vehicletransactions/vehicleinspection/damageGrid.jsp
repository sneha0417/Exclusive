<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionAction"%>
<%ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO(); %>
<script type="text/javascript">
      
      $(document).ready(function () { 	
    	  var datadamage='<%=inspdao.getDamage()%>';
        // alert(datadamage); 
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [

							{name : 'code1' , type: 'string' },
							{name : 'description1' , type:'string'},
							{name :'docno1',type:'String'}
	],
                
                localdata: datadamage,
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
            $("#damageGrid").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                //rowsheight:18,
               // statusbarheight:25,
			   filterable:true,
               showfilterrow:true,
                columnsresize: true,
                //columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
               // disabled:true,
               //showstatusbar:true,
                //editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                   /*  var cell = $('#newGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#newGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
               },
                columns: [
{ text: 'Code', datafield: 'code1', columntype: 'textbox',filtertype: 'input', width: '20%'},
{ text: 'Description',  datafield: 'description1', columntype: 'textbox',filtertype: 'input',  width: '80%'},
{ text: 'Docno',  datafield: 'docno1',  width: '80%',hidden:true}
	              ], 
            });
          //  $("damageGrid").jqxGrid("addrow", null, {});
            $('#damageGrid').on('celldoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	var row2=document.getElementById("temprow").value;
            	var code=$('#damageGrid').jqxGrid('getcellvalue', rowindex, "code1");
            	var desc=$('#damageGrid').jqxGrid('getcellvalue', rowindex, "description1");
            	var doc=$('#damageGrid').jqxGrid('getcellvalue', rowindex, "docno1");
            	$("#newGrid").jqxGrid('setcellvalue', row2, "code", code);
            	$("#newGrid").jqxGrid('setcellvalue', row2, "description", desc);
            	$("#newGrid").jqxGrid('setcellvalue', row2, "dmgid", doc);
            	
            	 
             	$("#newGrid").jqxGrid('addrow', null, {});
           	 $('#damagewindow').jqxWindow('close');
           //	$('#newGrid').jqxGrid('focus'); 
           	$("#newGrid").jqxGrid('selectcell', row2, 'type');
         	$('#newGrid').jqxGrid('focus',row2,'type'); 
         	 $("#newGrid").jqxGrid('begincelledit', row2, 'type',true); 
                // $("#jqxMaintenances").jqxGrid("addrow", null, {});
            });
        });
            </script>
            <div id="damageGrid"></div>
            