 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 <%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%String fleet=request.getParameter("fleet");
 String docno=request.getParameter("doc")==null?"0":request.getParameter("doc");
 ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO();
 %>
<script type="text/javascript">
      var dataexist;
     
    	 
    	 dataexist='<%=inspdao.getExistDamage(fleet,docno)%>'; 
      
        $(document).ready(function () { 	
        	
            // var url="demo.txt"; 
        	var num = 0;
        	var source =
            {
                datatype: "json",
                datafields: [
{name : 'code' , type: 'string' },
	{name : 'description' , type:'string'},
	{name : 'type' , type:'String'},
	{name : 'remarks' , type:'string'},
	 {name : 'upload',type:'string'},
	 {name :'dmgid',type:'string'},
	 {name :'srno',type:'string'}
	],
                
                localdata: dataexist,
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
            var list = ['Scratch', 'Dent', 'Crack','Lost'];
            $("#existingGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                rowsheight:18,
                //statusbarheight:25,
                columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
             	disabled:true,
               //showstatusbar:true,
                editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                    var cell = $('#existingGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                         var commit = $("#existingGrid").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    }
               },
                columns: [
{ text: 'Code', datafield: 'code', width: '10%',editable:false},
{ text: 'Description',  datafield: 'description',  width: '30%',editable:true},
{ text: 'Type',  datafield: 'type',  width: '20%'  ,editable:true,columntype:'',
	createeditor: function (row, column, editor) {
        editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
		} },
		{ text:'Damage Id',datafield:'dmgid',width:'20%',hidden:true},
{ text: 'Remarks', datafield:'remarks', width:'20%',editable:true },
{ text: 'Srno', datafield:'srno', width:'20%',hidden:true},
{   text: 'Attach', width:'20%', columntype: 'custom', datafield: 'upload',
    cellsrenderer: function (row, column, value) {
        if (value == "") {
            return "Select a file";
        };
    },
    createeditor: function (row, cellvalue, editor, cellText, width, height) {
        // construct the editor. 
        editor.html('<input id="attach' + row + '" type="file" onchange="readURL(this);"/>');
    },
    geteditorvalue: function (row, cellvalue, editor) {
        // return the editor's value.
        var value = $("#fileInput" + row).val();
        return value.substring(value.lastIndexOf("\\") + 1, value.length);
    }}
	              ], 
            });
            var rows=$("#existingGrid").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	  $("#existingGrid").jqxGrid("addrow", null, {});
            }
          

        });
            </script>
            <div id="existingGrid"></div>