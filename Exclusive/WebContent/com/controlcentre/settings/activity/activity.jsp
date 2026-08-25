<%@page import="com.controlcentre.settings.activity.ClsActivityDAO"%>
<%ClsActivityDAO DAO= new ClsActivityDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date_acti").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	   var data= '<%=DAO.searchDetails() %>'; 
	//  var data=0;
 var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'String' },
     						{name : 'ay_name', type: 'String'  } ,
                            {name : 'ay_code', type: 'String'  }  
                          	
                 ],
               localdata: data,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxactivitySearch1").jqxGrid(
                    {
                    	width: '90%',
                    	height: 300,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        //Add row method
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%' },
        					{ text: 'Activity',columntype: 'textbox', filtertype: 'input', datafield: 'ay_name', width: '40%' },
        					{ text: 'Activity Code',columntype: 'textbox', filtertype: 'input', datafield: 'ay_code', width: '30%' } 
        					
        	              ]
                    });
            $('#jqxactivitySearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxactivitySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("activity").value = $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "ay_name");
                document.getElementById("activity_code").value = $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "ay_code");
                $("#date_acti").jqxDateTimeInput('val', $("#jqxactivitySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
               // $('#window').jqxWindow('hide');
            }); 
        });
       function funSearchLoad(){
		changeContent('activitySearch.jsp', $('#window')); 
	 } 
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmActivity input').attr('readonly', true);
		$('#date_acti').jqxDateTimeInput({
			readonly : true
		});
		setValues();
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmActivity input').attr('readonly', false);
		$('#date_acti').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxactivitySearch1').jqxGrid({ disabled: true});
		}
	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		if($('#datehidden').val()){
			$("#date_acti").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	 $(function(){
	        $('#frmActivity').validate({
	                 rules: {
	                	 region: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                	 region: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 /* document.getElementById("region").focus(); */
	    	 $('#date_acti').jqxDateTimeInput('focus');
	     }
	  
</script>  
 
</head>
<body onLoad="funReadOnly();setValues();" >
<form id="frmActivity" action="saveActivity" method="get" autocomplete="off">
<script>
			 window.parent.formName.value="ACTIVITY";
			window.parent.formCode.value="ACT"; 
	</script>
	<%-- <jsp:include page="../../../../header.jsp" /> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Activity</legend>
	<table width="100%">
		<tr><td width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="date_acti" name="date_acti"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr><!-- pattern=".{1,3}" required="required" -->
		<tr><td align="right">Activity</td>
			<td><input type="text" name="activity" id="activity"  value='<s:property value="activity"/>' ></td>
			<td><div align="right">Activity Code</div></td>
             <td><input type="text" name="activity_code" id="activity_code" value='<s:property value="activity_code"/>'></td>
			</tr>
			
			<tr>
				<%-- <td><input type="hidden" id="mode" name="mode"/></td>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>
				
				
				<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/></td>
				<%-- <td><input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/></td> --%>
			</tr>
	</table>
	
	</fieldset><br/>
    	<div id="jqxactivitySearch1"></div>  
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
	</form>

<br/>
		<%-- 	<div id="window">
				<div id="windowHeader" class="windowHead">
					<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search
					</span>
				</div>
				<div id="windowContent" class="windowCont" style="overflow: hidden;">
					<jsp:include page="brandSearch.jsp"></jsp:include>
				</div></div>
	 --%>
	

</body>
</html>