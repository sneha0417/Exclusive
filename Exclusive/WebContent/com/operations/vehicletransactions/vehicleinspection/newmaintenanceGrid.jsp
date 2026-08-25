<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%String docno=request.getParameter("doc")==null?"0":request.getParameter("doc"); %>
<%String fleet=request.getParameter("fleet");
ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO();%>
<script type="text/javascript">
      var datanewmaintenance;
        $(document).ready(function () { 	
        	if(document.getElementById("docno").value!=''){
        		datanewmaintenance='<%=inspdao.getNewMaintenance(fleet,docno)%>';
        	}
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [
	{name : 'description' , type:'string'},
	{name : 'remarks' , type:'string'},
	{name :'doc',type:'string'}
	
	],
                
                localdata: datanewmaintenance,
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
           
            $("#newmaintenanceGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
               // rowsheight:18,
                //statusbarheight:25,
                columnsresize: true,
                //columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
             	//showaggregates:true,
               //showstatusbar:true,
                editable:true,
                disabled:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                    var cell = $('#newmaintenanceGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#newmaintenanceGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
                    var cell1 = $('#newmaintenanceGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'description') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	document.getElementById("temprowcomplaint").value=cell1.rowindex;
                        	  $('#maintenancewindow').jqxWindow('open');
                         		$('#maintenancewindow').jqxWindow('focus');
                          	   maintenanceSearchContent('complaintGrid.jsp');
                          	 $('#newmaintenanceGrid').jqxGrid('render');
                          }
                       
                        
                    }
               },
                columns: [
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },	
{ text: 'Description',  datafield: 'description',  width: '30%',editable:true},
{ text: 'Remarks', datafield:'remarks', width:'60%',editable:true },
{ text: 'Damage Id', datafield:'doc', width:'60%',hidden:true }

	              ], 
            });
            var rows=$("#newmaintenanceGrid").jqxGrid('getrows');
            var rowcount=rows.length;
            if(rowcount==0){
            	  $("#newmaintenanceGrid").jqxGrid("addrow", null, {});
            }
         //   $("#newmaintenanceGrid").jqxGrid("addrow", null, {});
            $('#newmaintenanceGrid').on('celldoubleclick', function (event) {
            	//alert("checcking "+event.args.rowindex);
            	document.getElementById("temprowcomplaint").value=event.args.rowindex;
                var row1=event.args.rowindex; 
               // alert("Row1="+row1);
                if(event.args.columnindex == 1){
             		   $('#maintenancewindow').jqxWindow('open');
                   		$('#maintenancewindow').jqxWindow('focus');
                    	   maintenanceSearchContent('complaintGrid.jsp');
             	   }
                else{
                }
                });
        });
            </script>
            <div id="newmaintenanceGrid"></div>
            <input type="hidden" name="temprowcomplaint" id="temprowcomplaint">