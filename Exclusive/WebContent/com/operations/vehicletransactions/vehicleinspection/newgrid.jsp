<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<%@page import="com.operations.vehicletransactions.vehicleinspection.ClsVehicleInspectionDAO"%>
<%String docno=request.getParameter("doc")==null?"0":request.getParameter("doc"); %>
<%String fleet=request.getParameter("fleet"); %>
<%String formdetailcode=request.getParameter("code");
ClsVehicleInspectionDAO inspdao=new ClsVehicleInspectionDAO();%>
<script type="text/javascript">
      var datanew;
        $(document).ready(function () { 	
        	if(document.getElementById("docno")!=''){
        		datanew='<%=inspdao.getNewDamage(fleet,docno,formdetailcode)%>';
        	}
        	
        	
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
	 {name :'srno',type:'string'},
	 {name :'path',type:'String'}
	],
                
                localdata: datanew,
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
            /* var renderer = function (id) {
            	return '<input type="button" onClick="return ajaxFileUpload();"   value="Attach"/>';
            } */
            $("#newGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                rowsheight:18,
               // statusbarheight:25,
                columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                //disabled:true,
               //showstatusbar:true,
                editable:true,
                //Add row method
                    handlekeyboardnavigation: function (event) {
                    	var cell = $('#newGrid').jqxGrid('getselectedcell');
                        if (cell != undefined && cell.datafield == 'remarks' && cell.rowindex == num - 1) {
                            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                            if (key == 13) {                                                        
                             var commit = $("#newGrid").jqxGrid('addrow', null, {});
                                num++;                           
                            }
                        }
                    
                    var cell1 = $('#newGrid').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'code') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	document.getElementById("temprow").value=cell1.rowindex;
                        	if(document.getElementById("mode").value=='view'){
                        		return false;
                        	}
                        	$('#damagewindow').jqxWindow('open');
                         		$('#damagewindow').jqxWindow('focus');
                          	   damageSearchContent('damageGrid.jsp');
                          }
                        
                    }

                  /*   var cell2 = $('#newGrid').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'upload') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var row=cell2.rowindex;
                        	//alert(row);
                        	$('#fileInput'+row).trigger('click');
                        	//alert('fileInput'+row);
                          }
                        
                    } */
               },
                columns: [
{ text: 'Code', datafield: 'code', width: '10%', cellbeginedit: function (row) {
    var temp=document.getElementById("mode").value;
    if (temp =="view")
     {
          return false;
     }
    }},
{ text: 'Description',  datafield: 'description',  width: '30%',editable:true, cellbeginedit: function (row) {
    var temp=document.getElementById("mode").value;
    if (temp =="view")
     {
          return false;
     }
    }},
{ text: 'Type',  datafield: 'type',  width: '10%'  ,editable:true,columntype:'dropdownlist',cellbeginedit: function (row) {
    var temp=document.getElementById("mode").value;
    if (temp =="view")
     {
          return false;
     }
    },
	createeditor: function (row, column, editor) {
        editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
		} },
{ text: 'Remarks', datafield:'remarks', width:'20%',editable:true , cellbeginedit: function (row) {
    var temp=document.getElementById("mode").value;
    if (temp =="view")
     {
          return false;
     }
    }},
{ text:'Damage Id',datafield:'dmgid',width:'20%',hidden:true},
{ text:'Srno',datafield:'srno',width:'20%',hidden:true},
{   text: 'Attach', width:'20%', columntype: 'custom',datafield:'upload', cellbeginedit: function (row) {
    var temp=document.getElementById("mode").value;
    var attach=$('#newGrid').jqxGrid('getcellvalue', row, "upload");
   // alert(attach+":::::"+temp);
    if (temp=="view" && attach=="0")
     {
    	//alert("Inside");
          return true;
     }
    else{
    	return false;
    }
    },
    cellsrenderer: function (row, column, value) {
        if (value == "" && document.getElementById("mode").value=="A") {
            return "Select a file";
        };
    },
    createeditor: function (row, cellvalue, editor, cellText, width, height) {
        // construct the editor. '<input id="file' + row + '" name="file' + row + '" type="file" />'
         editor.html('<input type="file" id="file" name="file"  onchange="readURL(this);"/>' ); 
    },
    geteditorvalue: function (row, cellvalue, editor) {
        // return the editor's value.
        var value = $("#file").val();
        return value.substring(value.lastIndexOf("\\") + 1, value.length);
    }},
    { text:'Attach',datafield:'attach',width:'10%',columntype:'custom', cellbeginedit: function (row) {
        var temp=document.getElementById("mode").value;
        if (temp =="view")
         {
              return true;
         }
        if(temp="A"){
        	return false;
        }
        },
       
        createeditor: function (row, cellvalue, editor, cellText, width, height) {
            // construct the editor. 
             var srNo = $('#newGrid').jqxGrid('getcellvalue', row, 'srno');
            //alert(srNo);
             editor.html('<input type="button" class="myButton" onClick="return fileUpload('+srNo+');"  width="5" value="Attach"/>'); 
        }}
	              ], 
            });
            var rows= $("#newGrid").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	$("#newGrid").jqxGrid("addrow", null, {});	
            }
            
            
            
            $('#newGrid').on('celldoubleclick', function (event) {
            	document.getElementById("temprow").value=event.args.rowindex;
                var row1=event.args.rowindex; 
                if(event.args.columnindex == 0){
                	if(document.getElementById("mode").value=='A'){
              		   $('#damagewindow').jqxWindow('open');
                    		$('#damagewindow').jqxWindow('focus');
                     	   damageSearchContent('damageGrid.jsp');
                	}
             	   }
                else{
                }
             if(!(document.getElementById("mode").value=='A' || document.getElementById("mode").value=='E')){
            	var imgpath=$('#newGrid').jqxGrid('getcellvalue', row1, "path");
            	
            	
            	  SaveToDisk($('#newGrid').jqxGrid('getcellvalue', row1, "path"),$('#newGrid').jqxGrid('getcellvalue', row1, "upload")); 
             }
                });
        });
        function ajaxFileUpload(row)  
        {  
      	 
      	 
      	 if($('input[type=file]').val()==""){
      		 document.getElementById("errormsg").innerText="Please Choose a File";
      		 return false;
      	 }
      	 document.getElementById("errormsg").innerText="";
            $.ajaxFileUpload  
            (  
                {  
                    url:'fileUploadInsp.action?formdetailcode='+document.getElementById("formdetailcode").value+'&doc='+document.getElementById("docno").value+'&srno='+row,//  
                   
                    secureuri:false,//false  
                    fileElementId:'file',//id  <input type="file" id="file" name="file" />  
                    dataType: 'json',// json  
                    success: function (data, status)  //  
                    {  
                  	  //alert(data.message);
                  	  //alert(status);
                  	  if(status=="success"){
                  		  document.getElementById("savemsg").innerText="Successfully Attached";
                  		document.getElementById("filedet").value=0;
                  		document.getElementById("filedet").value=0;
                  		  $.messager.alert('Message',"Successfully Attached");
                  		$('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
                  		  
                  	  }
                        //alert(data.message);//jsonmessage,messagestruts2  
                        // document.getElementById("savemsg").innerText="";
                        //$("#testImg").attr("src",data.message);  
                        if(typeof(data.error) != 'undefined')  
                        {  
                            if(data.error != '')  
                            {  
                           //     alert(data.error);  
                            }else  
                            {  
                         //       alert(data.message);  
                            }  
                        }  
                    },  
                    error: function (data, status, e)//  
                    {  
                       // alert(e);  
                    }  
                }  
            )  
            return false;  
        }
        
        function fileUpload(row){
        	
        	var canvasdet=document.getElementById("canvasdet").value;
        	var filedet=document.getElementById("filedet").value;
        	/* alert("==canvasdet==="+canvasdet);
        	alert("==filedet==="+filedet); */
        	//alert($('input[type=file] ').val());
        	 if(($('input[type=file]').val()!="")&&filedet==1){
        	 //alert("===ajaxFileUpload====");
        		 ajaxFileUpload(row);	 
        }
        	 
        	 if(($('input[type=canvas]').val()!="")&&canvasdet==1){
        		 //alert("===saveViaAJAX====");
        		 saveViaAJAX(row);
        		 
        }
        	 
        }
        
    	function SaveToDisk(fileURL, fileName) {
    		  //alert(fileURL);
    		   //fileName='';
    		   var host = window.location.origin;
    		   //alert("hooosssst"+host);
    		  
    		   var splt = fileURL.split("webapps"); 
    		  //alert("after split"+splt[1]);
    		   var repl = splt[1].replace( /;/g, "/");
    		   //alert("repl"+repl);
    		   //alert("after replace===="+repl);
    		   fileURL=host+repl;
    		  //alert("fileURL===="+fileURL);
    		    // for non-IE
    		    if (!window.ActiveXObject) {
    		        var save = document.createElement('a');
    		        //alert(fileName);
    		        var fileext = fileName.split('.');
    		        //alert("==ext===="+fileext[1]);
    		        var extn=fileext[1];
    		        //alert(fileURL);
    		        save.href = fileURL;
    		        save.target = '_blank';
    		       // save.download = fileURL || 'unknown';
    		        //alert(save.href);
    		        if((extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
    		        {
    		        	//alert("hahahahaha");
    		        document.getElementById("prevImage").src=save.href;
    		        }
    		        else{
    		        	//alert("PNGJPEGGIFBMP"+fileURL);
    		        	window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
    		        	
    		        	//save.download = fileURL;
    		        	
    		        }
    		       // window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
    		      /*   var event = document.createEvent('Event');
    		       // alert(event);
    		        event.initEvent('click', true, true);
    		        save.dispatchEvent(event);
    		        (window.URL || window.webkitURL).revokeObjectURL(save.href); */
    		    }

    		    // for IE
    		    else if ( !! window.ActiveXObject && document.execCommand)     {
    		        var _window = window.open(fileURL, '_blank');
    		        _window.document.close();
    		        _window.document.execCommand('SaveAs', true, fileName || fileURL)
    		        _window.close();
    		    }
    		}
            </script>
            <div id="newGrid"></div>
            <input type="hidden" name="temprow" id="temprow" >