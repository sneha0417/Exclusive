<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>
<style>
form label.error {
 color:red;
 font-weight:bold;

}

.myButton1 {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 12px;
	text-decoration:none;
}
.myButton1:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButton1:active {
	position:relative;
	top:1px;
}
 
.myButton4 {
	-moz-box-shadow:inset 0px 0px 0px -24px #e67a73;
	-webkit-box-shadow:inset 0px 0px 0px -24px #e67a73;
	box-shadow:inset 0px 0px 0px -24px #e67a73;
	background-color:#e4685d;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #ffffff;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:3px 12px;
	text-decoration:none;
	text-shadow:0px 1px 0px #b23e35;
}
.myButton4:hover {
	background-color:#eb675e;
}
.myButton4:active {
	position:relative;
	top:1px;
}

.bounce {
	color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -webkit-transform: translateX(0);
    transform: translateX(0);
  }
  40% {
    -moz-transform: translateX(-30px);
    -ms-transform: translateX(-30px);
    -webkit-transform: translateX(-30px);
    transform: translateX(-30px);
  }
  60% {
    -moz-transform: translateX(-15px);
    -ms-transform: translateX(-15px);
    -webkit-transform: translateX(-15px);
    transform: translateX(-15px);
  }
} 

@media (min-width: 15px) {
  .mega {
    font-size: 15px;
  }
}

@font-face {
  font-family: 'Roboto',comic sans ms,Tahoma;
  font-style: normal;
  font-weight: 100;
  unicode-range: U+0460-052F, U+20B4, U+2DE0-2DFF, U+A640-A69F;
}
  
@-webkit-keyframes hue {
  from {
    -webkit-filter: hue-rotate(0deg);
  }

  to {
    -webkit-filter: hue-rotate(-360deg);
  }
}

