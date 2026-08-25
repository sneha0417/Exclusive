<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script>

<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
 <style>
.hidden-scrollbar {
  overflow: auto;
  height: 600px;
}
#icons {
 width: 2.5em;
 height: 2em;
 border: none;
 background-color: #E0ECF8;
}
</style>

 
<script type="text/javascript">
      
      $(document).ready(function () { 
    	  
    	  
    	  document.getElementById('download').addEventListener('click', function() {
    		    //downloadCanvas(this);
    		  saveViaAJAX();
    		}, false);
    	  
    	  $("#imagediv").prop("hidden", false); 
    	  	 $("#canvasdiv").prop("hidden", true);
    	  
    	  /* Date */
    	  document.getElementById("btnEdit").disabled=true;
    	    $("#date").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy"});
    	    $("#time").jqxDateTimeInput({ width: '50%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
    	  $("#accdate").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#collectdate").jqxDateTimeInput({ width: '85px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  /* Window */
    	   $('#docwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       	   $('#docwindow').jqxWindow('close');
       	 $('#damagewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Damage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     	   $('#damagewindow').jqxWindow('close');
     	  $('#maintenancewindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Complaint Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	   $('#maintenancewindow').jqxWindow('close');
    	   document.getElementById("savemsg").innerText="";
       	 $('#rdocno').dblclick(function(){
       		 $('#cmbclaim').val('');
       		 document.getElementById("amount").value="";
       	  var reftype=document.getElementById("cmbreftype").value;
      	
      		if(document.getElementById("cmbreftype").value==''){
     			 document.getElementById("errormsg").innerText="Reference Type is Mandatory";
     			 return false;
     		 }
      		 
    		    $('#docwindow').jqxWindow('open');
    			 docSearchContent('docSearch.jsp?reftype='+reftype, $('#docwindow'));
    		});
       	$('#accremarks').keydown(function (evt) {
       	    //alert(evt.keyCode);
       	     if (evt.keyCode==9) {
       	      //alert("inside");
       	             event.preventDefault();
       	             $('#newmaintenanceGrid').jqxGrid('selectcell',0, 'description');
       	             $('#newmaintenanceGrid').jqxGrid('focus',0, 'description');
       	     }
       	   });
       enableAccData();
      });
   
      
      function getDoc(event){
    	 $('#cmbclaim').val('');
    	 document.getElementById("amount").value="";
    	  var reftype=document.getElementById("cmbreftype").value;
    	 
   		if(document.getElementById("cmbreftype").value==''){
  			 document.getElementById("errormsg").innerText="Reference Type is Mandatory";
  			 return false;
  		 }
 			 document.getElementById("errormsg").innerText="";
     	  var x= event.keyCode;
           if(x==114){
        	   $('#docwindow').jqxWindow('open');
      		 docSearchContent('docSearch.jsp?reftype='+reftype, $('#docwindow'));
           }
           else{
            }
      }
      function docSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#docwindow').jqxWindow('setContent', data);
	}); 
	}
      function damageSearchContent(url) {
	      $.get(url).done(function (data) {
	    	 // alert(data);
	    $('#damagewindow').jqxWindow('setContent', data);
	}); 
	}
      function maintenanceSearchContent(url) {
	      $.get(url).done(function (data) {
	    	 // alert(data);
	    $('#maintenancewindow').jqxWindow('setContent', data);
	}); 
	}
   function readURL(input) {
	 
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
            	
            	document.getElementById('prevImage').src=e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
     function funReadOnly(){
  	  $('#frmVehicleInspection input').attr('readonly',true);
  	$('#frmVehicleInspection select').attr('disabled',true);
  	
    }
  function setValues(){
	  funSetlabel();
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		
		 if ($('#hidcmbtype').val() != null) {
				$('#cmbtype').val($('#hidcmbtype').val());
			}
		 if ($('#hidcmbreftype').val() != null) {
				$('#cmbreftype').val($('#hidcmbreftype').val());
			}
		 if ($('#hidcmbclaim').val() != null) {
				$('#cmbclaim').val($('#hidcmbclaim').val());
			}
		 if($('#hiddate').val()){
				$("#date").jqxDateTimeInput('val', $('#hiddate').val());
			}
		 if($('#hidtime').val()){
				$("#time").jqxDateTimeInput('val', $('#hidtime').val());
			}
		 if($('#hidaccdate').val()){
				$("#accdate").jqxDateTimeInput('val', $('#hidaccdate').val());
			}
		 if($('#hidcollectdate').val()){
				$("#collectdate").jqxDateTimeInput('val', $('#hidcollectdate').val());
			}
		 if($('#msg').val()!=""){
	  		   $.messager.alert('Message',$('#msg').val());
	  		  }
		 if(document.getElementById("docno").value>0){
			 $('#existingdiv').load('existingGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
			 $('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
			 $('#existmaintenancediv').load('existmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
			 $('#newmaintenancediv').load('newmaintenanceGrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value);
			 
		 }
  }
  function funSearchLoad(){
		changeContent('mainSearch.jsp'); 
	 }
   function funRemoveReadOnly(){
	   $('#newGrid').jqxGrid({ disabled: false});
	   $('#newmaintenanceGrid').jqxGrid({ disabled: false});
	 	$('#frmVehicleInspection input').attr('readonly',false);
	 	  	$('#frmVehicleInspection select').attr('disabled',false);
	   $('#docno').prop('readonly',true);
	   $('#rdocno').prop('readonly',true);
	   $('#rfleet').prop('readonly',true);
	   if(document.getElementById("mode").value=='A'){
		   $('#existingGrid').jqxGrid('clear');
		   $("#existingGrid").jqxGrid("addrow", null, {});
		   $('#newGrid').jqxGrid('clear');
		   $("#newGrid").jqxGrid("addrow", null, {});
		   $('#existmaintenanceGrid').jqxGrid('clear');
		   $("#existmaintenanceGrid").jqxGrid("addrow", null, {});
		   $('#newmaintenanceGrid').jqxGrid('clear');
		   $("#newmaintenanceGrid").jqxGrid("addrow", null, {});
		   document.getElementById("savemsg").innerText="";
		   document.getElementById("errormsg").innerText="";
	   }
   }
   function funFocus(){
	   document.getElementById("cmbtype").focus();
   }
   function funNotify(){
	   if(document.getElementById("cmbtype").value==""){
		   document.getElementById("errormsg").innerText="";
		   document.getElementById("errormsg").innerText="Type is Mandatory";
		   document.getElementById("cmbtype").focus();
		   return 0;
	   }
	   if(document.getElementById("cmbreftype").value==""){
		   document.getElementById("errormsg").innerText="";
		   document.getElementById("errormsg").innerText="Reference Type is Mandatory";
		   document.getElementById("cmbreftype").focus();
		   return 0;
	   }
	   if(document.getElementById("rdocno").value==""){
		   document.getElementById("errormsg").innerText="";
		   document.getElementById("errormsg").innerText="Reference Doc is Mandatory";
		   document.getElementById("rdocno").focus();
		   return 0;
	   }
	   if(document.getElementById("chkaccidents").checked==true){
		   if($('#accdate').jqxDateTimeInput('getDate')==null){
			   document.getElementById("errormsg").innerText="";
			   document.getElementById("errormsg").innerText="Accident Date cannot be Empty";
			   $("#accdate .jqx-input-content").focus();
			   return 0;
		   }
		   if($('#collectdate').jqxDateTimeInput('getDate')==null){
			   document.getElementById("errormsg").innerText="";
			   document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
			   $("#collectdate .jqx-input-content").focus();
			   return 0;
		   }
	   }
	   var existrowsdamage = $("#existingGrid").jqxGrid('getrows');
		if(!((existrowsdamage[0].srno=="undefined") || (existrowsdamage[0].srno==null) || (existrowsdamage[0].srno==""))){
  	$('#existdamagegridlength').val(existrowsdamage.length);
  		//alert($('#gridlength').val());
  		for(var i=0 ; i < existrowsdamage.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "testexistdamage"+i)
			    .attr("name", "testexistdamage"+i);
				
			newTextBox.val(existrowsdamage[i].srno+"::");
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#testexistdamage"+i).val());
			}
  	} 
	    var rowsdamage = $("#newGrid").jqxGrid('getrows');
		if(!((rowsdamage[0].code=="undefined") || (rowsdamage[0].code==null) || (rowsdamage[0].code==""))){
   	$('#damagegridlength').val(rowsdamage.length);
   		//alert($('#gridlength').val());
   		for(var i=0 ; i < rowsdamage.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
				
			newTextBox.val(rowsdamage[i].code+"::"+rowsdamage[i].description+"::"+rowsdamage[i].type+"::"+rowsdamage[i].remarks+"::"+rowsdamage[i].upload+"::"+rowsdamage[i].dmgid);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
   	} 
		   var rowsmaintenance = $("#newmaintenanceGrid").jqxGrid('getrows');
			if(!((rowsmaintenance[0].description=="undefined") || (rowsmaintenance[0].description==null) || (rowsmaintenance[0].description==""))){
	   	$('#maintenancegridlength').val(rowsmaintenance.length);
	   		//alert($('#gridlength').val());
	   		for(var i=0 ; i < rowsmaintenance.length ; i++){
				//	var myvar = rows[i].tarif; 
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "testmaint"+i)
				    .attr("name", "testmaint"+i);
					
				newTextBox.val(rowsmaintenance[i].description+"::"+rowsmaintenance[i].remarks+"::"+rowsmaintenance[i].doc);
				
				newTextBox.appendTo('form');
				
					//alert("ddddd"+$("#test"+i).val());
				}
	   	}
		
			document.getElementById("errormsg").innerText="";
	   return 1;
   }

 function funResetValues(){
	 funRemoveReadOnly();
	 document.getElementById("rdocno").value="";
	 document.getElementById("rfleet").value="";
 }
 function enableAccData(){
	 if(document.getElementById("chkaccidents").checked==true){
		 document.getElementById("hidaccidents").value="1";
		 $('#accdate').jqxDateTimeInput({ disabled: false});
		 $('#prcs').prop('disabled',false);
		 $('#collectdate').jqxDateTimeInput({ disabled: false});
		 $('#accplace').prop('disabled',false);
		 $('#accfines').prop('disabled',false);
		 $('#cmbclaim').prop('disabled',false);
		 $('#accremarks').prop('disabled',false);
	 }
	 if(document.getElementById("chkaccidents").checked==false){
		 document.getElementById("hidaccidents").value="0";
		 $('#accdate').jqxDateTimeInput({ disabled: true});
		 $('#prcs').prop('disabled',true);
		 $('#collectdate').jqxDateTimeInput({ disabled: true});
		 $('#accplace').prop('disabled',true);
		 $('#accfines').prop('disabled',true);
		 $('#cmbclaim').prop('disabled',true);
		 $('#accremarks').prop('disabled',true);	 
	 }
 }
 function checkClaim(){
	 var temp=document.getElementById("cmbclaim").value;
	 if(temp=="1"){
		document.getElementById("amount").value=document.getElementById("hidinsurexcess").value;		 
	 }
	 else{
		 document.getElementById("accfines").value="0";
	 }
 }
 function isNumber(evt,id) {
		//Function to restrict characters and enter number only
			  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
 
 function funPrintBtn() {
		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		 $.messager.alert('Warning','Select a Document');
		 return false;
	   		}
		var url=document.URL;
	 var reurl=url.split("com/");
	  	//var reurl=url.split("tarifMgmt.jsp");
	  	
	  	var win= window.open(reurl[0]+"com/operations/vehicletransactions/vehicleinspection/inspectionPrint.action?docno="+document.getElementById("docno").value+"&fleetno="+document.getElementById("rfleet").value+"&lblurl="+window.location.origin,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
	 }
 
      
function opensnapshotWindow()
{
	var Pic = document.getElementById("canvas").toDataURL("image/png");
	Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "");
	//alert(Pic);
	
	$("#imagediv").prop("hidden", true); 
  	 $("#canvasdiv").prop("hidden", false);
	
	var url=document.URL;
    var reurl=url.split("vehicleInspection");
   
    window.open("snapshot.jsp", "Camera",'menubar=0,resizable=1,width=400,height=440, top=50, left=380');
     
    
}


function downloadCanvas(link) {
	var formname=document.getElementById("formdetailcode").value;
	var docno=document.getElementById("docno").value;
	var filename=formname+"_"+docno;
    link.href = document.getElementById("canvas").toDataURL();
    link.download =filename;
}


function saveViaAJAX()
{
	var testCanvas = document.getElementById("canvas");  
	var canvasData = testCanvas.toDataURL("image/png");
	var postData = "canvasData="+canvasData;
	//alert("canvasData ="+canvasData );	  
	var ajax = new XMLHttpRequest();
	ajax.open("POST",'saveImage.jsp',true);    
	ajax.setRequestHeader('Content-Type', 'canvas/upload');
	
	ajax.onreadystatechange=function()
  	{
		if (ajax.readyState == 4)
		{ 
			alert(ajax.responseText);
			// Write out the filename.
    		
		}
  	}

	ajax.send(postData);  
}
 
</script>
      
<style type="text/css">

#webcam, #canvas {
 width: 320px;
 height: -20px;
 border:20px solid #333;
 background:#e0ecf8;
 -webkit-border-radius: 20px;
 -moz-border-radius: 20px;
 border-radius: 20px;
}

#webcam {
 position:relative;
 margin-top:50px;
 margin-bottom:50px;
}

#webcam > span {
 z-index:2;
 position:absolute;
 color:#eee;
 font-size:10px;
 bottom: -16px;
 left:152px;
}

#webcam > img {
 z-index:1;
 position:absolute;
 border:0px none;
 padding:0px;
 bottom:-40px;
 left:89px;
}

#webcam > div {
 border:5px solid #333;
 position:absolute;
 right:-90px;
 padding:5px;
 -webkit-border-radius: 8px;
 -moz-border-radius: 8px;
 border-radius: 8px;
 cursor:pointer;
}

#webcam a {
 background:#fff;
 font-weight:bold;
}

