<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
		<html>
			<head>
		<s:head/>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>GatewayERP(i)</title>

		<jsp:include page="../../../../includes.jsp"></jsp:include>
		<style>
				form label.error 
				{
						color:red;
  						font-weight:bold;

				}

				.style1 
				{
						color: #FF0000;
						font-weight: bold;
				}
		</style> 
		<script type="text/javascript">

      	$(document).ready(function () 
      	{  
    			  //Date
    	  	    $("#date_coun").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" }); 
    	       	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
         	    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 


         
				 
				 
				 
				 $('#accountwindow').jqxWindow({
												width : '55%',
												height : '58%',
												maxHeight : '70%',
												maxWidth : '45%',
												title : 'Account Type',
												position : {
												x : 420,
												y : 87
												},
												theme : 'energyblue',
												showCloseButton : true,
												keyboardCloseKey : 27
												});
				 
		
					$('#accountwindow').jqxWindow('close');				 
					$('#txtaccno').dblclick(function()
					{		
						
						if($('#mode').val()!="view")
							{
						
									accountsearch('accountgrid.jsp');  
													
							}
					}); 			 
				 
					
					
					
					
				 $('#productwindow').jqxWindow({
						width : '25%',
						height : '58%',
						maxHeight : '70%',
						maxWidth : '45%',
						title : 'Product Type',
						position : {
							x : 420,
							y : 87
						},
						theme : 'energyblue',
						showCloseButton : true,
						keyboardCloseKey : 27
					});
				 
		
					$('#productwindow').jqxWindow('close');
				 	$('#txtprotype').dblclick(function()
				 	{
						
						if($('#mode').val()!="view")
						{
						 
							typeSearchContent('typegrid.jsp');  
						}
					}); 
					
					
				 	
				 	
					 $('#provincewindow').jqxWindow({
							width : '25%',
							height : '58%',
							maxHeight : '70%',
							maxWidth : '45%',
							title : 'Province Type',
							position : {
								x : 420,
								y : 87
							},
							theme : 'energyblue',
							showCloseButton : true,
							keyboardCloseKey : 27
						});
					 
			
						$('#provincewindow').jqxWindow('close');
					 
						$('#txtprovince').dblclick(function(){
							if($('#mode').val()!="view"){
							 
							provinceSearch('provincegrid.jsp');  }
						}); 
						
						
						
						
						$('#aliaswindow').jqxWindow({
							width : '25%',
							height : '58%',
							maxHeight : '70%',
							maxWidth : '45%',
							title : 'Alias Type',
							position : {
								x : 420,
								y : 87
							},
							theme : 'energyblue',
							showCloseButton : true,
							keyboardCloseKey : 27
						});
					 
			
						$('#aliaswindow').jqxWindow('close');
					 
						$('#txtappliedon').dblclick(function(){
							if($('#mode').val()!="view"){
							 
								aliasSearch('aliasgrid.jsp');  }
						}); 


							
							
		});		
 
         
      	
      	
      	
      	
      	function fundisable()
      	{
    		    		
    		if (document.getElementById('prdt').checked)
    		{
    			
    			$('#hidtype').val("1");
    			  
    		}
    		 else if (document.getElementById('serv').checked)
    		 {
    			 $('#hidtype').val("2");
    			 
    		  }
    	}
    	
    	
      	
      	
      	
      	
      	 function funFocus()
      	 {
      		// document.getElementById("txtclient_name").focus();  
      		
      	 }
      
      
      function getaccountType(event)
      {
	    	 var x= event.keyCode;
	    	 if(x==114)
	    	 {
	    		 if($('#mode').val()!="view"){
	    		 accountsearch('accountgrid.jsp');
	    		 }
	    	 }
	     	 else
	     	 {
	    	 }
  	 	}
		
		function accountsearch(url)
		{
				$('#accountwindow').jqxWindow('open');
				$.get(url).done(function(data)
				{
						$('#accountwindow').jqxWindow('setContent', data);
						$('#accountwindow').jqxWindow('bringToFront');
				});
		}	   
      
      
      function getProdType(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    		 
	    		 if($('#mode').val()!="view")
	    		{	 
	    		 typeSearchContent('typegrid.jsp'); 
	    		} 
	    		}
	     	 else{
	    		 }
	           	 }
		
		function typeSearchContent(url) {
			$('#productwindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#productwindow').jqxWindow('setContent', data);
				$('#productwindow').jqxWindow('bringToFront');
			});
		}	
		
		
		
		function getProvinceType(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    		 
	    		 if($('#mode').val()!="view")
	    	 		{
	    		 		provinceSearch('provincegrid.jsp');
	    	 		}
	    		 	}
	     	 else{
	    		 }
	           	 }
		
		function provinceSearch(url) {
			$('#provincewindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#provincewindow').jqxWindow('setContent', data);
				$('#provincewindow').jqxWindow('bringToFront');
			});
		}
		
		
		
		function getAliasType(event){
	    	 var x= event.keyCode;
	    	 if(x==114){
	    		 
	    		 if($('#mode').val()!="view")
	    	 		{
	    		 		aliasSearch('aliasgrid.jsp');
	    	 		}
	    		 	}
	     	 else{
	    		 }
	           	 }
		
		function aliasSearch(url) {
			$('#aliaswindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#aliaswindow').jqxWindow('setContent', data);
				$('#aliaswindow').jqxWindow('bringToFront');
			});
		}
		
  

   		function funNotify()
        { 	  
				var taxname=document.getElementById("txttaxname").value;
   			
   			
   				if(taxname=="")
   				{
   					document.getElementById("errormsg").innerText="Enter tax name";;
   					return 0;
   				}	
   			
   				var accno=document.getElementById("txtaccno").value;
   			
   			
   				if(accno=="")
   				{
   					document.getElementById("errormsg").innerText="Please select Account";
   					return 0;
   				}
   			
    	  
	  			 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		 		 // out date
		 	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		  		 if(fromdates>todates)
		  		 {
			  			 document.getElementById("errormsg").innerText="To Date Less Than From Date";
						 return 0;
				  }   	  
    	  
  	  
  				   document.getElementById("errormsg").innerText="";
  		           return 1;
	     } 
   
   
      	 function funSearchLoad()
      	 {
		 			changeContent('taxsearch.jsp', $('#window')); 
		 }

      
		function funReadOnly()
		{
					$('#frmtax input').attr('readonly', true );
					$('#frmtax select').attr('disabled', true ); 
					
					
					 
					 $('#prdt').attr('disabled', true );
					 $('#serv').attr('disabled', true );
					 
					 $('#date_coun').jqxDateTimeInput({ disabled: true}); 
					 $('#fromdate').jqxDateTimeInput({ disabled: true}); 
					 $('#todate').jqxDateTimeInput({ disabled: true}); 
		}
		
		
		function funRemoveReadOnly()
		{
					$('#frmtax input').attr('readonly', false );
					$('#frmtax select').attr('disabled', false );
					$('#docno').attr('readonly', true );
		
					$('#date_coun').jqxDateTimeInput({ disabled: false}); 
				    $('#fromdate').jqxDateTimeInput({ disabled: false}); 
	 				$('#todate').jqxDateTimeInput({ disabled: false}); 
	 				
	 				$('#txtappliedon').attr('readonly', true );
					$('#txtprovince').attr('readonly', true );   
					$('#txtaccno').attr('readonly', true );
					$('#txtaccname').attr('readonly', true );
					$('#txtprotype').attr('readonly', true );
					
					$('#prdt').attr('disabled', false );
					 $('#serv').attr('disabled', false );
					
					if($('#mode').val()=="A")
					{
					
						document.getElementById("prdt").checked = true;
						$('#hidtype').val("1");
					}
					

	}
	
    	function setValues()
    		{
    	
    		
    		
			if($('#hidtype').val()=="1")
			{
				document.getElementById("prdt").checked = true;
			}
			else if($('#hidtype').val()=="2")
			{
				document.getElementById("serv").checked = true;
			
			}
    		
    				 if($('#msg').val()!="")
    				 {
        		 		 	 $.messager.alert('Message',$('#msg').val());
        		  	 }
    				 if($('#hidedate_coun').val())
    				 {
    						$("#date_coun").jqxDateTimeInput('val', $('#hidedate_coun').val());
    				 }
    				 if($('#hidtodate').val())
    		         {
    		          $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
    		         }
    		         if($('#hidfromdate').val())
    		         {
    		          $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
    		         }
    		 
    				 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    				 funSetlabel();
    	
    		}
 	   </script> 
	</head>
 	<body onload="setValues();">
			<div id="mainBG" class="homeContent" data-type="background">
			<form id="frmtax" action="saveActionTaxmaster" autocomplete="off">

			<jsp:include page="../../../../header.jsp" />
			<br/> 
  
			<fieldset >
					<table width="100%" > 
  						<tr>
    						 <td width="14%"><div align="right">Date</div></td>
  							 <td width="12%"><div id="date_coun" name="date_coun" value='<s:property value="date_coun"/>'></div></td>
  							 <td width="23%"><div align="right">Doc No</div></td>
 							 <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
  
  						</tr>
 						<tr>
   							 <td align="right">Tax Code</td>
   							 <td ><input type="text" id="txttaxcode" name="txttaxcode" style="width:80%;" value='<s:property value="txttaxcode"/>'></td>
    						 <td width="11%" align="right">Tax Name</td>
   							 <td ><input type="text" id="txttaxname" name="txttaxname" style="width:40%;" value='<s:property value="txttaxname"/>'></td>
 						 </tr>
  						 <tr>
 	 						  <td align="right">Province</td>
   							  <td ><input type="text" id="txtprovince" name="txtprovince" style="width:80%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getProvinceType(event);" value='<s:property value="txtprovince"/>'></td>
   							  <td width="11%" align="right">Product Type</td>
  							  <td ><input type="text" id="txtprotype" name="txtprotype" style="width:40%;"placeholder="Press F3 for Search" readonly="true" onKeyDown="getProdType(event);" value='<s:property value="txtprotype"/>'></td>
 						 </tr>  
 						 <tr>
   							   <td align="right">CST %</td>
  							   <td ><input type="text" id="txtcst" name="txtcst" style="width:80%;" value='<s:property value="txtcst"/>'></td>
  							   <td width="11%" align="right">Percentage</td>
  							   <td ><input type="text" id="txtpercentage" name="txtpercentage" style="width:20%;" value='<s:property value="txtpercentage"/>'></td>
  					     </tr>
  						 <tr>
    							<td width="13%" align="right">Alias</td>
    							<td width="11%"><input type="text" id="txtalice" name="txtalice" style="width:80%;"  value='<s:property value="txtalice"/>'></td>
    							
    							 <td align="right">Type:</td>
    							 <td><input type="radio" id="prdt" name="type" onchange="fundisable();" value="prdt"><label for="prdt" >Product</label>&nbsp;
									 <input type="radio" id="serv" name="type" onchange="fundisable();" value="serv"><label for="serv" >Service</label></td>
    							
    					  </tr>
  
  						  <tr>
   								 <td align="right">From Date</td> 
    							 <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
     
    							 <td width="2%" align="right">To Date</td>
    						 	 <td width="11%"><div id="todate" name="todate" value='<s:property value="todate"/>'></div> </td>
   						   </tr>  
   						   <tr>
  								  <td align="right">Account No</td> 
   								  <td width="11%"><input type="text" id="txtaccno" name="txtaccno" style="width:80%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getaccountType(event);" value='<s:property value="txtaccno"/>'></td>
  							      <td width="11%"><input type="text" id="txtaccname" name="txtaccname" style="width:80%;" value='<s:property value="txtaccname"/>'></td>
   					       </tr>
    						<tr>
    								 <td width="9%" align="right">Applied on</td>
  									 <td ><input type="text" id="txtappliedon" name="txtappliedon" style="width:80%;" placeholder="Press F3 for Search" readonly="true" onKeyDown="getAliasType(event);" value='<s:property value="txtappliedon"/>'></td>
   
  							</tr>
  
					</table>

					<input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>'>
 					<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
								
					<input type="hidden" id="hidaliasid" name="hidaliasid" value='<s:property value="hidaliasid"/>'>
 					<input type="hidden" id="txtprovinceid" name="txtprovinceid" value='<s:property value="txtprovinceid"/>'>
 					<input type="hidden" id="txttypeid" name="txttypeid" value='<s:property value="txttypeid"/>'>
 					<input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'>
 				    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
 					<input type="hidden" name="hidedate_coun" id="hidedate_coun" value='<s:property value="hidedate_coun"/>'/>
					<input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'/>
      <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'/>
					<input type="hidden" name="hidcmbtimezone" id="hidcmbtimezone" value='<s:property value="hidcmbtimezone"/>' hidden="true"/>
    				 <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
					<input type="hidden" id="hidprovinceid" name="hidprovinceid" value='<s:property value="hidprovinceid"/>'>
					<input type="hidden" id="hidaccountid" name="hidaccountid" value='<s:property value="hidaccountid"/>'>
				</fieldset>
			</form>
 		</div> 
 
 		<div id="productwindow">
			<div></div>
			<div></div>
		</div>
		
		<div id="provincewindow">
			<div></div>
			<div></div>
		</div>
		<div id="accountwindow">
			<div></div>
			<div></div>
		</div>
		<div id="aliaswindow">
			<div></div>
			<div></div>
		</div>
                                  
	</body>
</html>
