 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		//getpmconfig();
		getmastertype();
		getSpecConfig();
		getConfig();
 
		$("#date").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});

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
		
		$('#deptsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Department Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#deptsearchwindow').jqxWindow('close');
		
		$('#typesearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Type Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#typesearchwindow').jqxWindow('close');
		
		$('#submodelsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Model Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#submodelsearchwindow').jqxWindow('close');
		
		
		$('#catsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#catsearchwindow').jqxWindow('close');
		
		$('#subcatsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Sub Category Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#subcatsearchwindow').jqxWindow('close');
		
		$('#brandsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '70%',
			title : 'Brand Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#brandsearchwindow').jqxWindow('close');
		$('#suitsearchwindow').jqxWindow({
			width : '80%',
			height : '70%',
			maxHeight : '90%',
			maxWidth : '90%',
			title : 'Brand Search',
			position : {
				x : 100,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#suitsearchwindow').jqxWindow('close');
		
		$('#modelsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Model Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#modelsearchwindow').jqxWindow('close');
		
		
		$('#yomsearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Yom Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#yomsearchwindow').jqxWindow('close');
		
		
		$('#spec1searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec1searchwindow').jqxWindow('close');
		
		
		$('#spec2searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec2searchwindow').jqxWindow('close');
		
		
		$('#spec3searchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : 'Spec Search',
			position : {
				x : 420,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#spec3searchwindow').jqxWindow('close');
		
		
		$('#txtproducttype').dblclick(function(){
			
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
			
		}); 
		
		$('#txtbrand').dblclick(function(){
			 
			 brandFormSearchContent('brandFormSearchGrid.jsp'); 
		}); 
		
		$('#txtcategory').dblclick(function(){
			
			catFormSearchContent('catFormSearchGrid.jsp'); 
		}); 
		
		
		$('#txtsubcategory').dblclick(function(){
			 
			var catid=document.getElementById("cmbcategory").value;
	   		subCatFormSearchContent('subCatFormSearchGrid.jsp?catid='+catid);
		}); 
		
		
		$('#txtunit').dblclick(function(){
			 
			unitFormSearchContent('unitFormSearchGrid.jsp');  
		}); 
		
		
		$('#textdept').dblclick(function(){
			deptFormSearchContent('deptFormSearchGrid.jsp'); 
		}); 

	});

	function unitSearchContent(url) {
		$('#unitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#unitsearchwindow').jqxWindow('setContent', data);
			$('#unitsearchwindow').jqxWindow('bringToFront');
		});
	}

	
	function getProdType(event){
    	 var x= event.keyCode;
    	 if(x==114){
    		 typeFormSearchContent('typeFormSearchGrid.jsp');  	 }
     	 else{
    		 }
           	 }
	
	function typeSearchContent(url) {
		$('#typesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#typesearchwindow').jqxWindow('setContent', data);
			$('#typesearchwindow').jqxWindow('bringToFront');
		});
	}
	function submodelSearchContent(url) {
		$('#submodelsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#submodelsearchwindow').jqxWindow('setContent', data);
			$('#submodelsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function typeFormSearchContent(url) {
		$('#typesearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#typesearchwindow').jqxWindow('setContent', data);
			$('#typesearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdBrand(event){
   	 var x= event.keyCode;
   	 if(x==114){
   		 brandFormSearchContent('brandFormSearchGrid.jsp');  	 }
    	 else{
   		 }
          	 }

	function brandSearchContent(url) {
		$('#brandsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#brandsearchwindow').jqxWindow('setContent', data);
			$('#brandsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function suitSearchContent(url) {
		$('#suitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#suitsearchwindow').jqxWindow('setContent', data);
			$('#suitsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function brandFormSearchContent(url) {
		$('#brandsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#brandsearchwindow').jqxWindow('setContent', data);
			$('#brandsearchwindow').jqxWindow('bringToFront');
		});
	}

	function modelSearchContent(url) {
		$('#modelsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#modelsearchwindow').jqxWindow('setContent', data);
			$('#modelsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function yomSearchContent(url) {
		$('#yomsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#yomsearchwindow').jqxWindow('setContent', data);
			$('#yomsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function spec1SearchContent(url) {
		$('#spec1searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec1searchwindow').jqxWindow('setContent', data);
			$('#spec1searchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function spec2SearchContent(url) {
		$('#spec2searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec2searchwindow').jqxWindow('setContent', data);
			$('#spec2searchwindow').jqxWindow('bringToFront');
		});
	}
	
	function spec3SearchContent(url) {
		$('#spec3searchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#spec3searchwindow').jqxWindow('setContent', data);
			$('#spec3searchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function getProdCat(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		 catFormSearchContent('catFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function catFormSearchContent(url) {
		$('#catsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#catsearchwindow').jqxWindow('setContent', data);
			$('#catsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdSubCat(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		 var catid=document.getElementById("cmbcategory").value;
	   		subCatFormSearchContent('subCatFormSearchGrid.jsp?catid='+catid);  	 }
	    	 else{
	   		 }
	          	 }

	function subCatFormSearchContent(url) {
		$('#subcatsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#subcatsearchwindow').jqxWindow('setContent', data);
			$('#subcatsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	function getProdUnit(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		unitFormSearchContent('unitFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function unitFormSearchContent(url) {
		$('#unitsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#unitsearchwindow').jqxWindow('setContent', data);
			$('#unitsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	
	function getProdDept(event){
	   	 var x= event.keyCode;
	   	 if(x==114){
	   		deptFormSearchContent('deptFormSearchGrid.jsp');  	 }
	    	 else{
	   		 }
	          	 }

	function deptFormSearchContent(url) {
		$('#deptsearchwindow').jqxWindow('open');
		$.get(url).done(function(data) {
			$('#deptsearchwindow').jqxWindow('setContent', data);
			$('#deptsearchwindow').jqxWindow('bringToFront');
		});
	}
	
	/* Validations */
	$(function() {
		$('#frmProduct').validate({
			rules : {
				txtproductcode : "required",
				txtproductname : "required",
			/* 	txtbarcode : "required", */
				cmbproducttype : "required",
				cmbbrand : "required",
				cmbcategory : "required",
				cmbsubcategory : "required",
				cmbunit : "required",
				cmbdept : "required"
			},
			messages : {
				txtproductcode : " *",
				txtproductname : " *",
			/* 	txtbarcode : " *", */
				cmbproducttype : " *",
				cmbbrand : " *",
				cmbcategory : " *",
				cmbsubcategory : " *",
				cmbunit : " *",
				cmbdept : " *"
			}
		});
	});

	function funReadOnly() {
		$('#frmProduct input').attr('readonly', true);
		$('#frmProduct input').attr('disabled', true);
		
		$('#hidpricemgt').attr('disabled', false);
		
		$('#cmbstar').attr('disabled', true);
		
		$('#cmbmastertype').attr('disabled', true);
		
		
		
		
		if(document.getElementById("docno").value=="")
			{
			document.getElementById("company").checked = true;
			
			}
		
		
 
			
		$('#date').jqxDateTimeInput({
			disabled : true
		});
		$("#jqxProductGrid").jqxGrid({
			disabled : true
		});
		$("#jqxUomGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSpecGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSuitGrid").jqxGrid({
			disabled : true
		});
		$("#jqxSuitGrid").jqxGrid({
			disabled : true
		});
		
		$("#jqxpmgt").jqxGrid({
			disabled : true
		});
		
		$("#jqxseding").jqxGrid({
			disabled : true
		});
		
		
		 
	}
/* function funprddel(){
	$('#docno').attr('disabled', false);
	var docno=document.getElementById("docno").value;

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();
		 
			if(parseInt(items)>0)
				{
				$('#frmProduct input').attr('disabled', true);
				$('#frmProduct select').attr('disabled', true);
				 
				exit(0);
			//	alert("34567890-");
				return 0;
				 
				}
			else
				{
				$('#frmProduct input').attr('disabled', false);
				$('#frmProduct select').attr('disabled', false);
				$('#mode').val('D');
				$('#frmProduct').submit();
				
				}
				
				
				
				}
 			 
			} 
		 
		x.open("GET", "deleteproduct.jsp?psrno="+docno, true);
		x.send();
 
} */
	function funRemoveReadOnly() {
	 
	 
 
		$('#hidpricemgt').attr('disabled', false);
		$('#txtproductcode').attr('readonly', false);
		$('#txtproductname').attr('readonly', false);
		
		$('#txtarbicprdname').attr('readonly', false);
		
		$('#desc1').attr('readonly', false);
		
		
		
		$('#txtbarcode').attr('readonly', false);
		$('#frmProduct input').attr('disabled', false);
		$('#cmbmastertype').attr('disabled', false);
		$('#cmbstar').attr('disabled', false);

		$('#date').jqxDateTimeInput({
			disabled : false
		});
		$("#jqxProductGrid").jqxGrid({
			disabled : false
		});
		$("#jqxUomGrid").jqxGrid({
			disabled : false
		});
		$("#jqxpmgt").jqxGrid({
			disabled : false
		});
		
		$("#jqxseding").jqxGrid({
			disabled : false
		});
		
		$('#docno').attr('readonly', true);

		if ($("#mode").val() == "A") {
			$("#jqxUomGrid").jqxGrid('clear');
			$("#jqxUomGrid").jqxGrid('addrow', null, {});
			$("#jqxProductGrid").jqxGrid('clear');
			$("#jqxProductGrid").jqxGrid('addrow', null, {});
			
			
			
			$("#jqxseding").jqxGrid('clear');
			$("#jqxseding").jqxGrid('addrow', null, {});
			
			
		 
			// pmDiv pricemanagementgrid.jsp
			
			$("#jqxSpecGrid").jqxGrid({
				disabled : false
			});
			$("#jqxSpecGrid").jqxGrid('clear');
			$("#jqxSpecGrid").jqxGrid('addrow', null, {});           	
			$("#jqxSuitGrid").jqxGrid({
				disabled : false
			});
			$("#jqxSuitGrid").jqxGrid('clear');
			$("#jqxSuitGrid").jqxGrid('addrow', null, {});
			$("#pmDiv").load("pricemanagementgrid.jsp?");
			getpmconfig();
			   
			$("#productDiv").load("productGrid.jsp?chktype="+1);
			
			$("#jqxProductGrid").jqxGrid({
				disabled : false
			});
			
			document.getElementById("company").checked = true;
			document.getElementById("comorbranch").value="1";
		}

		if ($("#mode").val() == "E") {
			 
			var docno=document.getElementById("docno").value;
			if(docno>0){
				if(document.getElementById("comorbranch").value=="1")
				{
					$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+1);
				}
			else if(document.getElementById("comorbranch").value=="2")
				{
				$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+2);
				}	
			}
			$("#jqxSuitGrid").jqxGrid({
	  			disabled : false
	  		});
			$("#jqxUomGrid").jqxGrid('addrow', null, {});
			
			if($('#mode').val()=='E')
	        {
	       var rows = $('#jqxUomGrid').jqxGrid('getrows');
	       var rowlength= rows.length;
	       
	       if(rowlength==1){
	   			$('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unit',$('#txtunit').val());
	           $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unitid',$('#cmbunit').val());
	           $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'fr',1);

	   	  }
	       
	       
	       
	       $("#jqxseding").jqxGrid('addrow', null, {});
	       
	      }
			
			$("#jqxSpecGrid").jqxGrid('addrow', null, {});
			$("#jqxSuitGrid").jqxGrid('addrow', null, {});
		}
	}

	
	
	
	
	
	
	
	
	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbbrand").html(optionsbrand);
				$('#cmbbrand').val($('#hidcmbbrand').val());
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}

	function getModel() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbbrand").html(optionsbrand);
				$('#cmbbrand').val($('#hidcmbbrand').val());
			} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}

	function getConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');

				var spec = items[0];
				var suit = items[1];
				
				var sed = items[2];

				if (parseInt(spec) == 0) {

					$("#SpecDiv").hide();
					
					
					 
					
					
				}
				if (parseInt(suit) == 0) {

					$("#SuitDiv").hide();
					$("#suits").hide();
					$("#mtypess").hide();
					$("#cmbmastertype").hide();
					
					
					
				}
				
				if (parseInt(sed) == 0) {

					$("#sedingmasterDiv").hide();
				 
				}

			} else {
			}
		}
		x.open("GET", "getConfig.jsp", true);
		x.send();
	}

	function getSpecConfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');

				document.getElementById("spec1").value = items[0];
				document.getElementById("spec2").value = items[1];
				document.getElementById("spec3").value = items[2];
				document.getElementById("spec4").value = items[3];
				$("#specDiv").load("specGrid.jsp");
			} else {
			}
		}
		x.open("GET", "getSpecConfig.jsp", true);
		x.send();
	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbcategory").html(optionsbrand);
				$('#cmbcategory').val($('#hidcmbcategory').val());
			} else {
			}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}

	function getType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbproducttype").html(optionsbrand);
				$('#cmbproducttype').val($('#hidcmbproducttype').val());
			} else {
			}
		}
		x.open("GET", "getType.jsp", true);
		x.send();
	}
	function getpmconfig() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
			var	items = x.responseText.trim();
			 
		 
			if(parseInt(items)==1)
				{
			 
				document.getElementById("hidpricemgt").value=items;
				$("#pricediv").show();
				
				chkfoc();
				}
			else
				{
				document.getElementById("hidpricemgt").value="0";
				$("#pricediv").hide();
			 
				
				}
			
	 
			} else {
			}
		}
		x.open("GET", "checkpricemgt.jsp", true);
		x.send();
	}

	function getUnit() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbunit").html(optionsbrand);
				$('#cmbunit').val($('#hidcmbunit').val());
			} else {
			}
		}
		x.open("GET", "getUnit.jsp", true);
		x.send();
	}

	function getDept() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbdept").html(optionsbrand);
				$('#cmbdept').val($('#hidcmbdept').val());
			} else {
			}
		}
		x.open("GET", "getdept.jsp", true);
		x.send();
	}
	function getmastertype() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				
				 
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand;
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbmastertype").html(optionsbrand);
				 
				
				if ($('#hidcmbmastertype').val() != "") {
					$('#cmbmastertype').val($('#hidcmbmastertype').val());
				}
				
		
			} else {
			}
		}
		x.open("GET", "getmastertype.jsp", true);
		x.send();
	}

	function getsubCategory(catid) {

		//var catid=$('#cmbcategory').val();

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('###');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
					/* document.getElementById("brandid").value=brandidItems[i]; */
				}

				$("select#cmbsubcategory").html(optionsbrand);
				$('#cmbsubcategory').val($('#hidcmbsubcategory').val());
			} else {
			}
		}
		x.open("GET", "getsubCategory.jsp?id=" + catid, true);
		x.send();
	}

	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}

	function funFocus() {
		document.getElementById("txtproductcode").focus();
	}

	function setValues() {

		
	 
		
		
		
		
		if ($('#msg').val() != "") {
			
			if(document.getElementById("msg").value.trim()=="Not Deleted" && $('#chkstatus').val()=="5")
				{
				//$('#msg').val('Cannot Delete Product With Stock');
				$.messager.alert('Message', 'Cannot Delete Product With Stock');
				$('#msg').val('');
				$('#mode').val('view');
				funReadOnly();
				
				}
			else
				{
			
			$.messager.alert('Message', $('#msg').val());
				} 
				
				
				
				
		}
		
	/* 	
		if($('#msg').val()=="Cannot Delete Product With Stock")
			{
			$('#msg').val('');
			$('#mode').val('view');
			
			alert("---asdsa-----");
			funReadOnly();
			
			
			} */
		
		if ($('#hidecmbstar').val() != "") {
			$('#cmbstar').val($('#hidecmbstar').val());
		}
			if ($('#hidcmbmastertype').val() != "") {
				$('#cmbmastertype').val($('#hidcmbmastertype').val());
			}
			
	
			
		 
		document.getElementById("formdet").innerText = $('#formdetail').val()
				+ " (" + $('#formdetailcode').val().trim() + ")";
		funSetlabel();
		 
		if(parseInt(document.getElementById("comorbranch").value)==1)
			{
			document.getElementById("company").checked = true;
			}
		else if(parseInt(document.getElementById("comorbranch").value)==2)
			{
			document.getElementById("branch").checked = true;
			}
		 
	
		
		fungridload();
		
		 
		
	}
	
	function fungridload(){
		
		var docno=document.getElementById("docno").value;
		
		if(docno>0){
			
			if(document.getElementById("comorbranch").value=="1")
			{
				$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+1);
			}
		else if(document.getElementById("comorbranch").value=="2")
			{
			$("#productDiv").load("productGrid.jsp?docno="+docno+"&chktype="+2);
			}		
			
		//	$("#pmDiv").load("pricemanagementgrid.jsp");
 	    $("#pmDiv").load("pricemanagementgrid.jsp?docno="+docno);
		$("#uomDiv").load("uomGrid.jsp?docno="+docno);
		$("#SuitDiv").load("suitGrid.jsp?docno="+docno);
		
		
		$("#sedingDiv").load("sedingGrid.jsp?docno="+docno);
		
		
		
		
		
		
		
		}
		
		
		
		if(docno==0)
			{
			 	funnotet();
			}
	}

	function funNotify() {

		var prorows = $("#jqxProductGrid").jqxGrid('getrows');
		var uomrows = $("#jqxUomGrid").jqxGrid('getrows');
		var specrows = $("#jqxSpecGrid").jqxGrid('getrows');
		var suitrows = $("#jqxSuitGrid").jqxGrid('getrows');
		
		document.getElementById("errormsg").innerText ="";
		
		$('#proGridlen').val(prorows.length);
		var j = 0;
		for (var i = 0; i < prorows.length; i++) {
			var dis=0;
			
			if (prorows[i].selects == true) {
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "prod" + j).attr("name", "prod" + j)
						.attr("hidden", "true");
				if (prorows[i].discontinued == true) {
					
					//alert("1");
					
					dis=1;
				}
				newTextBox.val(prorows[i].bdocno + "::" +prorows[i].selects
						+ "::" + dis + "::"
						+ prorows[i].bin+ "::" + prorows[i].minstock + "::"
						+ prorows[i].maxstock+ "::" + prorows[i].retailprice
						+ "::" + prorows[i].wholesale+ "::"
						+ prorows[i].normal+ "::"+prorows[i].reorderlevel+ "::"+prorows[i].reorderqty+ "::");  

				newTextBox.appendTo('form');
				j++;
				$('#proGridlen').val(j);
			}
			
		}
		
		
		var rows1 = $("#jqxseding").jqxGrid('getrows');
		   $('#jqxsedinglength').val(rows1.length);
		   
		  for(var i=0 ; i < rows1.length ; i++){
			  
			 var  disc=0;
			 
		 
			 
		if (rows1[i].discontinued == true) {
					
			 
					
					disc=1;
				}
			  
			  
						   newTextBox = $(document.createElement("input"))  
						      .attr("type", "dil")
						      .attr("id", "seding"+i)
						      .attr("name", "seding"+i)
						      .attr("hidden", "true");         
						  
						 newTextBox.val(rows1[i].part_no+"::"+rows1[i].priority+"::"+disc+"::");
						
					 
						  newTextBox.appendTo('form');
						  
				   
						 
	 
		   
		  }   
			  
		
		
	 
		
		
		if(j==0){
			document.getElementById("errormsg").innerText ="Select atleast one branch...!!!";
			return 0;
		}

		if (!((uomrows[0].unitid == "undefined") || (uomrows[0].unitid == null) || (uomrows[0].unitid ==" "))) {
			$('#uomGridlen').val(uomrows.length);
			
			for (var i = 0; i < uomrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "uom" + i).attr("name", "uom" + i)
						.attr("hidden", "true");

				newTextBox.val(uomrows[i].unitid + "::" + uomrows[i].fr + "::"
						+ uomrows[i].weight + "::" + uomrows[i].volumn + "::"
						+ uomrows[i].thickness + "::" + uomrows[i].len
						+ "::" + uomrows[i].width + "::");

				newTextBox.appendTo('form');

			}
		}

		if (!((specrows[0].spec1 == "undefined") || (specrows[0].spec1 == null) || (specrows[0].spec1 == ""))) {
			$('#specGridlen').val(specrows.length);

			for (var i = 0; i < specrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				var barcode=$('#txtbarcode').val()+i;
				alert(barcode);
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "spec" + i).attr("name", "spec" + i)
						.attr("hidden", "true");

				newTextBox.val(specrows[i].spec1 + "::" + specrows[i].spec2
						+ "::" + specrows[i].spec3 + "::" + specrows[i].spec4
						+ "::"+ barcode+ "::");

				newTextBox.appendTo('form');

			}
		}

		if (!((suitrows[0].doc_no == "undefined") || (suitrows[0].doc_no == null) || (suitrows[0].doc_no == ""))) {
			$('#suitGridlen').val(suitrows.length);
			for (var i = 0; i < suitrows.length; i++) {
				//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input")).attr("type",
						"dil").attr("id", "suit" + i).attr("name", "suit" + i)
						.attr("hidden", "true");
				/* suitrows[i].typeid + "::" + */
				
				newTextBox.val( suitrows[i].doc_no
						+ "::"+ suitrows[i].yomfrmid
						+ "::" + suitrows[i].yomtoid + "::"+ suitrows[i].bsize1id + "::"+ suitrows[i].bsize2id + "::"+ suitrows[i].bsize3id + "::"
						+ suitrows[i].csize1id + "::"+ suitrows[i].csize2id + "::"+ suitrows[i].csize3id + "::");

				newTextBox.appendTo('form');

			}
		}

		var rows = $("#jqxpmgt").jqxGrid('getrows');
		   $('#pmgtgridlength').val(rows.length);
		   
		  for(var i=0 ; i < rows.length ; i++){
			  
			  
						   newTextBox = $(document.createElement("input"))  
						      .attr("type", "dil")
						      .attr("id", "pmgt"+i)
						      .attr("name", "pmgt"+i)
						      .attr("hidden", "true");         
						  
						 newTextBox.val(rows[i].catid+"::"+rows[i].price1+" :: "+rows[i].price2+" :: "+rows[i].price3+" :: "  
								   +rows[i].discount1+" :: "+rows[i].discount2+" :: "+rows[i].discount3+" :: "+rows[i].foc1+" ::"+rows[i].foc2+" ::"+rows[i].foc3+" ::"
								   +rows[i].qty1+" ::"+rows[i].qty2+" ::"+rows[i].qty3+" ::");
						
					 
						  newTextBox.appendTo('form');
						  
				   
						 
	 
		   
		  }   
			  
		
		   // doc_no price1 price2 price3 discount1 discount2 discount3 foc1 foc2 foc3
		
		
		
		
		$('#cmbstar').attr('disabled', false);
		document.getElementById("errormsg").innerText = "";
		return 1;

	}
	function funcomorbranch()
        {
		if(document.getElementById("company").checked == true)
			
			{
			document.getElementById("comorbranch").value="1";
			
			$("#productDiv").load("productGrid.jsp?chktype="+1);
			 
			document.getElementById("comorbranch").value="1";
			
			}
		else if(document.getElementById("branch").checked == true)
			{
			$("#productDiv").load("productGrid.jsp?chktype="+2);
			document.getElementById("comorbranch").value="2";
			}
		
		} 
    function chkfoc()
    {
     
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	   
	      if(parseInt(items)==1)
	       {
	     
	    	  
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc1');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc2');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'foc3');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty1');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty2');
	    	  $('#jqxpmgt').jqxGrid('showcolumn', 'qty3');
	    
	    	  
	    	  
	        }
	          else
	      {
	      
	        	 
	         	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc1');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc2');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'foc3');
    	    	  
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty1');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty2');
    	    	  $('#jqxpmgt').jqxGrid('hidecolumn', 'qty3');
	      
	      }
	      
	       }}
	   x.open("GET","checkfoc.jsp?",true);
		x.send();
	 
	      
	        
    	
    }
    
    function funset(val)
    {
    	
    	$('#jqxseding').jqxGrid('setcellvalue', 0, 'part_no',val);
    	
    	$('#jqxseding').jqxGrid('setcellvalue', 0, 'priority',1);
    	
    	
    	
        
        
    	
    	
    	
    }
    function funnotet()
    {
    	
    	$("#jqxUomGrid").jqxGrid('addrow', null, {});
    	$("#jqxSpecGrid").jqxGrid('addrow', null, {});
    	$("#jqxSuitGrid").jqxGrid('addrow', null, {});
    	$("#jqxseding").jqxGrid('addrow', null, {}); 	
    	
	$('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unit',$('#txtunit').val());
    $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'unitid',$('#cmbunit').val());
    $('#jqxUomGrid').jqxGrid('setcellvalue', 0, 'fr',1);

    $('#jqxseding').jqxGrid('setcellvalue', 0, 'part_no',val);
	
	$('#jqxseding').jqxGrid('setcellvalue', 0, 'priority',1);
    }
	
    
    
    
	      
