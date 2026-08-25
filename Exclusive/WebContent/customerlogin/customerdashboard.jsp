<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Property Owner Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../propertyIncludes.jsp"></jsp:include>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

<link href="css/util.css" rel="stylesheet" />
<style>
	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700);
	:root {
  		/*--main-bg-color:#5867dd;
  			rgba(88,103,221,1)
  		*/
  		--main-bg-color:#5867dd;
  		--main-sec-color:#fff;
  		--main-third-color:#000;
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('fonts/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('fonts/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('fonts/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('fonts/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		position:relative;
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: var(--main-bg-color);
    	border-color: var(--main-bg-color);
		color:#fff;
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:var(--main-bg-color);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:var(--main-bg-color);
	}
	
	.custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	height:54px;
    	padding-top:20px;
    }
    .stmtpanel{
    	height:54px;
    	padding-top:15px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.admin-cover .panel-body{
	border:none;
}

.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-top: 10px;
	}
	.card-container .card-icon-wrapper{
		width: 30%;
		display: inline-block;
		clear: both;
		float: left;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	.card-container .card-detail-wrapper{
		width: 70%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-detail-wrapper{
		width: 50%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-expand-wrapper{
		width: 18%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container .card-detail-wrapper p:nth-child(1){
		margin-top: 5px;
		margin-bottom: 2px;
	}
	.centered{
	    margin: 0 auto;
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: var(--main-bg-color);
	}
	.contact-container{
		width:100%;
		background-color:#fff;
	}
	.contact-header{
		background-image:url("images/bg-02.jpg");
		background-size:cover;
		background-repeat:no-repeat;
		background-position:center top;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	#tblexenq tbody tr.active td,#tblexend tbody tr.active td{
		color: #fff;
	    background-color: var(--main-bg-color);
	}
	#tblexend tbody tr.active td span.badge{
		background-color:#fff;
		color:var(--main-bg-color);
	}
	#tblexenq tbody tr{
		cursor:pointer;
	}
	.btn-outline-primary{
	    color: var(--main-bg-color);
	    background-color: transparent;
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	.btn-outline-primary:hover,.btn-outline-primary:focus,.btn-outline-primary:active{
	    color: #fff;
	    background-color: var(--main-bg-color);
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	
	#tblcontracts .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tblcontracts .table-responsive {
	  overflow-y: visible !important;
	}
	.custom-navbar{
		background-color:var(--main-sec-color);
		color:var(--main-third-color);
	}
	.custom-navbar .navbar-brand,.custom-navbar .navbar-brand:hover,.custom-navbar .navbar-brand:active,.custom-navbar .navbar-brand:focus{
		color:var(--main-third-color);
	}
	.custom-navbar .user-dropdown-text,#myNavbar .fa-user,#myNavbar .caret{
		color:var(--main-third-color);
	}
	.contact-header-img .img-thumbnail{
		background-color:var(--main-sec-color);
		border-color:var(--main-sec-color);
	}
	.custom-navbar .dropdown.open .user-dropdown-text,#myNavbar .dropdown.open .fa-user,#myNavbar .dropdown.open .caret{
		color:var(--main-bg-color);
	}
	.jqx-datetimeinput .jqx-icon{
		top: 20%;
    	left: 10%;
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#" style="padding-top: 2px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;">
      					<img alt="" src="images/exclusivelogo1.jpg" style="width:auto; height: 100%;">
      				</span>
      				Property Owner Dashboard
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><i class="fa fa-user"></i> <span class="user-dropdown-text">John Doe</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
          					<!-- <li><a href="#">Change Password</a></li> -->
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60">
    		<li class="active"><a data-toggle="pill" href="#menu-dashboard"><i class="fa fa-home p-r-5"></i>Dashboard</a></li>
    		<li><a data-toggle="pill" href="#menu1"><i class="fa fa-credit-card p-r-5"></i>Account Statement</a></li>
    		<li><a data-toggle="pill" href="#menu2"><i class="fa fa-file-text p-r-5"></i>Invoice List</a></li>
    		<li ><a data-toggle="pill" href="#menu4"><i class="fa fa-users p-r-5"></i>Customer Helpdesk</a></li>
  		</ul>

  		<div class="tab-content">
    		<div id="menu-dashboard" class="tab-pane fade in active">
    			<div class="container-fluid m-t-20">
    				<div class="panel panel-default admin-cover animated fadeInDown" id="admin-cover">
	  					<div class="panel-body">
	    					<p style="margin-bottom:0;" class="fs-12"><strong>Hi Dave</strong>, Your Analytics are all set</p>
	    					<button type="button" class="close" data-target="#admin-cover" data-dismiss="alert" style="position:absolute;right:15px;top:15px;">
	    						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        	</button>
	  					</div>
					</div>
    				<div class="row hidden">
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn advance">
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/advance.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Advance</p>
									<p><strong>AED <span class="value">15245.56</span></strong></p>
								</div>
							</div>
						</div>
						<!--<div class="col-xs-12 col-sm-6 col-md-3 col-lg-2">
							<div class="card-container img-rounded m-b-10 animated zoomIn pdcinhand">
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/pdcinhand.png">
								</div>
								<div class="card-detail-wrapper">
									<p>PDC In Hand</p>
									<p><strong>AED <span class="value">15245.56</span></strong></p>
								</div>
							</div>
						</div>-->
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn total">
								<div class="card-icon-wrapper text-center">
									<!-- <img src="https://img.icons8.com/color/48/000000/total-sales-1.png"> -->
									<img src="images/icons/total.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Total</p>
									<p><strong>AED <span class="value">15245.56</span></strong></p>
								</div>
							</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn unapplied">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/unapplied.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Un Applied</p>
								<p><strong>AED <span class="value">15245.56</span></strong></p>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn balance">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/balance.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Balance</p>
								<p><strong>AED <span class="value">15245.56</span></strong></p>
							</div>
						</div>
					</div>
				</div>
				<div class="row m-t-10">
					
					<div class="col-xs-12 col-sm-12 col-md-4 col-lg-8">
						<div class="panel panel-default boxshadow1 animated zoomIn">
							<div class="panel-heading">
								<strong>Property List</strong>
							</div>
							<div class="panel-body" style="border:none;max-height:335px;">
								<table class="table tblproplist">
		  								<thead>
		  									<tr>
		  										<th>SrNo</th>
		  										<th>UnitNo</th>
		  										<th>Name</th>
		  										<th>ID</th>
		  										<th>Area</th>
		  										<th>M</th>
		  										<th>Expiry Dt</th>
		  									</tr>
		  								</thead>
										<tbody>
											
										</tbody>
		  							</table>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
						<div class="panel panel-default boxshadow1 animated zoomIn">
							<div class="panel-heading">
								<strong>Property Typewise</strong>
							</div>
							<div class="panel-body" style="border:none;">
								<!-- <canvas id="chartcountmonthwise"></canvas> -->
							</div>
							<div class="panel-body" style="border:none;max-height:335px;">
								<table class="table tblproptype">
		  								<thead>
		  									<tr>
		  										<th>SrNo</th>
		  										<th>Type</th>
		  										<th>Total</th>
		  										<th>Vacant</th>
		  										<th>On Hire</th>
		  									</tr>
		  								</thead>
										<tbody>
											
										</tbody>
		  							</table>
							</div>
							
						</div>
					</div>
				</div>
    		</div>
    		
    	</div>
    		<div id="menu1" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="fromdate"></div>
				  				<div id="todate"></div>
				        	</div>
				        	<div class="primarypanel custompanel">
				        		<button class="btn btn-default" id="btnacstmt">Statement</button>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<%-- <div id="accountsStatementDiv"><jsp:include page="accountsStatementTypeGrid.jsp"></jsp:include></div> --%>
							<div id="summdiv"><jsp:include page="summaryGrid.jsp"></jsp:include></div>
							<div id="summasdiv" class="borderStyle"><jsp:include page="summaryASGrid.jsp"></jsp:include></div>
						</div>
					</div>
					<div class="row hidden">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<table width="100%">
								<tr>
									<td width="85%" align="right" style="font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
			        				<td width="15%" align="left"><input type="text" class="textbox form-control" id="txtnetamount" name="txtnetamount" style="width:90%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
    		</div>
    		<div id="menu2" class="tab-pane fade">
    			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btninvsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btninvexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninvinfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="invfromdate"></div>
				  				<div id="invtodate"></div>
				        	</div>
				        	<div class="primarypanel custompanel">
				  				<select class="form-control" id="cmbinvacno" style="width:100%;"><option value="">--Select--</option></select>
				        	</div>
				        </div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="invoiceListDiv"><jsp:include page="invoiceListGrid.jsp"></jsp:include></div>
						</div>
					</div>
				</div>
    		</div>
  			<div id="menu4" class="tab-pane fade">
  				<div class="container m-t-10">
  					<div class="contact-container img-rounded boxshadow1">
  						<div class="contact-header">
  							<div class="row">
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-img p-t-15 p-l-15 p-r-15 p-b-15">
		  								<a href="https://www.exclusive-links.com/" target="_blank">
		  									<img alt="Company Logo" src="images/exclusivelogo.jpg" style="width:auto;height:150px;" class="img-responsive img-thumbnail img-responsive boxshadow1"></a>
		  							</div>		
  								</div>
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-detail pull-right p-r-20 p-t-25">
  										<h4>Complete Property Experience</h4>
  										<p>Let's start exploring the world together with us</p>
  									</div>		
  								</div>
  							</div>
  						</div>
  						<div class="contact-body">
  							<div class="container-fluid">
  								<div class="panel panel-default m-t-15">
  									<table class="table tblhelpdesk">
		  								<thead>
		  									<tr>
		  										<th>Sr No</th>
		  										<th>Employee</th>
		  										<th>Department</th>
		  										<th>Email</th>
		  										<th>Mobile</th>
		  									</tr>
		  								</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td>Earl Harmon</td>
												<td>Management</td>
												<td>earl@trust.com</td>
												<td>+9199895098950</td>
											</tr>
											<tr>
												<td>2</td>
												<td>Jeremy Gardener</td>
												<td>Finance</td>
												<td>jeremy_255@trust.com</td>
												<td>+9199895098950</td>
											</tr>
											<tr>
												<td>3</td>
												<td>Della Cunningham</td>
												<td>Customer Relation</td>
												<td>dells@trust.com</td>
												<td>+9199895098950</td>
											</tr>
										</tbody>
		  							</table>
  								</div>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  		</div>
	</div>
	
	<input type="hidden" name="clientacno" id="clientacno">
	<input type="hidden" name="cldocno" id="cldocno">
	<input type="hidden" name="propdocno" id="propdocno">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script>
    	var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    	window.chartColors = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
			color1:'rgb(255, 15, 0)',
			color2:'rgb(255, 102, 0)',
			color3:'rgb(255, 158, 1)',
			color4:'rgb(252, 210, 2)',
			color5:'rgb(248, 255, 1)',
			color6:'rgb(176, 222, 9)',
			color7:'rgb(4, 210, 21)',
			color8:'rgb(13, 142, 207)',
			color9:'rgb(13, 82, 209)',
			color10:'rgb(42, 12, 208)',
			color11:'rgb(138, 12, 207)',
			color12:'rgb(205, 13, 116)',
			color13:'rgb(117, 77, 235)',
			color14:'rgb(221, 221, 221)',
			color15:'rgb(153, 153, 153)',
			color16:'rgb(51, 51, 51)'
		};
		var barChartData = {
			labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
			datasets: [
				{
					label: 'Contracts',
					backgroundColor: window.chartColors.red,
					data: [5,4,2,6,3,1,3]
				}
			]

		};
    	var chartcountmonthwiseconfig = {
			type: 'line',
			data: {
				labels: ['Total','Vacant','On Hire'],
				datasets: [
					{
						label: 'Appartments',
						backgroundColor: window.chartColors.red,
						borderColor: window.chartColors.red,
						data: [3,0,3],
						fill: false,
					},
					{
						label: 'Buildings',
						backgroundColor: window.chartColors.blue,
						borderColor: window.chartColors.blue,
						data: [4,2,2],
						fill: false,
					},
					{
						label: 'Villa',
						backgroundColor: window.chartColors.yellow,
						borderColor: window.chartColors.yellow,
						data: [1,0,1],
						fill: false,
					},
				]
			},
			options: {
				responsive: true,
				title: {
					display: false,
					text: 'Chart.js Line Chart'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Category'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}]
				}
			}
		};
		window.onload = function() {
			var chartcountmonthwisectx = document.getElementById('chartcountmonthwise').getContext('2d');
			window.chartcountmonthwise = new Chart(chartcountmonthwisectx, chartcountmonthwiseconfig);
			var barchartctx = document.getElementById('chartvaluemonthwise').getContext('2d');
			window.chartvaluemonthwise = new Chart(barchartctx, {
				type: 'bar',
				data: barChartData,
				options: {
					title: {
						display: false,
						text: 'Invoice Analytics - Stacked'
					},
					tooltips: {
						mode: 'index',
						intersect: false
					},
					responsive: true,
					scales: {
						xAxes: [{
							stacked: true,
						}],
						yAxes: [{
							stacked: true
						}]
					}
				}
			});
		};
    	$(document).ready(function(){
    		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		$("#todate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		$("#invfromdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		$("#invtodate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     		$('#fromdate,#invfromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
			$('#cmbinvacno').select2({
				placeholder: "Select an account",
  				allowClear: true
			});
			$('#btnacstmt').click(function(){
				var property=$('#propdocno').val();
	      		var acno=$('#clientacno').val();
	      		if(property==""){           
	            	Swal.fire({
  						icon: 'warning',
  						title: 'Warning',
  						text: 'Property is Mandatory',
					});
					return false;
	      		}
	      		var fdate=$('#fromdate').jqxDateTimeInput('val');             
          		var tdate=$('#todate').jqxDateTimeInput('val');   
		  		var url=document.URL;  
	      		var reurl=url.split("customerlogin");                  
	      		var win= window.open(reurl[0]+"com/dashboard/realestate/propertyaccountmanagement/printpropertyaccount?docno="+property+'&fromDate='+fdate+'&toDate='+tdate+'&acno='+acno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      		win.focus();  
			});
			
    		$('#btnsubmit').click(function(){
    			var acno=$('#clientacno').val();
    			var fromdate=$('#fromdate').jqxDateTimeInput('val');
    			var todate=$('#todate').jqxDateTimeInput('val');
    			$('#txtnetamount').val('');
    			$('.page-loader').show();
    			//$('#accountsStatementDiv').load('accountsStatementTypeGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&accdocno='+acno+'&check=1&branchval=a');
    			$('#summdiv').load("summaryGrid.jsp?ownid="+$('#cldocno').val()+"&id="+1+"&todate="+todate);
    		});
    		$('#btnexcel').click(function(){
    			var excelname="Account Statement of "+$('.user-dropdown-text').text()+" dated from "+$('#fromdate').jqxDateTimeInput('val')+" to "+$('#todate').jqxDateTimeInput('val');
    			$("#summdiv").excelexportjs({
					containerid: "summdiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "jqxsummaryGrid", 
					columns: getColumns("jqxsummaryGrid") , 
					worksheetName:excelname
				});
				$("#summasdiv").excelexportjs({
					containerid: "summasdiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "jqxsummaryASGrid", 
					columns: getColumns("jqxsummaryASGrid") , 
					worksheetName:excelname
				});	
    		});
			$('#btninvsubmit').click(function(){
				var fromdate=$('#invfromdate').jqxDateTimeInput('val');
				var todate=$('#invtodate').jqxDateTimeInput('val');
				var acno=$('#cmbinvacno').val();
				if(acno==''){
					Swal.fire({
  						icon: 'warning',
  						title: 'Warning',
  						text: 'Account is Mandatory',
					});
					return false;
				}
				$('.page-loader button').show();
				$('#invoiceListDiv').load('invoiceListGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&acno='+acno+'&id=1&branchval=a');
			}); 
			$('#btninvexcel').click(function(){
    			var excelname="Invoice List of "+$('.user-dropdown-text').text()+" dated from "+$('#invfromdate').jqxDateTimeInput('val')+" to "+$('#invtodate').jqxDateTimeInput('val');
    			$("#invoiceListDiv").excelexportjs({
					containerid: "invoiceListDiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "invoiceListGrid", 
					columns: getColumns("invoiceListGrid") , 
					worksheetName:excelname
				});	
    		});
    	});
    	$(window).ready(function(){
    		getInitData();
		});
		
		
		function getInitData(){
			$('.page-loader').show();
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('#cldocno').val(items.split("::")[15].trim());
	  				$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.user-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				$('#clientacno').val(items.split("::")[3].trim());
	  				/*$('.pdcinhand .card-detail-wrapper .value').text(items.split("::")[4].trim());
	  				$('.subreceipt .card-detail-wrapper .value').text(items.split("::")[5].trim());
	  				$('.advance .card-detail-wrapper .value').text(items.split("::")[6].trim());
	  				$('.balance .card-detail-wrapper .value').text(items.split("::")[7].trim());
	  				$('.unapplied .card-detail-wrapper .value').text(items.split("::")[8].trim());
	  				$('.total .card-detail-wrapper .value').text(items.split("::")[9].trim());*/
	  				var policynodata=JSON.parse(items.split("::")[13].trim());
					var helpdeskdata='';
					$.each(policynodata.helpdeskdata, function( index, value ) {
	  					helpdeskdata+='<tr data-docno="'+value.split("***")[1]+'">';
	  					helpdeskdata+='<td>'+value.split("***")[0]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[2]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[3]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[4]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[5]+'</td>';
	  					helpdeskdata+='</tr>';
					});
					$('.tblhelpdesk tbody').html($.parseHTML(helpdeskdata));
					var proplisthtml='';
					$.each(policynodata.proplistdata, function( index, value ) {
	  					proplisthtml+='<tr>';
	  					proplisthtml+='<td>'+(index+1)+'</td>';
	  					proplisthtml+='<td>'+value.unitno+'</td>';
	  					proplisthtml+='<td>'+value.accname+'</td>';
	  					proplisthtml+='<td>'+value.prid+'</td>';
	  					proplisthtml+='<td>'+value.area+'</td>';
	  					proplisthtml+='<td>'+value.managed+'</td>';
	  					proplisthtml+='<td>'+value.contractdate+'</td>';
	  					proplisthtml+='</tr>';
					});
					$('.tblproplist tbody').html($.parseHTML(proplisthtml));
					var ownerachtml='<option value="">--Select--</option>';
					$.each(policynodata.owneracdata, function( index, value ) {
	  					ownerachtml+='<option value="'+value.acno+'">'+value.desc+'</option>';
					});
					$('#cmbinvacno').html($.parseHTML(ownerachtml));
					var countchartdata=JSON.parse(items.split("::")[14].trim());
					/* 
					$.each(countchartdata.chartdata, function( index, value ) {
	  					var newDataset = {
        					label: value.ptype,
        					backgroundColor:window.chartColorsArray[index],
        					borderColor:window.chartColorsArray[index],
        					data: [value.totalcount,value.availablecount,value.oncontractcount],
        					fill:false,
    					}
    					window.chartcountmonthwise.data.datasets.push(newDataset);
   						window.chartcountmonthwise.update();
					});
					window.chartcountmonthwise.data.labels=countchartdata.labels;
					window.chartcountmonthwise.data.datasets[0].data=countchartdata.charttourcount;
					window.chartcountmonthwise.data.datasets[1].data=countchartdata.charthotelcount;
					window.chartcountmonthwise.data.datasets[2].data=countchartdata.chartticketcount;
					window.chartcountmonthwise.options.title.text=countchartdata.chartcounttitle;
					window.chartcountmonthwise.update();
					window.chartvaluemonthwise.data.labels=countchartdata.labels;
					window.chartvaluemonthwise.data.datasets[0].data=countchartdata.charttourvalue;
					window.chartvaluemonthwise.data.datasets[1].data=countchartdata.chartticketvalue;
					window.chartvaluemonthwise.data.datasets[2].data=countchartdata.charthotelvalue;
					window.chartvaluemonthwise.data.datasets[3].data=countchartdata.chartvisavalue;
					window.chartvaluemonthwise.data.datasets[4].data=countchartdata.chartothervalue;
					window.chartvaluemonthwise.options.title.text=countchartdata.chartvaluetitle;
					window.chartvaluemonthwise.update(); */
	  				
					
					var ptypelisthtml='';
					$.each(policynodata.ptypedata, function( index, value ) {
						ptypelisthtml+='<tr>';
						ptypelisthtml+='<td>'+(index+1)+'</td>';
						ptypelisthtml+='<td>'+value.code+'</td>';
						ptypelisthtml+='<td>'+value.total+'</td>';
						ptypelisthtml+='<td>'+value.vacant+'</td>';
						ptypelisthtml+='<td>'+value.onhire+'</td>';
						ptypelisthtml+='</tr>';
					});
					$('.tblproptype tbody').html($.parseHTML(ptypelisthtml));
					
					$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp", true);
	  		x.send();
		}
		
		function SaveToDisk(fileURL, fileName) {
	   		var host = window.location.origin;
	   		var splt = fileURL.split("webapps"); 
	   		var repl = splt[1].replace( /;/g, "/");
	   		fileURL=host+repl;
	    	
	    	if (!window.ActiveXObject) {
	        	var save = document.createElement('a');
	        	save.href = fileURL;
	        	save.target = '_blank';
	        	save.download = fileName || 'unknown';
	        	window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	    	}

	    	// for IE
	    	else if ( !! window.ActiveXObject && document.execCommand){
	        	var _window = window.open(fileURL, '_blank');
	        	_window.document.close();
	        	_window.document.execCommand('SaveAs', true, fileName || fileURL)
	       	 	_window.close();
	    	}
		}
    	function funRoundAmt(value,id){
    		var res=parseFloat(value).toFixed(2);
    		var res1=(res=='NaN'?"0":res);
    		document.getElementById(id).value=res1;  
   		}
   		
   		function loadsummaryASGrid(acno){
       		$('.page-loader').show();
       		var fdate=$('#fromdate').jqxDateTimeInput('val');    
            var tdate=$('#todate').jqxDateTimeInput('val'); 
            var brch="a";
       	  	$('#summasdiv').load("summaryASGrid.jsp?accdocno="+acno+"&id="+1+"&fromdate="+fdate+"&todate="+tdate+"&branchval="+brch);       
        }
    </script>    
</body>
</html>