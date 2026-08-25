
<jsp:include page="../../../../includes.jsp"></jsp:include>     
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

 
<script type="text/javascript">

$(document).ready(function () {
	
	   
	   $('#docwindow').jqxWindow({ width: '20%', height: '31%',  maxHeight: '50%' ,maxWidth: '60%' , title: 'Jobtype Search' ,position: { x: 1000, y: 120 }, keyboardCloseKey: 27});
	   $('#docwindow').jqxWindow('close');
	   $('#dtypewindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'DocType Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#dtypewindow').jqxWindow('close');
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   
	/*  $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 }); */
});
function funExportBtn(){
	   $("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
	 }

function dtypeSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#dtypewindow').jqxWindow('open');
		$('#dtypewindow').jqxWindow('setContent', data);

	}); 
	} 
	
	function getsavedata(jobtype,username,userrole,jobtypeid){
		
		/* alert(jobtype);
		alert(username);
		alert(userrole); */
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText;

		 	if(parseInt(items)>0)
			 {
			 $.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
				
		      
			 }
		 else
			 {
			 $.messager.alert('Message', '  Not Updated ', function(r){
			  });
			 }

		}
		}	
		x.open("GET","saveData.jsp?jobtype="+jobtype+"&username="+username+"&userrole="+userrole+"&jobtypeid="+jobtypeid,true);
		x.send();
	}

function docnoSearchContent(url) {
	$.get(url).done(function (data) {
		$('#docwindow').jqxWindow('open');
		$('#docwindow').jqxWindow('setContent', data);
	}); 
}  
function funreload(event)
{

	  //var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	// var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	  /*  if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   { */
	 <%-- var barchval ='<%= session.getAttribute("BRANCHID")%>' ; --%>
    /*  var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();  */
	   $("#overlay, #PleaseWait").show();
	   /* ?barchval="+barchval */
	  $("#detlist").load("detailsGrid.jsp?check=1");
	
		  // }
	}




function  funcleardata()
{
	
	document.getElementById("doc_no").value="";
	document.getElementById("doctype").value="";
	document.getElementById("brhid").value="";
	document.getElementById("reason").value="";
	
	 if (document.getElementById("doc_no").value == "") {
			
		 
	        $('#doc_no').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("doctype").value == "") {
			
		 
	        $('#doctype').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("brhid").value == "") {
			
		 
	        $('#brhid').attr('placeholder', 'Press F3 TO Search'); 
	    }
	
	}
	
	
<%-- function saveApprremove()  
{  

	if($("#doc_no").val()=="" || $("#doctype").val()=="" || $("#brhid").val()==""){
		
		 $.messager.alert('Message','Select an Approval to Remove  ','warning');
		
		//alert('Select an Approval to Remove');
		
		return 0;
		
	}
/*  var reftypid=document.getElementById("reftypid").value; */     
	/* alert("===docno==="+$("#hidocno").val()+"===&dtype="+$("#hidtype").val()+"&userid===="+$("#hiuserid").val()+"==&brchid="+$("#hibrchid").val()+"===&desc="+$("#txtdesc").val()); */
    $.ajaxFileUpload  
    (  
        {  
            url:'removeApprove.action?docno='+$("#doc_no").val()+'&dtype='+$("#doctype").val()+'&brchid='+$("#brhid").val()+'&reason='+$("#reason").val(),
            secureuri:false,//false  
            fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            dataType: 'String',// json  
            success: function (data, status)  //  
            {  
                //alert(data.message);//jsonmessage,messagestruts2
           	
         //       $('#refreshdiv').load();
                var data='<%= com.common.ClsAttach.reload(docNo) %>';
             //   alert("============="+data);
               if(status=='success'){
              	 
            		  $("#detlist").load("detailsGrid.jsp?barchval="+$("#brhid").val()+"&fromdate="+$("#fromdate").val()+"&todate="+$("#todate").val()+"&doc_no="+$("#doc_no").val()+"&dtype="+$("#doctype").val());
            	   
            	   
                   $.messager.show({title:'Message',msg:'Approval Removed Successfully',showType:'show',
                      style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
                }
               
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
 --%>
	


</script>
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}


	
      

</style>
<script>

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<%--  <tr><td colspan="2">&nbsp;</td></tr>
	 
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr> --%>
     
	
	 <%-- <tr><td align="right"><label class="branch">Status</label></td><td align="left"><select id="status" name="status" style="height:20px;width:70%;" value='<s:property value="status"/>'>
    <option value="" selected>All</option>  
       <option value=0>Open</option>
    <option value=1>Close</option>  
	 </select></td></tr>  --%>
	 
	 
 <%--  <tr><td align="right"><label class="branch">DocType</label></td><td align="left"><input type="text" name="doctype" id="doctype" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getdtype(event);"   style="height:20px;width:70%;" value='<s:property value="doctype"/>'></td></tr> --%> 
 <%-- <tr><td align="right"><label class="branch">DocNo</label></td><td align="left"><input type="text" name="doc_no" id="doc_no"  placeholder="Press F3 TO Search" readonly="readonly"    onkeydown="getdocno(event)" onclick="this.placeholder='' "  style="height:20px;width:70%;" value='<s:property value="doc_no"/>' ></td></tr> --%> 
<%--  <tr><td align="right"><label class="branch">Reason</label></td><td align="left">
 <textarea name="reason" id="reason" style="height:90px;width:90%;resize:none;font:10px Tahoma;"><s:property value="reason"/></textarea></td></tr>  
 --%>    
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2"></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
	 <td colspan="2" align="center"><input type="hidden" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()">
     <input type="hidden" class="myButton" name="save" id="save"  value="Save" onclick="saveApprremove()"></td></tr>
	<tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 100px;"></div></td> 
	</tr>	
	
	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	
	
	</table>
	</fieldset>
	<input type="hidden" name="brhid" id="brhid"  value='<s:property value="brhid"/>'>
	<input type="hidden" name="jobtype" id="jobtype"  value='<s:property value="jobtype"/>'>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detlist"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="groupwindow">
   <div ></div>
</div>
<div id="docwindow">
   <div ></div>
</div>
<div id="dtypewindow">
   <div ></div>
</div>
</div>
</body>
</html>
	 