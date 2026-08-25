<%@page import="com.common.ClsMultiAttach" %>
<%ClsMultiAttach cma=new ClsMultiAttach(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
    String drId = request.getParameter("drid")==null?"0":request.getParameter("drid");%>
 
 <style type="text/css">
 .icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
 </style>

	<script type="text/javascript">
	$(document).ready(function(){
		
		getRefType();
		var data5='<%= cma.reGridload(docNo,drId,request.getParameter("formCode")) %>';
		
		Check(data5);
			});	
	
	function Check(data5){
		   
		
		  var source =
          {
              datatype: "json",
              datafields: [
						{name : 'sr_no', type: 'string'  },
   						{name : 'extension', type: 'string'  },
   						{name : 'description', type: 'string'    },
   						{name : 'type', type: 'string'    },
   						{name : 'filename', type: 'string'    },
   					    {name : 'path', type: 'string'    }
   						     						
               ],
               localdata: data5, 
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
          $("#jqxDocumentsAttach").jqxGrid(
          {
              width: '125%',
              height: 300,
              source: dataAdapter,
              editable: true,
              selectionmode: 'singlerow',
              columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
    						  groupable: false, draggable: false, resizable: false,datafield: '',
    						  columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
    						  cellsrenderer: function (row, column, value) {
        							return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
    							}    
							},
							{ text: 'Sr. No.', sortable: false, hidden:true, filterable: false, editable: false,
                              datafield: 'sr_no', width: '10%',cellsalign: 'center', align: 'center', editable: false	},
							{ text: 'Doc Type', datafield: 'extension', width: '10%', editable: false },
							{ text: 'Description', datafield: 'description', width: '35%', editable: false },
							{ text: 'Type', datafield: 'type', width: '25%', editable: false },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:true }
	              ]
          });	
		 $('#jqxDocumentsAttach').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"));
              }); 
		 
		 $('#jqxDocumentsAttach').on('rowclick', function (event) 
	              { 
	               var rowindexes=event.args.rowindex;
	               document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename");
	               document.getElementById("filedocno").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "sr_no");
	              }); 
	}
	 function ajaxFileUpload()  
	      {  
		   var reftypid=document.getElementById("reftypid").value;
		   
			    //check whether browser fully supports all File API
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        //get the file size and file type from file input field
			        var fsize = $('#file')[0].files[0].size;
			        
			        if(fsize>1048576) //do something if file size more than 1 mb (1048576)
			        {
			            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
			            return;
			        }
			    }else{
			    	//$.messager.alert('Message','Please upgrade your browser, because your current browser lacks some new features we need!','warning');
			    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
			        return;
			    }
			
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileMultiAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val()+'&drid='+$("#hiddrid").val() ,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'json',// json  
	                  success: function (data, status)  //  
	                  {  
	                      
	                     if(status=='success'){
	                         funAttachedBtn();
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      $.messager.alert('Message',e);
	                  }  
	              }  
	          )  
	          return false;  
	      }
	
	 function reload(){
		$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
	 }
 
	function SaveToDisk(fileURL, fileName) {

	   var host = window.location.origin;
	  
	   var splt = fileURL.split("webapps"); 
	   var repl = splt[1].replace( /;/g, "/");
	   repl = repl.replace( / /g, "%20");
	   repl = repl.replace( '#', "%23");
	   fileURL=host+repl;
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
			
	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	       
	    }

	    // for IE
	    else if ( !! window.ActiveXObject && document.execCommand)     {
	        var _window = window.open(fileURL, '_blank');
	        _window.document.close();
	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
	        _window.close();
	    }
	}
	
	function Delete(){
	    var filename=document.getElementById("filename").value;
	    var filedocno=document.getElementById("filedocno").value;
	   
	 var x=new XMLHttpRequest();
	 var items,brchItems,currItems,mcloseItems;
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	         items= x.responseText;
	         if(items>0){
	        	 funAttachedBtn();
	        	 
	        	 $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); 
	         }
	         else{
	  		  
	  		 $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
	  	     }
	      }
	  else
	   {}
	 }
	 x.open("GET",<%=contextPath+"/"%>+"/com/common/fileMultiAttachDelete.jsp?filename="+filename+"&docno="+filedocno,true);
	 x.send();
	}
	
	 function saveViaAJAX()
	 {
		 
		
		 var testCanvas =null;
		 var formname=document.getElementById("formdetailcode").value;
		 var docno=document.getElementById("docno").value;
		 var reftypid=document.getElementById("reftypid").value;
		 var drid=document.getElementById("hiddrid").value;
		 
		 if(docno==""){
			 document.getElementById("errormsg").innerText="Please Select a Document Number";
	  		 return false;
		 }
		 var iscapture=document.getElementById("iscapture").value;
			
			if(iscapture==1){
				 testCanvas = document.getElementById("canvasids"); 
			}
			else{
				testCanvas = document.getElementById("canvasid");  
				
			}
			
		  
		 	var canvasData = testCanvas.toDataURL("image/png");
		 	
		 	var postData = "canvasData="+canvasData;
	 	//var canvasData = testCanvas.toDataURL("image/png");
	 	
	 	
	 	var ajax = new XMLHttpRequest();
	 	ajax.open("POST",<%=contextPath+"/"%>+'/com/common/saveMultiImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val()+'&drid='+$("#hiddrid").val(),true);    
	 	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	 	
	 	ajax.onreadystatechange=function()
	   	{
	 		if (ajax.readyState == 4)
	 		{ 
	 			
	 			funAttachedBtn();
	 			 $.messager.show({title:'Message',msg:'Successfully Attached',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 });
	    		
	 			// Write out the filename.
	     		
	 		}
	   	}

	 	ajax.send(postData);  
	 }

function upload(){
	var iscapture=document.getElementById("iscapture").value;
	
	if(iscapture==1){
		saveViaAJAX();
	}
	else{
		
		 var path=document.getElementById("file").value;
		 var fsize = $('#file')[0].files[0].size;
		 //alert(fsize);
		 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		 //alert(extn);
		 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
	        {
			 
			 if(fsize>1048576)
				 { 
				 saveViaAJAX();
				 }
			 else{
		        	ajaxFileUpload();	
		        }
			 
			 
	        }
	        else{
	        	ajaxFileUpload();	
	        }
	}
		 
	 }
	 
	 
	 
	function loading(){
		 document.getElementById("iscapture").value=0;
	 	 var path=document.getElementById("file").value;
		 var fsize = $('#file')[0].files[0].size;
		 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		
		 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
	       {
			 
			 if(fsize>1048576)
				 {
				 document.getElementById("errormsg").innerText="Please Wait......";
				 }
	       }
	}

	function comonsnapshotWindow(){
		 document.getElementById("iscapture").value=1;
	    window.open(<%=contextPath+"/"%>+"com/common/snapshot.jsp", "CommonCamera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
	}


	function getRefType(){	
		var dtype=document.getElementById("formdetailcode").value;
		var x=new XMLHttpRequest();
		var items,refname,refcode,refdocno;
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{  
	        items= x.responseText;
	        items=items.split('####');
	        refname=items[0].split(",");
	        refcode=items[1].split(",");
	        refdocno=items[2].split(",");
	        	var optionref = '';
	        	var optionscurr = '';
	       for ( var i = 0; i < refname.length; i++) {
	    	   getRef(refname[0]);
	    	   optionref += '<option value="' + refname[i] + '">' + refname[i] + '</option>';
	        }
	       $("select#reftype").html(optionref); 
	        }
		else
			{}
	}
	x.open("GET",<%=contextPath+"/"%>+"com/common/getRefType.jsp?dtype="+dtype,true);
	x.send();
	}


function getRef(c){

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	items = items.split('####');
		 		var reftype = items[0].split(",");
		 		var refcode  = items[1].split(",");
		 		var refdocno  = items[2].split(",");
		 		document.getElementById("reftypid").value=refdocno;
		    }
	       else
		  {}
     }
      x.open("GET", <%=contextPath+"/"%>+"com/common/getRef.jsp?reftype="+c,true);
     x.send();
    
   }
	 
