<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
form label.error {
color:red;
  font-weight:bold;

}


      .controls {
        margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
        height: 32px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
      #target {
        width: 345px;
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

.btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
  
  .hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
  
</style>
<script type="text/javascript">
	$(document).ready(function () {     
		  $('#btnExcel').attr({ disabled: true});

		$('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  	$('#areainfowindow').jqxWindow('close');
	  	
	  	 $('#vendorinfowindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '50%' , title: 'Vendor Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vendorinfowindow').jqxWindow('close');
		 $('#roominfowindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Room Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#roominfowindow').jqxWindow('close');
		  document.getElementById("formdet").innerText="HotelType(HTL)";
   		  document.getElementById("formdetail").value="HotelType";
   		  document.getElementById("formdetailcode").value="HTL";
   		  window.parent.formCode.value="HTL";
   		  window.parent.formName.value="HotelType";
   		  
   		  $('#txtarea').dblclick(function(){
		  $('#areainfowindow').jqxWindow('open');
		  areaSearchContent('area.jsp?getarea=0');
		  });
   		
   		  $('#vendor').dblclick(function(){
		  $('#vendorinfowindow').jqxWindow('open');
		  VendorSearchContent('vendorsearch.jsp');
		  });
		});
	function getareadetails(event){
		 var x= event.keyCode;
   		 if(x==114){
   			$('#areainfowindow').jqxWindow('open');
   			areaSearchContent('area.jsp?getarea=0');  	 }
   		 else{
   			 }
	}
	function getvendordetails(event){
		 var x= event.keyCode;
   		 if(x==114){
   			$('#vendorinfowindow').jqxWindow('open');
   			VendorSearchContent('vendorsearch.jsp');
   		 }else{
   			 }
		
		
	}
	  function roominfoSearchContent(url) {
	      	 //alert(url);
	      		 $.get(url).done(function (data) {
	      			 
	      			 $('#roominfowindow').jqxWindow('open');
	      		$('#roominfowindow').jqxWindow('setContent', data);
	      
	      	}); 
	      	} 
	function VendorSearchContent(url) {
		$('#vendorinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vendorinfowindow').jqxWindow('setContent', data);
		$('#vendorinfowindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function areaSearchContent(url) {
		 		 $.get(url).done(function (data) {
				 //alert(data);
				 $('#areainfowindow').jqxWindow('setContent', data);
               	}); 
     	}
	 function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}
	
	function funReadOnly(){
		$('#frmHotelType input').attr('readonly', true );
		$('#frmHotelType input').attr('disabled', true );
		$('#frmHotelType select').attr('disabled', true ); 
		$("#jqxHotel").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmHotelType input').attr('readonly', false );
	 	$('#frmHotelType input').attr('disabled', false );
		$('#frmHotelType select').attr('disabled', false ); 
		$('#longitude').attr('readonly', true);
		$('#latitude').attr('readonly', true);
		$('#docno').attr('readonly', true);
		$("#jqxHotel").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	         $("#jqxHotel").jqxGrid('clear');
	        $('#docno').attr('readonly', true);
	        $('#name').attr('readonly', false);
	        $('#code').attr('readonly', false);
	        $('#hoteldiv').load('hoteltypeGrid.jsp');
	     }
		
		/*if ($("#mode").val() == "E") {
			$("#jqxHotel").jqxGrid('addrow', null, {});
		}*/
		
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	
	function funNotify(){
		
		if(document.getElementById("name").value==''){
			document.getElementById("errormsg").innerText="Enter name.";
			return false;
		}
		
		if(document.getElementById("txtareaid").value==''){
			document.getElementById("errormsg").innerText="Select Area.";
			return false;
		}
		if(document.getElementById("vendid").value==''){
			document.getElementById("errormsg").innerText="Select Vendor.";
			return false;
		}
		
		if(document.getElementById("txtareaid").value==''){
			document.getElementById("errormsg").innerText="Enter Area.";
			return false;
		}
		
		document.getElementById("location").value=document.getElementById("pac-input").value;
			
			var rows = $("#jqxHotel").jqxGrid('getrows');
			  
			   var z=0;
			  for (var i = 0; i < rows.length; i++) {
				var val=rows[i].val;
				//alert(val);
				
				
			    	   newTextBox = $(document.createElement("input"))
			    	   .attr("type", "dil")
				       .attr("id", "rtest"+z)
				       .attr("name", "rtest"+z)
				       .attr("hidden", "true");  
				    
				    
				 
				   newTextBox.val(rows[i].rtypeid+" :: "+rows[i].name+" :: "+rows[i].adult+" :: "+rows[i].child+" :: "+rows[i].extrabed+" :: "+rows[i].srno+" :: "+rows[i].roomsize+" :: "+rows[i].adultonly+" ::  "+rows[i].maxcount+" :: ");
				   //alert("iiii===="+newTextBox.val());
				   newTextBox.appendTo('form');
				   z++;
				  
			   }
			   $('#gridlength').val(z);
			    
		
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
 function funSearchLoad(){
		changeContent('hotelMainSearch.jsp', $('#window')); 
	 }
	 
	   function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode != 46 && charCode > 31 
            && (charCode < 48 || charCode > 57))
             return false;

          return true;
       }
		  
	function setValues() {
		if(document.getElementById("txthidrating").value!=""){
		document.getElementById("txtrating").value=document.getElementById("txthidrating").value;
		}
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
			
			 if(document.getElementById("location").value!=""){
			 document.getElementById("pac-input").value=document.getElementById("location").value;
			 google.maps.event.addDomListener(window, 'load', initialize);
		 }
		if(document.getElementById("docno").value!=""){
		var docno=document.getElementById("docno").value;
		//alert(docno);
		$('#hoteldiv').load('hoteltypeGrid.jsp?docno='+docno+'&id=1');
		
		}
		   
	}
	
	function funFocus(){
		document.getElementById("name").focus();
	}
	$(function(){
	        $('#frmHotelType').validate({
	        	rules: {
	                location:"required",
	                latitude:"required",
	                longitude:"required"
	                 
	            }, 
	        	messages:{
	        		location:" *",
	        		latitude:" *",
	        		longitude:" *"
	        	}
	        });
	      }); 
	
	function getCordinates(place){
			if(place==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Location is mandatory";
				return false;
			}
			else{
                var geocoder =  new google.maps.Geocoder();
                var city=place;
                geocoder.geocode({'address': city}, function(results, status) {
                      if (status == google.maps.GeocoderStatus.OK) {
                        $('#latitude').val(results[0].geometry.location.lat());
                        $('#longitude').val(results[0].geometry.location.lng());
                        /* var p1=new google.maps.LatLng(position1);
                        var p2=new google.maps.LatLng(position2);
                        var distance=(google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
                      	//Dont forget to add geometry library */ 
                      } else {
                        document.getElementById("errormsg").innerText="Invalid Location";
                        return false;
                      }
                    });			            

			}
		}
		
		
		function funvalid(){
		
			var chk=document.getElementById("roomsize").value;
			if(chk>9999.9){
			document.getElementById("errormsg").innerText="Please Enter Room Size Less Than 9999.9";
			document.getElementById("roomsize").value=0;
			}
			if(chk<9999.9){
				document.getElementById("errormsg").innerText="";	
				
			}
			/*if(chk<0){
			document.getElementById("errormsg").innerText="Please Enter Room Size Greater Than 0";
			document.getElementById("roomsize").value=0;
			}*/
			
		} 
	function setgrid(){
		 $("#jqxHotel").jqxGrid('addrow', null, {});
	     var rows = $('#jqxHotel').jqxGrid('getrows');
	     var rowlength= rows.length;
	    
	     
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "rtypeid", document.getElementById("roomdoc").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "roomtype", document.getElementById("jqxloc").value.replace(document.getElementById("txtcat").value,""));
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "category", document.getElementById("txtcat").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "adult", document.getElementById("adult").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "child", document.getElementById("child").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "extrabed", document.getElementById("extrabed").value);  
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "name", document.getElementById("rmname").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "btnattach",'Attach');
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "roomsize", document.getElementById("roomsize").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "maxcount", document.getElementById("maxcount").value);
	     $('#jqxHotel').jqxGrid('setcellvalue',  rowlength-1, "adultonly", document.getElementById("adultonly").value);
	     
	      document.getElementById("roomdoc").value ="";
		  document.getElementById("jqxloc").value="";
		  document.getElementById("txtcat").value=""; 
		  document.getElementById("adult").value ="";
		  document.getElementById("child").value ="";
		  document.getElementById("extrabed").value ="";
		  document.getElementById("rmname").value="";
		  document.getElementById("roomsize").value="";
		  document.getElementById("maxcount").value="";
		  document.getElementById("adultonly").value="";
		 $('#room').load('room.jsp');
		 document.getElementById("jqxloc").focus();
		 
	
	
	}
