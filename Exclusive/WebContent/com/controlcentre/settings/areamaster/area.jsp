<%@page import="com.controlcentre.settings.areamaster.area.ClsAreaDAO"%>
<%ClsAreaDAO DAO= new ClsAreaDAO();%>

<%@ taglib prefix="s" uri="/struts-tags" %>
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
      $(document).ready(function () {          
    	  $("#date_area").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
          var data= '<%=DAO.searchDetails()%>'; 
       	
              
       //  var data; 
               var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'doc_no' , type: 'int' },
       						    {name : 'area', type: 'String'  },
                            	{name : 'date', type: 'String'  },
                            	{name : 'region',type:'String'},
                            	{name : 'reg_id',type:'String'},
                            	{name : 'country',type:'String'},
                            	{name : 'cou1_id',type:'String'},
                            	{name : 'city_name',type:'String'},
                            	{name : 'city_id', type: 'String'  }
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
      


              $("#jqxAreaSearch1").jqxGrid(
                      {
                      	width: '80%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%'},
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},         					
          					{ text: 'Area',columntype: 'textbox', filtertype: 'input', datafield: 'area', width: '20%' },
          					{ text: 'Country id', datafield: 'cou1_id' } ,
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country', width: '20%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '20%' } ,
          					{ text: 'City id', datafield: 'city_id' } ,
         					{ text: 'City',columntype: 'textbox', filtertype: 'input', datafield: 'city_name', width: '20%' }

          	              ]
                      });

              $('#jqxAreaSearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		            	document.getElementById("docno").value= $('#jqxAreaSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
  		            	 document.getElementById("area").value = $("#jqxAreaSearch1").jqxGrid('getcellvalue', rowindex1, "area");
  		                document.getElementById("city").value = $("#jqxAreaSearch1").jqxGrid('getcellvalue', rowindex1, "city_id");
		                document.getElementById("country").value = $("#jqxAreaSearch1").jqxGrid('getcellvalue', rowindex1, "cou1_id");
  		                document.getElementById("region").value = $("#jqxAreaSearch1").jqxGrid('getcellvalue', rowindex1, "reg_id");
  		              $('#frmArea select').attr('disabled', false);
  		    		$('#date_area').jqxDateTimeInput({disabled: false});
  		                $("#date_area").jqxDateTimeInput('val',$("#jqxAreaSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		              $('#frmArea select').attr('disabled', true);
  		    		$('#date_area').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxAreaSearch1").jqxGrid('hidecolumn', 'reg_id'); 
              $("#jqxAreaSearch1").jqxGrid('hidecolumn', 'cou1_id'); 
              $("#jqxAreaSearch1").jqxGrid('hidecolumn', 'city_id'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('areaSearch.jsp', $('#window')); 
		 }

	function funReset() {
		document.getElementById("frmArea").reset();
	}
	function funReadOnly() {
		$('#frmArea input').attr('readonly', true);
		$('#frmArea select').attr('disabled', true);
		$('#date_area').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmArea input').attr('readonly', false);
		$('#frmArea select').attr('disabled', false);
		$('#date_area').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		if(document.getElementById("mode").value=='A'){
			$('#jqxAreaSearch1').jqxGrid({ disabled: true});
		}
		

	}

	 function getRegion() {
		 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					
					items = items.split('***');
					var brandItems = items[0].split(",");
					var brandidItems = items[1].split(",");
					var optionsbrand = '<option value="">--Select--</option>';
					for (var i = 0; i < brandItems.length; i++) {
						optionsbrand += '<option value="' + brandidItems[i] + '">'
								+ brandItems[i] + '</option>';
					}
					/* alert("ssss"+optionsbrand); */
					$("select#region").html(optionsbrand);
					$('#region').val($('#reg_id').val());
					} else {
				}
			}
			x.open("GET", "getRegion.jsp", true);
			x.send();
		} 
	 function getCountry() {
		 	var region=document.getElementById("region").value;
		 	//alert("==region"+region);
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					
					items = items.split('***');
					var brandItems = items[0].split(",");
					var brandidItems = items[1].split(",");
					var optionsbrand = '<option value="">--Select--</option>';
					for (var i = 0; i < brandItems.length; i++) {
						optionsbrand += '<option value="' + brandidItems[i] + '">'
								+ brandItems[i] + '</option>';
					}
					/* alert("ssss"+optionsbrand); */
					$("select#country").html(optionsbrand);
					$('#country').val($('#cou_id').val());
					} else {
				}
			}
			x.open("GET", "getCountry.jsp?region="+region, true);
			x.send();
		} 
	 function getCity() {
		 	var country=document.getElementById("country").value;
		 //	alert("==region"+country);
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					
					items = items.split('***');
					var brandItems = items[0].split(",");
					var brandidItems = items[1].split(",");
					var optionsbrand = '<option value="">--Select--</option>';
					for (var i = 0; i < brandItems.length; i++) {
						optionsbrand += '<option value="' + brandidItems[i] + '">'
								+ brandItems[i] + '</option>';
					}
					/* alert("ssss"+optionsbrand); */
					$("select#city").html(optionsbrand);
					$('#city').val($('#city_id').val());
					} else {
				}
			}
			x.open("GET", "getCity.jsp?country="+country, true);
			x.send();
		} 
	
	function funFocus(){
		document.getElementById("region").focus();
	}
	 $(function(){
	        $('#frmArea').validate({
	        	 rules: {
                	 region:{
                	 required:true
	                 },
	                 country:{
	                	 required:true,
	                	
	                 },
	                 city:{
	                	 required:true,
	                 },
	                 area:{
	                	 required:true,
	                	 maxlength:30 
	                 }
	                 },
	                 messages: {
	                	 region:{
	                	  required:" *"
	                  },
	                  country:{
	                	  required:" *",	  
	                  },
	                  city:{
	                	  required:" *",
	                  },
	                  city:{
	                	  required:" *",
	                	  maxlength:"max 30 chars"
	                  }
                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
if ($('#reg_id').val() != null) {
	//alert("ghcj");
			$('#region').val($('#reg_id').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
</script>
</head>
<body onLoad="getRegion();getCountry();getCity();funReadOnly();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmArea" action="saveArea"  autocomplete="off">
<script>
			window.parent.formName.value="City";
			window.parent.formCode.value="CTI";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset><legend>City Details</legend>
<input type="text" id="cou_id" name="cou_id" value='<s:property value="cou_id"/>' hidden="true">
<input type="text" id="reg_id" name="reg_id" value='<s:property value="reg_id"/>' hidden="true">
<input type="text" id="city_id" name="city_id" value='<s:property value="city_id"/>' hidden="true">
<table width="100%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%" colspan="2"><div id="date_area" name="date_area" value='<s:property value="date_area"/>'></div></td>
  <td width="23%" colspan="2"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>

<tr><td><div align="right">Region</div></td>
<td colspan="2"> 
<!-- <optio n value="">--Select--</option> -->
 <select name="region" id="region" onchange="getCountry();" style="width:95%;">
</select></td>
<td colspan="2"><div align="right">Country</div></td>
<td> 
 <select name="country" id="country" onchange="getCity();" style="width:23%;">
</select></td>
<tr>
<td><div align="right">State / Province</div></td>
<td > 
 <select name="city" id="city" style="width:100%;">
</select></td>
<td colspan="3"><div align="right">City</div></td><td><input type="text" name="area" id="area" value='<s:property value="area"/>' style="width:22%;"></td></tr>

<%-- <tr><td><div align="right">Country</div></td>
<td> 
 <select name="brand" id="brand" style="width:100%;">
</select></td> --%>
<%-- <td><div align="right">City</div></td>
<td> 
 <select name="brand" id="brand" style="width:50%;">
</select></td> --%>
<%-- <td><div align="right">Region</div></td>
<td> 
 <select name="brand" id="brand" style="width:50%;">
</select></td> --%>
</table> 
</fieldset>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
 <%-- <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> --%>

<%-- <input type="hidden" id="mode" name="mode"/>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/> --%>    
</form>
<br/>
<div id="jqxAreaSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="modelSearch.jsp"></jsp:include>
	</div></div> --%>
	
</div>
</body>
</html>