<%@page import="com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeAction" %>
<%ClsPlateCodeAction cpa=new ClsPlateCodeAction(); %>

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
<style>
form label.error {
color:red;
  font-weight:bold;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#date_plateCode").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
	//	 $("#btnEdit").attr('disabled', true );		
		document.getElementById("formdet").innerText="Plate Code(PLT)";
		document.getElementById("formdetail").value="Plate Code";
		document.getElementById("formdetailcode").value="PLT";
		window.parent.formCode.value="PLT";
		window.parent.formName.value="Plate Code";
		getAuth();
		var data= '<%=cpa.searchDetails() %>'; 
	
	            
	            
	             var num = 0; 
	            var source =
	            {
	                datatype: "json",
	                datafields: [
								{name : 'doc_no' , type: 'number' },
	                          	{name : 'code_no' , type: 'String' },
	     						{name : 'code_name', type: 'String'  },
	                          	{name : 'authname', type: 'String'  },
	                          	{name : 'authId', type: 'String'  },
	                          	{name : 'plateDate', type: 'date'  }
	                          	
	                 ],
	                 localdata: data,
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
	         
	            $("#jqxPlateCodeSearch1").jqxGrid(
	                    {
	                    	width: '70%',
	                        height: 350,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'singlerow',
	                        //pagermode: 'default',
	                        sortable: true,
	                        //pageable: true,
	                        altrows:true,
	                        //Add row method
	                        columns: [
	                                  {text: 'Doc No',datafield:'doc_no',hidden:true},
	        					{ text: 'Plate Code', datafield: 'code_no', width: '30%' },
								{ text: 'Plate Name', datafield: 'code_name', width: '40%' },
								{ text: 'Authority Name', datafield: 'authname', width: '30%' },
								{ text: 'Authority Id', datafield: 'authId', width: '30%',hidden:true },
								{ text: 'Date', datafield: 'plateDate', width: '30%',hidden:true,cellsformat:'dd.MM.yyyy' }
								]
	                    });
	            $('#jqxPlateCodeSearch1').on('rowdoubleclick', function (event) 
	            		{
			            	var rowindex1=event.args.rowindex;
			            	$('#date_plateCode').jqxDateTimeInput({ disabled: false});
			        		//$('#frmPlateCode select').attr('disabled', false);
			        		
			            	document.getElementById("docno").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
			                document.getElementById("plateCode").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "code_no"); 
			                document.getElementById("platename").value = $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "code_name");
			                $('#authName').val($("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "authId")) ;
			                $("#date_plateCode").jqxDateTimeInput('val', $("#jqxPlateCodeSearch1").jqxGrid('getcellvalue', rowindex1, "plateDate")); 
			        		$('#frmPlateCode select').attr('disabled', true);
			            	$('#date_plateCode').jqxDateTimeInput({ disabled: true});
			            	
			            	document.getElementById("authorityname").value= $('#jqxPlateCodeSearch1').jqxGrid('getcellvalue', rowindex1, "authname");
			            	
			            	var auth12=$('#jqxPlateCodeSearch1').jqxGrid('getcelltext', rowindex1, "authname");
			            	auth=auth12.replace(/ /g, "%20");
			            	 $("#nAliasgrid").load("nAliasgrid.jsp?itemno="+document.getElementById("docno").value);

			                $('#window').jqxWindow('close');
	            		 }); 
	
	});
	  function funSearchLoad(){
			changeContent('plateCodeSearch.jsp', $('#window')); 
		 }
	function funReadOnly() {
		$('#frmPlateCode input').attr('readonly', true);
		$('#frmPlateCode select').attr('disabled', true);
		 $('#date_plateCode').jqxDateTimeInput({ disabled: true}); 

	}
	function funRemoveReadOnly() {
		$('#frmPlateCode input').attr('readonly', false);
		 $('#date_plateCode').jqxDateTimeInput({ disabled: false}); 

		$('#frmPlateCode select').attr('disabled', false);
		$('#docno').attr('readonly', true);
		
		if(document.getElementById("mode").value=='E'){
		$("#jqxnalias").jqxGrid({ disabled: false});
		 $('#jqxnalias').jqxGrid('addrow', null, {});
		}
		/* if(document.getElementById("mode").value=='A'){
			$("#jqxnalias").jqxGrid('clear');
			 $('#jqxnalias').jqxGrid('addrow', null, {});
			 $("#jqxnalias").jqxGrid({ disabled: false});	
			
			} */
	}
	
	function getAuth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var authItems = items[0].split(",");
				var authIdItems = items[1].split(",");
				//alert(authIdItems);
				var optionsauth = '<option value="">--Select--</option>';
				for (var i = 0; i < authItems.length; i++) {
					optionsauth += '<option value="' + authIdItems[i] + '">'
							+ authItems[i] + '</option>';
				}
				$("select#authName").html(optionsauth);
				if ($('#authId').val() != null) {
					$('#authName').val($('#authId').val());

				}

			} else {
			}
		}
		x.open("GET", "getAuthority.jsp", true);
		x.send();
	}
	function setValues() {
		
		 if($('#datehidden').val()){
				$("#date_plateCode").jqxDateTimeInput('val', $('#datehidden').val());
			}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	function funFocus(){
		
		document.getElementById("authName").focus();
		
	}
	 $(function(){
	        $('#frmPlateCode').validate({
	                 rules: {
	                 authName:{
	                	 required:true
	                 },
	                 plateCode:{
	                	 required:true,
	                	 maxlength:10
	                 }
	                 },
	                 messages: {
	                  authName:{
	                	  required:" *"
	                  },
	                  plateCode:{
	                	  required:" *",
	                	  maxlength:"max 10 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	 var rows = $("#jqxnalias").jqxGrid('getrows'); 
	     	    var listss = new Array();
	    	 	var a = 1;
	    	   for(var i=0 ; i < rows.length ; i++){
	    		   var code=rows[i].code;
	    			if(code!="undefined" && code!="" && code!=null && typeof(code)!="undefined" ){
	        	    	
	    		   listss.push(rows[i].code+"::"+rows[i].doc_no+"::"+a+"::");  
	    			}
	    	   }
	    	savenalias(listss);
	    		return 1;
		} 
	     function funExcelBtn(){
			  $("#jqxPlateCodeSearch1").jqxGrid('exportdata', 'xls', 'Platecode');
		  }
	     
	     function savenalias(listss)
	     {
	     	
	     	    var codeno=document.getElementById("plateCode").value;
	       	     var authname=$("#authName option:selected").text();
	         	   var docno=document.getElementById("docno").value;
	         	   
	         		   	var x=new XMLHttpRequest();
	         		x.onreadystatechange=function(){
	         			if (x.readyState==4 && x.status==200)
	         				{
	         				 var itemsapprove= x.responseText;
	         				 	var itemvalappr=itemsapprove.trim();
	         					 	
	         	  if(parseInt(itemvalappr)==1)
	         	  	{
	    				}
	         			else
	         				{
	         			
	         				}  
	         		}
	         		}
	         		 
	         	x.open("GET","saveNAlias.jsp?list="+listss+"&docno="+docno+"&authname="+authname+"&codeno="+codeno);
	         		x.send();
	     	
	     	
	     	}  
	     
</script>
</head>

<body onLoad="setValues();">
	<form id="frmPlateCode" action="saveActionPlate"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" /><br/> 
		<div id="mainBG" class="homeContent" data-type="background">
			<%-- <fieldset>
				<table>
					<tr>
						<td width="11%"><div align="right">Date</div></td>
					  <td width="59%"><div id='date_plateCode'
								name='date_plateCode'
								value='<s:property value="date_plateCode"/>'></div></td>
						<td width="12%"><div align="right">Doc No</div></td>
						<td width="18%"><input type="text" name="docno" id="docno"
							value='<s:property value="docno"/>'></td>
					</tr>
					<tr>
						<td><div align="right">Authority</div></td>
						<td colspan="3"><select name="authName" id="authName"  style="width:26%;">
						  <option value="">--Select--</option>
                        </select>						</td>
				  </tr>
					<tr>
						<td><div align="right">
						  <div align="right">Plate Code</div>
						</div></td>
						<td colspan="3"><input type="text" id="plateCode" name="plateCode"
							style="width: 25%;" value='<s:property value="plateCode"/>'>
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp; <input
							type="text" name="platename" id="platename" style="width: 300px;"
							value='<s:property value="platename"/>'></td>
				  </tr>
					<tr>										        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
					
						<td><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/></td>
						<td><input type="hidden" name="deleted" id="deleted"
							value='<s:property value="deleted"/>' /></td>
						<td><input type="hidden" id="authId" name="authId"
							value='<s:property value="authId"/>' /></td>
						<td><input type="hidden" id="datehidden" name="datehidden"
							value='<s:property value="datehidden"/>' /></td>
					</tr>
				</table>
		  </fieldset>
 --%>		
 <fieldset>
 <table width="100%" >
  <tr>
    <td width="5%">Date</td>
    <td width="22%"><div id='date_plateCode'
								name='date_plateCode'
								value='<s:property value="date_plateCode"/>'></div></td>
    <td width="4%">Doc No</td>
    <td width="32%"><input type="text" name="docno" id="docno"
							value='<s:property value="docno"/>'></td>
    <td width="39%" rowspan="3"> <div id="nAliasgrid"><jsp:include page="nAliasgrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td>Authority</td>
    <td><select name="authName" id="authName"  style="width:80%;">
						  <option value="">--Select--</option>
                        </select></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Plate Code</td>
    <td><input type="text" id="plateCode" name="plateCode"
							style="width: 80%;" value='<s:property value="plateCode"/>'></td>
    <td>Name</td>
    <td><input
							type="text" name="platename" id="platename" style="width: 300px;"
							value='<s:property value="platename"/>'></td>
  </tr>
</table>
 </fieldset>
 
		</div>
		<table>
		<tr>
		<td>
			 <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
					
						<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
						<input type="hidden" name="deleted" id="deleted"
							value='<s:property value="deleted"/>' />
						<input type="hidden" id="authId" name="authId"
							value='<s:property value="authId"/>' />
					<input type="hidden" id="datehidden" name="datehidden"
							value='<s:property value="datehidden"/>' />
					<input type="hidden" id="authorityname" name="authorityname"
							value='<s:property value="authorityname"/>' />
		</td>
		</tr>
		</table>
	</form>
<br/>
<div id="jqxPlateCodeSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="plateCodeSearch.jsp"></jsp:include>
	</div></div> --%>
</body>
</html>