#webcam a > img {
 border:0px none;
}

#canvas {
 border:5px solid #ccc;
 background:#eee;
}

#flash {
 position:absolute;
 top:0px;
 left:0px;
 z-index:5000;
 width:100%;
 height:500px;
 background-color:#c00;
 display:none;
}

object {
 display:block; /* HTML5 fix */
 position:relative;
 z-index:1000;
}
</style>
     
      
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleInspection" action="saveVehicleInspection" autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>
<script>
			window.parent.formName.value="Vehicle Inspection";
			window.parent.formCode.value="VIP";
	</script>
	

<script type="text/javascript" src="<%=contextPath%>/js/jquery.webcam.min.js"></script> 

<%--  <p id="status" style="height:22px; color:#c00;font-weight:bold;"></p><div id="webcam">

<span ><p align="center">PoweredBy GateWayERP</p></span>
<!-- <div><a onClick="toggleFilter(this);"></a></div> --></div>
<p style="width:360px;text-align:center;font-size:12px">
<!-- <a href="javascript:webcam.capture(3);changeFilter();void(0);">Take a picture after 3 seconds</a> | -->
 <a href="javascript:webcam.capture();changeFilter();void(0);">Take Picture</a></p><br/>
 <p><canvas id="canvas" height="240" width="320"></canvas></p><ul id="cams"></ul> --%>
 <script type="text/javascript">

