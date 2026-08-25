<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" import="java.util.*" %>
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
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
 <% String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); %>
 <% String brch = request.getParameter("brch")==null?"0":request.getParameter("brch"); %>
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
     
     select.list1
{
    background-color: #99CCFF;
    font-size: 130%;
}
   
 .myButtons {
	background-color:#99CCFF;
	-moz-border-radius:21px;
	-webkit-border-radius:21px;
	border-radius:21px;
	border:1px solid #18ab29;
	display:inline-block;
	cursor:pointer;
	color:#000000;
	font-family:Arial;
	font-size:15px;
	padding:2px 10px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.myButtons:hover {
	background-color:#5cbf2a;
}
.myButtons:active {
	position:relative;
	top:1px;
}
   
        
</style>


	<script type="text/javascript">
	
	$(document).ready(function() {
		$('#first').val(0);
		$('#chk').val(0);
		$('#del').val(0);
		
  		 $('#comsearchwndow').jqxWindow({ width: '55%', height: '58%',isModal:true,autoOpen:false,  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , theme: 'energyblue', position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     	  $('#comsearchwndow').jqxWindow('close');
     	
     	 $('#concomsearchwndow').jqxWindow({ width: '55%', height: '58%',isModal:true,autoOpen:false,  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Search' , theme: 'energyblue', position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	  $('#concomsearchwndow').jqxWindow('close');
 
    	  getTermsCount();
	});

	 function gridLoad(){
		  var dtype=document.getElementById("formdetailcode").value;
		  var docno=document.getElementById("docno").value;
		  $("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&masterdoc="+docno);
		  
	  }

	function termsSearchContent(url) {
		$('#comsearchwndow').jqxWindow('open');
          $.get(url).done(function (data) {
        $('#comsearchwndow').jqxWindow('setContent', data);
       // $('#comsearchwndow').jqxWindow('bringToFront');

	}); 
    	}
	
	
	function condSearchContent(url) {
		 $('#concomsearchwndow').jqxWindow('open');
        $.get(url).done(function (data) {
      $('#concomsearchwndow').jqxWindow('setContent', data);
     // $('#comsearchwndow').jqxWindow('bringToFront');

	}); 
  	}

	function saveterms2(){
		
	
		 var docno=$('#docno').val();
	     var dtype=$('#formdetailcode').val();
	
	     
	     var list = new Array();
		 var rows = $("#jqxComTerms").jqxGrid('getrows');
		 
		   for(var i=0 ; i < rows.length ; i++){
			   
			   var voc_no=rows[i].voc_no;
			   var priono=0;
			   
			   priono=rows[i].priorno;
				
			   if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
				  {
				   priono=i+1;
				  }
			   
			
			   if(!(voc_no=="" || typeof(voc_no)=="undefined"))
				  {
			   
			   list.push(rows[i].voc_no+" :: "+rows[i].terms+" :: "+rows[i].conditions+" :: "+priono+" :: "); 
			   
			   
				  }
		   }
		 
		$.ajax({
		    type : "POST", 
			url:'<%=contextPath%>/com/common/saveTerms.action?docno='+$("#docno").val()+'&dtype='+$("#formdetailcode").val()+'&list='+list ,
			/* contentType: "application/json; charset=utf-8", */
			//data : "docno="+docno+"&dtype="+dtype,
			dataType : "string",
			async: true,
			success : function(result) {
				alert("Success");
		}
		});
	}
	
	
	 function saveterms()  
     {  
		 document.getElementById("errormsg").innerText="Please Wait ....";
		 var docno=$('#docno').val();
	     var dtype=$('#formdetailcode').val();
	     var brhid=$('#brchName').val();
		 var list = new Array();
		 
		 var rows = $("#jqxComTerms").jqxGrid('getrows');
		 var chk=0;
		 $('#btnSend').attr('disabled',true);
		 
		 
		 
/*  		 $('#lp').val(rows.length);
		var aa=$('#first').val();
		var bb=rows.length-aa;
		 var sec=$('#sec').val();
		alert("aa"+aa);
		var cc=0;
		alert("rows.length"+rows.length);  
		var aa=$('#first').val();
		var rl=rows.length;
		
		 */
		 var aa=$('#first').val();
/*  	 alert("aa"+aa);
		 alert("rows.length"+rows.length);    */
		
		if(aa==rows.length-1)
			
			
			{1

	/* 	 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
			     
		     }); */
		     $("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno+"&brhid="+brhid);
		     
		 	  $.messager.show({title:'Message',msg:'Record successfully Updated',showType:'show',
                  style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
              }); 
		 	
		 	 $('#chk').val(0);
			 $('#sec').val(0);
			 $('#first').val(0);
			 $('#lp').val(0);
			 $('#del').val(0);
		 	document.getElementById("errormsg").innerText="";
			 $('#btnSend').attr('disabled',false);
		 	return 0;
		 	
 
			}
		
		  chk=$('#chk').val();
		 
	 
		 
		 if(chk==0)
			 {
			 if(rows.length>20)
				 {
				 aa=0
				 bb=20;
				 var ccc=parseInt(rows.length)-20;
				 $('#sec').val(ccc);
				 $('#chk').val(1);
				 $('#first').val(20);
				 }
			 else
				 {
				 bb=rows.length;
				 var kk=rows.length-1;
				 $('#first').val(kk);
				 }
			 
			 }
			 else if(chk==1)
				 {
				
				 var cc=$('#sec').val();
				 
				 if(cc>20)
					 {
					var ss=parseInt(aa)+20;
					 $('#first').val(ss);
					 var kk=parseInt(cc)-20;
					 $('#sec').val(kk);
					 bb=parseInt(aa)+20;
					 }
				 
				 else
					 {
				 
					 bb=rows.length;
					 var kk=rows.length-1;
					 $('#first').val(kk);
		 
					 }
	 
				 
				 }
			 
			 
			  
 
		
 
		   for(var i=aa ; i <bb; i++){
			   
			   
			   
			   var voc_no=rows[i].voc_no;
			   var priono=0;
			   var conditions;
			   var terms;
			   
			   priono=rows[i].priorno;
			   
			   
			   if((priono=="" || typeof(priono)=="undefined" || typeof(priono)=="NaN"))
				  {
				   priono=i+1;
				  }
			   
			
			   if(!(voc_no=="" || typeof(voc_no)=="undefined"))
				  {
				   
				   
				   conditions=rows[i].conditions;
				   terms=rows[i].terms;
				  // conditions=conditions.replace('%','%25');
				   conditions = conditions.replace(/#|%/g,'%25');
				   
				  terms = terms.replace(/#|%/g,'%25');
				 
			   
			   list.push(rows[i].voc_no+" :: "+terms+" :: "+conditions+" :: "+priono+" :: "); 
			  
			   
				  }
		   }
		    
		   save(list);
		 
     }
	   
	 
	 
	 function save(list){
 
		 
		 var  del=$('#del').val();
		 
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 var items= x.responseText;
					 	var itemval=items.trim();  
					 	
					 	//alert(items);
					 	 $('#del').val(1);
	      if(parseInt(itemval)==1)
	      	{
					  
	    	  saveterms() ;
					  
					 	
					}
				else
					{
				/* 	$.messager.alert('Message', '  Not Updated ', function(r){
					     
				     });
					 */ $('#del').val(0);
					 	document.getElementById("errormsg").innerText="";
					 $('#chk').val(0);
					 $('#sec').val(0);
					 $('#first').val(0);
					 $('#lp').val(0);
					 
					 $("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno+"&brhid="+brhid);
					 
					 $.messager.show({title:'Message',msg:'Not Updated',showType:'show',
		                  style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		              }); 
					 $('#btnSend').attr('disabled',false);
					}   
			}
			}
			
		      x.open("POST", <%=contextPath+"/"%>+"com/common/termsavedata.jsp?docno="+document.getElementById("docno").value+"&dtype="+document.getElementById("formdetailcode").value+"&brhid="+$('#brchName').val()+"&list="+list+"&chk="+del);
 <%--  x.open("GET", <%=contextPath+"/"%>+"com/common/termsavedata.jsp?list="+list+"&docno="+document.getElementById("docno").value+"&dtype="+document.getElementById("formdetailcode").value+"&brhid="+$('#brchName').val()); --%>
			x.send();
		}

<%-- 	   
         $.ajaxFileUpload  
         (  
             {  
            	 url:'<%=contextPath%>/com/common/saveTerms.action?docno='+$("#docno").val()+'&dtype='+$("#formdetailcode").val()+'&list='+list+'&brhid='+brhid ,
                 secureuri:false,//false  
                 fileElementId:'file',//id  <input type="file" id="file" name="file" />  
                 dataType: 'string',// json  
                 success: function (data, status)  //  
                 {  
                	 $.messager.show({title:'Message',msg:'Terms and Conditions Saved',showType:'show',
                         style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                     });
                	 $("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno+"&brhid="+brhid);
                 },  
                 error: function (data, status, e)//  
                 {  
                    
                 }  
             }  
         )  
         return false;  
     }
	  --%>
	 
	 function getTermsCount(){
			
			var docno=document.getElementById('docno').value;
			var dtype=document.getElementById('formdetailcode').value;
			var brhid=$('#brchName').val();
	
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	var items= x.responseText;
				 	items = items.split('####');
				 		var count = items[0];
				 		
				 		if(count>0){
				 			
				 			$("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno+"&brhid="+brhid);
				 		}
				 		else{
				 			 $("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype);
				 		}
					}
			       else
				  {}
		     }
		      x.open("GET", <%=contextPath+"/"%>+"com/common/getTermsCount.jsp?docno="+docno+"&dtype="+dtype+"&brhid="+brhid,true);
		     x.send();
		    
		   }
	 
	 
	 function deleteterms(){
		 
		 var docno=$('#docno').val();
	     var dtype=$('#formdetailcode').val();
	     var brhid=$('#brchName').val();
	     
	 	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 		var count = items[0];
			 		
			 		if(count>0){
			 			$("#comtermsDiv").load("<%=contextPath%>/com/common/termsGrid.jsp?dtype="+dtype+"&qotdoc="+docno+"&brhid="+brhid);
			 			 $.messager.show({title:'Message',msg:'Deleted Successfully',showType:'show',
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
		 x.open("GET", <%=contextPath+"/"%>+"com/common/termdeletedata.jsp?docno="+docno+"&dtype="+dtype+"&brhid="+brhid,true);
	     x.send();
	 }
	
	</script>
	
	
<body>
<div id="mainBG" class="homeContent" data-type="background">
 <form id="frmterms" action="saveTerms" method="post" autocomplete="off">
 <table width="100%">
 <tr>
    <td>
 <fieldset><legend><font style="font-family: comic sans ms;font-weight: bold;">Terms & Conditions</font></legend>
<div id="comtermsDiv"><jsp:include page="termsGrid.jsp"></jsp:include></div></fieldset>
</td>
</tr>
</table>
<table width="100%" >
<tr>
<td width="50%" align="right"><button class="myButtons" type="button" id="btnSend" name="btnSend" onClick="saveterms()">Save</button></td>
<td width="50%" align="left"><button class="myButtons" type="button" id="btnSend" name="btnSend" onClick="deleteterms()">Delete</button></td>
<td>
<input type="hidden" name="condoc" id="condoc" value='<s:property value="condoc"/>' />
<input type="hidden" name="first" id="first" value='<s:property value="first"/>' />
<input type="hidden" name="sec" id="sec" value='<s:property value="sec"/>' />
<input type="hidden" name="lp" id="lp" value='<s:property value="lp"/>' />
<input type="hidden" name="del" id="del" value='<s:property value="del"/>' />
<input type="hidden" name="chk" id="chk" value='<s:property value="chk"/>' />
<input type="hidden" name="termsgridlen" id="termsgridlen" value='<s:property value="termsgridlen"/>' />
<input type="hidden" name="txtcond" id="txtcond" value='<s:property value="txtcond"/>' />
</td>
</tr>
</table>

<div id="comsearchwndow">
   <div></div>
   </div>
   <div id="concomsearchwndow">
   <div></div>
   </div>
   
</form>   
 </div> 
</body>

</html>