</script>
	
	
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Description</td>
    <td colspan="2"><input type="text" name="txtdesc" id="txtdesc" style="width:80%" value='<s:property value="txtdesc"/>'></td>
    
    <td width="23%"  align="left"> Ref Type:
      <select name="reftype" id="reftype"  onchange="getRef(this.value);"> 
					</select> </td>     
      <td width="21%"><input type="file" id="file" name="file" onChange="return loading();" /></td>  
    <td width="20%" align="center"><!-- <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Attach"  onclick="return ajaxFileUpload();"> -->
    
    <button class="icon" id="btnsearch" name="btnsearch" title="Attach" onclick="return upload();">
							<img alt="Attach" src="<%=contextPath%>/icons/attachicon.png">
						</button>
    <button class="icon" id="btnAttachDelete" title="Delete current Document" onclick="Delete();">
							<img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
						</button>
						
		<button class="icon" id="click" title="Take SnapShot " onclick="comonsnapshotWindow();">
							<img alt="deleteDocument" src="<%=contextPath%>/icons/asnapshot.png">
						</button>				
						</td>
						
						
			<input id="reftypid" type="hidden"  />									
		<input id="width" type="hidden" value="640" />
		<input id="height" type="hidden" />
		<input id="data" type="hidden" />
		<input id="iscapture" type="hidden" />
		<br /><span id="message"></span><br />
		<canvas id="canvasid" hidden="true"  height="480" width="640"></canvas>
		<canvas id="canvasids" hidden="true"  height="240" width="320"></canvas>
		<div id="img">
		</div>
						
  </tr>
  
  <tr>
  
    <td colspan="5" align="center"> <div id="refreshdiv"><div id="jqxDocumentsAttach"></div></div>
    </td>
  </tr>