var pos = 0;
var ctx = null;
var cam = null;
var image = null;

var filter_on = false;
var filter_id = 0;

function changeFilter() {
 if (filter_on) {
 filter_id = (filter_id + 1) & 7;
 } 
}

function toggleFilter(obj) {
 if (filter_on =!filter_on) {
 obj.parentNode.style.borderColor = "#c00";
 } else {
 obj.parentNode.style.borderColor = "#333";
 }
}

jQuery("#webcam").webcam({

 width: 320,
 height: 240,
 mode: "callback",
 swffile:"jscam_canvas_only.swf",

 onTick: function(remain) {

 if (0 == remain) {
 jQuery("#status").text("Cheese!");
 } else {
 jQuery("#status").text(remain + " seconds remaining...");
 }
 },

 onSave: function(data) {

 var col = data.split(";");
 var img = image;

 if (false == filter_on) {

 for(var i = 0; i < 320; i++) {
 var tmp = parseInt(col[i]);
 img.data[pos + 0] = (tmp >> 16) & 0xff;
 img.data[pos + 1] = (tmp >> 8) & 0xff;
 img.data[pos + 2] = tmp & 0xff;
 img.data[pos + 3] = 0xff;
 pos+= 4;
 }
 

 } else {

 var id = filter_id;
 var r,g,b;
 var r1 = Math.floor(Math.random() * 255);
 var r2 = Math.floor(Math.random() * 255);
 var r3 = Math.floor(Math.random() * 255);

 for(var i = 0; i < 320; i++) {
 var tmp = parseInt(col[i]);

 /* Copied some xcolor methods here to be faster than calling all methods inside of xcolor and to not serve complete library with every req */

 if (id == 0) {
 r = (tmp >> 16) & 0xff;
 g = 0xff;
 b = 0xff;
 } else if (id == 1) {
 r = 0xff;
 g = (tmp >> 8) & 0xff;
 b = 0xff;
 } else if (id == 2) {
 r = 0xff;
 g = 0xff;
 b = tmp & 0xff;
 } else if (id == 3) {
 r = 0xff ^ ((tmp >> 16) & 0xff);
 g = 0xff ^ ((tmp >> 8) & 0xff);
 b = 0xff ^ (tmp & 0xff);
 } else if (id == 4) {

 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 var v = Math.min(Math.floor(.35 + 13 * (r + g + b) / 60), 255);
 r = v;
 g = v;
 b = v;
 } else if (id == 5) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 if ((r+= 32) < 0) r = 0;
 if ((g+= 32) < 0) g = 0;
 if ((b+= 32) < 0) b = 0;
 } else if (id == 6) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 if ((r-= 32) < 0) r = 0;
 if ((g-= 32) < 0) g = 0;
 if ((b-= 32) < 0) b = 0;
 } else if (id == 7) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 r = Math.floor(r / 255 * r1);
 g = Math.floor(g / 255 * r2);
 b = Math.floor(b / 255 * r3);
 }

 img.data[pos + 0] = r;
 img.data[pos + 1] = g;
 img.data[pos + 2] = b;
 img.data[pos + 3] = 0xff;
 pos+= 4;
 }
 }

 if (pos >= 0x4B000) {
 ctx.putImageData(img, 0, 0);
 pos = 0;
 }
 },

 onCapture: function () {
 webcam.save();

 jQuery("#flash").css("display", "block");
 jQuery("#flash").fadeOut(100, function () {
 jQuery("#flash").css("opacity", 1);
 });
 },

 debug: function (type, string) {
 jQuery("#status").html(type + ": " + string);
 },

 onLoad: function () {
/* 
 var cams = webcam.getCameraList();
 for(var i in cams) {
 //jQuery("#cams").append("<li>" + cams[i] + "</li>");
 } */
 }
});

