 

<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <jsp:include page="../../includes.jsp"></jsp:include>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script  src="<%=contextPath%>/js/scanner.js"></script>
<script type="text/javascript" src="/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="/js/resample.js"></script>

 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
 
 String formcode = request.getParameter("formCode")==null?"NA":request.getParameter("formCode"); 
 String brchid = request.getParameter("brchid")==null?"0":request.getParameter("brchid"); 
 
 String frmname = request.getParameter("frmname")==null?"":request.getParameter("frmname"); 
 
 
 %>
 
 <style type="text/css">
 .icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}

.btns {
  background: #d9344a;
  background-image: -webkit-linear-gradient(top, #d9344a, #b82b4e);
  background-image: -moz-linear-gradient(top, #d9344a, #b82b4e);
  background-image: -ms-linear-gradient(top, #d9344a, #b82b4e);
  background-image: -o-linear-gradient(top, #d9344a, #b82b4e);
  background-image: linear-gradient(to bottom, #d9344a, #b82b4e);
  font-family: Arial;
  color: #ffffff;
  font-size: 12px;
  padding: 3px 8px 2px 8px;
  text-decoration: none;
}

.btns:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}

 .icons {
	width: 1em;
	height: 1em;
	border: none;
	background-color: #E0ECF8;
}


 </style>

	<script type="text/javascript"> 
	$(document).ready(function(){
		  $("body").prepend('<div id="attachoverlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		     $("body").prepend("<div id='attachPleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:400px;'><img src='../../icons/31load.gif'/></div>");
		var masterdocno='<%=docNo%>';
		var formcode='<%=formcode%>';
		
		var brchid='<%=brchid%>';
		var frmname='<%=frmname%>';
		if(masterdocno>0)
			{
			document.getElementById("docno").value=masterdocno;
			}
		if(formcode!='NA')
			{
			document.getElementById("formdetailcode").value=formcode;
			}
		if(brchid>0)
		{
		document.getElementById("brchid").value=brchid;
		}
		if(frmname!="")
			{
			document.getElementById("frmnames").innerText=frmname;
			document.getElementById("formnames").value=frmname;
			
			}
		
		
		getRefType();
		 var indexVal2 = document.getElementById("docno").value;
		 

    	  
         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
			});	
	
	 
	 function ajaxFileUpload()  
	      {  
		   var reftypid=document.getElementById("reftypid").value;
			    //check whether browser fully supports all File API
			    if (window.File && window.FileReader && window.FileList && window.Blob)
			    {
			        //get the file size and file type from file input field
			        var fsize = $('#file')[0].files[0].size;
			        
			         
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
	                  url:'fileAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#txtdesc").val()+'&reftypid='+$("#reftypid").val() ,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'json',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                      <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
	                      alert("============="+data); --%>
	                     if(status=='success'){
	                        // funAttachBtn();
	                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              //$.messager.alert('Message',data.error);
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              //$.messager.alert('Message',data.message);
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      //alert(e);  
	                      $.messager.alert('Message',e);
	                  }  
	              }  
	          )  
	          return false;  
	      }
	
	 function reload(){
		$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
		
		<%--  $('#jqxDocumentsAttach').jqxGrid('refreshdata');
		 //Thread.sleep(10000);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>); --%>
	 }
 
	function SaveToDisk(fileURL, fileName) {
		
		
		
	 //  alert(fileURL);
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
	        //alert(save);
	       // alert(fileURL);
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
			
	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	        
	        //var event = document.createEvent('Event');
	       // alert(event);
	        //event.initEvent('click', true, true);
	        //save.dispatchEvent(event);
	        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
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
	    /* var spltname = filename.split(".");
	    alert("==spltname==="+spltname[0]); */
	    <%-- alert("==filename=="+filename);
	    var dtype=<%=request.getParameter("formCode")%>;
	    alert("==dtype=="+dtype);
	    var doc_no=<%=request.getParameter("docno")%>;
	     --%>
	   
	    //alert("==doc_no=="+doc_no);
	 var x=new XMLHttpRequest();
	 var items,brchItems,currItems,mcloseItems;
	 x.onreadystatechange=function(){
	  if (x.readyState==4 && x.status==200)
	   {
	         items= x.responseText;
	         if(items>0){
	        	 var indexVal2 = document.getElementById("docno").value;
	    		 

	       	  
	             $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
	        	  $.messager.alert('Message','Successfully Deleted');
	        	/*  $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); */ 
	         }
	         else{
	  		  $.messager.alert('Message','Not Deleted');
	  	/* 	 $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             });  */
	  	     }
	      }
	  else
	   {}
	 }
	 x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
	 x.send();
	}
	
	 function saveViaAJAX()
	 {
		 
		
		 var testCanvas =null;
		 var formname=document.getElementById("formdetailcode").value;
		 var docno=document.getElementById("docno").value;
		 var reftypid=document.getElementById("reftype").value;
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
	 	ajax.open("POST",<%=contextPath+"/"%>+'saveImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid,true);    
	 	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	 	
	 	ajax.onreadystatechange=function()
	   	{
	 		if (ajax.readyState == 4)
	 		{ 
	 			//document.getElementById("savemsg").innerText="Successfully Attached";
	 			/*  
	 			 $.messager.show({title:'Message',msg:'Successfully Attached',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 });
	 			 
	 			 
	 			  */
	 			 var indexVal2 = document.getElementById("docno").value;
	 			   
	 	         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
	 			 
	    	 $.messager.alert('Message',"Successfully Attached");
	    		 
	 			//alert(ajax.responseText);
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
	else if(iscapture==2){
		savedata();
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
	 //alert(fsize);
	 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
	
	 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
       {
		 
		 if(fsize>1048576)
			 {
			 document.getElementById("errormsg").innerText="Please Wait......";
			 }
		 
		 
		 
       }
      
	
	
}

function comonsnapshotWindow()
{

	 document.getElementById("iscapture").value=1;
	 
    window.open(<%=contextPath+"/"%>+"com/common/snapshot.jsp", "CommonCamera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
     
    
}


function getRefType()
{	
	
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
    	   optionref += '<option value="' + refdocno[i] + '">' + refname[i] + '</option>';
    	  
        }
       $("select#reftype").html(optionref); 
       
        	
        }
	else
		{
		}
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
function formsub()
{
var iscapture=document.getElementById("iscapture").value;
	
	if(iscapture==1){
		saveViaAJAX();
	}
	 
	else
		{
	
	 
    if (window.File && window.FileReader && window.FileList && window.Blob)
	    {
	         
	        var fsize = $('#file')[0].files[0].size;
	        
	        if(fsize>10380902) //do something if file size more than 1 mb (1048576)
	        {
	        	 
	            $.messager.alert('Message',fsize +' bytes too big ! Maximum Size 9.9 MB!','warning');
	              
	            return false;
	        }
	        else
	        	{
	        	 
	        	  $( "#from1").submit();
	        	}
	        return false;
	    } 
	  
		}
	}
	 
	function setValuess()
	{
		
		if($('#msgs').val()!=""){
	 		   $.messager.alert('Message',$('#msgs').val());
	 		  $('#msgs').val('');
	 		  }
		
	}
	
	
	function scans(paths) {
		
	 
		   scanner.scan(displayResponseOnPage,
		       {
		           "output_settings": [
		               {
		                   "type": "save",
		                   "format": "jpg",
		                   "save_path": ""+paths
		               }
		           ]
		       }
		   );
		   
			/*  var indexVal2 = document.getElementById("docno").value;
			   
 	         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
 			 
    	 $.messager.alert('Message',"Successfully Attached"); */
		   
		}

		function displayResponseOnPage(successful, mesg, response) {
		   document.getElementById('response').innerHTML = scanner.getSaveResponse(response);
		}
		
		
	 
		
		
		function savedata()
 	    {

			 var formname=document.getElementById("formdetailcode").value;
			 var docno=document.getElementById("docno").value;
			 var reftypid=document.getElementById("reftype").value;
			 
			 var typeid=2;
			 if(docno==""){
				 document.getElementById("errormsg").innerText="Please Select a Document Number";
		  		 return false;
			 }
			 
				
			 
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					
		 
					
					 if(parseInt(items))
						 {
						 var indexVal2 = document.getElementById("docno").value;
						   
			 	         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
			 			 
			    	 $.messager.alert('Message',"Successfully Attached"); 
			    	 document.getElementById("iscapture").value=0;
						 }
					 else
						 {
						 
						 $.messager.alert('Message',"Not Attached"); 
						 document.getElementById("iscapture").value=0;
						 
						 }
					 
					
					
					
				} else {
				}
			}
			x.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid+'&typeid='+typeid,true);   
			x.send();
		
 	    }

 		function scansdata()
 	    {
 		
 			
 			 var formname=document.getElementById("formdetailcode").value;
			 var docno=document.getElementById("docno").value;
			 var reftypid=document.getElementById("reftype").value;
			 var typeid=1;
			 if(docno==""){
				 document.getElementById("errormsg").innerText="Please Select a Document Number";
		  		 return false;
			 }
			 
				
 			 
 		
 			var x = new XMLHttpRequest();
 			x.onreadystatechange = function() {
 				if (x.readyState == 4 && x.status == 200) {
 					var items = x.responseText.trim();	
 					document.getElementById("iscapture").value=2;
 					scans(items);
 					
 					
 					
 				} else {
 				}
 			}
 			x.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid+'&typeid='+typeid,true);   
 			x.send();
 		
 		
 		}
 		 
 	
 		
 	 
	</script>
	
<script type="text/javascript" >
// Need to upload scanned images to server or save them on hard disk? Please refer to the dev guide: http://asprise.com/document-scan-upload-image-browser/ie-chrome-firefox-scanner-docs.html
// For more scanning code samples, please visit https://github.com/Asprise/scannerjs.javascript-scanner-access-in-browsers-chrome-ie.scanner.js
 
var scanRequest = {
    "use_asprise_dialog": true, // Whether to use Asprise Scanning Dialog 
    "show_scanner_ui": false, // Whether scanner UI should be shown 
    "twain_cap_setting": { // Optional scanning settings 
        "ICAP_PIXELTYPE": "TWPT_RGB" // Color 
    },
    "output_settings": [{
        "type": "return-base64",
        "format": "jpg"
    }]
};
 
/** Triggers the scan */
function scan() {

    scanner.scan(displayImagesOnPage, scanRequest);
}
 
/** Processes the scan result */
function displayImagesOnPage(successful, mesg, response) {
    if (!successful) { // On error 
        console.error('Failed: ' + mesg);
        return;
    }
    if (successful && mesg != null && mesg.toLowerCase().indexOf('user cancel') >= 0) { // User cancelled. 
        console.info('User cancelled');
        return;
    }
    var scannedImages = scanner.getScannedImages(response, true, false); // returns an array of ScannedImage 
    for (var i = 0;
        (scannedImages instanceof Array) && i < scannedImages.length; i++) {
        var scannedImage = scannedImages[i];
        var elementImg = scanner.createDomElementFromModel({
            'name': 'img',
            'id': 'canvasids',
            'attributes': {
                'class': 'scanned',
                'src': scannedImage.src
            }
        });
         
        // alert(scannedImage.src);
        (document.getElementById('images') ? document.getElementById('images') : document.body).appendChild(elementImg);
       // alert(scannedImage.src);
      
    }
	$("#attachoverlay, #attachPleaseWait").show();
    saveViaAJAX1(scannedImage.src);
  //  document.getElementById("errormsg").innerText="Scanning In Progress... ";
}

 

 


 function saveViaAJAX1(scannedImages)
{
	
	
	 var testCanvas =null;
	 var formname=document.getElementById("formdetailcode").value;
	 var docno=document.getElementById("docno").value;
	 var reftypid=document.getElementById("reftype").value;
	 if(docno==""){
		 document.getElementById("errormsg").innerText="Please Select a Document Number";
 		 return false;
	 }
	 
		
	  
	 /* 	var canvasData = testCanvas.toDataURL("image/png"); */
	// alert(scannedImages);
	 	var postData = "canvasData="+scannedImages;
	//var canvasData = testCanvas.toDataURL("image/png");
	
	
	var ajax = new XMLHttpRequest();
	ajax.open("POST",'savescanImages.jsp?formname='+formname+'&docno='+docno+'&descpt='+$("#txtdesc").val()+'&reftypid='+reftypid,true);    
	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	
	ajax.onreadystatechange=function()
  	{
		if (ajax.readyState == 4)
		{ 
			//document.getElementById("savemsg").innerText="Successfully Attached";
			/*  
			 $.messager.show({title:'Message',msg:'Successfully Attached',showType:'show',
                style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
            });
			 
			 
			  */
			 var indexVal2 = document.getElementById("docno").value;
			   
	         $("#attachs").load("Attachgridmaster.jsp?docno="+indexVal2+"&formc="+document.getElementById("formdetailcode").value);
			 
   	 $.messager.alert('Message',"Successfully Attached");
   	 
 	$("#attachoverlay, #attachPleaseWait").hide();
   	// document.getElementById("errormsg").innerText="";
			//alert(ajax.responseText);
			// Write out the filename.
    		
		}
  	}
 
	ajax.send(postData);  
}
 



</script> 
	
<style type="text/css">
.scanned
{
height:100px;
width:100px
}


</style>
<body onload="setValuess();">

 <table width="50%">
 <tr><td>
<!--  <button type="button" onclick="scan();">Scan</button> 
  -->

<div id="images" hidden="true"  style=" border: 1px"  height="480" width="640"></div>
 

	
	 


 </td></tr>
 </table>


<fieldset>
<table width="100%"   >
<tr><td width="5%" ></td> <td width="70%" align="center">
<label id="frmnames" name="frmnames" style="color:blue;font-weight:bold;font-size:14px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="frmnames"/></label> </td>
<td  width="30%">

 <button class="icon" id="btnAttachDelete" title="Delete current Document" onclick="Delete();">
							<img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
						</button>
						&nbsp;&nbsp;
		<button class="icon" id="click" title="Take SnapShot " onclick="comonsnapshotWindow();">
							<img alt="deleteDocument" src="<%=contextPath%>/icons/asnapshot.png">
						</button>	
				<button class="icon"  id="click" title="scanner " onclick="scan();">
							<img alt="scanner" src="<%=contextPath%>/icons/Scanner.png">
						</button>			
						
						<!--  <button type="button" onclick="scansdata();">Scan</button> -->
						
						</td></tr></table>
						</fieldset>
						<br>
  <form action="fileAttachActionmaster" id="from1" method="post" enctype="multipart/form-data">

<div id=search>
<fieldset>
<table width="100%"   >
  <tr>
    <td width="7%" align="right">Description</td>
    <td colspan="2"><input type="text" name="txtdesc" id="txtdesc" style="width:95%" value='<s:property value="txtdesc"/>'></td>
    
    <td width="23%"  align="left"> Ref Type:
      <select name="reftype" id="reftype"  style="width:50%"  > 
					</select> </td>     
      <td width="21%"><input type="file" id="file" name="file" onChange="return loading();" /></td>  
    <td width="20%" align="center"><!-- <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Attach"  onclick="return ajaxFileUpload();"> -->
    
   <button class="icon" id="alttachsss" title="Attach"  type="button" onclick="formsub()">
							<img alt="" src="<%=contextPath%>/icons/attachicon.png">
						</button>  
   			
   			 
   			
						</td>
		</tr>				
						
		</table>
		</fieldset>				
 <table width="100%"  >
  <tr>
   <td width="100%" ><div id="attachs">  <jsp:include page="Attachgridmaster.jsp"></jsp:include></div></td>
  </tr></table>
  <input type="hidden" name="formnames" id="formnames" value='<s:property value="formnames"/>'/>
<input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
<input type="hidden" name="msgs" id="msgs" value='<s:property value="msgs"/>'/>

<input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'/> 
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'/>
<input type="hidden" name="brchid" id="brchid" value='<s:property value="brchid"/>'/>
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
  </div>
  
  </form>
  
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
 