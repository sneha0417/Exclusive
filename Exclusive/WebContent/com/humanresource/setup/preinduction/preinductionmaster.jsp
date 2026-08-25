<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<%
 
%>
<html>
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../includes.jsp"></jsp:include> 
 
 
 
<style>
form label.error {
color:red;
  font-weight:bold;

}
 #psearch {
 
background:#FAEBD7;
 
}
.btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 10px;
  padding: 4px 15px 6px 17px;
  text-decoration: none;
}
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
</style>
<script type="text/javascript">
<%-- var text1='<%=dtype%>'; --%>
 
 $(document).ready(function () {
	 
   	 $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 
 

     $('#swin').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#swin').jqxWindow('close');
     $('#abcwn').jqxWindow({ width: '40%', height: '65%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: {x: 250, y: 60  }, keyboardCloseKey: 27});
     $('#abcwn').jqxWindow('close');
 
     
 
     

 
	   $('#designation').dblclick(function(){

		  	if($('#mode').val()!= "view")
	  		{
	  	
	  		
		  	    $('#swin').jqxWindow('open');
		   
		  	  SearchContent('designationsearch.jsp?');
	  		}
		   
		   
		  }); 
		
	   
	   
	   $('#grade').dblclick(function(){

		  	if($('#mode').val()!= "view")
	  		{
	  	
	  		
		  	    $('#swin').jqxWindow('open');
		   
		  	  SearchContent1('grade.jsp?');
	  		}
		   
		   
		  }); 
	   $('#report').dblclick(function(){

		  	if($('#mode').val()!= "view")
	  		{
	  	
	  		
		  	    $('#swin').jqxWindow('open');
		   
		  	  SearchContent2('reportsearch.jsp?');
	  		}
		   
		   
		  }); 
		
		
	   
	});
 
 
 function getitem(event){
  	 var x= event.keyCode;
  	 if(x==114){

 
  	  	if($('#mode').val()!= "view")
  		{
  	
  		
	  	    $('#swin').jqxWindow('open');
	   
	  	 SearchContent('designationsearch.jsp?');
  		}
  		  
  	 
  	 }
  	 else{
  		 }
  	 }  
 
 
 function getitem1(event){
  	 var x= event.keyCode;
  	 if(x==114){

 
  	  	if($('#mode').val()!= "view")
  		{
  	
  		
	  	    $('#swin').jqxWindow('open');
	   
	  	 SearchContent1('grade.jsp?');
  		}
  		  
  	 
  	 }
  	 else{
  		 }
  	 }  
 function getitem2(event){
  	 var x= event.keyCode;
  	 if(x==114){

 
  	  	if($('#mode').val()!= "view")
  		{
  	
  		
	  	    $('#swin').jqxWindow('open');
	   
	  	 SearchContent2('reportsearch.jsp?');
  		}
  		  
  	 
  	 }
  	 else{
  		 }
  	 }
  	  function SearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
  //alert(data);
        $('#swin').jqxWindow('setContent', data);

  	}); 
    	}
 
 
  	  function SearchContent1(url) {
  	       //alert(url);
  	          $.get(url).done(function (data) {
  	  //alert(data);
  	        $('#swin').jqxWindow('setContent', data);

  	  	}); 
  	    	} 
          
  	  function SearchContent2(url) {
 	       //alert(url);
 	          $.get(url).done(function (data) {
 	  //alert(data);
 	        $('#swin').jqxWindow('setContent', data);

 	  	}); 
 	    	} 
         
         
          
    function funReset(){
		//$('#frmpurReq')[0].reset(); 
	}
	function funReadOnly(){
		  document.getElementById("headname").innerText="";
		  document.getElementById("valsss").value="";
		$('#frmpurReq input').attr('readonly', true );
		$('#frmpurReq textarea').attr('readonly', true );
		$('#frmpurReq select').attr('disabled', true);
		$('#masterdate').jqxDateTimeInput({ disabled: true});
		
		$("#qualgrid").jqxGrid({ disabled: true}); 
		$("#expgrid").jqxGrid({ disabled: true});
		$("#intervewgrid").jqxGrid({ disabled: true});
    	  
		$("#jobgrid").jqxGrid({ disabled: true});
		$("#descgrid").jqxGrid({ disabled: true});
		
		
		$('#edit1').attr('disabled', true);
		$('#save1').attr('disabled', true);
		
		$('#edit2').attr('disabled', true);
		$('#save2').attr('disabled', true);
		
		
		$("#fdata").show();
		
		
	}
	function funRemoveReadOnly(){
		
		$("#fdata").hide();
		 
		
		
		$('#edit1').attr('disabled', true);
		$('#save1').attr('disabled', true);
		
		$('#edit2').attr('disabled', true);
		$('#save2').attr('disabled', true);
		
		$('#frmpurReq input').attr('readonly', false );
		$('#frmpurReq textarea').attr('readonly', false );
		$('#frmpurReq select').attr('disabled', false);
	
		$('#masterdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		
		
		$('#designation').attr('readonly', true);
		$('#grade').attr('readonly', true);
		$('#report').attr('readonly', true);
		
	  	if($('#mode').val()== "A")
  		{	
	  $('#masterdate').val(new Date());
  	  $("#expgrid").jqxGrid('clear');
  	  $("#intervewgrid").jqxGrid('clear');
  	  $("#qualgrid").jqxGrid('clear');
  	  
	  	  $("#expgrid").jqxGrid('addrow', null, {});
          $("#intervewgrid").jqxGrid('addrow', null, {});
    	  $("#qualgrid").jqxGrid('addrow', null, {});
    	  
    	  
  		$("#qualgrid").jqxGrid({ disabled: false}); 
		$("#expgrid").jqxGrid({ disabled: false});
		$("#intervewgrid").jqxGrid({ disabled: false});
		
		
		
	  	  $("#jobgrid").jqxGrid('clear');
	  	  $("#descgrid").jqxGrid('clear');
		
		
		
		
    	  
	  		
  		}
	  	
	  	
	  	if($('#mode').val()== "E")
  		{	
	  		
	    	  $("#expgrid").jqxGrid('addrow', null, {});
	          $("#intervewgrid").jqxGrid('addrow', null, {});
	    	  $("#qualgrid").jqxGrid('addrow', null, {});
	    	  
	    	  $("#qualgrid").jqxGrid({ disabled: false}); 
	  		$("#expgrid").jqxGrid({ disabled: false});
	  		$("#intervewgrid").jqxGrid({ disabled: false});
	      	  
		  		
  		}
		
		
		
		 
	}
	 
	
 
	
	
	
	function funNotify(){	
 
	 
 		 var rows = $("#qualgrid").jqxGrid('getrows');
		   var aa=0;
		   for(var i=0 ; i < rows.length ; i++){
		   if(parseInt(rows[i].qualdoc)>0)
			   {
			   aa=aa+1;
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test1"+i)
			       .attr("name", "test1"+i)  
			    .attr("hidden", "true"); 
			    newTextBox.val(rows[i].qualdoc+"::"+rows[i].remarks+" :: "+i+" :: ");
			   newTextBox.appendTo('form');
			 
			   $('#1lenght').val(aa);
			   
			   }
		   }    
		  
		   var rows = $("#expgrid").jqxGrid('getrows');
		   var bb=0;
		   for(var i=0 ; i < rows.length ; i++){
                    if(rows[i].expin!="" && rows[i].expin!=null && typeof(rows[i].expin)!="undefiend") 
			 	   {
		 
			   bb=bb+1;
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test2"+i)
			       .attr("name", "test2"+i)  
			    .attr("hidden", "true"); 
			    newTextBox.val(rows[i].expin+"::"+rows[i].noof+"::"+rows[i].mnd+" :: "+i+" :: ");
			   newTextBox.appendTo('form');
			   
			 
			   $('#2lenght').val(bb);
			   
			   }
		    
		   }
			  
		   var rows = $("#intervewgrid").jqxGrid('getrows');
		   var cc=0;
		   for(var i=0 ; i < rows.length ; i++){
				 
				 if(rows[i].desc1!="" && rows[i].desc1!=null && typeof(rows[i].desc1)!="undefiend") 
			 	   {
			   cc=cc+1;
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "test3"+i)
			       .attr("name", "test3"+i)  
			    .attr("hidden", "true"); 
			    newTextBox.val(rows[i].desc1+" :: "+i+" :: ");
			   newTextBox.appendTo('form');
		 
			   $('#3lenght').val(cc);
			   
			   }
		   }   
			$('#masterdate').jqxDateTimeInput({ disabled: false});
		return 1;
	} 

	function funChkButton() {
		
		frmpurReq.submit();
	}

	function funSearchLoad(){

		 changeContent('Mastersearch.jsp'); 
	}
  
		 
	function funFocus(){
		 
	   	$('#masterdate').jqxDateTimeInput('focus'); 	    		
	} 
	 
	function setValues() {
		
	  	  $("#jobgrid").jqxGrid('clear');
	  	  $("#descgrid").jqxGrid('clear');
		
		if($('#hidmasterdate').val()){
			$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
		}
		 
   	  var docVal1 = document.getElementById("masterdoc_no").value;
      	if(docVal1>0)
      		{
		 var indexVal2 = document.getElementById("masterdoc_no").value;
         $("#grid1").load("qual.jsp?docno="+indexVal2);
         $("#grid2").load("exp.jsp?docno="+indexVal2);
         $("#grid3").load("interview.jsp?docno="+indexVal2);
         $("#grid4").load("job.jsp?docno="+indexVal2);
         
     	$("#jobgrid").jqxGrid({ disabled: true});
		$("#descgrid").jqxGrid({ disabled: true});
 		
 		$('#edit1').attr('disabled', false);
 		$('#save1').attr('disabled', true);
 		
 		$('#edit2').attr('disabled', false);
 		$('#save2').attr('disabled', true);
 		
      		}
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";   
		funSetlabel();
		
		
		
		  
		
	}
	
    function funPrintBtn(){
 
  	   } 
  	  
    function isNumber1(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
        
        		 if (iKeyCode == 45)
        			       			 
        			  {
        			 
        			 
        			  return true;
        		     } 
        		
        		
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
     	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
           
            return false;
        	}
        document.getElementById("errormsg").innerText="";  
        return true;
    }
   
   
	function funRoundAmt(value ,id){
		  var res=parseFloat(value).toFixed(0);
		  var res1=(res=='NaN'?"0":res);
		  document.getElementById(id).value=res1;  
		 }
	
	function editval(val)
	
	{
	 
		if(val==1)
			{
			$('#save1').attr('disabled', false);
			$("#jobgrid").jqxGrid({ disabled: false});
			  $("#jobgrid").jqxGrid('addrow', null, {});
			  document.getElementById("headname").innerText="";
			  document.getElementById("valsss").value="";
		
			}
		else
			{
			$('#save2').attr('disabled', false);
			$("#descgrid").jqxGrid({ disabled: false});
			  $("#descgrid").jqxGrid('addrow', null, {});
			}
		
	}
	
	
	
	function save(val)
	{
		
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
		 	  
		     
		   	if(r==false)
		   	  {
		   		
		   	  }
		   	else
		   		{
		   		var listss = new Array();
		   		 
		   		if(val==1)
		   			{
		    
		   		
		   			var selectedrows=$("#jobgrid").jqxGrid('getrows');
		   			 
		   				  for(var i=0 ; i < selectedrows.length ; i++){
		   					 listss.push($("#jobgrid").jqxGrid('getcellvalue',selectedrows[i],'header')+"::"+$("#jobgrid").jqxGrid('getcellvalue',selectedrows[i],'rownoss')+"::"+i); 
		   						  }
		   				   save1(listss,val);
		   			}
		   		else
		   			{
		   			
		   			 
		   			 
		   			var selectedrows=$("#descgrid").jqxGrid('getrows');
		   			 
		   				  for(var i=0 ; i < selectedrows.length ; i++){
		   					 listss.push($("#jobgrid").jqxGrid('getcellText',selectedrows[i],'desc1')+"::"+document.getElementById("valsss").value+"::"+i); 
		   						  }
		   				   save1(listss,val);
		   			}
 
		   		 

			   
			   
			   
			   
	            }
		   	
		   
		   	
		    });
		
		  }
		  function save1(listss,val){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200) 
						{
						 var items= x.responseText;
						 	var itemval=items.trim();
						 
		      if(parseInt(itemval)==1)
		      	{
						 	$.messager.alert('Message', ' successfully Updated ', function(r){
							     
						     });
						    
							$("#jobgrid").jqxGrid({ disabled: true});
							$("#descgrid").jqxGrid({ disabled: true});
							
							 document.getElementById("headname").innerText="";
							$('#edit1').attr('disabled', false);
							$('#save1').attr('disabled', true);
							
							$('#edit2').attr('disabled', true);
							$('#save2').attr('disabled', true);
							
					  		 var indexVal2 = document.getElementById("masterdoc_no").value;
					          
					           $("#grid4").load("job.jsp?docno="+indexVal2);
					           
					           
					           if(val==2)
					        	   {
					        	   var indexVal2 = document.getElementById("valsss").value;
							          
						           $("#grid5").load("desc.jsp?docno="+indexVal2+"&aa=1");
						           
						           
						            
						       	$("#descgrid").jqxGrid({ disabled: true});
						           
					        	   }
				 
						}
					else
						{
						$.messager.alert('Message', '  Not Updated ', function(r){
						     
					     });
						}  
				}
				}  
			x.open("GET","savedata.jsp?list="+listss+"&masterdocno="+document.getElementById("masterdoc_no").value+"&val="+val);
				x.send();
			}

		 
	 
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurReq" action="saveDatsss" autocomplete="OFF" >     
<jsp:include page="../../../../header.jsp"></jsp:include>
<br>
<fieldset>