function getPageSize() {

 var xScroll, yScroll;

 if (window.innerHeight && window.scrollMaxY) {
 xScroll = window.innerWidth + window.scrollMaxX;
 yScroll = window.innerHeight + window.scrollMaxY;
 } else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
 xScroll = document.body.scrollWidth;
 yScroll = document.body.scrollHeight;
 } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
 xScroll = document.body.offsetWidth;
 yScroll = document.body.offsetHeight;
 }

 var windowWidth, windowHeight;

 if (self.innerHeight) { // all except Explorer
 if(document.documentElement.clientWidth){
 windowWidth = document.documentElement.clientWidth;
 } else {
 windowWidth = self.innerWidth;
 }
 windowHeight = self.innerHeight;
 } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
 windowWidth = document.documentElement.clientWidth;
 windowHeight = document.documentElement.clientHeight;
 } else if (document.body) { // other Explorers
 windowWidth = document.body.clientWidth;
 windowHeight = document.body.clientHeight;
 }

 // for small pages with total height less then height of the viewport
 if(yScroll < windowHeight){
 pageHeight = windowHeight;
 } else {
 pageHeight = yScroll;
 }

 // for small pages with total width less then width of the viewport
 if(xScroll < windowWidth){
 pageWidth = xScroll;
 } else {
 pageWidth = windowWidth;
 }

 return [pageWidth, pageHeight];
}

