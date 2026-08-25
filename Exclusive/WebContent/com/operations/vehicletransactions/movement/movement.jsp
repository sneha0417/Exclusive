<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 545px;
}
form label.error {
color:red;
  font-weight:bold;

}
</style> 
<script type="text/javascript">
     $(document).ready(function ()
    		 {
    	 $('#btnEdit').attr('disabled',true);
    	 $('#btnDelete').attr('disabled',true);
    	 
    	 getBranch();
    	 
    	 /* getLocation(document.getElementById("cmbbranch").value); */
    	 document.getElementById("deliveryfield").style.display="none";
    	 document.getElementById("collectionfield").style.display="none";
		 if(document.getElementById("hidchkgaragedelivery").value==1){
    		 document.getElementById("chkgaragedelivery").checked=true;
    		 checkGarageDelivery();
    	 }
    	 if(document.getElementById("hidchkgaragedelivery").value==0){
    		 document.getElementById("chkgaragedelivery").unchecked=true;
    		 checkGarageDelivery();
    	 }
    	 if(document.getElementById("hidchkgaragecollect").value==1){
    		 document.getElementById("chkgaragecollect").checked=true;
    		 checkGarageCollection();
    	 }
    	 if(document.getElementById("hidchkgaragecollect").value==0){
    		 document.getElementById("chkgaragecollect").unchecked=true;
    		 checkGarageCollection();
    	 }  
    	 checkStaff();
    	  $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#dateouthidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	  $("#garagedeldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#garagecollectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    	  $("#timeout").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#closetime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
         $("#timeouthidden").jqxDateTimeInput({ width: '12%', height: '15px', formatString: 'HH:mm', showCalendarButton: false });
          $("#garagedeliverytime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#garagecollecttime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#hiddelivery").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
          $("#hidcollect").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
 document.getElementById("garage").style.display="none";
    	 document.getElementById("staff").style.display="none";
     	 document.getElementById("btnclosesave").style.display="none";
    	document.getElementById("btndeliverysave").style.display="none"; 
    	
    	$('#dateout').on('change', function (event) 
    			{  
    	//checkfuturedate();
    	if($('#dateout').jqxDateTimeInput('getDate')!=null){
    		var date=new Date($('#dateout').jqxDateTimeInput('getDate'));
    		var status=checkfuturedatenew(date);//Checking Future date.Written on 11-07-2016	
    		if(status){
    			document.getElementById("errormsg").innerText="";
    			return true;
    		}
    		else{
    			$('#dateout').jqxDateTimeInput('focus');
    			return false;
    		}
    	}
    	});
    	
    	$('#closedate').on('change', function (event) 
    			{  
    	//checkfuturedate();
    	if($('#closedate').jqxDateTimeInput('getDate')!=null){
    		var date=new Date($('#closedate').jqxDateTimeInput('getDate'));
    		var status=checkfuturedatenew(date);//Checking Future date.Written on 11-07-2016	
    		if(status){
    			document.getElementById("errormsg").innerText="";
    			return true;
    		}
    		else{
    			$('#closedate').jqxDateTimeInput('focus');
    			return false;
    		}
    	}
    	});
    	
    	
    	$('#garagedeldate').on('change', function (event) 
    			{  
    	//checkfuturedate();
    	if($('#garagedeldate').jqxDateTimeInput('getDate')!=null){
    		var date=new Date($('#garagedeldate').jqxDateTimeInput('getDate'));
    		var status=checkfuturedatenew(date);//Checking Future date.Written on 11-07-2016	
    		if(status){
    			document.getElementById("errormsg").innerText="";
    			return true;
    		}
    		else{
    			$('#garagedeldate').jqxDateTimeInput('focus');
    			return false;
    		}
    	}
    	});
    	
    	
    	$('#garagecollectdate').on('change', function (event) 
    			{  
    	//checkfuturedate();
    	if($('#garagecollectdate').jqxDateTimeInput('getDate')!=null){
    		var date=new Date($('#garagecollectdate').jqxDateTimeInput('getDate'));
    		var status=checkfuturedatenew(date);//Checking Future date.Written on 11-07-2016	
    		if(status){
    			document.getElementById("errormsg").innerText="";
    			return true;
    		}
    		else{
    			$('#garagecollectdate').jqxDateTimeInput('focus');
    			return false;
    		}
    	}
    	});
    	
    	
    	  //Future Validation for time
     	$('#timeout').on('change', function (event) 
     			{  
    	    	//checkfuturetime();
    	    	if($('#timeout').jqxDateTimeInput('getDate')!=null){
    		  
    	  
    	    	var date=$('#dateout').jqxDateTimeInput('getDate');
    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
    	    		document.getElementById("errormsg").innerText="";
    	    		document.getElementById("errormsg").innerText="Please select a valid date";
    	    		$('#dateout').jqxDateTimeInput('focus');
    	    		return false;
    	    	}
    	    	else{
    		    	var time=$('#timeout').jqxDateTimeInput('getDate');
    		    	var status=checkfuturetime(date,time);
    		    	if(status){
    		    		document.getElementById("errormsg").innerText="";
    		    		return true;	
    		    	}
    		    	else{
    		    		$('#timeout').jqxDateTimeInput('focus');
    		    		return false;
    		    	}	    		
    	    	}
    	  }
     	}); 
     	
     	$('#garagecollecttime').on('change', function (event) 
     			{  
    	    	//checkfuturetime();
    	    	if($('#garagecollecttime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#garagecollectdate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="";
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#garagecollectdate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	}
	    	    	else{
	    		    	var time=$('#garagecollecttime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	}
	    		    	else{
	    		    		$('#garagecollecttime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	  }
     	});
     	
     	
    	$('#garagedeliverytime').on('change', function (event) 
     			{  
    	    	//checkfuturetime();
    	    	if($('#garagedeliverytime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#garagedeldate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="";
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#garagedeldate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	}
	    	    	else{
	    		    	var time=$('#garagedeliverytime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	}
	    		    	else{
	    		    		$('#garagedeliverytime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	  }
     	});
    	
    	
    	
    	$('#closetime').on('change', function (event) 
     			{  
    	    	//checkfuturetime();
    	    	if($('#closetime').jqxDateTimeInput('getDate')!=null){
	    	    	var date=$('#closedate').jqxDateTimeInput('getDate');
	    	    	if(date==null || date=="undefined" || typeof(date)=="undefined" || date==""){
	    	    		document.getElementById("errormsg").innerText="";
	    	    		document.getElementById("errormsg").innerText="Please select a valid date";
	    	    		$('#closedate').jqxDateTimeInput('focus');
	    	    		return false;
	    	    	}
	    	    	else{
	    		    	var time=$('#closetime').jqxDateTimeInput('getDate');
	    		    	var status=checkfuturetime(date,time);
	    		    	if(status){
	    		    		document.getElementById("errormsg").innerText="";
	    		    		return true;	
	    		    	}
	    		    	else{
	    		    		$('#closetime').jqxDateTimeInput('focus');
	    		    		return false;
	    		    	}	    		
	    	    	}
    	  }
     	});
    	
    	 if(document.getElementById("docno").value==''){
    		 $('#btnclose').prop('disabled',true);
    	 }
    	 else if((document.getElementById("closekm").value=='')||(document.getElementById("closekm").value==0.0)){
    		 $('#btnclose').prop('disabled',false);
    	 }
    	 else{
    		 $('#btnclose').prop('disabled',true);
    	 }
    	 if(document.getElementById("chkgaragedelivery").checked==true){
    		 $('#garagedeldate').jqxDateTimeInput({ disabled:false});
    		 if($('#garagedeldate').jqxDateTimeInput('getDate')==null){
    			 $('#btndeliveryupdate').prop('disabled',false);	 
    		 }
    		 $('#garagedeldate').jqxDateTimeInput({ disabled:true});
    	 }
    	 else{
    		 $('#btndeliveryupdate').prop('disabled',true);
    	 }
    	
    	   	checkStaff();
    	 getAccidents();

          $('#fleetwindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	   $('#fleetwindow').jqxWindow('close');
   	 $('#driverwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#driverwindow').jqxWindow('close');
 	  $('#staffwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#staffwindow').jqxWindow('close');
   	 $('#maintenancewindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Maintenance Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	   $('#maintenancewindow').jqxWindow('close');
 	  $('#garagewindow').jqxWindow({ autoOpen:false,width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#garagewindow').jqxWindow('close');
   	 $('#txtfleetno').dblclick(function(){
   		if(document.getElementById("mode").value=="A"){
		    $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		 fleetSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
   		}
		});
   	 
   	 //function getdblDriver(id)
   	 $('#driver').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){
   			if(document.getElementById("cmbstatus").value==""){
 			   document.getElementById("errormsg").innerText="";
 			   document.getElementById("errormsg").innerText="Please Select Movement Type";
 			   document.getElementById("cmbstatus").focus();
 			   return false;
 		   }
   			$('#driverwindow').jqxWindow('open');
   			$('#driverwindow').jqxWindow('focus');
   			 driverSearchContent('driverSearch.jsp?id=1&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow')); 
   		 }
		    
		});
   	 $('#staff').dblclick(function(){
   		 //var status=document.getElementById("cmbstatus").value;
   		 	 if(document.getElementById("mode").value=="A"){
		    $('#staffwindow').jqxWindow('open');
		$('#staffwindow').jqxWindow('focus');
		 staffSearchContent('staffSearch.jsp?id=1', $('#staffwindow'));
   		 	 }
		});
   	 $('#garage').dblclick(function(){
   		 //var status=document.getElementById("cmbstatus").value;
   		 	 if(document.getElementById("mode").value=="A"){
		    $('#garagewindow').jqxWindow('open');
		$('#garagewindow').jqxWindow('focus');
		 garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
   		 	 }
		});
   	 $('#closestaff').dblclick(function(){
   		 if(document.getElementById("mode").value=="A"){   
   		 $('#staffwindow').jqxWindow('open');
		$('#staffwindow').jqxWindow('focus');
		 staffSearchContent('staffSearch.jsp?id=2', $('#staffwindow'));
   		 }
		});
   	 $('#closedriver').dblclick(function(){
   		 if(document.getElementById("mode").value=="close"){ 
   		 $('#driverwindow').jqxWindow('open');
		$('#driverwindow').jqxWindow('focus');
		 driverSearchContent('driverSearch.jsp?id=2&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
   		 }
		});
   //	checkStaff();
      if(document.getElementById("clstatus").value=='1'){
    	 document.getElementById("btnclose").style.display="none";
     }
     else{
    	 document.getElementById("btnclose").style.display="block";
     }
      
      
      //Reconfirm Closing km and km difference
      
      
     });
	 
	 
     function checkfuturedatenew(date){
    	 var date1=new Date(date);
    	 date1.setHours(0,0,0,0);
    	 var currentdate=new Date();
    	 currentdate.setHours(0,0,0,0);
    	 if(date1>currentdate){
    		 document.getElementById("errormsg").innerText="";
    		 document.getElementById("errormsg").innerText="Future Date Not Allowed";
    		 return false;
    	 }
    	 else{
    		 return true;
    	 }
     }
     
 
 	function checkfuturetime(date,time){
 		var date1=new Date(date);
 		var time1=new Date(time);
 		var currentdate = new Date(); 
 		var currenthours=currentdate.getHours();
 		var currentminutes=currentdate.getMinutes();
 		var time1hours=time1.getHours();
 		var time1minutes=time1.getMinutes();
 		date1.setHours(0,0,0,0);
 		currentdate.setHours(0,0,0,0);
 		if(date1-currentdate==0){
 			if(time1hours>currenthours){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Future Time Not Allowed";
 				return false;
 			}
 			else if(time1hours==currenthours){
 				if(time1minutes>currentminutes){
 					document.getElementById("errormsg").innerText="";
 					document.getElementById("errormsg").innerText="Future Time Not Allowed";
 					return false;
 				}
 			}
 		}
 		return true;
 	}
	 
     function checkfuturedate(){
 		var date1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
 		var futuredate=new Date();
 		date1.setHours(0,0,0,0);
 		futuredate.setHours(0,0,0,0);
 		if(date1>futuredate){
 				   document.getElementById("errormsg").innerText="";
 				   document.getElementById("errormsg").innerText="Future Date Cannot be applied";
 				   $('#dateout').jqxDateTimeInput('focus'); 
 				   return false;
 			   }
 	
 			 
 			   document.getElementById("errormsg").innerText="";
 			   //$('#timeout').jqxDateTimeInput('focus'); 
 			   return true;
 			  
 	}
     function checkStaff(){
    	 //alert("Inside Checking");
    	 $('#cmbstatus').prop('disabled',false);
    	// alert(document.getElementById("cmbstatus").value);
    	 var temp=document.getElementById("cmbstatus").value;
    	// $('#cmbstatus').prop('disabled',true);
    	 if(temp=="ST"){
    	// alert("Inside ST:"+temp+"-----");
    		 document.getElementById("garage").style.display="none";
    		 document.getElementById("staff").style.display="block";
    		// alert("After staff");
    		document.getElementById("driver").disabled=true;
    		document.getElementById("closedriver").disabled=true;
    		 document.getElementById("closestaff").disabled=false;
    		 $('#chkgaragedelivery').attr('disabled', true);
    		 $('#chkgaragecollect').attr('disabled', true); 
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="none";
        	 document.getElementById("collectionfield").style.display="none";
    		 
    	 }
    	 else if(temp=='GA'||temp=='GM'||temp=='GS'){
    		 document.getElementById("staff").style.display="none";
    		 document.getElementById("closestaff").disabled=true;

     		document.getElementById("driver").disabled=false;
     		document.getElementById("closedriver").disabled=false;
    		 document.getElementById("garage").style.display="block";
    		 $('#chkgaragedelivery').attr('disabled', false);
    		 $('#chkgaragecollect').attr('disabled', false);
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="block";
        	 document.getElementById("collectionfield").style.display="block";
    	 }
    	 else{
    		// document.getElementById("staff").style.display="block";
    		
    		document.getElementById("driver").disabled=false;
    		document.getElementById("closedriver").disabled=false;
    		 document.getElementById("closestaff").disabled=true;
    		 document.getElementById("garage").style.display="none";
    		 document.getElementById("staff").style.display="none";
    		 $('#chkgaragedelivery').attr('disabled', true);
    		 $('#chkgaragecollect').attr('disabled', true); 
    		 checkGarageDelivery();
    		 checkGarageCollection();
    		 document.getElementById("deliveryfield").style.display="none";
        	 document.getElementById("collectionfield").style.display="none";
    	 }
     /* 	 else{
    		 document.getElementById("staff").style.display="none";
    		 document.getElementById("garage").style.display="none";
    		 document.getElementById("closestaff").disabled=true;
    		 $('#chkgaragedelivery').attr('disabled', true);
    		 $('#chkgaragecollect').attr('disabled', true); 
    		 checkGarageDelivery();
    		 checkGarageCollection();
    	 }  */
    	// $('#cmbstatus').prop('disabled',true);
     }
     function fleetSearchContent(url) {
   	    //alert(url);
   	      $.get(url).done(function (data) {
   	//alert(data);
   	    $('#fleetwindow').jqxWindow('setContent', data);

   	}); 
   	}
     function driverSearchContent(url) {
    	    //alert(url);
    	      $.get(url).done(function (data) {
    	//alert(data);
    	    $('#driverwindow').jqxWindow('setContent', data);

    	}); 
    	}
     function staffSearchContent(url) {
 	    //alert(url);
 	      $.get(url).done(function (data) {
 	//alert(data);
 	    $('#staffwindow').jqxWindow('setContent', data);

 	}); 
 	}
     function garageSearchContent(url) {
  	    //alert(url);
  	      $.get(url).done(function (data) {
  	//alert(data);
  	    $('#garagewindow').jqxWindow('setContent', data);

  	}); 
  	}
     function maintenanceSearchContent(url) {
    	    //alert(url);
    	      $.get(url).done(function (data) {
    	//alert(data);
    	    $('#maintenancewindow').jqxWindow('setContent', data);

    	}); 
    	}
     function getFleet(event){
   	   	//alert("Here");
         var x= event.keyCode;
         if(document.getElementById("mode").value=="A"){
         if(x==114){
       	   $('#fleetwindow').jqxWindow('open');
      		$('#fleetwindow').jqxWindow('focus');
      		 fleetSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
         }
         else{
          }
         }
         }
     function getGarage(event){
          
    	 var x= event.keyCode;
    	 if(document.getElementById("mode").value=="A"){
    	 if(x==114){
        	  $('#garagewindow').jqxWindow('open');
      		$('#garagewindow').jqxWindow('focus');
      		 garageSearchContent('garageSearch.jsp?', $('#garagewindow'));
          }
          else{
           }
    	 }
          }
     function getDriver(event,value){   
    	var aa=value;
         var x= event.keyCode;
         
         if(x==114){
       if(aa==1){
    	   if(document.getElementById("mode").value=="A"){
    		   if(document.getElementById("cmbstatus").value==""){
    			   document.getElementById("errormsg").innerText="";
    			   document.getElementById("errormsg").innerText="Please Select Movement Type";
    			   document.getElementById("cmbstatus").focus();
    			   return false;
    		   }
 $('#driverwindow').jqxWindow('open');
      		$('#driverwindow').jqxWindow('focus');
      		 driverSearchContent('driverSearch.jsp?id=1&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
    	   }
    	   }
       else if(aa==2){
    	   if(document.getElementById("mode").value=="close"){
    		   
    		   $('#driverwindow').jqxWindow('open');
      		$('#driverwindow').jqxWindow('focus');
      		 driverSearchContent('driverSearch.jsp?id=2&trancode='+document.getElementById("cmbstatus").value, $('#driverwindow'));
    	   }
       }
       else{
    	   
       }
         }
         else{
          }
        
         }
     function getStaff(event,value){   
     	var aa=value;
          var x= event.keyCode;
          if(document.getElementById("mode").value=="A"){
          if(x==114){
        if(aa==1){
     	   
        
        	   $('#staffwindow').jqxWindow('open');
       		$('#staffwindow').jqxWindow('focus');
       		 staffSearchContent('staffSearch.jsp?id=1', $('#staffwindow'));
        }
        else if(aa==2){

        	   $('#staffwindow').jqxWindow('open');
       		$('#staffwindow').jqxWindow('focus');
       		 satffSearchContent('staffSearch.jsp?id=2', $('#staffwindow'));
       
        }
        else{
     	   
        }
          }
          else{
           }
          }
          }
    function funReset(){
  		//$('#frmMovement')[0].reset(); 
  	}
  	function funReadOnly(){
  		
  		$('#frmMovement input').attr('readonly', true );
  		$('#frmMovement select').attr('disabled', true);
  		$('#frmMovement checkbox').attr('disabled', true);
  		$('#frmMovement textarea').attr('readonly', true );
  		if($('#date').jqxDateTimeInput('disabled')==false){
  			$('#date').jqxDateTimeInput({ disabled: true});
  		}
  		
  		if($('#dateout').jqxDateTimeInput('disabled')==false){
  			$('#dateout').jqxDateTimeInput({ disabled: true});	
  		}
  		
  /* 		$('#garagedeldate').jqxDateTimeInput({ disabled: true});
  		$('#garagedeliverytime').jqxDateTimeInput({ disabled: true});
  		$('#garagecollectdate').jqxDateTimeInput({ disabled: true});
  		$('#garagecollecttime').jqxDateTimeInput({ disabled: true}); */
		if($('#closedate').jqxDateTimeInput('disabled')==false){
			$('#closedate').jqxDateTimeInput({ disabled: true});
		}
  		//$('#accdate').jqxDateTimeInput({ disabled: true});
  		//$('#collectdate').jqxDateTimeInput({ disabled: true});
  		if($('#timeout').jqxDateTimeInput('disabled')==false){
  			$('#timeout').jqxDateTimeInput({ disabled: true});
  		}
  		if($('#closetime').jqxDateTimeInput('disabled')==false){
  			$('#closetime').jqxDateTimeInput({ disabled: true});
  		}
  		
  //	checkGarageDelivery();
  	
   	checkStaff();
  	}
  	function funRemoveReadOnly(){
  	 	$('#frmMovement input').attr('readonly', false );
  		$('#frmMovement select').attr('disabled', false);
  		$('#frmMovement textarea').attr('readonly', false );
  		$('#frmMovement checkbox').attr('disabled', false);
  		$('#date').jqxDateTimeInput({ disabled: false});
  		$('#dateout').jqxDateTimeInput({ disabled: false});
  		/*  */
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		//$('#accdate').jqxDateTimeInput({ disabled: false});
  		//$('#collectdate').jqxDateTimeInput({ disabled: false});
  		$('#timeout').jqxDateTimeInput({ disabled: false});
  		
  		$('#closetime').jqxDateTimeInput({ disabled: false});
  		//$('#acctime').jqxDateTimeInput({ disabled: false});
  		//$("#jqxMaintenances").jqxGrid({ disabled: false});
  		//$("#jqxMovement").jqxGrid({ disabled: false});
  		$('#docno').attr('readonly', true); 
  		var session1='<%=session.getAttribute("USERNAME").toString()%>';
  		var session2='<%=session.getAttribute("USERID").toString()%>';
  		//alert("SESSION"+session1);
  		$('#outuser').val(session1);
  		$('#outuserid').val(session2);
  		$('#txtfleetno').attr('readonly', true );
  		$('#txtfleetname').attr('readonly', true );
  		$('#staff').attr('readonly', true );
  		$('#garage').attr('readonly', true );
  		$('#driver').attr('readonly', true );
  		$('#driver').attr('readonly', true );
  		$('#outuser').attr('readonly', true );
  		$('#closestaff').attr('readonly', true );
  		$('#closeuser').attr('readonly', true );
  		$('#totalkm').attr('readonly', true );
  		getTestLocation();
  		/* $('#garagedeliverykm').prop('disabled', true);
  		$('#cmbgaragedeliveryfuel').prop('disabled', true);
  		$('#garagecollectkm').prop('disabled', true);
  		$('#cmbgaragecollectfuel').prop('disabled', true); */
  		
  	if(document.getElementById("mode").value=="A" && document.getElementById("chkstatus").value!="1"){
  		
  		$('#date').jqxDateTimeInput({ value: new Date()});
  		$('#dateout').jqxDateTimeInput({ value: null});
  		$('#timeout').jqxDateTimeInput({ value:null});
  		$('#garagedeldate').jqxDateTimeInput({ value: null});
  		$('#garagedeliverytime').jqxDateTimeInput({ value: null});
  		$('#garagecollectdate').jqxDateTimeInput({ value:null});
  		$('#garagecollecttime').jqxDateTimeInput({ value: null});
  		$('#closedate').jqxDateTimeInput({ value:null});
  		$('#closetime').jqxDateTimeInput({ value: null}); 
  		document.getElementById("btnclose").style.display="block";
  		document.getElementById("accfines").value="0.0";
  		$('#outuser').val('');
  		document.getElementById("btndeliverysave").style.display="none";
  		document.getElementById("btndeliveryupdate").style.display="block";
  		document.getElementById("btndeliveryupdate").disabled=true;
 	  	$('#cmbcloselocation').attr('disabled',true);$('#cmbclosebranch').attr('disabled',true);
		$('#closedate').jqxDateTimeInput({ disabled: true});
		$('#closetime').jqxDateTimeInput({ disabled: true});
		$('#closekm').attr('disabled',true);
		$('#cmbclosefuel').attr('disabled',true);
		$('#closedriver').attr('disabled',true);
		$('#closestaff').attr('disabled',true);
		$('#cmbaccidents').attr('disabled',true);
		$('#accdetails').attr('disabled',true);
		$('#accfines').attr('disabled',true);
		$('#closeuser').attr('disabled',true);
		$('#totalkm').attr('disabled',true);
		$('#remarks').attr('disabled',true);
  		
  	}
   	 getAccidents();
   	checkStaff();
   
  	}
  	
  	function funenable(){
  		//alert("Inside Enable");
  		$('#frmMovement input').attr('disabled', false );
  		$('#frmMovement select').attr('disabled', false);
  		$('#frmMovement textarea').attr('disabled', false );
  		$('#frmMovement checkbox').attr('disabled', false);
  		$('#date').jqxDateTimeInput({ disabled: false});
  		$('#dateout').jqxDateTimeInput({ disabled: false});
  		$('#timeout').jqxDateTimeInput({ disabled: false});
  		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
  		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
  		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
  		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		$('#closetime').jqxDateTimeInput({ disabled: false});

  	}
  	function getLocation(value) {
  		//alert(value);
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsloc);
				//$("select#cmbcloselocation").html(optionsloc);
				if ($('#hidcmblocation').val() != null) {
					$('#cmblocation').val($('#hidcmblocation').val());
				}
				/* if ($('#hidcmbcloselocation').val() != null) {
					$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
				} */
			} else {
			}
		}
		x.open("GET", "getLocation.jsp?branch="+value, true);
		x.send();
	}
  	
	function getCloseLocation(value) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				//$("select#cmblocation").html(optionsloc);
				$("select#cmbcloselocation").html(optionsloc);
				/* if ($('#hidcmblocation').val() != null) {
					$('#cmblocation').val($('#hidcmblocation').val());
				} */
				if ($('#hidcmbcloselocation').val() != null) {
					$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
				}
			} else {
			}
		}
		x.open("GET", "getLocation.jsp?branch="+value+"", true);
		x.send();
	}
  	
  	function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsloc);
				$("select#cmbclosebranch").html(optionsloc);
				if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				}
				if ($('#hidcmbclosebranch').val() != null) {
					$('#cmbclosebranch').val($('#hidcmbclosebranch').val());
				}
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
  	function getTestLocation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				//alert(items);
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmblocation").html(optionsloc);
				$("select#cmbcloselocation").html(optionsloc);
				/* if ($('#hidcmblocation').val() != null) {
					$('#cmblocation').val($('#hidcmblocation').val());
				}
				if ($('#hidcmbcloselocation').val() != null) {
					$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
				} */
			} else {
			}
		}
		x.open("GET", "getTestLocation.jsp", true);
		x.send();
	}
  	function getStatus() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var statusItems = items[0].split(",");
				var statusIdItems = items[1].split(",");
				var optionsstatus = '<option value="">--Select--</option>';
				for (var i = 0; i < statusItems.length; i++) {
					optionsstatus += '<option value="' + statusIdItems[i] + '">'
							+ statusItems[i] + '</option>';
				}
				$("select#cmbstatus").html(optionsstatus);
				
				if ($('#hidcmbstatus').val() != null) {
					$('#cmbstatus').val($('#hidcmbstatus').val());
				}
				
			} else {
			}
		}
		x.open("GET", "getStatus.jsp", true);
		x.send();
	}

  	
  	function funNotify(){
  		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
  		if($('#dateout').jqxDateTimeInput('getDate')==null){
  			document.getElementById("errormsg").innerText="";
  			document.getElementById("errormsg").innerText="Out Date is Mandatory";
  			$('#dateout').jqxDateTimeInput('focus'); 
	  			return 0;	
  		}
  		if($('#timeout').jqxDateTimeInput('getDate')==null){
  			document.getElementById("errormsg").innerText="";
  			document.getElementById("errormsg").innerText="Out Time is Mandatory";
  			$('#timeout').jqxDateTimeInput('focus');
  			return 0;	
  		}
  	 	var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
  	 	var timeout1=$('#timeout').jqxDateTimeInput('getDate');
  		var dateouthidden1=new Date($('#dateouthidden').jqxDateTimeInput('getDate'));
  		var timeouthidden1=$('#timeouthidden').jqxDateTimeInput('getDate');
  		var tempstatus=document.getElementById("cmbstatus").value;
  		//alert(timeout1+"::"+timeouthidden1);
  		//alert("Date Out:"+dateout1);
  		
  		dateout1.setHours(0,0,0,0);
  		dateouthidden1.setHours(0,0,0,0);
  		if(document.getElementById("txtfleetno").value==''){
  			document.getElementById("errormsg").innerText="";
  			document.getElementById("errormsg").innerText="Fleet is Mandatory";
  			document.getElementById("txtfleetno").focus();
  			return 0;
  		}
  		else{
  			document.getElementById("errormsg").innerText="";
  		}
  		//alert("Date Out:"+dateout1);
  		//alert("Date OutHidden:"+dateouthidden1);
  		
  		if(dateout1<dateouthidden1){
  			//alert("Date Out:"+dateout1+" In Date:"+dateouthidden1);
  			document.getElementById("errormsg").innerText="";
  			document.getElementById("errormsg").innerText="Date Should Not be Less than In Date";
  			$('#dateout').jqxDateTimeInput('focus'); 
  	  			return 0;	
  			
  		}
  		if(dateout1-dateouthidden1==0){
				
	  			if(timeout1.getHours() < timeouthidden1.getHours()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Time Should Not be Less than In Time";
	  				$('#timeout').jqxDateTimeInput('focus'); 
	  				return 0;
	  			}
	  			if(timeout1.getHours() == timeouthidden1.getHours()){
	  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Time Should Not be Less than In Time";
	  				$('#timeout').jqxDateTimeInput('focus');
	  				return 0;
	  			}
	  			}
	  			
	  			else{
	  				document.getElementById("errormsg").innerText="";
	  			}
	  		}
  		else{
  			document.getElementById("errormsg").innerText="";
  		}
  		//alert("Outer");
  		var x=checkfuturedate();
  		//alert(x);
  		if(x==false){
  			return 0;
  		}
  		//alert(!(dateout1!=dateouthidden1));
  		
  		if((tempstatus=='GA')||(tempstatus=='GM')||tempstatus=='GS'){
  			if(document.getElementById("garage").value==''){
  				document.getElementById("errormsg").innerText="Garage is Mandatory";
  				document.getElementById("garage").focus();
  				return 0;
  			}
  			else{
  				document.getElementById("errormsg").innerText="";
  			}
  			if(document.getElementById("driver").value==''){
  				document.getElementById("errormsg").innerText="";
  				document.getElementById("errormsg").innerText="Driver is Mandatory";
  				document.getElementById("driver").focus();
  				return 0;
  			}
  			else{
  				document.getElementById("errormsg").innerText="";
  			}
  			document.getElementById("chkgaragedelivery").checked=true;
  			checkGarageDelivery();
  		}
  		else if(tempstatus=='ST'){
  			if(document.getElementById("staff").value==''){
  				document.getElementById("errormsg").innerText="";
  				document.getElementById("errormsg").innerText="Staff is Mandatory";
  				document.getElementById("staff").focus();
  				return 0;
  			}
  			else{
  				document.getElementById("errormsg").innerText="";
  			}
  			document.getElementById("chkgaragedelivery").checked=false;
  			checkGarageDelivery();
  		}
  		else{
  			if(document.getElementById("driver").value==''){
  				document.getElementById("errormsg").innerText="";
  				document.getElementById("errormsg").innerText="Driver is Mandatory";
  				document.getElementById("driver").focus();
  				return 0;
  			}
  			else{
  				document.getElementById("errormsg").innerText="";
  			}
  			document.getElementById("chkgaragedelivery").checked=false;
  			checkGarageDelivery();
  		}
  		checkavailability('add');
 	} 

		
  	
  	function checkavailability(mode){
		var valfleet=document.getElementById("txtfleetno").value;
		if(mode=="add"){
			var dateout=$('#dateout').jqxDateTimeInput('val');
			var timeout=$('#timeout').jqxDateTimeInput('val');
			
		}
		else{
			var dateout=$('#closedate').jqxDateTimeInput('val');
			var timeout=$('#closetime').jqxDateTimeInput('val');

		}
		  var x=new XMLHttpRequest();
		    x.onreadystatechange=function(){
		    if (x.readyState==4 && x.status==200)
		     {
		     
		           
		      var items=x.responseText;
		    var chkfleet=items.trim();
		       if(chkfleet=="1")
		        {
		    	  // alert("inside 0");
		        $.messager.alert('Message','Fleet Is Not Available ','warning');   
		        return false;
		        }
		       else
		        {
		    	   // alert("inside 1");
		    	   $('#cmboutfuel').prop("disabled", false);
  		$('#outkm').prop("disabled", false);
  		$('#cmblocation').prop("disabled", false);
  		$('#cmbbranch').prop("disabled", false);
		    	 
		    		 funSetlabel();
					   $("#overlay, #PleaseWait").show();
					$('#frmMovement').submit();
					$('#cmboutfuel').prop("disabled", true);
			  		$('#outkm').prop("disabled", true);
			  		$('#cmblocation').prop("disabled", true);
			  		$('#cmbbranch').prop("disabled", true);
			  		$('#cmbstatus').prop("disabled", true);
					
		        }
		    
		      
		      }
		    
		    }
		     
		   x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout+"&mode="+mode,true);

		   x.send();
		     
		   
	}
	
 	function funChkButton() {
		/* funReset(); */
	}

	function funSearchLoad(){
		//alert(document.getElementById("mode").value);
		 changeContent('mainSearch.jsp', $('#window')); 
	}
		
 	function funFocus(){
	   	$('#date').jqxDateTimeInput('focus'); 	    		
 	}
 	function setValues(){
 		funSetlabel();
 		getTestLocation();
 		//getLocation(document.getElementById("cmb"));
 		getStatus();
 		$('#date').jqxDateTimeInput({ disabled: false});
 	//	$('#dateout').jqxDateTimeInput({ disabled: false});
 		$('#timeout').jqxDateTimeInput({ disabled: false});
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
 		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
 		$('#closedate').jqxDateTimeInput({ disabled: false});
 		$('#closetime').jqxDateTimeInput({ disabled: false});
 		$('#frmMovement select').attr('disabled',false);
 		
 		//date and time setting
 	 	if($('#hidtimeout').val()){
			$("#timeout").jqxDateTimeInput('val', $('#hidtimeout').val());
		}
 		//alert("Hid Delivery:"+$('#hiddelivery').jqxDateTimeInput('getDate'));
 	 	/* if($('#hiddelivery').jqxDateTimeInput('getDate')!=null ){
 	 		$("#garagedeldate").jqxDateTimeInput('val', $('#hiddelivery').jqxDateTimeInput('val'));
 	 	}
 	 	if($('#hidcollect').jqxDateTimeInput('val')!=null){
 	 		$("#garagecollectdate").jqxDateTimeInput('val', $('#hidcollect').jqxDateTimeInput('val'));
 	 	} */
 		if($('#hidgaragedeliverytime').val()){
			$("#garagedeliverytime").jqxDateTimeInput('val', $('#hidgaragedeliverytime').val());
		}
 		
 		if($('#hidgaragecollecttime').val()){
			$("#garagecollecttime").jqxDateTimeInput('val', $('#hidgaragecollecttime').val());
		}
 		
 		if($('#hidclosetime').val()){
			$("#closetime").jqxDateTimeInput('val', $('#hidclosetime').val());
		} 
 		 
 		//setting combo box
 		
 		if ($('#hidcmbstatus').val() != null) {
			$('#cmbstatus').val($('#hidcmbstatus').val());
		}
 		
 		
 		if ($('#hidcmbbranch').val() != null) {
			$('#cmbbranch').val($('#hidcmbbranch').val());
		}
 		
 		getLocation($('#hidcmbbranch').val());
 		
 		if ($('#hidcmboutfuel').val() != null) {
			$('#cmboutfuel').val($('#hidcmboutfuel').val());
		}
 		if ($('#hidcmbgaragedeliveryfuel').val() != null) {
			$('#cmbgaragedeliveryfuel').val($('#hidcmbgaragedeliveryfuel').val());
		}
 		
 		if ($('#hidcmbgaragecollectfuel').val() != null) {
			$('#cmbgaragecollectfuel').val($('#hidcmbgaragecollectfuel').val());
		}
 		
 		
 		if ($('#hidcmbclosebranch').val() != null) {
			$('#cmbclosebranch').val($('#hidcmbclosebranch').val());
		}
 		getCloseLocation($('#hidcmbclosebranch').val());
 		if ($('#hidcmbcloselocation').val() != null) {
			$('#cmbcloselocation').val($('#hidcmbcloselocation').val());
		}
 		if ($('#hidcmbclosefuel').val() != null) {
			$('#cmbclosefuel').val($('#hidcmbclosefuel').val());
		}
 		if ($('#hidcmbaccidents').val() != null) {
			$('#cmbaccidents').val($('#hidcmbaccidents').val());
		}
 		if($('#hidcmbstatus').val()=='ST'){
 			document.getElementById("staff").style.display="block";
 			document.getElementById("garage").style.display="none";
 		}
 		if(($('#hidcmbstatus').val()=='GA')||($('#hidcmbstatus').val()=='GM')||($('#hidcmbstatus').val()=='GS')){
 			document.getElementById("staff").style.display="none";
 			document.getElementById("garage").style.display="block";
 		}
 		if(document.getElementById("staff").value!=''){
 			if(document.getElementById("closekm").value>0){
 		 		$('#closestaff').attr('disabled',false);
 	 			document.getElementById("closestaff").value=document.getElementById("staff").value;
 	 			$('#closestaff').attr('disabled',true);
 			}
 	
 		}
 		
 		 if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
 		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
 		 if($('#date').jqxDateTimeInput('disabled')==false){
 			$('#date').jqxDateTimeInput({ disabled: true});
 		 }
 		 if($('#dateout').jqxDateTimeInput('disabled')==false){
 			$('#dateout').jqxDateTimeInput({ disabled: true});	 
 		 }
 		if($('#timeout').jqxDateTimeInput('disabled')==false){
 			$('#timeout').jqxDateTimeInput({ disabled: true});
 		}
 		if($('#garagedeldate').jqxDateTimeInput('disabled')==false){
 			$('#garagedeldate').jqxDateTimeInput({ disabled: true});
 		}
 		if($('#garagedeliverytime').jqxDateTimeInput('disabled')==false){
 			$('#garagedeliverytime').jqxDateTimeInput({ disabled: true});	
 		}
 		if($('#garagecollectdate').jqxDateTimeInput('disabled')==false){
 			$('#garagecollectdate').jqxDateTimeInput({ disabled: true});	
 		}
 		if($('#garagecollecttime').jqxDateTimeInput('disabled')==false){
 			$('#garagecollecttime').jqxDateTimeInput({ disabled: true});	
 		}
 		if($('#closedate').jqxDateTimeInput('disabled')==false){
 			$('#closedate').jqxDateTimeInput({ disabled: true});	
 		}
 		if($('#closetime').jqxDateTimeInput('disabled')==false){
 			$('#closetime').jqxDateTimeInput({ disabled: true});	
 		}
 		
 		$('#frmMovement select').attr('disabled',true);
 		if(document.getElementById("movtempstatus").value=="OUT"){
 			document.getElementById("btnclose").style.display="block";
 			$('#btnclose').attr('disabled',false);
 		}
 		else{
 			document.getElementById("btnclose").style.display="block";
 			$('#btnclose').attr('disabled',true);
 			$('#btndeliveryupdate').attr('disabled',true);
 		}
 		$('#cmbstatus').prop('disabled',false);
 		//alert($('#hidcmbstatus').val());
 		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
 			document.getElementById("deliveryfield").style.display="block";
 	    	 document.getElementById("collectionfield").style.display="block";
 		}
 		else{
 			document.getElementById("deliveryfield").style.display="none";
 	    	 document.getElementById("collectionfield").style.display="none";
 		}
 		$('#cmbstatus').prop('disabled',true);
 	 if(document.getElementById("deliverystatus").value=="1"){
 		document.getElementById("btndeliveryupdate").disabled=true;
 	}	
 	else{
 		document.getElementById("btndeliveryupdate").disabled=false;
 	} 
	
	 
 	if ($('#hidcmblocation').val() != null || $('#hidcmblocation').val()!="") {
		$('#cmblocation').val($('#hidcmblocation').val());
	}
 	}
 
 	function getTotalkm(){
 		var km1=document.getElementById("outkm").value;
 		var km2=document.getElementById("closekm").value;
 		var totkm=km2-km1;
 		document.getElementById("totalkm").value=totkm;
 	}
 	function closeMov(){
 	//alert("Here");
 	if(document.getElementById("deliverystatus").value=="0" && ($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM")){
 		document.getElementById("errormsg").innerText="";
 		document.getElementById("errormsg").innerText="Please Update Delivery Info";
 		return false;
 	}
 	
	$('#cmbcloselocation').attr('disabled', false);
	$('#cmbclosebranch').attr('disabled', false);
 		checkStaff();
	$('#date').jqxDateTimeInput({ disabled: false});
	if($('#dateout').jqxDateTimeInput('disabled')==false){
		$('#dateout').jqxDateTimeInput({ disabled: false});
	}
	if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
		document.getElementById("chkgaragecollect").checked=true;
		checkGarageCollection();
	}
	else{
		document.getElementById("chkgaragecollect").checked=false;
		checkGarageCollection();
	}
	
/* 	$('#garagedeldate').jqxDateTimeInput({ disabled: false});
	$('#garagecollectdate').jqxDateTimeInput({ disabled: false}); */
	
  		$('#closedate').jqxDateTimeInput({ disabled: false});
  		$('#closetime').jqxDateTimeInput({ disabled: false});
  		$('#cmbclosefuel').attr('disabled', false);
  		$('#closekm').attr('readonly', false);
  		$('#closedriver').attr('readonly', true);
  		$('#closeremarks').attr('readonly', false);
  		$('#closeuser').attr('readonly', true);
  		$('#totalkm').attr('readonly', true);
  		document.getElementById("btnclose").style.display="none";
  		document.getElementById("btnclosesave").style.display="block";
  		//document.getElementById("cmbcloselocation").focus();
  		$('#cmbaccidents').attr('disabled', false);
  		//document.getElementById("closeuser").value=document.getElementById("outuser").value;
  		//document.getElementById("hidcloseuser").value=document.getElementById("outuserid").value;
  		//alert($('#hidcmbstatus').val());
  		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
  			document.getElementById("closedriver").value="";
  	  		document.getElementById("hidclosedriver").value="";
  	  	$('#garagecollectdate').jqxDateTimeInput('focus');
  		}
  		else{
  			document.getElementById("closedriver").value=document.getElementById("driver").value;
  	  		document.getElementById("hidclosedriver").value=document.getElementById("hiddriver").value;	
  	  	document.getElementById("cmbclosebranch").focus();
  		}
  		
  		document.getElementById("closestaff").value=document.getElementById("staff").value;
  		document.getElementById("hidclosestaff").value=document.getElementById("hidstaff").value;
  		document.getElementById("mode").value="close";
 	}
 	function closeSave(){
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		if($('#closedate').jqxDateTimeInput('getDate')==null){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Close Date is Mandatory";
				$('#closedate').jqxDateTimeInput('focus'); 
				return false;
			}
 		
 		var closedateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(closedateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
			
		}
 		if($('#closetime').jqxDateTimeInput('getDate')==null){
 	 	 		document.getElementById("errormsg").innerText="";
 	 	 		document.getElementById("errormsg").innerText="Close Time is Mandatory";
 	 	 		$('#closetime').jqxDateTimeInput('focus'); 
 	 	 		return false;
 		}
 		var tempindate=new Date($('#dateout').jqxDateTimeInput('getDate'));
 		tempindate.setHours(0,0,0,0);
 		var tempintime=$('#timeout').jqxDateTimeInput('getDate');													// first date n time 
 		var tempcollectdate=new Date($('#garagecollectdate').jqxDateTimeInput('getDate'));
 		var tempcollecttime=$('#garagecollecttime').jqxDateTimeInput('getDate');
 		var tempoutdate=new Date($('#garagedeldate').jqxDateTimeInput('getDate'));								// deleivery
 		var tempouttime=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		
 		var tempclosedate=new Date($('#closedate').jqxDateTimeInput('getDate'));									// close
 		tempclosedate.setHours(0,0,0,0);
 		var tempclosetime=$('#closetime').jqxDateTimeInput('getDate');
 	 	$('#outkm').prop('disabled',false);
 		var tempoutkm=parseFloat($('#outkm').val());
 		$('#outkm').prop('disabled',true);
 		
 		/* if($('#cmbstatus').val()=='TR' || $('#cmbstatus').val()=='ST'){ */
 			var closekm=parseFloat($('#closekm').val());	
 			var closefuel=$('#cmbclosefuel').val();
 			//alert(tempclosedate+"::::::::"+tempindate);
 			
 			if(tempclosedate<tempindate){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Close Date cannot be less than Out Date";
 				$('#closedate').jqxDateTimeInput('focus'); 
 				return false;
 			}
 			
 			else if(tempclosedate-tempindate==0){
 				
 				if(tempclosetime.getHours()<tempintime.getHours()){
 					document.getElementById("errormsg").innerText="";
 					document.getElementById("errormsg").innerText="Close Time cannot be less than Out Time";
 					$('#closetime').jqxDateTimeInput('focus'); 
 					return false;
 				}
 				else if(tempclosetime.getHours()==tempintime.getHours()){
 				
 					if(tempclosetime.getMinutes()<tempintime.getMinutes()){
 						document.getElementById("errormsg").innerText="";
 						document.getElementById("errormsg").innerText="Close Time cannot be less than Out Time";
 						$('#closetime').jqxDateTimeInput('focus'); 
 						return false;
 					}
 					else{
 						document.getElementById("errormsg").innerText="";
 					}
 				}
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			if(closekm==''||closekm==0.0){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Close Km Cannot be less than Out Km";
 				document.getElementById("closekm").focus();
 				return false;
 			}
 			else if(closekm<tempoutkm){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Close km cannot be less than Out km";
 				document.getElementById("closekm").focus();
 				return false;
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			if(document.getElementById("cmbclosefuel").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Please select Close Fuel";
 				document.getElementById("cmbclosefuel").focus();
 				return false;
 			}
 			document.getElementById("errormsg").value="";
 		/* } */
 
 		/** Collection validation starts */
 		
 		if(document.getElementById("chkgaragecollect").checked==true){
 			tempcollectdate.setHours(0,0,0,0);
 			tempoutdate.setHours(0,0,0,0);
 			tempoutkm=parseFloat($('#garagedeliverykm').val());
 			if($('#garagecollectdate').jqxDateTimeInput('getDate')==null){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Collection Date is Mandatory";
 				$('#garagecollectdate').jqxDateTimeInput('focus'); 
 				return false;
 			}
 			
 			var collectdateval=funDateInPeriod($('#garagecollectdate').jqxDateTimeInput('getDate'));
 			if(collectdateval==0){
 				$('#garagecollectdate').jqxDateTimeInput('focus');
 				return false;
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			if($('#garagecollecttime').jqxDateTimeInput('getDate')==null){
 				
 		 	 		document.getElementById("errormsg").innerText="";
 		 	 		document.getElementById("errormsg").innerText="Collection Time is Mandatory";
 		 	 		$('#garagecollecttime').jqxDateTimeInput('focus'); 
 		 	 		return false;
 		 	 	
 			}
 			if(document.getElementById("cmbgaragecollectfuel").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Collection Fuel is Mandatory";
 				document.getElementById("cmbgaragecollectfuel").focus();
 				return false;
 			}
 			if(tempcollectdate<tempoutdate){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Collection Date should Not be Less than Delivery Date";
 				$('#garagecollectdate').jqxDateTimeInput('focus');
 				return false;
 			}  
 			
 			if(tempcollectdate-tempoutdate==0){
 				if(tempcollecttime.getHours() < tempouttime.getHours()){
 					document.getElementById("errormsg").innerText="";
 					document.getElementById("errormsg").innerText="Collection Time should Not be Less than Delivery Time";
 					$('#garagecollecttime').jqxDateTimeInput('focus');
 					return false;
 				}
 				else if(tempcollecttime.getHours()==tempouttime.getHours()){
 					if(tempcollecttime.getMinutes()<tempouttime.getMinutes()){
 						document.getElementById("errormsg").innerText="";
 	 					document.getElementById("errormsg").innerText="Collection Time should Not be Less than Delivery Time";
 	 					$('#garagecollecttime').jqxDateTimeInput('focus');
 	 					return false;
 	 				}
 				}
 				
 				
 				else{
 					document.getElementById("errormsg").innerText="";
 				}
 			}
 			
 			if((document.getElementById("garagecollectkm").value=='')||parseFloat((document.getElementById("garagecollectkm").value)==0.0)){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Collection KM should not be Empty";
 				document.getElementById("garagecollectkm").focus();
 				return false;
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			if(parseFloat(document.getElementById("garagecollectkm").value)<tempoutkm){
 				//alert("Collectkm:"+document.getElementById("garagecollectkm").value+"Out KM:"+tempoutkm);
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Collection KM should not be less than Delivery KM";
 				document.getElementById("garagecollectkm").focus();
 				return false;
 			}
 			else{
 				document.getElementById("errormsg").innerText="";
 			}
 			//alert("Here Inside");
 			if(tempclosedate<tempcollectdate){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Close Date Cannot be less than Collection Date";
 				$('#closedate').jqxDateTimeInput('focus');
 				return false;
 			}
 			if(tempclosedate-tempcollectdate==0){
 				if(tempclosetime.getHours()<tempcollecttime.getHours()){
 					document.getElementById("errormsg").innerText="";
 					document.getElementById("errormsg").innerText="Close Time cannot be less than Collection Time";
 					$('#closetime').jqxDateTimeInput('focus');
 					return false;
 				}
 				if(tempclosetime.getHours()==tempcollecttime.getHours()){
 					if(tempclosetime.getMinutes()<tempcollecttime.getMinutes()){
 						document.getElementById("errormsg").innerText="";
 	 					document.getElementById("errormsg").innerText="Close Time cannot be less than Collection Time";
 	 					$('#closetime').jqxDateTimeInput('focus');
 	 					return false;	
 					}
 				}
 			}
 			if(parseFloat(document.getElementById("closekm").value)<parseFloat(document.getElementById("garagecollectkm").value)){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Close Km Cannot be less than Collection Km";
 				document.getElementById("closekm").focus();
 				return false;
 			}
 	}
 		
 		/** Collection validation finish */
 		
 		if(document.getElementById("totalkm").value=='' || parseFloat(document.getElementById("totalkm").value)==0.0){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Close KM must be greater than Out KM";
 			document.getElementById("closekm").focus();
 			return false;
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		if(parseFloat(document.getElementById("totalkm").value)<0){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Please enter valid KM";
 			document.getElementById("closekm").focus();
 			return false;
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		if(document.getElementById("cmbclosebranch").value==''){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Close Branch is Mandatory";
 			document.getElementById("cmbclosebranch").focus();
 			return false;
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		if(document.getElementById("cmbcloselocation").value==''){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Close Location is Mandatory";
 			document.getElementById("cmbcloselocation").focus();
 			return false;
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
		if(document.getElementById("closekm").value=="" || parseFloat(document.getElementById("closekm").value)==0.0){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Close KM must be greater than Out KM";
			document.getElementById("closekm").focus();
			return false;
		}
		else{
 			document.getElementById("errormsg").innerText="";
 		}
		if(parseFloat(document.getElementById("closekm").value)<parseFloat(document.getElementById("outkm").value)){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Close Km cannot be less than out km";
			document.getElementById("closekm").focus();
			return false;
		}
		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		if(document.getElementById("cmbclosefuel").value==""){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Close Fuel is Mandatory";
 			document.getElementById("cmbclosefuel").focus();
 			return false;
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		if($('#hidcmbstatus').val()=="GA" || $('#hidcmbstatus').val()=="GS" || $('#hidcmbstatus').val()=="GM"){
 		if(document.getElementById("closedriver").value==""){
 			document.getElementById("errormsg").innerText="";
 			document.getElementById("errormsg").innerText="Close Driver is Mandatory";
 			document.getElementById("closedriver").focus();
 			return false;
 		}
 		}
 		$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		
 		funenable();
 		//alert($('#closedate').jqxDateTimeInput('getDate'));
 		$.messager.confirm('Confirm', 'Closing KM: '+$('#closekm').val()+' Driven KM: '+$('#totalkm').val(), function(r){
		if (r){
			 checkavailability('close');
			//$('#garagecollectdate').jqxDateTimeInput({ disabled: true});
	 		//$('#garagedeldate').jqxDateTimeInput({ disabled: true});
		}
 		});
 		//document.getElementById("frmMovement").submit();
 		

 		
 	}
 	function getAccidents(){
 		$('#cmbaccidents').prop('disabled', false );
 		if(document.getElementById("cmbaccidents").value==1){
 			document.getElementById("hidaccidents").value=1;
 			$('#accdetails').prop('disabled', false );
 			$('#accfines').prop('disabled', false );
 			$('#accdetails').prop('readonly', false );
 			$('#accfines').prop('readonly', false );
 		}
 		else{
 			document.getElementById("hidaccidents").value=0;
 			$('#accdetails').prop('disabled', true );
 			$('#accfines').prop('disabled', true );
 			
 		}
 		//$('#cmbaccidents').prop('disabled', true );
 	}
 	function checkGarageDelivery(){
 		//alert("here");
 		if(document.getElementById("chkgaragedelivery").checked==true){
 			//alert("Inside Garage Delivery");
 			document.getElementById("hidchkgaragedelivery").value="1";
 		 	//$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		 	if(document.getElementById("mode").value!="A"){
    		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
    		$('#garagedeliverykm').prop('disabled', false );
    		$('#garagedeliverykm').prop('readonly', false );
    		$('#cmbgaragedeliveryfuel').prop('disabled', false );
 		 	}
    		//$('#btndeliveryupdate').prop('disabled', false );
 			//disableGarage2();
 		}
 		if(document.getElementById("chkgaragedelivery").checked==false){
 			document.getElementById("hidchkgaragedelivery").value="0";
 			//$('#garagedeldate').jqxDateTimeInput({ disabled: true});
 			if(document.getElementById("mode").value!="A"){
 				if($('#garagedeliverytime').jqxDateTimeInput('disabled')==false){
 					$('#garagedeliverytime').jqxDateTimeInput({ disabled: true});		
 				}
 				
    		
    		
    		$('#garagedeliverykm').prop('disabled', true );
    		$('#cmbgaragedeliveryfuel').prop('disabled', true );
    		$('#btndeliveryupdate').prop('disabled', true );
 			}
 		}
 		
 	}
 	
 	function checkGarageCollection(){
 		if(document.getElementById("chkgaragecollect").checked==true){
 			//alert("here2");
 			document.getElementById("hidchkgaragecollect").value=1;
 			if($('#garagecollectdate').jqxDateTimeInput('disabled')==true){
 				$('#garagecollectdate').jqxDateTimeInput({ disabled: false});
 			}
 			
 			//
    		$('#garagecollecttime').jqxDateTimeInput({ disabled: false});
    		$('#garagecollectkm').prop('readonly', false );
    		$('#garagecollectkm').prop('disabled', false );
    		$('#cmbgaragecollectfuel').prop('disabled', false );
    		
 			//disableGarage2();
 		}
 		if(document.getElementById("chkgaragecollect").checked==false){
 			document.getElementById("hidchkgaragecollect").value=0;
 			if($('#garagecollectdate').jqxDateTimeInput('disabled')==false){
 				$('#garagecollectdate').jqxDateTimeInput({ disabled: true});
 			}
 			//$('#garagecollectdate').jqxDateTimeInput({ disabled: true});
    		$('#garagecollecttime').jqxDateTimeInput({ disabled: true});
    		$('#garagecollectkm').prop('disabled', true );
    		$('#cmbgaragecollectfuel').prop('disabled', true );
 		}
 	}
 	//Extra function used for disable collectdate in case of jquery error
 
 	function funDeliveryUpdate(){
 		//alert("Delivery update Function");
 		$('#garagedeldate').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverytime').jqxDateTimeInput({ disabled: false});
 		$('#garagedeliverykm').prop('disabled',false);
 		$('#garagedeliverykm').prop('readonly',false);
 		$('#cmbgaragedeliveryfuel').prop('disabled',false);
 		document.getElementById("btndeliveryupdate").style.display="none";
		document.getElementById("btndeliverysave").style.display="block";
		$('#garagedeldate').jqxDateTimeInput('focus');
 	}
 	function funDeliverySave(){
 		if($('#garagedeldate').jqxDateTimeInput('getDate')==null){
 	 		document.getElementById("errormsg").innerText="";
 	 		document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
 	 		return false;
 	 	}
 		
 		var deliverydateval=funDateInPeriod($('#garagedeldate').jqxDateTimeInput('getDate'));
		if(deliverydateval==0){
			$('#garagedeldate').jqxDateTimeInput('focus');
			return false;
		}
 		if($('#garagedeliverytime').jqxDateTimeInput('getDate')==null){
 			document.getElementById("errormsg").innerText="";
  			document.getElementById("errormsg").innerText="Garage Delivery Time is Mandatory";
	  			return 0;	
 		}
 		var date1 = new Date($('#garagedeldate').jqxDateTimeInput('getDate'));
 		var date2=new Date($('#dateout').jqxDateTimeInput('getDate'));
 		var time1=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		var time2=$('#timeout').jqxDateTimeInput('getDate');
 		$('#outkm').prop('disabled',false);
 		$('#outfuel').prop('disabled',false);
 		var tempoutkm=parseFloat($('#outkm').val());
 		var tempoutfuel=$('#outfuel').val();
 		$('#outkm').prop('disabled',true);
 		$('#outfuel').prop('disabled',true);
 	 	date1.setHours(0,0,0,0);
 	 	date2.setHours(0,0,0,0);
 	 	
 		if(date1<date2){
			document.getElementById("errormsg").innerText="Delivery Date should Not be Less than Out Date";
			return false;
 		}
 	if(date1-date2==0){
 		
 		if(time1.getHours()<time2.getHours()){
 			document.getElementById("errormsg").innerText="Delivery Time should Not be Less than Out Time";
 			return false;
 		}
 		else if(time1.getHours()==time2.getHours()){
 		if(time1.getMinutes()<time2.getMinutes()){
 			document.getElementById("errormsg").innerText="Delivery Time should Not be Less than Out Time";
 			return false;
 		}
 		
 		}
 		else{
 			document.getElementById("errormsg").innerText="";
 		}
 		
 	}
 	else{
 		document.getElementById("errormsg").innerText="";
 	
 	}
 	if((document.getElementById("garagedeliverykm").value=='')||(parseFloat(document.getElementById("garagedeliverykm").value)==0.0)){
 		document.getElementById("errormsg").innerText="Delivery KM is Mandatory";
 		return false;
 	}
 	else{
 		document.getElementById("errormsg").innerText="";
 	}
 	if(parseFloat(document.getElementById("garagedeliverykm").value)<tempoutkm){
 		document.getElementById("errormsg").innerText="Delivery KM should Not be Less than Out KM";
 		return false;
 	}
 	else{
 		document.getElementById("errormsg").innerText="";
 	}
 	if(document.getElementById("cmbgaragedeliveryfuel").value==''){
 		document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
 		return false;
 	}
 	else{
 		document.getElementById("errormsg").innerText="";
 	}
 	document.getElementById("errormsg").innerText="";
 	
 			
 		var testdoc=document.getElementById("docno").value;
 		var testfleet=document.getElementById("txtfleetno").value;
 		var deliverydate=$('#garagedeldate').jqxDateTimeInput('getDate');
 		var deliverytime=$('#garagedeliverytime').jqxDateTimeInput('getDate');
 		var deliverykm=document.getElementById("garagedeliverykm").value;
 		var deliveryfuel=document.getElementById("cmbgaragedeliveryfuel").value;
 		var location=document.getElementById("cmblocation").value;
 		var branch=document.getElementById("cmbbranch").value;
 		var trancode=document.getElementById("cmbstatus").value;
		var d1=new Date(deliverytime);
		var temptime=$('#garagedeliverytime').jqxDateTimeInput('val');
		var driver=document.getElementById("hiddriver").value;
 		getDelivery(testdoc,testfleet,deliverydate,temptime,deliverykm,deliveryfuel,location,trancode,driver,branch);
 	}
 	function getDelivery(testdoc,testfleet,deliverydate,temptime,deliverykm,deliveryfuel,location,trancode,driver,branch){
 		//alert("Inside Ajax");
	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
			//	alert((parseInt(items))>0);
				if((parseInt(items))>0){
					document.getElementById("msg").value="Successfully Saved";
					 $.messager.alert('Message',$('#msg').val());
					 document.getElementById("btndeliveryupdate").style.display="block";
					 document.getElementById("btndeliverysave").style.display="none";
					 document.getElementById("btndeliveryupdate").disabled=true;
					 document.getElementById("hidchkgaragedelivery").value="1";
					 document.getElementById("deliverystatus").value="1";
				}
				else{
					document.getElementById("msg").value="Not Saved";
					 $.messager.alert('Message',$('#msg').val());
					 document.getElementById("chkstatus").value="1";
					 document.getElementById("hidchkgaragedelivery").value="0";
				}
			} else {
			}
		}
		x.open("GET", "deliveryUpdate.jsp?doc="+testdoc+"&fleet="+testfleet+"&date="+$('#garagedeldate').jqxDateTimeInput('getDate')+"&time="+temptime+"&km="+deliverykm+"&fuel="+deliveryfuel+"&location="+location+"&trancode="+trancode+"&driver="+driver+"&branch="+branch, true);
		x.send();
		}
 	
 	 $(function(){
	        $('#frmMovement').validate({
	                 rules: {
	                 cmblocation: {
	                	 required:true
	                 },
	                 cmbbranch:{
	                	 required:true
	                 },
	                 cmbstatus:{
	                	 required:true
	                 },
	                 accdetails:{
	                	 maxlength:200
	                 },
	                 outremarks:{
	                	 maxlength:250
	                 },
	                 closeremarks:{
	                	 maxlength:250
	                 }
	                 },
	                 messages: {
	                  cmblocation: {
	                	  required:" *"
	                  } ,
	                  cmbbranch:{
	                	  required:" *"
	                  },
	                  cmbstatus:{
	                	  required:" *"
	                  },
		              accdetails:{
		                maxlength:"Max 200 chars"
		              },
	                 outremarks:{
	                	 maxlength:"Max 250 chars"
	                 },
	                 closeremarks:{
	                	 maxlength:"Max 250 chars"
	                 }
	                  
	                 }
	        });
	  });
 	
 	  function isNumber(evt,id) {
	        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	            return false;
	            
	         }
	        
	        return true;
	    }
 
 	  //Function to Print
		function funPrintBtn() {
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   		}
	   		var url=document.URL;
	   	 var reurl=url.split("saveMovement");
	   	  	//var reurl=url.split("tarifMgmt.jsp");
	   	  	
	   	  	var dtype=$('#formdetailcode').val();
		  		var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  		//alert("hai");
	   	  	var win= window.open(reurl[0]+"printMovement.action?docno="+document.getElementById("docno").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   	    	//var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();
	   	 }
 	
</script>



</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMovement" action="saveMovement" autocomplete="off" >
	<script>
			window.parent.formName.value="Movement";
			window.parent.formCode.value="MOV";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<div class='hidden-scrollbar'>
<fieldset style="background: #ECF8E0;">
<legend><b>Vehicle Movement Opening Info</b></legend>
<table width="100%">
  <tr>
    <td width="4%" align="right">Date</td>
    <td width="11%" align="left"><div id='date' name='date' value='<s:property value="date"/>'></div>
                   </td>
                   <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
    <td width="6%" align="right">Fleet No</td>
    <td width="9%" align="left"><input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' onkeydown="getFleet(event);" readonly placeholder="Press F3 to Search"/></td>
    <td colspan="8" align="left"><input type="text" id="txtfleetname" name="txtfleetname" style="width:100%;" value='<s:property value="txtfleetname"/>'readonly="readonly"/></td>
    <td width="4%" align="right">&nbsp;</td>
    <td width="7%">&nbsp;</td>
    <td width="5%" align="right">Doc No</td>
    <td width="10%" align="left"><input type="text" id="docno" name="docno"  tabindex="-1" value='<s:property value="docno"/>' readonly/></td>
    <td width="0%">&nbsp;</td>
  </tr>
  <tr>
    <td width="4%" align="right">Branch</td>
    <td width="11%" align="left"><select name="cmbbranch" id="cmbbranch" style="width:92%;" onchange="getLocation(this.value);">
      <option value="">--Select--</option>
    </select></td>
<input type="hidden" name="hidcmblocation" id="hidcmblocation" value='<s:property value="hidcmblocation"/>'/>
    <td width="6%" align="right">Location</td>
    <td align="left"><select name="cmblocation" id="cmblocation" style="width:92%;">
      <option value="">--Select--</option>
    </select></td>
    <input type="hidden" id="hiddateout" name="hiddateout" value='<s:property value="hiddateout"/>'/>
    <td width="5%" align="right">Date Out</td>
    <td width="7%" align="right"><div id='dateout' name='dateout' value='<s:property value="dateout"/>'></div></td>
    <td width="3%" align="right">Time</td>
    <td width="8%" align="left"><div id='timeout' name='timeout' value='<s:property value="timeout"/>'></div></td>
    <input type="hidden" id="hidtimeout" name="hidtimeout" value='<s:property value="hidtimeout"/>'/>
    <td width="3%" align="right">KM</td>
    <td width="8%" align="left"><input type="text" id="outkm" name="outkm"  value='<s:property value="outkm"/>'/></td>
    <td width="3%" align="right">Fuel</td>
    <td width="7%" align="left"><select id="cmboutfuel" name="cmboutfuel" value='<s:property value="cmboutfuel"/>'>
      <option value="">-Select-</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
    </select>
      </td>
      <input type="hidden" id="hidcmboutfuel" name="hidcmboutfuel"  value='<s:property value="hidcmboutfuel"/>'/>
    <td align="right">Movement Type</td>
    <td colspan="2" align="left"><select id="cmbstatus" name="cmbstatus"  style="width:85%;" onchange="checkStaff();" value='<s:property value="cmbstatus"/>' >
              <option value="">-Select-</option></select>
              </td>
              <input type="hidden" id="hidcmbstatus" name="hidcmbstatus" value='<s:property value="hidcmbstatus"/>'/>
    <td align="left"><input type="text" name="staff" id="staff" value='<s:property value="staff"/>' onKeyDown="getStaff(event,1);" placeholder="Press F3 to Search"/>
     <input type="text" name="garage" id="garage" value='<s:property value="garage"/>' onKeyDown="getGarage(event);" placeholder="Select Garage"/></td>
        <input type="hidden" name="hidgarage" id="hidgarage" value='<s:property value="hidgarage"/>'/>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">Driver</td>
    <td align="left"><input type="text" id="driver" name="driver" value='<s:property value="driver"/>' onKeyDown="getDriver(event,1);" readonly placeholder="Press F3 to Search"/>
      <input type="checkbox" name="chkgaragedelivery" id="chkgaragedelivery" onChange="checkGarageDelivery();" hidden="true"></td>
    <input type="hidden" name="hidstaff" id="hidstaff" value='<s:property value="hidstaff"/>'/>
    <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'/>
    <td align="right"><!--Delivery-->Remarks</td>
    <td colspan="9" align="left"><input type="text" id="outremarks" name="outremarks" style="width:100%;" value='<s:property value="outremarks"/>'/></td>
    <td align="right">User</td>
    <td colspan="3" align="left"><input type="text" id="outuser" name="outuser" style="width:98%;text-transform:uppercase;" value='<s:property value="outuser"/>' /></td>
    <input type="hidden" name="outuserid" id="outuserid" value='<s:property value="outuserid"/>'/>
    <td>&nbsp;</td>
    </tr>
</table>
    </fieldset>
<fieldset>
<table width="100%" >
  <tr>
    <td width="50%"><fieldset id="deliveryfield"><legend><b>Delivery Info</b></legend><table width="100%" >
      <tr>
        <td width="4%" align="right">Date </td>
        <td width="16%" align="left"><div id="garagedeldate" name="garagedeldate" value='<s:property value="garagedeldate"/>'></div>
</td>
        <td width="4%" align="right">Time</td>
        <td width="16%" align="left"><div id="garagedeliverytime" name="garagedeliverytime" value='<s:property value="garagedeliverytime"/>'></div>
</td>
        <td width="5%" align="right">KM</td>
        <td width="17%" align="left"><input type="text" name="garagedeliverykm" id="garagedeliverykm" value='<s:property value="garagedeliverykm"/>' onkeypress="javascript:return isNumber (event,id)"></td>
        <td width="6%" align="right">Fuel</td>
        <td width="19%" align="left"><select name="cmbgaragedeliveryfuel" id="cmbgaragedeliveryfuel">
          <option value="">--Select--</option><option value=0.000>Level 0/8</option>
       <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
        </select></td>
        <td width="19%" align="center"><input type="button" name="btndeliveryupdate" id="btndeliveryupdate" class="myButton" value="Update" onclick="funDeliveryUpdate();">
        <input type="button" name="btndeliverysave" id="btndeliverysave" class="myButton" value="Save" onclick="funDeliverySave();" hidden="true">
        </td>
      </tr>
    </table></fieldset></td>
    
    <td width="50%"><fieldset id="collectionfield"><legend><b>Collection Info</b></legend><table width="100%">
      <tr>
        <td width="4%" align="left"><input type="checkbox" name="chkgaragecollect" id="chkgaragecollect" onchange="checkGarageCollection();" hidden="true">
          <!--Collection--></td>
        <td width="6%" align="right">Date</td>
        <td width="15%" align="left"><div id="garagecollectdate" name="garagecollectdate" value='<s:property value="garagecollectdate"/>'></div>
</td>
        <td width="7%" align="right">Time</td>
        <td width="16%" align="left"><div id="garagecollecttime" name="garagecollecttime" value='<s:property value="garagecollecttime"/>'></div>
</td>
        <td width="7%" align="right">KM</td>
        <td width="16%" align="left"><input type="text" name="garagecollectkm" id="garagecollectkm" value='<s:property value="garagecollectkm"/>' onkeypress="javascript:return isNumber (event,id)"></td>
        <td width="5%" align="right">Fuel</td>
        <td width="24%" align="left"><select name="cmbgaragecollectfuel" id="cmbgaragecollectfuel">
          <option value="">--Select--</option><option value=0.000>Level 0/8</option>
        <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
        </select></td>
      </tr>
    </table></fieldset></td>
  </tr>
</table>
</fieldset>
<fieldset style="background: #F7F2E0;">
      <legend><b>Vehicle Movement Closing Info</b></legend>
      <table width="100%">
  <tr>
    <td width="4%" align="right">Branch</td>
    <td width="8%" align="left"><select name="cmbclosebranch" id="cmbclosebranch" style="width:97%;" onchange="getCloseLocation(this.value);">
      <option value="">--Select--</option>
    </select></td>
    <input type="hidden" name="hidcmbcloselocation" id="hidcmbcloselocation" value='<s:property value="hidcmbcloselocation"/>'/>
    <td width="3%" align="right">Location</td>
    <td width="7%" align="left"><select name="cmbcloselocation" id="cmbcloselocation" style="width:97%;">
      <option value="">--Select--</option>
    </select></td>
      <input type="hidden" id="hidclosedate" name="hidclosedate" value='<s:property value="hidclosedate"/>'/>
    <td width="2%" align="right">Date</td>
    <td width="6%" align="left"><div id='closedate' name='closedate' value='<s:property value="closedate"/>'></div></td>
    <td width="2%" align="right">Time</td>
    <td width="7%" align="left"><div id='closetime' name='closetime' value='<s:property value="closetime"/>'></div></td>
    <td width="3%" align="right">KM</td>
    <td width="8%" align="left"><input type="text" id="closekm" name="closekm"  value='<s:property value="closekm"/>' onKeyPress="javascript:return isNumber (event,id)" onBlur="getTotalkm();"/></td>
    <td width="7%" align="right">Fuel</td>
      <input type="hidden" id="hidclosetime" name="hidclosetime" value='<s:property value="hidclosetime"/>'/>
    <td width="8%" align="right"><select id="cmbclosefuel" name="cmbclosefuel" style="width:98%;" value='<s:property value="cmbclosefuel"/>'>
      <option value="">-Select-</option>
      <option value=0.000>Level 0/8</option>
      <option value=0.125>Level 1/8</option>
      <option value=0.250>Level 2/8</option>
      <option value=0.375>Level 3/8</option>
      <option value=0.500>Level 4/8</option>
      <option value=0.625>Level 5/8</option>
      <option value=0.750>Level 6/8</option>
      <option value=0.875>Level 7/8</option>
      <option value=1.000>Level 8/8</option>
    </select></td>
    <td width="4%" align="right">Driver</td>
    <td width="10%" align="left"><input type="text" name="closedriver" id="closedriver" onKeyDown="getDriver(event,2);" value='<s:property value="closedriver"/>' style="width:100%;"  readonly/></td>
      <input type="hidden" id="hidcmbclosefuel" name="hidcmbclosefuel" value='<s:property value="hidcmbclosefuel"/>'/>
    <td width="3%" align="right">Staff</td>
    <td width="8%" align="left"><input type="text" name="closestaff" id="closestaff" value='<s:property value="closestaff"/>' onKeyDown="getStaff(event,2);"  readonly/></td>
    <input type="hidden" name="hidclosestaff" id="hidclosestaff" value='<s:property value="hidclosestaff"/>'/>
    <input type="hidden" name="hidcmbaccidents" id="hidcmbaccidents" value='<s:property value="hidcmbaccidents"/>'/>
    <td width="10%" rowspan="2" align="center"><input type="button" name="btnclose" id="btnclose" class="myButton" value="Close" onclick="closeMov();">
    <input type="button" name="btnclosesave" id="btnclosesave" class="myButton" value="Save" onclick="closeSave();">
    </td>
      <input type="hidden" id="hidclosedriver" name="hidclosedriver" value='<s:property value="hidclosedriver"/>'/>
      <input type="hidden" id="hidcloseuser" name="hidcloseuser" value='<s:property value="hidcloseuser"/>'/>
  </tr>
  <tr>
    <td align="right">Accidents</td>
    <td align="left"><select name="cmbaccidents" id="cmbaccidents" onChange="getAccidents();" style="width:97%;">
      <option value="">--Select--</option>
      <option value=1>Yes</option>
      <option value=0>No</option>
    </select></td>
    <input type="hidden" name="hidaccidents" id="hidaccidents" value='<s:property value="hidaccidents"/>'/>
    <td align="right">Details</td>
    <td colspan="5" align="left"><input type="text" name="accdetails" id="accdetails" style="width:99%;" value='<s:property value="accdetails"/>'/></td>
    <td align="right">Fines</td>
    <td colspan="2" align="left"><input type="text" name="accfines" id="accfines" value='<s:property value="accfines"/>'/></td>
    <td align="right">&nbsp;</td>
    <td align="right">User</td>
    <td align="left"><input type="text" id="closeuser" name="closeuser" style="width:100%;text-transform:uppercase;" value='<s:property value="closeuser"/>' readonly  /></td>
    <td align="right">Total KM</td>
    <td align="left"><input type="text" id="totalkm" name="totalkm"  value='<s:property value="totalkm"/>'/></td>
    </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="10" align="left"><input type="text" id="closeremarks" name="closeremarks" style="width:99.5%;" value='<s:property value="closeremarks"/>'/></td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
      </table>
    </fieldset>
    
<br/>
  <!--<div id='jqxExpander'>
  <div>Accidents/Maintenance Details</div>
  <div>
  <table width="100%" style="background: #E0ECF8;">
  <tr>
    <td><input type="checkbox" name="chkaccident" id="chkaccident" unchecked onchange="changeAcc();"></td>
    <td><input type="checkbox" name="chkmaintenance" id="chkmaintenance"  unchecked onchange="changeMaintenance();"></td>
  </tr>
  <tr>
    <td width="50%"><div id="accdiv"><fieldset id="fieldsetacc">
      <legend>Accidents Info</legend>
      <table width="100%">
  <tr>
    <td width="13%" align="right">Date</td>
    <td width="25%" align="left"><div id='accdate' name='accdate' value='<s:property value="accdate"/>'></div>
                    </td>
                    <input type="hidden" id="hidaccdate" name="hidaccdate" value='<s:property value="hidaccdate"/>'/>
    <td align="right">Time</td>
    <td align="left"><div id='acctime' name='acctime' value='<s:property value="acctime"/>'></div>
                   </td>
                   <input type="hidden" id="hidacctime" name="hidacctime" value='<s:property value="hidacctime"/>'/>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td align="left"><select id="cmbacctype" name="cmbacctype" style="width:80%" value='<s:property value="cmbacctype"/>'>
            <option vaue="">-Select-</option><option value="Third Party">Third Party</option><option value="Own Claim">Own Claim</option></select>
            </td>
            <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>
    <td width="15%" align="right">PRCS</td>
    <td width="47%" align="left"><select id="cmbprcs" name="cmbprcs" style="width:30%" value='<s:property value="cmbprcs"/>'>
            <option vaue="-1">-Select-</option><option value=1>Yes</option><option value=0>No</option></select>
            </td>
            <input type="hidden" id="hidcmbprcs" name="hidcmbprcs" value='<s:property value="hidcmbprcs"/>'/>
  </tr>
  <tr>
     <td align="right">Collected</td>
    <td align="left"><div id='collectdate' name='collectdate' value='<s:property value="collectdate"/>'></div>
        </td><input type="hidden" id="hidcollectdate" name="hidcollectdate" value='<s:property value="hidcollectdate"/>'/>
    <td colspan="2"><button type="button" class="icon" id="btnUpdate" title="Update" onclick="">
							<img alt="search" src="../../../../icons/update.png"></button></td>
  </tr>
  <tr>
    <td align="right">Place</td>
    <td align="left"><input type="text" name="accplace" id="accplace" value='<s:property value="accplace"/>'/></td>
    <td align="right">Fines</td>
    <td align="left"><input type="text" id="fines" name="fines" style="width:30%" value='<s:property value="fines"/>'/></td>
  </tr>
  <tr>
    <td align="right">Details</td>
    <td colspan="3" align="left"><textarea id="details" name="details" style="width:62.5%;resize: none;" value='<s:property value="details"/>'></textarea></td>
  </tr>
</table>
      </fieldset></div>
    </td>
    <td width="50%"><table width="100%">
  <tr>
    <td width="100%" height="100%"><div id="maintdiv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div></td>
  </tr>
  <div id="maintenancewarning" align="center" style="color:red;font-weight:bold;">Please Select a Valid Type</div>
</table></td>

  </tr>
</table></div></div>-->
<br/>
 <!--<div id='jqxExpander1'>
 <div>Overview</div>
 <div style="background: #E0ECF8;">
 <br/>
 <center><jsp:include page="movementGrid.jsp"></jsp:include></center>
 <br/>
</div></div>-->
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="mode" name="mode" value='<s:property value="delete"/>'/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
<input type="hidden" name="hidchkgaragedelivery" id="hidchkgaragedelivery" value='<s:property value="hidchkgaragedelivery"/>' >
<input type="hidden" name="hidgaragedeliverydate" id="hidgaragedeliverydate" value='<s:property value="hidgaragedeliverydate"/>'>
<input type="hidden" name="hidgaragedeliverytime" id="hidgaragedeliverytime" value='<s:property value="hidgaragedeliverytime"/>'>
<input type="hidden" name="hidchkgaragecollect" id="hidchkgaragecollect"  value='<s:property value="hidchkgaragecollect"/>' >
<input type="hidden" name="hidcmbgaragecollectfuel" id="hidcmbgaragecollectfuel" value='<s:property value="hidcmbgaragecollectfuel"/>' >
<input type="hidden" name="hidcmbgaragedeliveryfuel" id="hidcmbgaragedeliveryfuel" value='<s:property value="hidcmbgaragedeliveryfuel"/>' >
<input type="hidden" name="hidgaragecollectdate" id="hidgaragecollectdate" value='<s:property value="hidgaragecollectdate"/>'>
<input type="hidden" name="hidgaragecollecttime" id="hidgaragecollecttime" value='<s:property value="hidgaragecollecttime"/>'>
<div id="dateouthidden" name="dateouthidden" hidden="true"></div>
<div id="timeouthidden" name="timeouthidden" hidden="true"></div>
<div id="hiddelivery" name="hiddelivery" hidden="true"></div>
<div id="hidcollect" name="hidcollect" hidden="true"></div>
<input type="hidden" name="movtempstatus" id="movtempstatus" value='<s:property value="movtempstatus"/>'>
<input type="hidden" name="clstatus" id="clstatus" value='<s:property value="clstatus"/>'>
<input type="hidden" name="deliverystatus" id="deliverystatus" value='<s:property value="deliverystatus"/>'>
<input type="hidden" name="hidcmbbranch" id="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'>
<input type="hidden" name="hidcmbclosebranch" id="hidcmbclosebranch" value='<s:property value="hidcmbclosebranch"/>'>
<input type="hidden" name="vehtrancode" id="vehtrancode" value='<s:property value="vehtrancode"/>'>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="maintenancewindow">
   <div ></div>
</div>
<div id="driverwindow">			
   <div ></div>
</div>
<div id="staffwindow">
   <div ></div>
</div>
<div id="garagewindow">
   <div ></div>
</div>
<div id="errormsg"></div>
</form>
</div>
</body>
</html>