<table width="100%"  >                        
  <tr>
    <td width="4.5%" align="right">Date</td>  
    <td colspan="1"  width="6%"><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div> 
                     <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/></td>
                 <td width="3%"  align="right">Ref No</td><td><input type="text" id="refno" name="refno" value='<s:property value="refno"/>'  /> 
                 <td  colspan="2">&nbsp;  </td>
    <td width="33%" colspan="1">Doc No  <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
                                                                
<tr>
     <td width="3%" align="right">Designation</td>
    <td    width="20%">  <input type="text" id="designation" name="designation" placeholder="Press F3 to Search"      onkeydown="getitem(event);"  style="width:70%;" value='<s:property value="designation"/>'/>
    
     <input type="hidden" id="designationid" name="designationid"  style="width:70%;" value='<s:property value="designationid"/>'/>
    </td>
  
 
 <td width="3%" align="right">Description</td>
    <td    width="20%">  <input type="text" id="desc1" name="desc1"  style="width:100%;" value='<s:property value="desc1"/>'/></td>
 
       <td align="right" width="10%">No of positions</td>
      <td align="left" width="10%">   <input type="text" id="noofpos"  name=noofpos value='<s:property value="noofpos"/>' onblur="funRoundAmt1(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   style="text-align: left;">
     
     
        <td width="15%" align="left">Grade  <input type="text" id="grade" name="grade" placeholder="Press F3 to Search"      onkeydown="getitem1(event);" style="width:70%;" value='<s:property value="grade"/>'/>
    
     <input type="hidden" id="gradeid" name="gradeid"  style="width:70%;" value='<s:property value="gradeid"/>'/>
    </td>
  </tr>