window.addEventListener("load", function() {

 jQuery("body").append("<div id=\"flash\"></div>");

 var canvas = document.getElementById("canvas");

 if (canvas.getContext) {
 ctx = document.getElementById("canvas").getContext("2d");
 ctx.clearRect(0, 0, 320, 240);

 var img = new Image();
 img.src = "/image/logo.gif";
 img.onload = function() {
 ctx.drawImage(img, 129, 89);
 }
 image = ctx.getImageData(0, 0, 320, 240);
 }
 
 var pageSize = getPageSize();
 jQuery("#flash").css({ height: pageSize[1] + "px" });

}, false);

window.addEventListener("resize", function() {

 var pageSize = getPageSize();
 jQuery("#flash").css({ height: pageSize[1] + "px" });

}, false);

</script>	
	
	
	
<div class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="100%"><table width="100%">
      <tr>
        <td width="2%" align="right">Date</td>
        <td width="6%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
        <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
        <td width="6%" align="right">Time</td>
        <td width="6%" align="left"><div id="time" name="time"  value='<s:property value="date"/>'></div></td>
        <input type="hidden" name="hidtime" id="hidtime" value='<s:property value="hidtime"/>'>
        <td width="6%" align="right">Type</td>
        <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
        <td width="8%" align="left"><select name="cmbtype" id="cmbtype">
          <option value="">--Select--</option><option value="IN">IN</option><option value="OUT">OUT</option>
        </select></td>
        <td width="4%" align="right">Ref type</td>
        <td width="12%" align="left"><select name="cmbreftype" id="cmbreftype" onchange="funResetValues();">
          <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option><option value="RPL">Replacement</option><option value="NRM">Non Revenue  Movement</option>
        </select></td>
        <input type="hidden" name="hidcmbreftype" id="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'>
        <td width="7%" align="right">Ref Doc No</td>
        <td width="9%" align="left"><input type="text" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>' readonly placeholder="Press F3 to Search" onkeydown="getDoc(event);"></td>
        <td width="5%" align="right">Ref Fleet No</td>
        <td width="9%" align="left"><input type="text" name="rfleet" id="rfleet" value='<s:property value="rfleet"/>' readonly></td>
        <td width="3%" align="right">Doc No</td>
        <td width="17%" align="left"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td  width="100%">
