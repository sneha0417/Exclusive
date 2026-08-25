<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Reports</title>               
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<jsp:include page="../../../../propertyIncludes.jsp"></jsp:include> 
  <style type="text/css"> 
   @media (min-width: 900px) {               
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
} 
   .textpanel{
    color: blue;
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 

    .msg-details{
      text-align: right;
    }

    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .hidden-scrollbar {
	  overflow: scroll;
	  height: 3500px;      
	}
	h3{
	text-align:center;
	color:#FD5E3C;
	}
  </style>
</head>       
<body>  
<div class='hidden-scrollbar'>                   
  <div class="container-fluid"> 
  <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>AVAILABILITY STATUS</h3>       
      </div>      
    </div>    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<div id="ppdiv"><jsp:include page="propertyGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    <div id="hideprodetails">
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>PROPERTY DETAILS</h3>  
      </div>   
    </div> 
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">      
   			<div id="pdetdiv"><jsp:include page="propertyDetailsGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div>
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>AVAILABILITY ANALYSIS</h3>  
      </div>      
    </div> 
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<div id="chartdiv"><jsp:include page="chart.jsp"></jsp:include></div>     
      </div>   
    </div>  
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>MAINTENANCE REVIEW</h3>  
      </div>      
    </div>   
    <div class="row">   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<div id="msdiv"><jsp:include page="mstatusGrid.jsp"></jsp:include></div>
      </div>   
    </div>
    <div id="hidemain"> 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>MAINTENANCE DETAILS</h3>  
      </div>      
    </div> 
    <div class="row">   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">              
   			<div id="maindiv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div> 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">      
   			<h3>STATISTICS</h3>  
      </div>      
    </div> 
    <div class="row">   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<div id="dprodiv"><jsp:include page="dailypropertyGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
     <div id="hidestatistics1">         
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>PROPERTY DETAILS</h3>      
      </div>   
    </div> 
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                           
   			<div id="pdetsticsdiv"><jsp:include page="propertyDetailsStatisticsGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div>
     <div id="hidestatistics2">                 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>CONTRACTS DETAILS</h3>                
      </div>   
    </div> 
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                  
   			<div id="cdetsticsdiv"><jsp:include page="contractsDetailsStatisticsGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div>
    <div id="hidestatistics3">                 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
   			<h3>TENANCY RENEWAL DETAILS</h3>                
      </div>   
    </div> 
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                  
   			<div id="rdetsticsdiv"><jsp:include page="renewalDetailsStatisticsGrid.jsp"></jsp:include></div>
      </div>         
    </div> 
    </div>
    <div id="hidestatistics4">                 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>TENANT REQUESTS DETAILS</h3>                
      </div>   
    </div> 
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                  
   			<div id="trdetsticsdiv"><jsp:include page="trequestDetailsStatisticsGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div>
     <div id="hidestatistics5">                 
     <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
   			<h3>TENANT REQUEST COMPLETED DETAILS</h3>                
      </div>   
    </div>               
     <div class="row" >                   
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                  
   			<div id="trcdetsticsdiv"><jsp:include page="treqcompletedDetailsStatisticsGrid.jsp"></jsp:include></div>
      </div>   
    </div> 
    </div>
    <div id="hidestatistics6">                 
	     <div class="row">
	      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
	   			<h3>INSPECTION DETAILS</h3>                                       
	      </div>   
	    </div> 
	     <div class="row" >                       
	      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                                      
	   			<div id="insdetsticsdiv"><jsp:include page="inspectsDetailsStatisticsGrid.jsp"></jsp:include></div>
	      </div>   
	    </div> 
    </div>
  </div>       
 </div> 
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
    $(document).ready(function(){ 
    $('[data-tooltip="tooltip"]').tooltip();
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     load();
	     $("#hideprodetails").hide(); 
	     $("#hidemain").hide(); 
	     $("#hidestatistics1").hide();$("#hidestatistics2").hide();$("#hidestatistics3").hide(); 
	     $("#hidestatistics4").hide();$("#hidestatistics5").hide();$("#hidestatistics6").hide();          
    });
    function loadprodet(type,ptype){   
    	$('#pdetdiv').load("propertyDetailsGrid.jsp?type="+type+"&ptype="+ptype+"&id="+1);         
    }
    function load(){
    	$('#ppdiv').load("propertyGrid.jsp?id="+1);   
    	$('#chartdiv').load("chart.jsp?id="+1);  
    	$('#msdiv').load("mstatusGrid.jsp?id="+1);
    	$('#maindiv').load("maintenanceGrid.jsp?id="+1);
    	$('#dprodiv').load("dailypropertyGrid.jsp?id="+1);
    }
    function loadmaindata(status){  
    	$('#maindiv').load("maintenanceGrid.jsp?status="+status+"&id="+1);   
    }
    function fundailyactivitydetails(type,mtype){
    	if(type=="PRO"){
    		$('#pdetsticsdiv').load("propertyDetailsStatisticsGrid.jsp?mtype="+mtype+"&id="+1);               
    	}else if(type=="CON"){
    		$('#cdetsticsdiv').load("contractsDetailsStatisticsGrid.jsp?mtype="+mtype+"&id="+1); 
    	}else if(type=="TNR"){
    		$('#rdetsticsdiv').load("renewalDetailsStatisticsGrid.jsp?mtype="+mtype+"&id="+1); 
    	}else if(type=="TRQ"){
    		$('#trdetsticsdiv').load("trequestDetailsStatisticsGrid.jsp?mtype="+mtype+"&id="+1); 
    	}else if(type=="TRC"){
    		$('#trcdetsticsdiv').load("treqcompletedDetailsStatisticsGrid.jsp?mtype="+mtype+"&id="+1); 
    	}else if(type=="INS" || type=="SKP"){                   
    		$('#insdetsticsdiv').load("inspectsDetailsStatisticsGrid.jsp?mtype="+mtype+"&type="+type+"&id="+1);          
    	}else{}         
    }            
  </script>
</body>
</html>