</table>
<input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
<input type="hidden" name="filedocno" id="filedocno" value='<s:property value="filedocno"/>'/>
  </div>
  
  
  
</body>
 <script>
	(function ( $width, $height, $file) {
		
		// (C) WebReflection Mit Style License
		
		// simple FileReader detection
		
		
		// async callback, received the
		// base 64 encoded resampled image
		function resampled(data) {
			//$message.innerHTML = "done";
			
		/* 	  ($img.lastChild || $img.appendChild(new Image)
			).src = data; */
			document.getElementById("data").value=data;
			/* var img = document.getElementById('imgid').src;

			alert(img.getAttribute('src')); // foo.jpg
			alert(img.src); */
			
			/* document.getElementById('imgid').src=data; */
			
			var imgid = new Image();
			imgid.src =data;
			
			var temp_paint = $('#canvasid');
			var temp_ctx = temp_paint[0].getContext('2d');
			
			  //var img = document.getElementById('imgid').src;
			//alert(img);
			 document.getElementById("errormsg").innerText=" ";
			  temp_ctx.drawImage(imgid, 0, 0,640, 480);
	     
		}
		
		// async callback, fired when the image
		// file has been loaded
		function load(e) {
			//$message.innerHTML = "resampling ...";
			// see resample.js
			Resample(
					this.result,
					this._width || null,
					this._height || null,
					resampled
			);
			
		}
		
		// async callback, fired if the operation
		// is aborted ( for whatever reason )
		function abort(e) {
			//$message.innerHTML = "operation aborted";
		}
		
		// async callback, fired
		// if an error occur (i.e. security)
		function error(e) {
			//$message.innerHTML = "Error: " + (this.result || e);
		}
		
		// listener for the input@file onchange
		$file.addEventListener("change", function change() {
			var
				// retrieve the width in pixel
				width = parseInt($width.value, 10),
				// retrieve the height in pixels
				height = parseInt($height.value, 10),
				// temporary variable, different purposes
				file
			;
			// no width and height specified
			// or both are NaN
			if (!width && !height) {
				// reset the input simply swapping it
				$file.parentNode.replaceChild(
					file = $file.cloneNode(false),
					$file
				);
				// remove the listener to avoid leaks, if any
				$file.removeEventListener("change", change, false);
				// reassign the $file DOM pointer
				// with the new input text and
				// add the change listener
				($file = file).addEventListener("change", change, false);
				// notify user there was something wrong
				//$message.innerHTML = "please specify width or height";
			} else if(
				// there is a files property
				// and this has a length greater than 0
				($file.files || []).length &&
				// the first file in this list 
				// has an image type, hopefully
				// compatible with canvas and drawImage
				// not strictly filtered in this example
				/^image\//.test((file = $file.files[0]).type)
			) {
				// reading action notification
				//$message.innerHTML = "reading ...";
				// create a new object
				file = new FileReader;
				// assign directly events
				// as example, Chrome does not
				// inherit EventTarget yet
				// so addEventListener won't
				// work as expected
				file.onload = load;
				file.onabort = abort;
				file.onerror = error;
				// cheap and easy place to store
				// desired width and/or height
				file._width = width;
				file._height = height;
				// time to read as base 64 encoded
				// data te selected image
				file.readAsDataURL($file.files[0]);
				// it will notify onload when finished
				// An onprogress listener could be added
				// as well, not in this demo tho (I am lazy)
			} else if (file) {
				// if file variable has been created
				// during precedent checks, there is a file
				// but the type is not the expected one
				// wrong file type notification
				//$message.innerHTML = "please chose an image";
			} else {
				// no file selected ... or no files at all
				// there is really nothing to do here ...
				//$message.innerHTML = "nothing to do";
			}
		}, false);
	}(
	
		// all required fields ...
		document.getElementById("width"),
		document.getElementById("height"),
		document.getElementById("file")
	));
	</script>




</html>