<tr>
   <td width="10%" align="right">Salary Range  &nbsp; &nbsp;&nbsp;From</td>
    <td colspan="6"  width="70%">
     <input type="text" id="fromsal"  name="fromsal" value='<s:property value="fromsal"/>' onblur="funRoundAmt1(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   style="text-align: left;">
    &nbsp;   &nbsp;To   &nbsp;
      <input type="text" id="tosal"  name=tosal value='<s:property value="tosal"/>' onblur="funRoundAmt1(this.value,this.id);" onkeypress="javascript:return isNumber1 (event);"   style="text-align: left;">
    &nbsp;  Reporting To  <input type="text" id="report" name="report"  placeholder="Press F3 to Search"      onkeydown="getitem2(event);" style="width:18%;" value='<s:property value="report"/>'/>
     <input type="hidden" id="reportid" name="reportid"  style="width:20%;" value='<s:property value="reportid"/>'/>
    </td>
    </tr>
</table>    
</fieldset>    
 <table width="100%">
 <tr>
 <td width="30%">
  <fieldset><legend>Qualification</legend>
  
<div id="grid1"><jsp:include page="qual.jsp"></jsp:include></div> 
</fieldset> 
</td>
 <td  width="30%">
 <fieldset><legend>Experience</legend>
<div id="grid2">  <jsp:include page="exp.jsp"></jsp:include></div>
</fieldset> 
</td>
 <td width="30%">
  <fieldset><legend>Interview Evaluation Points</legend>