<table width="100%" >
  <tr>
    <td width="37%" height="104"><fieldset>
          <legend>Existing</legend>
          <div id="existingdiv">
           <jsp:include page="existingGrid.jsp"></jsp:include> 
          </div>
        </fieldset></td>
    <td width="38%"><fieldset>
          <legend>New</legend>
          <div id="newdiv">
            <jsp:include page="newgrid.jsp"></jsp:include>
          </div>
        </fieldset></td>
    <%-- <td width="25%" rowspan="3"><fieldset style="height=100%;width=100%;">

<a id="download" href=""><button type="button">Download File</button></a>

	<center><button id="icon" title="SnapShot"  type="button" onclick="opensnapshotWindow()">
			 <img alt="SnapShot" src="<%=contextPath%>/icons/snapshot.png"> 
		</button></center>
	
   <div id="canvasdiv"><p><canvas id="canvas"  height="240" width="320"></canvas></p><ul id="cams"></ul></div>
<div id="imagediv"><img id="prevImage" src="<%=contextPath%>/icons/gatewaybg.png" alt="Image" height="100%" width="100%"/></div>

    <br>
    </fieldset></td> --%>
    
    
    <td width="25%" rowspan="3"><fieldset style="height=100%;width=100%;">
<table width="100%">
  <tr>
    <td width="42%"><center><a id="download" href=""><button id="icons" title="Save Image"  type="button"> <img alt="Download File" src="<%=contextPath%>/icons/isave.png"></button></a></center></td>
    <td width="58%"><center><button id="icons" title="SnapShot"  type="button" onclick="opensnapshotWindow()">
    <img alt="SnapShot" src="<%=contextPath%>/icons/snapshot.png"> 
  </button></center></td>
  </tr>
  <tr>
    <td colspan="2"><div id="canvasdiv"><p><canvas id="canvas"  height="240" width="320"></canvas></p><ul id="cams"></ul></div>