</script>

<style>
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}
</style>

</head>
<body onload="setValues();getpmconfig();">
	<div id="mainBG" class="homeContent" data-type="background">
 		<!-- <form id="frmProduct" action="saveProduct" method="post"  namespace="/"
method="POST" enctype="multipart/form-data">
			autocomplete="off">   -->
	  <s:form action="saveProduct1" id="frmProduct"  method="post"  namespace="/com/controlcentre/masters/product"  autocomplete="OFF"  >   
			
			<jsp:include page="../../../../header.jsp"></jsp:include><br />
<table width="100%">
					<tr></tr></table>
			<div class='hidden-scrollbar'>

				<table width="100%">
					<tr>
						<td width="7%" align="right">Date</td>
						<td width="43%"><div id="date" name="date"
								value='<s:property value="date"/>'></div> <input type="hidden"
							id="hiddate" name="hiddate" value='<s:property value="hiddate"/>' /></td>
						<td width="31%" align="right">Doc No</td>
						<td width="19%"><input type="text" id="docno" name="docno"
							style="width: 65%;" tabindex="-1"
							value='<s:property value="docno"/>' /></td>
					</tr>
				</table>

				<table width="100%" >
					<tr>
						<td width="40%">
							<fieldset>
								<table width="100%">
									<tr>
										<td width="15%" align="right">Product Code</td>
										<td width="85%"><input type="text" id="txtproductcode"
											name="txtproductcode" style="width: 30%;"
											value='<s:property value="txtproductcode"/>' onblur="funset(this.value)" /></td>
									</tr>
									<tr>
										<td align="right">Product Name</td>
										<td><input type="text" id="txtproductname"
											name="txtproductname" style="width: 100%;"
											value='<s:property value="txtproductname"/>' /></td>
									</tr>
									
									
									<tr>
											
											<td align="right">اسم المنتج</td>
										<td><input type="text" id="txtarbicprdname"
											name="txtarbicprdname" style="width: 100%;" 
											value='<s:property value="txtarbicprdname"/>' /></td> </tr>
									
									<tr>
										<td align="right">Bar Code</td>
										<td><input type="text" id="txtbarcode" name="txtbarcode"
											style="width: 30%;" value='<s:property value="txtbarcode"/>' /></td>
									</tr>
																 <tr>
    <td width="11%" align="right">Star</td>
    <td colspan="6"><select  name="cmbstar" id="cmbstar"  value='<s:property value="cmbstar"/>' style="width:31%;"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>
    &nbsp;&nbsp;&nbsp;
    <label id="mtypess"> Type</label>
       <select  name="cmbmastertype" id="cmbmastertype"  value='<s:property value="cmbmastertype"/>' style="width:30%;"><option ></option></select>
    
    </td> 
       <td width="30%">
        </td>
  </tr>
								</table>
							</fieldset>
						</td>
						<td width="60%">
							<fieldset>
								<table width="100%" >
									<tr>
										<td width="10%" align="right">Product Type</td>
										<td width="45%">
											<input type="text" id="txtproducttype" name="txtproducttype"
											style="width: 80%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' /></td>
											
										<td width="11%" align="right">Brand</td>
										<td><input type="text" id="txtbrand" name="txtbrand"
											style="width: 75%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdBrand(event);" value='<s:property value="txtbrand"/>' /></td>
									</tr>
									<tr>
										<td align="right">Category</td>
										<td>
											<input type="text" id="txtcategory" name="txtcategory"
											style="width: 80%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdCat(event);" value='<s:property value="txtcategory"/>' /></td>
											
										<td align="right">Sub Category</td>
										<td>
											<input type="text" id="txtsubcategory" name="txtsubcategory"
											style="width: 75%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdSubCat(event);" value='<s:property value="txtsubcategory"/>' /></td>
									</tr>
									<tr>
										<td align="right">Unit</td>
										<td>
											<input type="text" id="txtunit" name="txtunit"
											style="width: 50%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdUnit(event);" value='<s:property value="txtunit"/>' /></td>

										<td align="right">Department</td>
										<td><input type="text" id="textdept" name="textdept"
											style="width: 50%;" placeholder="Press F3 for Search" readonly="true"  onKeyDown="getProdDept(event);" value='<s:property value="textdept"/>' />
											
											<input
											type="hidden" id="spec1" name="spec1"
											value='<s:property value="spec1"/>' /> <input type="hidden"
											id="spec2" name="spec2" value='<s:property value="spec2"/>' />
											<input type="hidden" id="spec3" name="spec3"
											value='<s:property value="spec3"/>' /> <input type="hidden"
											id="spec4" name="spec4" value='<s:property value="spec4"/>' />
											
											<input type="hidden" id="cmbproducttype" name="cmbproducttype" value='<s:property value="cmbproducttype"/>' />
											<input type="hidden" id="cmbbrand" name="cmbbrand" value='<s:property value="cmbbrand"/>' />
											<input type="hidden" id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>' />
											<input type="hidden" id="cmbsubcategory" name="cmbsubcategory" value='<s:property value="cmbsubcategory"/>' />
											<input type="hidden" id="cmbunit" name="cmbunit" value='<s:property value="cmbunit"/>' />
											<input type="hidden" id="cmbdept" name="cmbdept" value='<s:property value="cmbdept"/>' />
											
											
											<input type="hidden" id="hidcmbmastertype" name="hidcmbmastertype" value='<s:property value="hidcmbmastertype"/>' />







											<input type="hidden" id="specGridlen" name="specGridlen"
											value='<s:property value="specGridlen"/>' /> <input
											type="hidden" id="proGridlen" name="proGridlen"
											value='<s:property value="proGridlen"/>' /> <input
											type="hidden" id="suitGridlen" name="suitGridlen"
											value='<s:property value="suitGridlen"/>' /> <input
											type="hidden" id="uomGridlen" name="uomGridlen"
											value='<s:property value="uomGridlen"/>' />
										<input type="hidden" name="mode" id="mode"
											value='<s:property value="mode"/>' />
										<input type="hidden" name="deleted" id="deleted"
											value='<s:property value="deleted"/>' />
										<input type="hidden" id="msg" name="msg"
											value='<s:property value="msg"/>' />
											<input type="hidden" id="hidspec1id" name="hidspec1id"
											value='<s:property value="hidspec1id"/>' />
											<input type="hidden" id="hidspec2id" name="hidspec2id"
											value='<s:property value="hidspec2id"/>' />
											<input type="hidden" id="hidspec3id" name="hidspec3id"
											value='<s:property value="hidspec3id"/>' />
											<input type="hidden" id="hidsuitid" name="hidsuitid"
											value='<s:property value="hidsuitid"/>' /></td>
									</tr>
									<tr><td align="right">Description</td><td colspan="3"><input type="text" id="desc1" style="width: 90.4%;"  name="desc1"  value='<s:property value="desc1"/>' /></td>
									</tr>

								</table>
							</fieldset>
							
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><label id="stdcostname"  name="stdcostname"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="stdcostname"/> </label></b>   
							 <b><label id="stdcostprice"  name="stdcostprice"   style="font-size: 13px;font-family: Tahoma; color:#a03838"><s:property value="stdcostprice"/> </label></b>
							&nbsp;&nbsp;
							 <b><label id="fixname"  name="fixname"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="fixname"/> </label></b> 
							 <b><label id="fixprices"  name="fixprices"   style="font-size: 13px;font-family: Tahoma; color:#a03838"><s:property value="fixprices"/> </label></b>
							 &nbsp;&nbsp;
							 <b><label id="lbrcostname"  name="lbrcostname"   style="font-size: 13px;font-family: Tahoma; color:#6000FC"><s:property value="lbrcostname"/> </label></b>
							 <b><label id="lbrcosts"  name="lbrcosts"   style="font-size: 13px;font-family: Tahoma; color:#a03838"><s:property value="lbrcosts"/> </label></b>
						</td>
					</tr>
				</table>
				<br />
				<table width="100%">
					<tr>
						<td colspan="4">
							<fieldset>
									<legend>Permissions</legend>
									<table width="100%">
									<tr>
									<td>
									&nbsp;
									<input type="radio" id="company" name="chkbrorcom" value=""  onchange="funcomorbranch()"> Company &nbsp;&nbsp;
									  <input type="radio"id="branch"  name="chkbrorcom" value="" onchange="funcomorbranch()"> Branch  
									</td></tr>
										</table>
									
									<div id="productDiv">
									<jsp:include page="productGrid.jsp"></jsp:include><br /></div>
								</fieldset>
							
							<table width="100%">
							
							<tr>
									<td>
									<div id="pricediv">
										<fieldset>
												<legend>Price Management</legend>
												
												
												<div id="pmDiv"> 
											
												<jsp:include page="pricemanagementgrid.jsp"></jsp:include></div>
									</fieldset>
										</div></td>
								</tr>
							
								<tr>
									<td>
										<fieldset>
												<legend>UOM</legend>
												<div id="uomDiv">
											
												<jsp:include page="uomGrid.jsp"></jsp:include></div>
									</fieldset>
										
								</tr>
						<tr>
									<td>
									
									<div id="sedingmasterDiv">
									
										<fieldset>
												<legend>Superseding</legend>
												<div id="sedingDiv">
											
												<jsp:include page="sedingGrid.jsp"></jsp:include></div>
									</fieldset>
									</div>
									
									</td>	
								</tr>
								
								<tr>
									<td>
									
										<div id="SpecDiv">
											<fieldset>
												<legend>Specification</legend>
												<jsp:include page="specGrid.jsp"></jsp:include></fieldset>
												</div>
										
									</td>
								</tr>

								<tr>
									<td><div id="suits">
												 <fieldset>
												<legend>Suitabilty</legend>
												<table width="100%">
												<tr>
												<td width="99%" height="300">
												<div  id="SuitDiv">
										
												<jsp:include page="suitGrid.jsp"></jsp:include>
												</div></td><td width="1%" height="300">&nbsp;</td></tr></table></fieldset>
										</div>
									</td>
								</tr>


							</table>
						</td>
					</tr>
				</table>

 		</div> 
			
			
			
				<input type="hidden" id="jqxsedinglength" name="jqxsedinglength" value='<s:property value="jqxsedinglength"/>' />
			
				<input type="hidden" id="hidecmbstar" name="hidecmbstar" value='<s:property value="hidecmbstar"/>' />
			
					<input type="hidden" id="pmgtgridlength" name="pmgtgridlength" value='<s:property value="pmgtgridlength"/>' />
			<input type="hidden" id="comorbranch" name="comorbranch" value='<s:property value="comorbranch"/>' />
			
			<input type="hidden" id="hidpricemgt" name="hidpricemgt" value='<s:property value="hidpricemgt"/>' /> <!-- //div -->
			
 	 </s:form>  
 		
				<div id="unitsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="catsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="subcatsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="typesearchwindow">
			<div></div>
			<div></div>
		</div>

		<div id="brandsearchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="modelsearchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="deptsearchwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="yomsearchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="spec1searchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="spec2searchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="spec3searchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="suitsearchwindow">
			<div></div>
			<div></div>
		</div>
		<div id="submodelsearchwindow">
			<div></div>
			<div></div>
		</div>
	</div>
</body>
</html>