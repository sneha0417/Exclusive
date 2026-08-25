<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO(); %>
<script type="text/javascript">
    	  var searchdata='<%=inspdao.getSearchData(session)%>';
      		
        $(document).ready(function () { 	
        	document.getElementById("savemsg").innerText=""; 
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [
{name : 'doc_no' , type: 'string' },
	{name : 'date' , type:'date'},
	{name : 'type' , type:'String'},
	{name : 'reftype' , type:'string'},
	 {name : 'refdocno',type:'string'},
	 {name :'amount',type:'number'},
	 {name :'accident',type:'number'},
	 {name :'polrep',type:'string'},
	 {name :'acdate',type:'date'},
	 {name :'coldate',type:'date'},
	 {name :'place',type:'string'},
	 {name :'fine',type:'number'},
	 {name :'remarks',type:'string'},
	 {name :'claim',type:'number'},
	 {name :'rfleet',type:'string'}
	 ],
                
                localdata: searchdata,
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
          
            $("#searchGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                //rowsheight:18,
                //statusbarheight:25,
                columnsresize: true,
                //columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
             	//disabled:true,
               //showstatusbar:true,
                //editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                    var cell = $('#searchGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#searchGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
               },
                columns: [
                          
{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
{ text: 'Date',  datafield: 'date',  width: '20%',cellsformat:'dd.MM.yyyy'},
{ text: 'Type',  datafield: 'type',  width: '20%' },
{ text:'Fleet', datafield:'rfleet',width:'30%'},
{ text:'Ref Type',datafield:'reftype',width:'20%'},
{ text: 'Ref Docno', datafield:'refdocno', width:'20%',hidden:true },
{ text: 'Amount', datafield:'amount', width:'20%',hidden:true,cellsformat:'d2'},
{ text: 'Accident', datafield:'accident', width:'20%',hidden:true },
{ text: 'PRCS', datafield:'polrep', width:'20%',hidden:true},
{ text: 'Acc Date', datafield:'acdate', width:'20%',hidden:true,cellsformat:'dd.MM.yyyy' },
{ text: 'Collect Date', datafield:'coldate', width:'20%',hidden:true,cellsformat:'dd.MM.yyyy'},
{ text: 'Place', datafield:'place', width:'20%',hidden:true },
{ text: 'Fine', datafield:'fine', width:'20%',hidden:true ,cellsformat:'d2'},
{ text: 'Remarks', datafield:'remarks', width:'20%',hidden:true },
{ text: 'Claim', datafield:'claim', width:'20%',hidden:true }

], 
            });
            var rows=$("#searchGrid").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	  $("#searchGrid").jqxGrid("addrow", null, {});
            }
          
            $('#searchGrid').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	document.getElementById("docno").value=$('#searchGrid').jqxGrid('getcellvalue', rowindex, "doc_no");
            	 $("#date").jqxDateTimeInput('val',$("#searchGrid").jqxGrid('getcellvalue', rowindex, "date"));
            	 $('#cmbtype').val($("#searchGrid").jqxGrid('getcellvalue', rowindex, "type"));
            	 $('#cmbreftype').val($("#searchGrid").jqxGrid('getcellvalue', rowindex, "reftype"));
            	 document.getElementById("rdocno").value=$('#searchGrid').jqxGrid('getcellvalue', rowindex, "refdocno");
            	 document.getElementById("amount").value=$('#searchGrid').jqxGrid('getcellvalue', rowindex, "amount");
            	 document.getElementById("hidaccidents").value=$('#searchGrid').jqxGrid('getcellvalue', rowindex, "refdocno");
            	 document.getElementById("prcs").value=$('#searchGrid').jqxGrid('getcellvalue', rowindex, "polrep");
            	 $("#accdate").jqxDateTimeInput('val',$("#searchGrid").jqxGrid('getcellvalue', rowindex, "acdate"));
            	 $("#collectdate").jqxDateTimeInput('val',$("#searchGrid").jqxGrid('getcellvalue', rowindex, "coldate"));
            	 document.getElementById("accplace").value=$("#searchGrid").jqxGrid('getcellvalue', rowindex, "place");
            	 document.getElementById("accfines").value=$("#searchGrid").jqxGrid('getcellvalue', rowindex, "fine");
            	 document.getElementById("rfleet").value=$("#searchGrid").jqxGrid('getcellvalue', rowindex, "rfleet");
            	 document.getElementById("accremarks").value=$("#searchGrid").jqxGrid('getcellvalue', rowindex, "remarks");
            	 $('#cmbclaim').val($("#searchGrid").jqxGrid('getcellvalue', rowindex, "claim"));
    			 $('#existingdiv').load('existingGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
    			 $('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
    			 $('#existmaintenancediv').load('existmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
    			 $('#newmaintenancediv').load('newmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
            $('#window').jqxWindow('close');
            });
        });
            </script>
            <div id="searchGrid"></div>