</script>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCNRkpjhg621w7iyU8uialJS_Ye84J4wJk&libraries=places"></script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmHotelType" action="saveActionHotelType" method="post"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 

<fieldset>
<legend>Hotel Type</legend>
<table width="100%" >
  <tr>
    <td width="15%" align="right">Name</td>
    <td colspan="3"><input type="text" name="name" id="name" style="width: 400px;" placeholder="Name" value='<s:property value="name"/>' style="width:100%;" tabindex="1"></td>
    <td></td>
     
    <td align="center">Min</td>
  
    <td align="left">Max</td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="27%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    
  	<td align="right">Vendor</td>
    <td width="20%" colspan="3"><input type="text" id="vendor" name="vendor" style="width: 400px;" value='<s:property value="vendor"/>' tabindex="2" readonly placeholder="Vendor 

Search" onKeyDown="getvendordetails(event);"/>
    <input type="hidden" id="vendid" name="vendid" value='<s:property value="vendid"/>' /></td>
    <td align="right">Infant</td>
 <td><input type="text" name="txtinfmin" id="txtinfmin" style="width: 50px;" value='<s:property value="txtinfmin"/>' tabindex="7"></td>
 <td><input type="text" name="txtinfmax" id="txtinfmax" style="width: 50px;" value='<s:property value="txtinfmax"/>' tabindex="8"></td>
    
  </tr>
 <tr>
    <td align="right">Latitude</td>
    <td><input type="text" name="latitude" readonly id="latitude" style="width: 200px;" value='<s:property value="latitude"/>' tabindex="3"></td>
    <td align="right">Longitude</td>
    <td><input type="text" name="longitude" readonly id="longitude" style="width: 200px;" value='<s:property value="longitude"/>' tabindex="4"></td>
     <td align="right">Child</td>
 <td><input type="text" name="txtchildmin" id="txtchildmin" style="width: 50px;" value='<s:property value="txtchildmin"/>' tabindex="9"></td>
 <td><input type="text" name="txtchildmax" id="txtchildmax" style="width: 50px;" value='<s:property value="txtchildmax"/>' tabindex="10"></td>
    
  </tr>
   
 
 
  <tr>
