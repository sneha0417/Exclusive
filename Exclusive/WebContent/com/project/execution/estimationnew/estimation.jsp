<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">

.myButtonses {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
 background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
 background-color:#599bb3;
 -moz-border-radius:4px;
 -webkit-border-radius:4px;
 border-radius:4px;
 display:inline-block;
 cursor:pointer;
 color:#ffffff;
 font-family:Verdana;
 font-size:10px;
 padding:4px 8px;
 text-decoration:none;
}
.myButtonses:hover {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
 background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
 background-color:#408c99;
}
.myButtonses:active {
 position:relative;
 top:1px;
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
<%
String modes =request.getParameter("modes")==null?"0":request.getParameter("modes").toString();
String mod =request.getParameter("mod")==null?"view":request.getParameter("mod").toString();
String mastertrno =request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String isassign =request.getParameter("isassign")==null?"0":request.getParameter("isassign").toString();
String docno= request.getParameter("mastertrno")==null?"0":request.getParameter("mastertrno").toString();
String reviseno=request.getParameter("reviseno")==null?"0":request.getParameter("reviseno").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").toString();
String ref_type=request.getParameter("ref_type")==null?"0":request.getParameter("ref_type").toString();
String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
String reftrno=request.getParameter("reftrno")==null?"0":request.getParameter("reftrno").toString();
String address=request.getParameter("address")==null?"0":request.getParameter("address").toString();
String material=request.getParameter("material")==null?"0":request.getParameter("material").toString();
String labour=request.getParameter("labour")==null?"0":request.getParameter("labour").toString();
String machine=request.getParameter("machine")==null?"0":request.getParameter("machine").toString();
String nettotal=request.getParameter("nettotal")==null?"0":request.getParameter("nettotal").toString();
String surtrno=request.getParameter("surtrno")==null?"0":request.getParameter("surtrno").toString();
%>
<script type="text/javascript">
var mod1='<%=mod%>';
var modes='<%=modes%>';
var mastertrno='<%=mastertrno%>';
      $(document).ready(function () {
    	  
    	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
     	$('#clientsearch1').jqxWindow({ width: '50%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	    $('#clientsearch1').jqxWindow('close');
  		$('#activitysearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
 	    $('#activitysearchwindow').jqxWindow('close'); 
 	    $('#lchargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Labour Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#lchargeinfowindow').jqxWindow('close');
		$('#echargeinfowindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Equipment Charge Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#echargeinfowindow').jqxWindow('close');
		$('#sidesearchwndow').jqxWindow({ width: '70%', height: '80%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Search ' , position: { x: 543, y: 0 }, keyboardCloseKey: 27});
		$('#sidesearchwndow').jqxWindow('close');
		$('#enquirywindow').jqxWindow({ width: '60%', height: '50%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Enquiry Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#enquirywindow').jqxWindow('close');
		
		 $('#servicetypewindow').jqxWindow({ width: '25%', height: '70%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#servicetypewindow').jqxWindow('close'); 
		  
		  $('#sitewindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Site Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#sitewindow').jqxWindow('close');
		  
		  $('#scopesearchwindow').jqxWindow({ width: '25%', height: '60%',  maxHeight: '60%' ,maxWidth: '80%' ,title: ' Scope Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		  $('#scopesearchwindow').jqxWindow('close');
		  
		  $('#templatesearchwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Template Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
	 	  $('#templatesearchwindow').jqxWindow('close'); 
	 	    
		  $('#unitsearchwindow').jqxWindow({
				width : '25%',
				height : '58%',
				maxHeight : '70%',
				maxWidth : '45%',
				title : 'Unit Search',
				position : {
					x : 420,
					y : 87
				},
				theme : 'energyblue',
				showCloseButton : true,
				keyboardCloseKey : 27
			});
			$('#unitsearchwindow').jqxWindow('close');
		 
		 refChange();getPreSalesScopeAllowed();
 	  $('#txtclient').dblclick(function(){
		   
		   	if($('#mode').val()!= "view")
		   		{
		   	 $('#clientsearch1').jqxWindow('open');
			 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
		   		}
		 });
 	  
 	 $('#txtenquiry').dblclick(function(){
 		 
		var clientid=document.getElementById("clientid").value;
		var reftype=$('#cmbreftype').val();
	 	if(clientid>0){
	 		
	 		document.getElementById("errormsg").innerText="";
	 		
	 	}
	 	else{
	 		document.getElementById("errormsg").innerText="Select a client";
	 		
	 		return 0;
	 	} 
 		 
 		if($('#mode').val()!= "view")
   		{
 		 changeContent('enqMastersearch.jsp?reftype='+reftype); 
   		}
 		  });
 	 
 	$('#txtsite').dblclick(function(){
 		 
 		if($('#mode').val()!= "view")
   		{
 			if(document.getElementById("cmbreftype").value!="DIR"){
	 			$('#sitewindow').jqxWindow('open');
				  var reftype=$('#cmbreftype').val();
				  var srvedocno=$('#txtenquiry').val();
				  var surtrno=$('#hidsurtrno').val();
				  var enqtrno=$('#hidenqtrno').val();
		    	  var id=0;
		    	  
		    	  if(surtrno>0){
 		    		 id=4;
			      	 siteSearchContent("sitesearch.jsp?reftrno="+surtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1"); 
		    	  } else {
		    		  id=3;
				      siteSearchContent("sitesearch.jsp?reftrno="+enqtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1");
		    	  }
 			} else {
 				$('#txtsite').attr('readonly', false );
 				$('#txtsite').val('');$('#txtsiteid').val('');
 			}
   		}
 	});
 	
 	$('#txttemplatecode').dblclick(function(){
		 
 		if($('#mode').val()!= "view")
   		{
 			 $('#templatesearchwindow').jqxWindow('open');
 			templateSearchContent('templatesDetailsSearch.jsp?', $('#templatesearchwindow'));    	
   		}
 	});
 	
 		 
      });
      
      function unitSearchContent(url) {
  		$('#unitsearchwindow').jqxWindow('open');
  		$.get(url).done(function(data) {
  			$('#unitsearchwindow').jqxWindow('setContent', data);
  			$('#unitsearchwindow').jqxWindow('bringToFront');
  		});
  	}
      
      function templateSearchContent(url) {
    		$('#templatesearchwindow').jqxWindow('open');
    		$.get(url).done(function(data) {
    			$('#templatesearchwindow').jqxWindow('setContent', data);
    			$('#templatesearchwindow').jqxWindow('bringToFront');
    		});
    	}
      
      function scopeSearchContent(url) {
    		$('#scopesearchwindow').jqxWindow('open');
    		$.get(url).done(function(data) {
    			$('#scopesearchwindow').jqxWindow('setContent', data);
    			$('#scopesearchwindow').jqxWindow('bringToFront');
    		});
    	}
      
      function getScopeGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var scopeGroupItems = items[0].split(",");
  				var scopeGroupIdItems = items[1].split(",");
  				var optionsscopegroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < scopeGroupItems.length; i++) {
  					optionsscopegroup += '<option value="' + scopeGroupIdItems[i] + '">'
  							+ scopeGroupItems[i] + '</option>';
  				}
  				$("select#cmbscopegroup").html(optionsscopegroup);
  				if ($('#hidcmbscopegroup').val() != null) {
  					$('#cmbscopegroup').val($('#hidcmbscopegroup').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getScopeGroup.jsp?contrmode="+$('#txtcontrmode').val(), true);
  		x.send();
  	}
      
      function getScopeAMCDetails(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				
	  				if ($("#mode").val() == "A") {
	  					
	  					 $('#materialGrid').jqxGrid('setcellvalue', 0, "scope" ,items[0]);
   		    		     $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeid" ,items[1]);
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "product" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "productid" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "brand" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "brandname" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "unit" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeamount" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "amount" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "unittotal" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "total" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "nettotal" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "margin" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "proname" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "prodoc" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "unitdocno" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "psrno" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "proid" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "specid" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "brandid" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "stdprice" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "marginper" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "lbrchg" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "scopestdcost" ,"");
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "scopeproduct" ,items[2]);
	   		    		 $('#materialGrid').jqxGrid('setcellvalue', 0, "qty" ,"");
   		    		 
	  				}
	  			    
	  		}
	  		}
	  		x.open("GET", "getScopeAMCDetails.jsp?scopegroup="+$('#cmbscopegroup').val(), true);
	  		x.send();
	 }
      
      function getPreSalesScopeAllowed(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#presalesscopeallowed').val(items);
  			    
  			  if(parseInt(items)==1){
  					$('#tblpresalesscope').show();
  					$('#cmbscopegroup').show();
  					document.getElementById("lblscopegroup").style.display = 'inline-block';
          			$('#materialGrid').jqxGrid('showcolumn', 'scope');
					$('#materialGrid').jqxGrid('showcolumn', 'scopeamount');
					$('#materialGrid').jqxGrid('showcolumn', 'unittotal');
  			    } else {
  			    	$('#tblpresalesscope').hide();
  			    	$('#cmbscopegroup').hide();
  			    	document.getElementById("lblscopegroup").style.display = 'none';
  			    	$('#materialGrid').jqxGrid('hidecolumn', 'scope');
					$('#materialGrid').jqxGrid('hidecolumn', 'scopeamount');
					$('#materialGrid').jqxGrid('hidecolumn', 'unittotal');
  			    }
  		}
  		}
  		x.open("GET", "getPreSalesScopeAllowed.jsp", true);
  		x.send();
  }
      
      function getTemplateDetailsADD(docno,site,siteid){
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    			    
    			    var splt=items.split(",");
    		    	 
    		    	 for(var i=0;i<splt.length;i++)
    		    	 {
    		    		 var data=splt[i].split("::");
    		    	//alert(splt[i]);	 
    		    		 var desc1=data[0].trim()=="undefined" || data[0].trim()=="NaN" || data[0].trim()==""|| data[0].trim()==null?"0":data[0].trim().replace( "20%", " ");
    		    		 var scope=data[1]=="undefined" || data[1]=="NaN" || data[1]==""|| data[1]==null?"0":data[1].trim();
    		    		 var scopeid=data[2]=="undefined" || data[2]=="NaN" || data[2]==""|| data[2]==null?"0":data[2].trim();
    		    		 var product=data[3].trim()=="undefined" || data[3].trim()=="NaN" || data[3].trim()==""|| data[3].trim()==null?"0":data[3].trim().replace( "20%", " ");
    		    		 var productid=data[4]=="undefined" || data[4]=="NaN" || data[4]==""|| data[4]==null?"0":data[4].trim();
    		    		 var activity=data[5]=="undefined" || data[5]=="NaN" || data[5]==""|| data[5]==null?"0":data[5].trim();
    		    		 var activityid=data[6]=="undefined" || data[6]=="NaN" || data[6]==""|| data[6]==null?"0":data[6].trim();
    		    		 var brandname=data[7]=="undefined" || data[7]=="NaN" || data[7]==""|| data[7]==null?"0":data[7].trim();
    		    		 var unit=data[8]=="undefined" || data[8]=="NaN" || data[8]==""|| data[8]==null?"0":data[8].trim();
    		    		 var scopeamount=data[9]=="undefined" || data[9]=="NaN" || data[9]==""|| data[9]==null?"0":data[9].trim();
    		    		 var amount=data[10]=="undefined" || data[10]=="NaN" || data[10]==""|| data[10]==null?"0":data[10].trim();
    		    		 var total=data[11]=="undefined" || data[11]=="NaN" || data[11]==""|| data[11]==null?"0":data[11].trim();
    		    		 var nettotal=data[12]=="undefined" || data[12]=="NaN" || data[12]==""|| data[12]==null?"0":data[12].trim();
    		    		 var margin=data[13].trim()=="undefined" || data[13].trim()=="NaN" || data[13].trim()==""|| data[13]==null?"0":data[13].trim();
    		    		 var invoiced=data[14].trim()=="undefined" || data[14].trim()=="NaN" || data[14].trim()==""|| data[14]==null?"0":data[14].trim();
    		    		 var proname=data[15].trim()=="undefined" || data[15].trim()=="NaN" || data[15].trim()==""|| data[15]==null?"0":data[15].trim().replace( "20%", " ");
    		    		 var prodoc=data[16].trim()=="undefined" || data[16].trim()=="NaN" || data[16].trim()==""|| data[16]==null?"0":data[16].trim();
    		    		 var unitdocno=data[17].trim()=="undefined" || data[17].trim()=="NaN" || data[17].trim()==""|| data[17]==null?"0":data[17].trim();
    		    		 var psrno=data[18].trim()=="undefined" || data[18].trim()=="NaN" || data[18].trim()==""|| data[18]==null?"0":data[18].trim();
    		    		 var proid=data[19].trim()=="undefined" || data[19].trim()=="NaN" || data[19].trim()==""|| data[19]==null?"0":data[19].trim();
    		    		 var specid=data[20].trim()=="undefined" || data[20].trim()=="NaN" || data[20].trim()==""|| data[20]==null?"0":data[20].trim();
    		    		 var stypeid=data[21].trim()=="undefined" || data[21].trim()=="NaN" || data[21].trim()==""|| data[21]==null?"0":data[21].trim();
    		    		 var site=data[22].trim()=="undefined" || data[22].trim()=="NaN" || data[22].trim()==""|| data[22]==null?"0":data[22].trim().replace( "20%", " ");
    		    		 var sertype=data[23].trim()=="undefined" || data[23].trim()=="NaN" || data[23].trim()==""|| data[23]==null?"0":data[23].trim();
    		    		 var brandid=data[24].trim()=="undefined" || data[24].trim()=="NaN" || data[24].trim()==""|| data[24]==null?"0":data[24].trim();
    		    		 var sitesrno=data[25].trim()=="undefined" || data[25].trim()=="NaN" || data[25].trim()==""|| data[25]==null?"0":data[25].trim();
    		    		 var stdprice=data[26].trim()=="undefined" || data[26].trim()=="NaN" || data[26].trim()==""|| data[26]==null?"0":data[26].trim();
    		    		 var marginper=data[27].trim()=="undefined" || data[27].trim()=="NaN" || data[27].trim()==""|| data[27]==null?"0":data[27].trim();
    		    		 var lbrchg=data[28].trim()=="undefined" || data[28].trim()=="NaN" || data[28].trim()==""|| data[28]==null?"0":data[28].trim();
    		    		 var scopestdcost=data[29].trim()=="undefined" || data[29].trim()=="NaN" || data[29].trim()==""|| data[29]==null?"0":data[29].trim();
    		    		 var qty=data[30].trim()=="undefined" || data[30].trim()=="NaN" || data[30].trim()==""|| data[30]==null?"0":data[30].trim();
    		          	 
    		    		 var rows = $("#materialGrid").jqxGrid('getrows');
    		    		 
    		    		 var rowindex=((rows.length)-1);
    		    		 
    		    		 $('#materialGrid').jqxGrid('setcellvalue',rowindex , "desc1" ,desc1);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scope" ,scope);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopeid" ,scopeid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "product" ,product);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "productid" ,productid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brand" ,brandname);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brandname" ,brandname);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "unit" ,unit);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopeamount" ,scopeamount);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "amount" ,amount);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "total" ,total);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "nettotal" ,nettotal);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "margin" ,margin);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "proname" ,proname);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "prodoc" ,prodoc);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "unitdocno" ,unitdocno);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "psrno" ,psrno);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "proid" ,proid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "specid" ,specid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "site" ,site);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "brandid" ,brandid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "sitesrno" ,sitesrno);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "stdprice" ,stdprice);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "marginper" ,marginper);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "lbrchg" ,lbrchg);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "scopestdcost" ,scopestdcost);
    		    		 //$('#materialGrid').jqxGrid('setcellvalue', rowindex, "activity" ,activity);
    		    		 //$('#materialGrid').jqxGrid('setcellvalue', rowindex, "activityid" ,activityid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "stypeid" ,stypeid);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "sertype" ,sertype);
    		    		 $('#materialGrid').jqxGrid('setcellvalue', rowindex, "qty" ,qty);
    		    	 }
    		    	 
    			    $("#overlay, #PleaseWait").hide();
    			  
    		}
    		}
    		x.open("GET", "getTemplateDetails.jsp?docno="+docno+"&sitename="+site+"&siteid="+siteid, true);
    		x.send();
    }
      
      function getclinfo(event){
    		 var x= event.keyCode;
    		 if(x==114){
    		  $('#clientsearch1').jqxWindow('open');
    		 clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));    }
    		 else{
    			 }
    		 } 
      
      function getTemplate(event){
 		 var x= event.keyCode;
 		 if(x==114){
 			$('#templatesearchwindow').jqxWindow('open');
 			templateSearchContent('templatesDetailsSearch.jsp?', $('#templatesearchwindow'));
 		 }
 		 else{
 			 }
 		 }
    	      function clientSearchContent(url) {
    	            
    	                $.get(url).done(function (data) {
    	   
    		           $('#clientsearch1').jqxWindow('setContent', data);

    	     	}); 
    	          	}
	function funReadOnly(){
		
		$('#frmEstimation input').attr('readonly', true );
		$('#frmEstimation select').attr('disabled', true);
		$('#date').jqxDateTimeInput({disabled: true});
		$('#btnSummary').attr('disabled', true );
		$('#btntemplateadd').attr('disabled', true );
		$("#materialGrid").jqxGrid({ disabled: true});
		
		if(modes=="view")
		{
		
		document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
		document.getElementById("formdetail").value=window.parent.formName.value;
		document.getElementById("formdetailcode").value=window.parent.formCode.value.trim();
		  $('#doc_no').attr('disabled', false);
	 		 $('#masterdoc_no').attr('disabled', false);
	 		 $('#mode').attr('disabled', false);
	 		 $('#cmbreftype').attr('disabled', false);
	    	 $('#date').jqxDateTimeInput({ disabled: false}); 
		
		document.getElementById("masterdoc_no").value=mastertrno;
		document.getElementById("mode").value=modes;
		var loadid=2;
		var docno=mastertrno;

		  document.getElementById("docno").value= '<%=docno%>';
	         document.getElementById("txtreviseno").value='<%=reviseno%>';
	         $('#date').jqxDateTimeInput('val','<%=date%>');
	         $('#hiddate').jqxDateTimeInput('val','<%=date%>');
	         document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("clientid").value='<%=cldocno%>';
	         document.getElementById("cmbreftype").value='<%=ref_type%>';
	         document.getElementById("hidcmbreftype").value='<%=ref_type%>';
	         document.getElementById("txtenquiry").value='<%=refdocno%>';
	         document.getElementById("enquiryid").value='<%=reftrno%>';
	         document.getElementById("txtmatotal").value='<%=material%>';
	        
	         document.getElementById("txtnettotal").value='<%=nettotal%>';
	         document.getElementById("txtnettotalshow").value='<%=nettotal%>';
	         document.getElementById("txtclientdet").value='<%=address%>';
	         $('#cmbscopegroup').attr('disabled', false);
	         var cmbreftype=$('#cmbreftype').val();
	         if(cmbreftype!='DIR'){
	        	 $('#cmbreftype').attr('disabled', false);
	         }
	         refChange();
		 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
		
		
		   $('#docno').attr('disabled', false);
			 $('#mode').attr('disabled', false);
		   
		}
		 if(document.getElementById("status").value.trim()=="0" )
			{
			mod1="view";
			}
			
		 if(mod1=="A")
			{
			
		    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
			document.getElementById("formdetail").value=window.parent.formName.value;
			document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
			funCreateBtn();
			
			}
	} 
	
	function funRemoveReadOnly(){
		getPreSalesScopeAllowed();
		getScopeGroup();
		
		$('#frmEstimation input').attr('readonly', false );
		$('#frmEstimation select').attr('disabled', false);
		$('#date').jqxDateTimeInput({disabled: false});
		$('#btnSummary').attr('disabled', false );
		$('#btntemplateadd').attr('disabled', false );
		$('#docno').attr('readonly', true);
		$('#txtactivityname').attr('readonly', true );
		$('#txtclient').attr('readonly', true );
		$('#txtclientdet').attr('readonly', true );
		$('#txtreftype').attr('readonly', true );
		$('#txttemplatecode').attr('readonly', true );
		$('#txttemplatename').attr('readonly', true );
		$('#txtnettotalshow').attr('readonly', true );
		$("#materialGrid").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "E") {
			    //refChange();
			    $('#txtenquiry').attr('disabled', false );
			    $('#enquiryid').attr('disabled', false );
			    $('#clientid').attr('disabled', false );
			    $('#cmbreftype').attr('disabled', false );
			    $('#cmbscopegroup').attr('disabled', false);
				$('#frmEstimation input').attr('readonly', true );
			    $("#materialGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
			    
				$('#gridtext').attr('readonly', false );
				$('#gridtext1').attr('readonly', false );
				
			    
			    
			    
		  }
		
		if ($("#mode").val() == "A") {
			$("#activitiesid").val("0");
			$("#txtreviseno").val("0");
			$('#date').val(new Date());
			$("#materialGrid").jqxGrid('clear');
			$("#materialGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
			
		}
		if(mod1=="A")
		{
			
			 document.getElementById("txtclient").value='<%=client%>';
	         document.getElementById("clientid").value='<%=cldocno%>';
	         document.getElementById("txtclientdet").value='<%=address%>';
	         document.getElementById("cmbreftype").value='<%=ref_type%>';
	         document.getElementById("hidcmbreftype").value='<%=ref_type%>';
	         document.getElementById("txtenquiry").value='<%=refdocno%>';
	         document.getElementById("enquiryid").value='<%=reftrno%>';
	         document.getElementById("hidenqtrno").value='<%=reftrno%>';
	         document.getElementById("hidsurtrno").value='<%=surtrno%>';
	         var cmbreftype=$('#cmbreftype').val();
	         
	         if(cmbreftype!='DIR'){
	        	 $('#cmbreftype').attr('disabled', false);
	         }
	         $('#cmbscopegroup').attr('disabled', false);
	         refChange();
	         if(cmbreftype=='ENQ'){
	        	 $("#materialDiv").load("materialDetailsGrid.jsp?enqtrno="+'<%=reftrno%>'+"&loadid=3");
	         }
	       
		}
		
		chkproductconfig();
	
	}
	
	/* function getlcharge(rowBoundIndex){
		 
		  $('#lchargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        lchargeSearchContent('chargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function lchargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#lchargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	}
	  	
	
	function getecharge(rowBoundIndex){
		 
		  $('#echargeinfowindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        echargeSearchContent('equipchargeSearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	
	function echargeSearchContent(url) {
		//alert(url);
			 $.get(url).done(function (data) {
				 //alert(data);
		$('#echargeinfowindow').jqxWindow('setContent', data);

		            }); 
		  	} */
	  	
function funExcelBtn(){
				    if(parseInt(window.parent.chkexportdata.value)=="1") {
				      JSONToCSVCon(materialexcel,$("#docno").val()+'/'+$("#txtclient").val(), true);
				    } else {
				    }
				   }
			  


	 function productSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#sidesearchwndow').jqxWindow('open');
      		$('#sidesearchwndow').jqxWindow('setContent', data);
      
      	}); 
      } 
	
	 function funSearchLoad(){
		 changeContent('Mastersearch.jsp'); 
	}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	
	 
	function getservicetype(rowBoundIndex){
		 
		  $('#servicetypewindow').jqxWindow('open');

	 // $('#accountWindow').jqxWindow('focus');
	        serviceSearchContent('servicesearch.jsp?rowBoundIndex='+rowBoundIndex);
	     	 }
	     	 
	function serviceSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#servicetypewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	
	
	function getsite(rowBoundIndex,reftrno,id){
		 
		  $('#sitewindow').jqxWindow('open');
		  var reftype=$('#cmbreftype').val();
		  var srvedocno=document.getElementById("txtenquiry").value;
	 // $('#accountWindow').jqxWindow('focus');
	        siteSearchContent("sitesearch.jsp?rowBoundIndex="+rowBoundIndex+"&reftrno="+reftrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=2");
	     	 }
	   
	function getsites(event){
		 var x= event.keyCode;
		 if(x==114){
			 
		 		if($('#mode').val()!= "view")
		   		{
		 			if(document.getElementById("cmbreftype").value!="DIR"){
			 			$('#sitewindow').jqxWindow('open');
						  var reftype=$('#cmbreftype').val();
						  var srvedocno=$('#txtenquiry').val();
						  var surtrno=$('#hidsurtrno').val();
						  var enqtrno=$('#hidenqtrno').val();
				    	  var id=0;
				    	  
				    	  if(surtrno>0){
		 		    		 id=4;
					      	 siteSearchContent("sitesearch.jsp?reftrno="+surtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1"); 
				    	  } else {
				    		  id=3;
						      siteSearchContent("sitesearch.jsp?reftrno="+enqtrno+"&id="+id+"&reftype="+reftype+"&srvedocno="+srvedocno+"&gridtextbox=1");
				    	  }
		 			} else {
		 				$('#txtsite').attr('readonly', false );
		 				$('#txtsite').val('');$('#txtsiteid').val('');
		 			}
		   		}   
		 }
		 else{ }
		 }
	
	function siteSearchContent(url) {
	//alert(url);
		 $.get(url).done(function (data) {
			 //alert(data);
	$('#sitewindow').jqxWindow('setContent', data);

	            	}); 
	  	}
	
	
	
	
	 function funNotify(){
     	
     	
     	if($('#clientid').val()=="")
     	{
     	document.getElementById("errormsg").innerText="select a Client";
     	return 0;
     	}
     
     	 var rows1 = $("#materialGrid").jqxGrid('getrows');
    
     	document.getElementById("errormsg").innerText="";
     	//alert(rows1.length);
     	 $('#matgridlen').val(rows1.length);

	 	var griddesc="";
     	 var errorstatus=0;
     	if(rows1.length=="0"){
    		$.messager.alert('Message','Enter Proper Details','warning');
    		   	errorstatus=1;
    			return 0;
    		 }
    		 else{
     	 
     	 for(var i=0;i<rows1.length-1;i++){
     		/*  alert(rows1[i].desc1);
     		alert(rows1[i].stypeid); */
     		/*  alert(rows1[i].prodoc);   
     		alert(rows1[i].stdprice); */
     		 if(rows1[i].prodoc>0)
     			 {
     			
     			 if(parseFloat(rows1[i].amount)>0 && parseFloat(rows1[i].stdprice)>=parseFloat(rows1[i].amount)){
     				document.getElementById("errormsg").innerText="Amount Should Be Greater than Standard Price ("+rows1[i].stdprice+")";
     				return 0;
     				errorstatus=1;
     			 }
     			 }
     		 else{
     			document.getElementById("errormsg").innerText="";
     			 errorstatus=0;
     		 }
     		 if((rows1[i].desc1=="undefined" || typeof(rows1[i].desc1)=="undefined" || rows1[i].desc1==null || rows1[i].desc1=="") &&
     				(rows1[i].stypeid=="undefined" || typeof(rows1[i].stypeid)=="undefined" || rows1[i].stypeid==null || rows1[i].stypeid=="" )&&
     				(rows1[i].prodoc=="undefined" || typeof(rows1[i].prodoc)=="undefined" || rows1[i].prodoc==null || rows1[i].prodoc=="" )
     				 ){
     			$.messager.alert('Message','Enter Proper Details','warning');
  			   	errorstatus=1;
     			return 0;
     		 }
     		 else{
     			 errorstatus=0;
     		 }
     	 }
    		 }
     	 
     	 if(errorstatus==1){
     		 return 0;
     	 }

  
     	 var reftype=$("#cmbreftype").val();
     	   var srno=0; 
     	 for(var i=0 ; i < rows1.length ; i++){
     		     newTextBox = $(document.createElement("input"))
     		       .attr("type", "dil")
     		       .attr("id", "mate"+i)
     		       .attr("name", "mate"+i)
     		       .attr("hidden", "true"); 
     		     if(reftype=="DIR"){
     		 srno=srno+1;
     		     }
     		     else{
     		    	 srno=rows1[i].sitesrno;
     		     }
     		   newTextBox.val(rows1[i].desc1+" :: "+rows1[i].prodoc+" :: "+rows1[i].psrno+" :: "+rows1[i].unitdocno+" :: "+rows1[i].qty+" :: "+rows1[i].amount+" :: "+rows1[i].total+" :: "+rows1[i].margin+" :: "+rows1[i].nettotal+" :: "+rows1[i].activityid+" :: "+rows1[i].site+" :: "+rows1[i].stypeid+" :: "+srno+" :: "+rows1[i].marginper+" :: "+rows1[i].scopeid+" :: "+rows1[i].scopeamount+" :: "+rows1[i].stdprice+" :: "+rows1[i].lbrchg+" :: "+rows1[i].scopestdcost+" :: " );
     		   newTextBox.appendTo('form');
     		  
     				}	 
         			
			$('#cmbscopegroup').attr('disabled', false);
     		return 1;
     } 


	 
	 function funFocus(){
		    document.getElementById("txtclient").focus();
		
	    }

			
			  function funPrintBtn(){
			 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
			 	  
			 	   var url=document.URL;

			        var reurl=url.split("saveEstimationnew");
			        
			        $("#docno").prop("disabled", false);                
			        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				     var dtype=$('#formdetailcode').val();
				  
							 var win= window.open(reurl[0]+"printestimation?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
			  
						/* var win= window.open(reurl[0]+"printpurchaseorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
						   */   
						win.focus();
			 	  } 
			 	  
			 	   else {
				    	      $.messager.alert('Message','Select a Document....!','warning');
				    	      return false;
				    	     } 
				    	
			 	}

			  
	 
	 function setValues(){
		 
		 $('#cmbscopegroup').attr('disabled', false);
		 getScopeGroup();
		 if($('#mode').val()== "view") {
		 	$('#cmbscopegroup').attr('disabled', true);
	   	 }
		  var docno=$("#masterdoc_no").val();
		
		  var loadid=2;
		  if($('#hiddate').val()){
				 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
			  }
		  if($('#hidcmbreftype').val()!=""){
				 $("#cmbreftype").val($('#hidcmbreftype').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  if(document.getElementById("hidestedit").value=="1"){
			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
		  }
		  if(docno>0){
			     
				 $("#materialDiv").load("materialDetailsGrid.jsp?trno="+docno+"&loadid="+loadid);
				 
			}
	 }
	 	  
	 	 function getEnquiry(event){
	 		 
	 		var clientid=document.getElementById("clientid").value;
		 	
		 	if(clientid>0){
		 		
		 		document.getElementById("errormsg").innerText="";
		 		
		 	}
		 	else{
		 		document.getElementById("errormsg").innerText="Select a client";
		 		
		 		return 0;
		 	} 

				var x= event.keyCode;
			 	 if(x==114){
				   
			 		 changeContent('enqMastersearch.jsp?reftype='+reftype);  
				
			    	 }
			 	 else{
			 		 }
			 	 }
			    	 
			function enquirySearchContent(url) {
				 $.get(url).done(function (data) {
				$('#enquirywindow').jqxWindow('setContent', data);
			           	}); 
			 	}
	 
			function refChange(){
				 var reftype=$('#cmbreftype').val();

				 if(reftype=='DIR'){
					  $('#txtenquiry').attr('disabled', true);
					  $('#txtsite').attr('readonly', false);
					  $('#txtsite').val('');$('#txtsiteid').val('');
				 }
				 else{
					  
					  $('#txtenquiry').attr('disabled', false);
					  $('#txtenquiry').attr('readonly', true);
					  $('#txtsite').attr('readonly', true);
					  $('#txtsite').val('');$('#txtsiteid').val('');
					  if (document.getElementById("txtsiteid").value == "") {
					        $('#txtsite').attr('placeholder', 'Press F3 to Search'); 
					  }
				 }
				 
				}
			
			function funTemplateLoadAdd(){
				var siteid=$('#txtsiteid').val();
				var templateid=$('#txttemplateid').val();
				var site=$('#txtsite').val();
				
				 if(site==''){
					  document.getElementById("errormsg").innerText="Site is Mandatory.";
				 	  return 0;
				 }
				 
				 if(templateid==''){
					  document.getElementById("errormsg").innerText="Template is Mandatory.";
				 	  return 0;
				 }
				 document.getElementById("errormsg").innerText="";
				 
				 $("#overlay, #PleaseWait").show();
		         getTemplateDetailsADD(templateid,site,siteid);
		         
			}
	        

</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEstimation" action="saveEstimationnew" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>

<table width="100%">

  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/></td>
    <td width="15%" align="left">&nbsp;</td>
    <td width="10%" align="right">Revise No.</td>
    <td width="28%"><input type="text" id="txtreviseno" name="txtreviseno" style="width:50%;" value='<s:property value="txtreviseno"/>'/></td>
    <td width="8%" align="right">Doc No.</td>
    <td width="25%"><input type="text" id="docno" name="docno" style="width:70%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>

<fieldset>
<table width="100%">
  <tr>
    <td width="6%" align="right">Customer</td>
    <td width="14%"><input type="text" id="txtclient" name="txtclient" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>'  onKeyDown="getclinfo(event);"/></td>
    <td width="25%"><input type="text" id="txtclientdet" name="txtclientdet" style="width:95%;" value='<s:property value="txtclientdet"/>' tabindex="-1"/></td>
    <td width="6%" align="right">Ref. Type</td>
    <td width="12%"><select id="cmbreftype" name="cmbreftype" style="width:97%;" onchange="refChange();" value='<s:property value="cmbreftype"/>'>
      <option value="DIR">DIR</option>
      <option value="ENQ">ENQ</option>
      <option value="SRVE">SRVE</option>
      </select>
      <input type="hidden" id="hidcmbreftype" name="hidcmbreftype" value='<s:property value="hidcmbreftype"/>'/></td>
    <td width="21%"><input type="text" id="txtenquiry" name="txtenquiry" style="width:98%;"  placeholder="Press F3 to Search" value='<s:property value="txtenquiry"/>'  onKeyDown="getEnquiry(event);"/>
    <input type="hidden" id="txtcontrmode" name="txtcontrmode" value='<s:property value="txtcontrmode"/>'/></td>
    <td width="7%" align="right"><label id="lblscopegroup">Scope Group</label></td>
    <td width="9%" align="right"><select id="cmbscopegroup" name="cmbscopegroup" style="width:97%;" onchange="getScopeAMCDetails();" value='<s:property value="cmbscopegroup"/>'>
    <option value="">--Select--</option>
    </select>
    <input type="hidden" id="hidcmbscopegroup" name="hidcmbscopegroup" value='<s:property value="hidcmbscopegroup"/>'/></td>
  </tr>
  </table>
<table id="tblpresalesscope" width="100%">
   <tr>
    <td width="7%" align="right">Site</td>
    <td width="26%"><input type="text" id="txtsite" name="txtsite" style="width:97%;" value='<s:property value="txtsite"/>'  onKeyDown="getsites(event);"/>
    <input type="hidden" id="txtsiteid" name="txtsiteid" value='<s:property value="txtsiteid"/>'/></td>
    <td width="10%" align="right">Template</td>
    <td width="16%"><input type="text" id="txttemplatecode" name="txttemplatecode" style="width:97%;" placeholder="Press F3 to Search" value='<s:property value="txttemplatecode"/>'  onKeyDown="getTemplate(event);"/>
    <input type="hidden" id="txttemplateid" name="txttemplateid" value='<s:property value="txttemplateid"/>'/></td>
    <td colspan="2"><input type="text" id="txttemplatename" name="txttemplatename" style="width:97%;" tabindex="-1" value='<s:property value="txttemplatename"/>'/></td>
    <td width="9%" align="center"><button class="myButton" type="button" id="btntemplateadd" name="btntemplateadd" onclick="funTemplateLoadAdd();">ADD</button></td>
  </tr>
</table></fieldset>

<fieldset><legend>Material Details</legend>
<p style="float: right;display:inline;font-weight:bold;color:#000000;position: absolute;z-index: 800;right:200px;margin-top:-9px;">Total&nbsp;&nbsp;</p>
<input type="hidden" id="txtnettotal" name="txtnettotal" style="width:94%;float: right;text-align: right;" value='<s:property value="txtnettotal"/>'/>
<input type="text" id="txtnettotalshow" name="txtnettotalshow" style="width:10%;float: right;text-align: right;font-weight:bold;color:#000000;background-color:#F2F4F4;position: absolute;z-index: 800;right:60px;margin-top:-12px;" readonly tabindex="-1" value='<s:property value="txtnettotal"/>'/>

<input type="text" name="gridtext" id="gridtext" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext"/>'  />   
<input type="text" name="gridtext1" id="gridtext1" style="width:0%;height:0%;"  class="textbox"  value='<s:property value="gridtext1"/>' /> 
<div id="materialDiv"><jsp:include page="materialDetailsGrid.jsp"></jsp:include></div>
</fieldset>

<input type="hidden" id="clientid" name="clientid"  value='<s:property value="clientid"/>'/>
<input type="hidden" id="enquiryid" name="enquiryid"  value='<s:property value="enquiryid"/>'/>
<input type="hidden" id="activitiesid" name="activitiesid"  value='<s:property value="activitiesid"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="presalesscopeallowed" name="presalesscopeallowed"  value='<s:property value="presalesscopeallowed"/>'/>
<input type="hidden" id="txtmatotal" name="txtmatotal"  value='<s:property value="txtmatotal"/>'/>
<input type="hidden" id="txtlabtotal" name="txtlabtotal"  value='<s:property value="txtlabtotal"/>'/>
<input type="hidden" id="txteqptotal" name="txteqptotal"  value='<s:property value="txteqptotal"/>'/>
<input type="hidden" id="matgridlen" name="matgridlen"  value='<s:property value="matgridlen"/>'/>
<input type="hidden" id="labgridlen" name="labgridlen"  value='<s:property value="labgridlen"/>'/>
<input type="hidden" id="eqgridlen" name="eqgridlen"  value='<s:property value="eqgridlen"/>'/>
<input type="hidden" id="actgridlen" name="actgridlen"  value='<s:property value="actgridlen"/>'/>
<input type="hidden" id="hidestedit" name="hidestedit"  value='<s:property value="hidestedit"/>'/>
<input type="hidden" id="hidsurtrno" name="hidsurtrno" value='<s:property value="hidsurtrno"/>' />
<input type="hidden" id="hidenqtrno" name="hidenqtrno" value='<s:property value="hidenqtrno"/>' />
<input type="hidden" id="productchk" name="productchk"  value='<s:property value="productchk"/>' />
<input type="hidden" id="txtgridservicetypeid" name="txtgridservicetypeid"  value='<s:property value="txtgridservicetypeid"/>' />  
<input type="hidden" id="txtgridscopeid" name="txtgridscopeid"  value='<s:property value="txtgridscopeid"/>' />    
<input type="hidden" name="txtgridscopeproduct" id="txtgridscopeproduct" style="width:80%" value='<s:property value="txtgridscopeproduct"/>'>

</div>
</form>

<div id="customerDetailsWindow">
   <div></div>
</div>
<div id="activitysearchwindow">
	<div></div>
</div>
<div id="clientsearch1">
   <div ></div>
</div>
<div id="sidesearchwndow">
   <div ></div> 
</div>
<div id="lchargeinfowindow">
   <div ></div>
</div>
<div id="echargeinfowindow">
   <div ></div>
</div>
<div id="enquirywindow">
   <div ></div>
</div>

<div id="servicetypewindow">
   <div ></div>
</div>
<div id="sitewindow">
   <div ></div>
</div>
<div id="unitsearchwindow">
   <div ></div>
   </div>
<div id="templatesearchwindow">
	<div ></div>
</div>
<div id="scopesearchwindow">
	<div ></div>
</div>
</div>
</body>
</html>