<div id="grid3"><jsp:include page="interview.jsp"></jsp:include></div>
</fieldset> 
</td>
</tr>
</table>
<div id="fdata">

<table width="100%">
 
 <tr>

 <td  width="30%">
 <fieldset><legend>Job Description</legend>   
   <input type="button" class="myButton" id="edit1" value="Edit" onclick="editval(1)"> &nbsp;  &nbsp; &nbsp;
  <input type="button" class="myButton" id="save1" value="Save" onclick="save(1)">
<div id="grid4">  <jsp:include page="job.jsp"></jsp:include></div>
</fieldset> 
</td>
 <td  width="40%">
 <fieldset><legend>Description</legend>
 
<font face="verdana" size="4" color="#d13d10"> <label id="headname">&nbsp; </label> </font>  <input type="hidden" id="valsss" >
    <input type="hidden"  style="align:rignt" class="myButton" id="edit2" value="Edit" onclick="editval(2)"> &nbsp;  &nbsp; &nbsp;
 <input type="button"   style="align:rignt" class="myButton" id="save2" value="Save"  onclick="save(2)">
 
 
<div id="grid5">  <jsp:include page="desc.jsp"></jsp:include></div>
</fieldset> 
</td>
</tr>
</table>


</div>



<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>' /> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="lenght1" id="1lenght" value='<s:property value="lenght1"/>' />   
<input type="hidden" name="lenght2" id="2lenght" value='<s:property value="lenght2"/>' />   
<input type="hidden" name="lenght3" id="3lenght" value='<s:property value="lenght3"/>' />   

</form>
<div id="abcwn">
<div ></div>
</div>
<div id="swin">
<div ></div>
</div>
</div>
</body>
</html>