<td align="right">Area</td>
    <td><input type="text" id="txtarea" name="txtarea" style="width: 200px;" value='<s:property value="txtarea"/>'  tabindex="5"readonly placeholder="Area Search" 

onKeyDown="getareadetails(event);"/>
    <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>' /></td> 
 <td width="6%" align="right">Rating</td>
    <td width="26%"><select id="txtrating" name="txtrating"  style="width: 200px;" value='<s:property value="txtrating"/>'tabindex="6">
      <option value="">--Select--</option> <option value="1 Star">1 Star</option> <option value="2 Star">2 Star</option>
       <option value="3 Star">3 Star</option> <option value="4 Star">4 Star</option> <option value="5 Star">5 Star</option> <option value="7 Star">7 

Star</option></select>
       <input type="hidden" id="txthidrating" name="txthidrating" value='<s:property value="txthidrating"/>'/></td>
 <td align="right">TeenAge</td>
 <td><input type="text" name="txtteenmin" id="txtteenmin" style="width: 50px;" value='<s:property value="txtteenmin"/>' tabindex="11"></td>
 <td><input type="text" name="txtteenmax" id="txtteenmax" style="width: 50px;" value='<s:property value="txtteenmax"/>' tabindex="12"></td>
 
 </tr>

</table>
</fieldset><br/>

<table style="width:100%;">
	<tr>
		<td width="100%">
			<table style="width: 100%" >
				<tr>
					<td>Room Type</td>
					<td><div   id="room" ><jsp:include page="room.jsp"></jsp:include></div><input type="hidden" id="roomdoc" ></td>
					<td>Category</td>
					<td><input type="text" id="txtcat"  style="width: 300px;" tabindex="14"></td>
					<td>Name</td>
					<td><input type="text" id="rmname" style="width: 300px;" tabindex="15"></td>
					
				</tr>
				<tr>
				    <td colspan="6">
				      Room Size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="roomsize"  style="width: 50px;" onkeypress="return isNumberKey(event)" onchange="funvalid()" tabindex="16">
		              &nbsp;&nbsp;Max Count&nbsp;&nbsp;<input type="text" id="maxcount"  style="width: 50px;" tabindex="17">
					  &nbsp;&nbsp;Adult Only&nbsp;&nbsp;<input type="text" id="adultonly"  style="width: 50px;" tabindex="18">
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Max Adult&nbsp;&nbsp; &nbsp;<input type="text" id="adult"  style="width: 50px;" tabindex="19">
					  &nbsp;&nbsp;Max Child&nbsp;&nbsp;<input type="text" id="child"  style="width: 50px;" tabindex="20">
					  &nbsp;&nbsp;Extra Bed&nbsp;&nbsp;<select id="extrabed" tabindex="21"><option value="">--Select--</option> <option value="0">0</option> <option value="1">1</option><option value="2">2</option> <option value="3">3</option></select>
					  &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="setbtn"  class="btn" onclick="setgrid()" value="ADD" >
				    </td>
				</tr>
				<tr>
					<td colspan="11">
						<div id="hoteldiv"><jsp:include page="hoteltypeGrid.jsp"></jsp:include></div>		
					</td>
				</tr>
			  
			</table>
		</td>
		
	</tr>
	 <tr>
	     <td>
		     <div id="mapdiv"><jsp:include page="map.jsp" /></div>
	     </td>
	</tr> 
	<tr>  <td> &nbsp;	
	     </td>
	</tr> 
<tr>  <td> 	&nbsp;
	     </td>
	</tr> 
<tr>  <td> 	&nbsp;
	     </td>
	</tr> 
<tr>  <td> 	&nbsp;
	     </td>
	</tr> 
</table>
<input type="hidden" name="location" id="location" value='<s:property value="location"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>

</form>

<div id="accountWindow">
	<div ></div>
</div>

<div id="nationalityWindow">
   <div></div>
</div>	

<div id="vendorinfowindow">
	<div></div><div></div>
</div> 
<div id="areainfowindow">
   <div ></div>
   </div>
   <div id="roominfowindow">
   <div ></div>
   </div>
</div>
</div>
</body>
</html>
  
 
  