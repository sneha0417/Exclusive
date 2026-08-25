<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%@page import="com.controlcentre.settings.servicesettings.ClsServiceSettingDAO"%>
<%ClsServiceSettingDAO DAO= new ClsServiceSettingDAO();
String doctype = request.getParameter("doctype")==null?"0":request.getParameter("doctype").trim();
 String name=request.getParameter("formname"); 
String code=request.getParameter("formcode");
String lblname=request.getParameter("lblname");
String lbldrp=request.getParameter("lbldrp");
String mode=request.getParameter("mode");

%> 
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  
    	document.getElementById("formdet").innerText="Service Settings(SRS)";
  		document.getElementById("formdetail").value="Service Settings";
  		document.getElementById("formdetailcode").value="SRS";
  		window.parent.formCode.value="SRS";
  		window.parent.formName.value="Service Settings";
    	  
    	  <%if(!(name==null)) {%>
  	    document.getElementById("formdet").innerText="<%=name%>(<%=code%>)";
  		document.getElementById("formdetail").value="<%=name%>";
  		document.getElementById("formdetailcode").value="<%=code%>";
  		window.parent.formCode.value="<%=code%>";
  		window.parent.formName.value="<%=name%>"; 
  		document.getElementById("txtcategory").value="<%=lbldrp%>";
  		document.getElementById("test").innerText="<%=lblname%>";
  		document.getElementById("mode").value="<%=mode%>";  
  		<%}%>
  		
  		  $('#btnEdit').attr('disabled', true);
    	  $('#btnSearch').attr('disabled', true);
    	  //$('#btnDelete').attr('disabled', true);
    	  
    	  
    	  
    	  $("#date").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
    	 
          var data='<%=DAO.settingList(session,doctype) %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						    {name : 'groupname', type: 'String'  },
                            	{name : 'description', type: 'String'  },
                            	{name : 'codeno',type:'String'},
                            	{name : 'dtype',type:'String'},
                            	{name : 'date',type:'String'},
                            	
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
      


              $("#jqxServiceSetting").jqxGrid(
                      {
                      	width: '90%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                          sortable: true,
                          altrows:true,
                          //Add row method
                          columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',editable:false  },	
							{ text: 'Category', datafield: 'dtype', width: '15%',editable:false },
							{ text: 'Code', datafield: 'codeno', width: '15%',editable:false  },
							{ text: 'Name', datafield: 'groupname', width: '30%',editable:false },
							{ text: 'Description', datafield: 'description', width: '30%',editable:false  },
							{ text: 'date', datafield: 'date', width: '30%',hidden:true  },
          	              ]
                      });

              $('#jqxServiceSetting').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxServiceSetting').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		                document.getElementById("txtcategory").value = $("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "dtype");
  		              $('#frmServiceSetting select').attr('disabled', false);
  		    		   $('#date').jqxDateTimeInput({disabled: false});
  		                $("#date").jqxDateTimeInput('val',$("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "date"));
  		                $('#txtcode').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "codeno")) ;
  		                $('#txtname').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "groupname")) ;
  		                $('#txtdesc').val($("#jqxServiceSetting").jqxGrid('getcellvalue', rowindex1, "description")) ;
  		              $('#frmServiceSetting select').attr('disabled', true);
  		    		$('#date').jqxDateTimeInput({disabled: true});
              		 }); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmServiceSetting input').attr('readonly', true);
		$('#frmServiceSetting select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmServiceSetting input').attr('readonly', false);
		$('#frmServiceSetting select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		

		<%if(!(name==null)) {%>
		document.getElementById("txtcategory").value="<%=lbldrp%>";  
  		<%}%>
		
	}

	
	function funFocus(){
		document.getElementById("txtcode").focus();
	}
	 $(function(){
	        $('#frmServiceSetting').validate({
	                 rules: {
	                 brand:{
	                	 required:true
	                 },
	                 model:{
	                	 required:true,
	                	 maxlength:20
	                 }
	                 },
	                 messages: {
	                  brand:{
	                	  required:" *"
	                  },
	                  model:{
	                	  required:" *",
	                	  maxlength:"max 20 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		
		if ( $('#hidtxtcategory').val() != null && $('#hidtxtcategory').val() !="") {
		
					$('#txtcategory').val($('#hidtxtcategory').val());
		}
		
		
if ($('#brandid').val() != null) {
	//alert("ghcj");
			$('#brand').val($('#brandid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
	
	function refChange(){
		
		
		
		var value=document.getElementById("txtcategory").value;
		
		if(value=="area"){
			document.getElementById("test").innerText="Service Area Settings";
		}
		if(value=="service"){
			document.getElementById("test").innerText="Service  Settings";
		}
		if(value=="agent"){
			document.getElementById("test").innerText="Service Agent Settings";
		}
		if(value=="complaints"){
			document.getElementById("test").innerText="Service Complaint Settings";
		}
		if(value=="equipments"){
			document.getElementById("test").innerText="Service Equipments Settings";
		}
		if(value=="holdlocation"){
			document.getElementById("test").innerText="Service Hold Location Settings";
		}
		if(value=="jobcategory"){
			document.getElementById("test").innerText="Service Job Category Settings";
		}
		if(value=="serviceactivity"){
			document.getElementById("test").innerText="Service Activity Settings";
		}
		if(value=="section"){
			document.getElementById("test").innerText="Service Section Settings";
		}
		if(value=="assignmode"){
			document.getElementById("test").innerText="Service Assign Mode Settings";
		}
		if(value=="site"){
			document.getElementById("test").innerText="Service Site Settings";
		}
		if(value=="project"){
			document.getElementById("test").innerText="Service Project Settings";
		}
	}
	
</script>
</head>
<body onLoad="setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmServiceSetting" action="saveServiceSetting"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<fieldset><legend><labal id="test" >Service Settings </labal></legend>
<table width="100%">
<tr>
  <td width="12%"><div align="right">Date</div></td>
  <td width="22%"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
  <td width="7%"><div align="right">Doc No</div></td>
  <td width="59%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Category</div></td>
<td> 

 <select name="txtcategory" id="txtcategory" onchange="refChange();" style="width:60%;" >
<option value="service">Service</option>
<!-- <option value="agent">Agent</option> -->
<option value="complaints">Complaints</option>
<option value="area">Area</option>
<!-- <option value="equipments">Equipments</option> -->
<!-- <option value="holdlocation">Hold Location</option> -->
<!-- <option value="jobcategory">Job Category</option> -->
<option value="serviceactivity">Service Activity</option>
<!-- <option value="project">Project</option>
<option value="section">Section</option> -->
<option value="assignmode">Assign Mode</option>
<!-- <option value="site">Site</option> -->

 </select></td>
 <td><div align="right">Code</div></td><td><input type="text" name="txtcode"  id="txtcode" value='<s:property value="txtcode"/>'></td></tr>
 
 <tr><td><div align="right">Name</div></td>
<td><input type="text" name="txtname"  id="txtname" style="width:80%;" value='<s:property value="txtname"/>'></td>
 <td><div align="right">Description</div></td><td><input type="text" style="width:80%;" name="txtdesc"  id="txtdesc" value='<s:property value="txtdesc"/>'></td></tr>

<td><input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' /> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
<input type="hidden" id="hidtxtcategory" name="hidtxtcategory" value='<s:property value="hidtxtcategory"/>' />
</td>

</table> 
</fieldset>    
</form>
<br/>
<div id="jqxServiceSetting"></div>
	
</div>
</body>
</html>