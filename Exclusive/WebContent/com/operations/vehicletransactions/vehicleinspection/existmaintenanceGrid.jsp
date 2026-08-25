<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsInspAttach"%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%String fleet=request.getParameter("fleet");
String docno=request.getParameter("doc")==null?"0":request.getParameter("doc");
ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO();
%>
<script type="text/javascript">
      var dataexistmaintenance;
      
    	  dataexistmaintenance='<%=inspdao.getExistComplaint(fleet,docno)%>';
      
        $(document).ready(function () { 	
        	
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
                
                localdata: dataexistmaintenance,
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
           
            $("#existmaintenanceGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
               // rowsheight:18,
                //statusbarheight:25,
                columnsresize: true,
                //columnsheight: 15,
                disabled:true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
             	//showaggregates:true,
               //showstatusbar:true,
                editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                    var cell = $('#existmaintenanceGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#existmaintenanceGrid").jqxGrid('addrow', null, {});
                            num++;                           
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
            var rows=$("#existmaintenanceGrid").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	  $("#existmaintenanceGrid").jqxGrid("addrow", null, {});
            }
            

        });
            </script>
            <div id="existmaintenanceGrid"></div>