</style>

 
<script type="text/javascript">

	$(document).ready(function () {   
		
	    document.getElementById("formdet").innerText="Leave Setup(LSP)";
		document.getElementById("formdetail").value="Leave Setup";
		document.getElementById("formdetailcode").value="LSP";
		window.parent.formCode.value="LSP";
		window.parent.formName.value="Leave Setup";
		document.getElementById("showlabel").innerText="";
		
		$('#refSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Ref No Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#refSearchwindow').jqxWindow('close');
		
		$('#btnCreate').attr('disabled', true);
		$('#btnDelete').attr('disabled', true);
		$('#btnSearch').attr('disabled', true);
		$('#btnEdit').attr('disabled', true);
		
		$('#refno').dblclick(function(){
			  $('#refSearchwindow').jqxWindow('open');
			  refnoSearchContent('refmastersearch.jsp?');
		});   
		    
     });
	
	function funSearchLoad(){}

	function refnoSearchContent(url) {
		    $.get(url).done(function (data) {
		    $('#refSearchwindow').jqxWindow('open');
	   		$('#refSearchwindow').jqxWindow('setContent', data);
		}); 
	}
	 
	 
	 function gethrsetup(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
		 	  $('#refSearchwindow').jqxWindow('open');
		 	  refnoSearchContent('refmastersearch.jsp?');    }
	 	 else{}
	 	 }
      
	function funReadOnly() {
		$('#frmleavesetup input').attr('readonly', true);
		//btnCreate btnDelete  btnSearch btnEdit
	
		$('#savebtn').attr('disabled', true);
		$('#deltbtn').attr('disabled', true);
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmleavesetup input').attr('readonly', false);
		$('#docno').attr('readonly', true);
	}
 
	function setValues() {
		 
		 /* if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val()); document.getElementById("newmode").value=='Saved'
			  } */
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			
			  if(document.getElementById("newmode").value=='Saved') {
				   var leaveid=document.getElementById("leaveid").value;
				   var refno= document.getElementById("refno").value;
				   $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
				  
				   var disdata="hide";
				  
	        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
	        	   document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
	        	   
	               $.messager.alert('Message', '  Record successfully Updated ');
	        	   	funReadOnly();
				   } else if(document.getElementById("newmode").value=='notSaved') {
				      $.messager.alert('Message', '  Not Updated ');
				  } 
	}
	
	 function funNotify(){}
	 
	 function fundel() {
		 
		 var leavetype="";
		 var rows = $("#leavesetupgrid").jqxGrid('getrows');      
 		 for(var i=0;i<rows.length;i++){
		     if(parseInt(rows[i].checkclick)==1){
		    	leavetype=rows[i].leavetype; 
		     }
 		 }
		 
         $.messager.confirm('Message', 'Do you want to delete all records of '+leavetype, function(r){
	        	if(r==false) {
	        		return false; 
	        	  } else{
	        		var leaveid="";
	        		var rows = $("#leavesetupgrid").jqxGrid('getrows');      
	        		for(var i=0;i<rows.length;i++){
	        			if(parseInt(rows[i].checkclick)==1){
	        			  leaveid=rows[i].ldocno; 
	        			 }
	        		}
	        		fundeldata(leaveid,leavetype);
	        	}
		     });
	 	  
       }

	   function fundeldata(leaveid,leavetype) {
				 var refno= document.getElementById("refno").value;
				 var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200) {
						 	var items= x.responseText;
						 	if(parseInt(items)>0) {
						 		  $.messager.alert('Message', 'Record Successfully Deleted Leave Type - '+leavetype);
						          document.getElementById("newmode").value="";
						 		  var leaveid=document.getElementById("leaveid").value;
								  var refno= document.getElementById("refno").value;
								  
								  $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
								  var disdata="hide";
					        	  $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
						    } else { 
						    	  $.messager.alert('Message', '  Not Deleted'); 
						 	}
				       }
					}
					  x.open("GET","deletedate.jsp?leaveid="+leaveid+"&refno="+refno,true);
				     x.send();
			 }
	   
	     function funsave(){
	         $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        	if(r==false) {
		        		return false; 
		        	 } else{
		        		funsavedata();
		        	}
			     });
	     }
	     
	     function funsavedata(){	 
	    	  var z=0;
			  var rows = $("#condtiongrid").jqxGrid('getrows');      
			  var selectedrows=$("#condtiongrid").jqxGrid('selectedrowindexes');
				 
				$('#algridlength').val(selectedrows.length);
			    for (var i = 0; i < rows.length; i++) {
				      for(var j=0;j<selectedrows.length;j++){
				       if(selectedrows[j]==i){
				    	   newTextBox = $(document.createElement("input"))
				    	   .attr("type", "dil")
					       .attr("id", "condtest"+z)
					       .attr("name", "condtest"+z)
					       .attr("hidden", "true");  
					    
					   newTextBox.val(rows[i].allowanceid+" :: ");
					   newTextBox.appendTo('form');
					   z++;
				       }
				      }
                   }
		   
			 //   ldocno, cf,deduct,l1,l2,l3,l1ded,l2ded,l3ded,checkclick
		   
			var rows = $("#leavesetupgrid").jqxGrid('getrows');      
		    for(var i=0;i<rows.length;i++){
		     if(parseInt(rows[i].checkclick)==1){
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "leavetest"+0)
			       .attr("name", "leavetest"+0)
			       .attr("hidden", "true");  
			    
			   newTextBox.val(rows[i].ldocno+" :: "+rows[i].cf+" :: "+rows[i].deduct+" :: "+rows[i].l1+" :: "+rows[i].l2+" :: "+rows[i].l3+" :: "+rows[i].l1ded+" :: "+rows[i].l2ded+" :: "+rows[i].l3ded); 
			   newTextBox.appendTo('form');
		     }
		   }

		    document.getElementById("frmleavesetup").submit();
	    		/* return 1; */
		} 
	     
	     function funFocus(){}
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 
<jsp:include page="../../../../../header.jsp" /><br/> 
	
<fieldset><legend>Leave Setup</legend>   
<fieldset>
<table width="100%">
		<tr><td width="10%"  align="right">Ref No</td> 
		<td width="15%" align="left"><input type="text" placeholder="Press F3 To Search" onKeyDown="gethrsetup(event);" name="refno" id="refno" style="width:100%;" value='<s:property value="refno"/>'></td>
		<td width="8%" align="right">Category</td>
		<td width="27%" ><input type="text" name="category"  id="category" style="width:99%;" value='<s:property value="category"/>'></td>
		<td width="40%" class="bounce" style="text-align: center;">&nbsp;&nbsp;&nbsp;<b><label id="showlabel" style="font-size: 13px;font-family: Tahoma; color:#6000FC" value='<s:property value="showlabel"/>'></label></b></td></tr> 
</table> 
</fieldset><br/>

<table width="100%">
	 <tr>
	 <td width="65%"><fieldset><div id="lsetup1"> <jsp:include page="leavesetupgrid.jsp"></jsp:include></div></fieldset></td>
	 <td  width="35%" >
	 <table  width="100%"><tr>
	 <td align="center">
	 <fieldset><div id="lsetup2"> <jsp:include page="condtiongrid.jsp"></jsp:include></div></fieldset><br/>
	 <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="button" id="deltbtn" onclick="fundel()"   class="myButton4"  value="Delete"></td>
	 </tr></table>
	 </td></tr>
</table>
	 
<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
<input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
<input type="hidden" id="leaveid" name="leaveid" value='<s:property value="leaveid"/>' />
<input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
<input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
<input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 

</fieldset> 
</form><br/>

<div id="refSearchwindow">
   <div></div>
</div>	 

</body>
</html>