<div id="imagediv"><img id="prevImage" src="<%=contextPath%>/icons/gatewaybg.png" alt="Image" height="100%" width="100%"/></div></td>
  <input type="hidden" name="canvasdet" id="canvasdet"  value='<s:property value="canvasdet"/>'>
  </tr>
</table>
</fieldset></td>
    
    
  </tr>
  <tr>
    <td height="17" colspan="2" align="right">Chargeable Amount
          <input type="text" name="amount" id="amount" value='<s:property value="amount"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);">
        </td>
  </tr>
 
  <tr>
    <td height="25" colspan="2"><fieldset>
      <legend><input type="checkbox" name="chkaccidents" id="chkaccidents" value='<s:property value="chkaccidents"/>' onchange="enableAccData();">&nbsp;Accidents</legend>
      
      <table width="100%">
        <tr>
        
          <td width="2%" height="26" align="right">Date</td>
          <td width="6%" align="left"><div id="accdate" name="accdate"  value='<s:property value="accdate"/>'></div></td>
          <input type="hidden" name="hidaccdate" id="hidaccdate"  value='<s:property value="hidaccdate"/>'>
          <td width="6%" align="right">Police Report</td>
          <td width="8%" align="left"><input type="text" name="prcs" id="prcs"  value='<s:property value="prcs"/>'></td>
          <td width="6%" align="right">Collection Date</td>
          <td width="7%" align="left"><div id="collectdate" name="collectdate"  value='<s:property value="collectdate"/>'></div></td>
          <input type="hidden" name="hidcollectdate" id="hidcollectdate"  value='<s:property value="hidcollectdate"/>'>
          <td width="3%" align="right">Place</td>
          <td width="9%" align="left"><input type="text" name="accplace" id="accplace"  value='<s:property value="accplace"/>'></td>
          <td width="3%" align="right">Fines</td>
          <td width="10%" align="left"><input type="text" name="accfines" id="accfines"  value='<s:property value="accfines"/>' style="text-align:right;" onkeypress="javascript:return isNumber (event,id)" onblur="funRoundAmt(value,id);"></td>
          <td width="3%" align="right">Claim</td>
          <td width="8%"><select name="cmbclaim" id="cmbclaim" onchange="checkClaim();">
            <option value="">--Select--</option><option value=1>Own</option><option value=0>Third Party</option>
            </select></td>
          <td width="4%" align="right">Remarks</td>
          <td width="25%" align="left"><input type="text" name="accremarks" id="accremarks" value='<s:property value="accremarks"/>' style="width:100%;" ></td>
          <input type="hidden" name="hidcmbclaim" id="hidcmbclaim"  value='<s:property value="hidcmbclaim"/>'>
          </tr> 
        </table>
      </fieldset></td>
  </tr>
</table></td>
  </tr>
  
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td><fieldset>
      <legend>Existing Complaints</legend><div id="existmaintenancediv">
            <jsp:include page="existmaintenanceGrid.jsp"></jsp:include>
          </div></fieldset></td>
          <td><fieldset>
      <legend>New Complaints</legend><div id="newmaintenancediv">
            <jsp:include page="newmaintenanceGrid.jsp"></jsp:include>
          </div></fieldset></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
</table>
</fieldset>

</div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="damagegridlength" id="damagegridlength" value='<s:property value="damagegridlength"/>'>
<input type="hidden" name="existdamagegridlength" id="existdamagegridlength" value='<s:property value="existdamagegridlength"/>'>
<input type="hidden" name="maintenancegridlength" id="maintenancegridlength" value='<s:property value="maintenancelength"/>'>
<input type="hidden" name="hidaccidents" id="hidaccidents" value='<s:property value="hidaccidents"/>'>
<input type="hidden" name="hidinsurexcess" id="hidinsurexcess" value='<s:property value="hidinsurexcess"/>'>
<!-- <input type="file" id="file" name="file" />  
        <input type="button" class="myButton"  value="Attach" onclick="return ajaxFileUpload();">   -->
<div id="docwindow">
   <div ></div>
</div>
<div id="damagewindow">
   <div></div>
</div>

<div id="maintenancewindow">
   <div></div>
</div>

</form>

</div>
</body>
</html>