 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Property Inspection</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="css/util.css">
	<link rel="stylesheet" href="css/signature-pad.css">
	<style type="text/css">
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
		.page-loader{
			width:100vw;
			height:100vh;
			background-color:rgba(255,255,255,0.5);
			position:fixed;
			z-index:9999999;
		}
		.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
			background-color: var(--main-bg-color);
	    	border-color: var(--main-bg-color);
			color:#fff;
			position:absolute;
			top:50%;
			left:50%;
			transform:translate(-50%,-50%);
		}
		.room-container,.key-container{
			background-color: #fff;
			box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
			padding: 20px;
			display: inline-block;
			cursor: pointer;
		}
		.room-container.active,.key-container.active{
			background-color:var(--main-bg-color);
		}
		.room-container.active .roomname,.key-container.active .keyname{
			color: #fff;
		}
		#filterlist li{
			cursor:pointer;
		}
		.room-outer-container{
			width: 100%;
			background-color: transparent;
			border:none;
			outline: none;
		}
		.room-outer-container .outer-wrapper,.outer-wrapper-keys{
			max-width: 100%;
			overflow-x: auto;
			scroll-behavior: smooth;
			white-space: nowrap;
			display: inline;
			float: left;
			background-color: transparent;
			border:none;
			outline: none;
		}
		
		
		@media (max-width: 767px) {
    		.custom-tabs.nav-pills > li {
			    float:none;
			    display:inline-block;
			}	
		}

	</style>
</head>
<body  onselectstart="return false" onclick="getsessionset();">
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
      					<img alt="" src="images/exclusivelinks.png" style="width:auto; height: 100%;">
      				</span>
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li><a data-toggle="pill" href="#insppending"><i class="fa fa-hourglass-end p-r-5"></i>Inspection Pending</a></li>
      				<!-- <li><a data-toggle="pill" href="#inspcompleted"><i class="fa fa-check p-r-5"></i>Inspection Completed</a></li> -->
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
	<div class="container-fluid m-t-30 m-b-10">
		<div class="tab-content">
			<div class="tab-pane fade active in" id="insppending">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<ul class="nav nav-pills custom-tabs nav-justified">
		    				<li class="active"><a data-toggle="pill" href="#menu0"><i class="fa fa-pencil p-r-5"></i>Inspection</a></li>
				    		<li><a data-toggle="pill" href="#menu1"><i class="fa fa-repeat p-r-5"></i>Hand Over</a></li>
				    		<li><a data-toggle="pill" href="#menu2"><i class="fa fa-rotate-left p-r-5"></i>Hand Back</a></li>
		  				</ul>
					</div>
				</div>
				<div class="document-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="search-container">
								<input class="form-control" id="filterinput" type="text" placeholder="Search..">
								<ul class="list-group" id="filterlist">
		    						
		  						</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="document-selected">
					<div class="input-group">
		    			<input type="text" class="form-control" name="selecteddoc" id="selecteddoc">
		    			<div class="input-group-btn">
		      				<button class="btn btn-default" type="button">
		        				<i class="fa fa-pencil"></i>
		      				</button>
		    			</div>
		  			</div>
				</div>
				<div class="room-outer-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="outer-wrapper-keys p-t-10 p-b-20 nav nav-pills">
							</div>		
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="tab-content key-detail-container">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="outer-wrapper p-t-10 p-b-20 nav nav-pills">
							</div>		
						</div>
					</div>
				</div>
				<div class="feature-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="tab-content">
							</div>
						</div>
					</div>
				</div>
				<div class="signature-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="form-group">
								<select class="form-control" name="cmbsignstatus" id="cmbsignstatus">
									<option value="">--Select--</option>
									<option value="1">No Issues</option>
									<option value="2">Minor</option>
									<option value="3">Major</option>
								</select>
							</div>
							<div class="form-horizontal" style="margin-top:10px;">
								<div class="form-group">
	    							<label class="control-label col-xs-2" for="email">Repairs list</label>
	    							<div class="col-xs-10">
	      								<input type="text" class="form-control" id="repairslist" placeholder="Enter Repairs">
	    							</div>
	  							</div>
							</div>
							
							<div class="panel panel-default option-panel">
								<div class="panel-heading">
									<h5 class="panel-title">Please select option</h5>
								</div>
								<div class="panel-body">
									<div class="list-group checkbox-list-group">
										
									</div>
								</div>
							</div>
							<div id="signature-pad1" class="signature-pad">
					    		<div class="signature-pad--body">
					      			<canvas style="width:100%;min-height:200px;" width="100%"></canvas>
					    		</div>
					    		<div class="signature-pad--footer">
					      			<div class="description text-center">Inspector Sign above</div>
					      			<div class="signature-pad--actions hidden">
					        			<div>
					          				<button type="button" class="button clear" data-action="clear">Clear</button>
					          				<button type="button" class="button" data-action="change-color">Change color</button>
					          				<button type="button" class="button" data-action="undo">Undo</button>
					        			</div>
					        			<div>
					          				<button type="button" class="button save" data-action="save-png">Save as PNG</button>
					          				<button type="button" class="button save" data-action="save-jpg">Save as JPG</button>
					          				<button type="button" class="button save" data-action="save-svg">Save as SVG</button>
					        			</div>
					      			</div>
					    		</div>
					  		</div>
					  		<div id="signature-pad2" class="signature-pad">
					    		<div class="signature-pad--body">
					      			<canvas style="width:100%;min-height:200px;" width="100%"></canvas>
					    		</div>
					    		<div class="signature-pad--footer">
					      			<div class="description text-center">Tenant Sign above</div>
					      			<div class="signature-pad--actions hidden">
					        			<div>
					          				<button type="button" class="button clear" data-action="clear">Clear</button>
					          				<button type="button" class="button" data-action="change-color">Change color</button>
					          				<button type="button" class="button" data-action="undo">Undo</button>
					        			</div>
					        			<div>
					          				<button type="button" class="button save" data-action="save-png">Save as PNG</button>
					          				<button type="button" class="button save" data-action="save-jpg">Save as JPG</button>
					          				<button type="button" class="button save" data-action="save-svg">Save as SVG</button>
					        			</div>
					      			</div>
					      			<div class="text-center">
					      				<button type="button" class="btn btn-default btn-primary" id="btnsavesignature">Save Signature</button>
					      				<button type="button" class="btn btn-default btn-primary" id="btninspprint">Print</button>
					      				<button type="button" class="btn btn-default btn-primary" id="btnconfirm">Confirm</button>
					      			</div>
					    		</div>
					  		</div>
						</div>
					</div>
				</div>
				<div class="button-container">
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="pull-right">
								<button type="button" class="btn btn-default">Cancel</button>
								<button type="button" class="btn btn-default btn-primary" id="btnsave">Save Changes</button>
								<button type="button" class="btn btn-default btn-primary" id="btnattach">Attach</button>
								<button type="button" class="btn btn-default btn-primary" id="btnsignature">Signature</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="inspcompleted">
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
						<div class="inspcompleted-container m-t-20">
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="fileuploaddiv">
		<jsp:include page="fileUpload.jsp"></jsp:include>
	</div>
	<input type="file" name="file" id="file" class="form-control hidden">
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
	<script src="vendor/signaturepad/signature_pad.umd.js"></script>
	<!--<script src="vendor/signaturepad/app.js"></script>-->
	<script type="text/javascript">
	
	<%-- $(document).click(function(event){
		alert("inside");
		var sessionbr='<%=session.getAttribute("BRANCHID")%>';
		alert("inside"+sessionbr);
		if(sessionbr==""||sessionbr=="null"||sessionbr==null||sessionbr.trim()=="")
		{
			Swal.fire({
				  title: 'Session Out!',
				  text: "Your Secure Session Has Expired ,Please Login Again.....!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Yes'
				}).then((result) => {
				  if (result.isConfirmed) {
						window.location.href=<%=contextPath + "/"%>+"login.jsp";
				  }
				})
      		event.preventDefault();
    	
		}
	});
	 --%>
		var wrapper1 = document.getElementById("signature-pad1"),
		canvas1 = wrapper1.querySelector("canvas"),
		signaturePad1;
	
		var wrapper2 = document.getElementById("signature-pad2"),
		canvas2 = wrapper2.querySelector("canvas"),
		signaturePad2;
		function resizeCanvas(canvas) {
			var ratio =  window.devicePixelRatio || 1;
			canvas.width = canvas.offsetWidth * ratio;
			canvas.height = canvas.offsetHeight * ratio;
			canvas.getContext("2d").scale(ratio, ratio);
		}
	
		resizeCanvas(canvas1);
		signaturePad1 = new SignaturePad(canvas1);
	
		resizeCanvas(canvas2);
		signaturePad2 = new SignaturePad(canvas2);
		
			
		$(document).ready(function(){
			
			$('#cmbsignstatus').select2({
				placeholder: "Select a status",
  				allowClear: true
			});
			$('.room-outer-container,.feature-container,.button-container,.document-selected,.signature-container').hide();
			var navMain = $(".navbar-collapse");
     		navMain.on("click", "a:not([data-toggle='dropdown'])", null, function () {
         		navMain.collapse('hide');
     		});
     		$('#btninspprint').click(function(){
     			var url=document.URL;
     			var reurl=url.split("propertyinspection");
     			var inspdocno=$('#selecteddoc').attr('data-inspdocno');
                var win= window.open(reurl[0]+"propertyinspection/printPropertyInspLogin.action?docno="+inspdocno+"&dtype=BPI","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                win.focus();
     		});
			$('#btnsignature').click(function(){
				var insptype=$('.custom-tabs li.active a').text();
				var inspdocno=$('#selecteddoc').attr('data-inspdocno');
				if(inspdocno=="0" || inspdocno=="" || inspdocno==null || inspdocno=="undefined" || typeof(inspdocno)=="undefined"){
					Swal.fire({
						icon: 'error',
					  	title: 'Warning',
					  	text: 'Please save '+insptype
					});
					return false;
				}
				$('.signature-container').show();
				$('.room-outer-container,.feature-container,.button-container').hide();
				var optionhtml='';
				var optionarray=new Array();
				if(insptype=="Inspection" || insptype=="Hand Back"){
					optionarray.push('I agree that this report fairly represents the condition of the rental unit');
					optionarray.push('I agree the deductions for damages will be from security deposit');
					optionarray.push('I understand if I do not provide utility clearance bills within 10 days and preventing new accounts to be opened the Agents will complete this at a charge of AED 500 per utility company and bill amounts will be deducted from security deposit');
					optionarray.push('I do not agree that this report fairly represents the condition of the rental unit for the following reasons');
				}
				else if(insptype=="Hand Over"){
					optionarray.push('I agree that this report fairly represents the condition of the rental unit');
					optionarray.push('Any additional faults/comments to be noted as part of hand over condition report must be done in writing by Tenant within 72 hours of the date of report');
					optionarray.push('I do not agree that this report fairly represents the condition of the rental unit for the following reason');
				}
				$.each(optionarray, function( index, value ) {
					optionhtml+='<div class="list-group-item">&nbsp;';
					optionhtml+='<label>';
					optionhtml+='<input type="checkbox" id="chkopt'+(index+1)+'"><span class="list-group-item-text"><i class="fa fa-fw"></i>'+value+'</span>';
					optionhtml+='</label>';
					optionhtml+='</div>';
				});
				$('.option-panel .panel-body .list-group').html($.parseHTML(optionhtml));
				$('#selecteddoc').trigger('click');
				document.getElementById("selecteddoc").focus();
			});
			$('#btnsavesignature').click(function(){
     			var testCanvas =null;
     			var insptype=$('.custom-tabs li.active a').text();
		        var propdocno=$('#selecteddoc').attr('data-propdocno');
				var attachdesc="Property "+insptype+" signature of "+propdocno;
				var inspdocno=$('#selecteddoc').attr('data-inspdocno');
				var roomdocno=$('.room-outer-container .outer-wrapper .room-container.active').attr('data-roomdocno');
     			var formname="BPI";
     			var chkopt1=0,chkopt2=0,chkopt3=0,chkopt4=0;
     			var repairslist=$('#repairslist').val();
     			repairslist=encodeURIComponent(repairslist);
  				if(document.getElementById("chkopt1").checked==true){
  					chkopt1=1;
  				}
  				if(document.getElementById("chkopt2").checked==true){
  					chkopt2=1;
  				}
  				if(document.getElementById("chkopt3").checked==true){
  					chkopt3=1;
  				}
  				if ($('#chkopt4').length > 0) {
  					if(document.getElementById("chkopt4").checked==true){
  	  					chkopt4=1;
  	  				}
  				}
    			if(signaturePad1.isEmpty() || signaturePad2.isEmpty()) {
    				Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please enter signature'
					});
					return false;
  				}
  				else{
  					var signerrorstatus=0;
  					var cmbsignstatus=$('#cmbsignstatus').val();
  					//Signature1
  					var dataURL=signaturePad1.toDataURL();
  					var postData = "canvasData="+dataURL;
    				var x = new XMLHttpRequest();
    				x.open("POST","saveSignature.jsp?formname=BPI&docno="+inspdocno+"&descpt="+attachdesc+"&reftypid="+roomdocno+"&signindex=1&cmbsignstatus="+cmbsignstatus+"&chkopt1="+chkopt1+"&chkopt2="+chkopt2+"&chkopt3="+chkopt3+"&chkopt4="+chkopt4+"&repairslist="+repairslist,true); 
    				x.setRequestHeader('Content-Type', 'canvas/upload');
    				x.onreadystatechange=function(){
    					if (x.readyState == 4) {
    						var items = x.responseText.trim();
    						if(items=="0"){
    							var dataURL1=signaturePad2.toDataURL();
    		  					var postData1 = "canvasData="+dataURL1;
    		    				var x1 = new XMLHttpRequest();
    		    				x1.open("POST","saveSignature.jsp?formname=BPI&docno="+inspdocno+"&descpt="+attachdesc+"&reftypid="+roomdocno+"&signindex=2&cmbsignstatus="+cmbsignstatus,true); 
    		    				x1.setRequestHeader('Content-Type', 'canvas/upload');
    		    				x1.onreadystatechange=function(){
    		    					if (x1.readyState == 4) {
    		    						var items1 = x1.responseText.trim();
    		    						if(items1=="0"){
    		    						}
    		    						else{
    										signerrorstatus=1;
    		    						}
    		    					}
    		      				}
    							x1.send(postData1);
    						}
    						else{
								signerrorstatus=1;
    						}
    					}
      				}
					x.send(postData);
  					
					
  					
					if(signerrorstatus==0){
						Swal.fire({
							icon: 'success',
							title: 'success',
							text: 'Signature uploaded'
						});
					}
					else{
						Swal.fire({
							icon: 'error',
							title: 'Error',
							text: 'Signature not uploaded'
						});
					}
  				}
    			
			});
			$('.custom-tabs a').on('shown.bs.tab', function(){
  				getInitData();
  			});
		    $('#btnconfirm').click(function(){
		    	var inspdocno=$('#selecteddoc').attr('data-inspdocno');
		    	var propdocno=$('#selecteddoc').attr('data-propdocno');
		    	var tncdocno=$('#selecteddoc').attr('data-tncdocno');
		    	var insptype=$('.custom-tabs li.active a').text();
				if(inspdocno=="0" || inspdocno=="" || inspdocno==null || inspdocno=="undefined" || typeof(inspdocno)=="undefined"){
					Swal.fire({
						icon: 'error',
					  	title: 'Warning',
					  	text: 'Please save '+insptype
					});
					return false;
				}
				else{
					$('.page-loader').show();
					var x = new XMLHttpRequest();
	  				x.onreadystatechange = function() {
	  					if (x.readyState == 4 && x.status == 200) {
	  						var items = x.responseText.trim();
	  						if(parseInt(items)==0){
		  						Swal.fire({
									icon: 'success',
								  	title: 'Success',
								  	text: insptype+' confirmation successfull'
								});
								getInitData();
	  							$('.room-outer-container,.feature-container,.button-container,.document-selected,.signature-container').hide();
								$('.document-container').show();
	  						}
	  						else{
	  							Swal.fire({
									icon: 'error',
							  		title: 'Warning',
							  		text: 'Not Confirmed'
								});
	  						}
	  						$('.page-loader').hide();
	  					}
	  				}
	  				x.open("GET", "confirmInsp.jsp?propdocno="+propdocno+"&inspdocno="+inspdocno+"&tncdocno="+tncdocno+"&insptype="+encodeURIComponent(insptype), true);
	  				x.send();
				}
		    });
			$('#btnattach').click(function(){
				var activeroom=$('.room-outer-container .outer-wrapper .room-container.active');
				var insptype=$('.custom-tabs li.active a').text();
				if(activeroom.length==0){
					Swal.fire({
						icon: 'error',
					  	title: 'Warning',
					  	text: 'Please select a room'
					});
					return false;
				}
				var inspdocno=$('#selecteddoc').attr('data-inspdocno');
				if(inspdocno=="0" || inspdocno=="" || inspdocno==null || inspdocno=="undefined" || typeof(inspdocno)=="undefined"){
					Swal.fire({
						icon: 'error',
					  	title: 'Warning',
					  	text: 'Please save '+insptype
					});
					return false;
				}
				var roomdocno=$('.room-outer-container .outer-wrapper .room-container.active').attr('data-roomdocno');
				var furndocno=$('#room'+roomdocno).find('.cmbattachfurniture').val();
				if(furndocno=="" || furndocno==null || furndocno=="undefined" || typeof(furndocno)=="undefined"){
					Swal.fire({
						icon: 'error',
					  	title: 'Warning',
					  	text: 'Please select furniture to attach'
					});
					return false;
				}
				$('#file').trigger('click');
				return false;
			});
			$("#filterinput").on("keyup", function() {
    			var value = $(this).val().toLowerCase();
    			$("#filterlist li").filter(function(){
      				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    			});
  			});
  			getInitData();
  			$('.document-selected').find('.btn').click(function(){
  				$('.room-outer-container,.feature-container,.button-container,.document-selected,.signature-container').hide();
				$('.document-container').show();
  				getInitData();
  				
  			});
  			$('#btnsave').click(function(){
  				$('.page-loader').show();
  				var insptype=$('.custom-tabs li.active a').text();
  				insptype=encodeURIComponent(insptype);
  				var strinsptype=$('.custom-tabs li.active a').text();
  				var propdocno=$('#selecteddoc').attr('data-propdocno');
  				var tncdocno=$('#selecteddoc').attr('data-tncdocno');
  				var inspdocno=$('#selecteddoc').attr('data-inspdocno');
  				var scheduledate=$('#selecteddoc').attr('data-scheduledate');
  				const roomlist = document.querySelectorAll(".feature-container .tab-content .tab-pane");
  				const keylist = document.querySelectorAll(".tab-content.key-detail-container .tab-pane");
  				
				var insparray=new Array();
				var keyarray=new Array();
				for(const roomitem of roomlist) {
					var roomdocno=$(roomitem).attr('data-roomdocno');
					const panellist=$(roomitem).find('.panel-body');
					for(const panelitem of panellist){
						var furndocno=$(panelitem).attr('data-furndocno');
						var comment=$(panelitem).find('input[name="furncomments"]').val();
						var inspstatus=$(panelitem).find('.cmbstatus').val();
						if(inspstatus=="" || inspstatus=="undefined" || typeof(inspstatus)=="undefined" || inspstatus==null){
							inspstatus="0";
						}
						comment=encodeURIComponent(comment);
						insparray.push(roomdocno+" :: "+furndocno+" :: "+comment+" :: "+inspstatus);
					}
				}
				for(const keyitem of keylist) {
					var keydocno=$(keyitem).attr('data-keydocno');
					const panellist=$(keyitem).find('.panel-body');
					for(const panelitem of panellist){
						var comment=$(panelitem).find('input[name="keycomments"]').val();
						comment=encodeURIComponent(comment);
						keyarray.push(keydocno+" :: "+comment);
					}
				}
				var x = new XMLHttpRequest();
	  			x.onreadystatechange = function() {
	  				if (x.readyState == 4 && x.status == 200) {
	  					var items = x.responseText.trim();
	  					if(parseInt(items)>0){
	  						var inspsavedocno=parseInt(items);
	  						$('#selecteddoc').attr('data-inspdocno',inspsavedocno);
	  						Swal.fire({
								icon: 'success',
							  	title: 'Success',
							  	text: strinsptype+' successfully created'
							});
	  					}
	  					else{
	  						Swal.fire({
								icon: 'error',
							  	title: 'Warning',
							  	text: strinsptype+' not created'
							});
	  					}
	  					$('.page-loader').hide();
	  				}
	  			}
	  			x.open("GET", "saveInspData.jsp?propdocno="+propdocno+"&tncdocno="+tncdocno+"&insptype="+insptype+"&insparray="+insparray+"&inspdocno="+inspdocno+"&keyarray="+keyarray+"&scheduledate="+scheduledate, true);
	  			x.send();
  			});
  			
		});
		function getsessionset(){
			
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText.trim();
			 	if(parseInt(items)==0)
		 		{
		 		 
		 		
		 		// $.messager.alert('Message','Your Secure Session Has Expired ,Please Login Again.....!','warning');
		 		<%-- $.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
					if (r){
						window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
					}
				}); --%>
		 		
				<%-- Swal.fire({
					  title: 'Session Out!',
					  text: "Your Secure Session Has Expired ,Please Login Again.....!",
					  icon: 'warning',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: 'Yes'
					}).then((result) => {
					  if (result.isConfirmed) {
							event.preventDefault();
							window.location.href=<%=contextPath + "/"%>+"propertyinspection/index.jsp";
					  }
					}) --%>
				let timerInterval
				Swal.fire({
				  title: 'Session Out!',
				  text: 'Your Secure Session Has Expired ,Please Login Again.....!',
				  timer: 5000,
				  timerProgressBar: true,
				  didOpen: () => {
				    Swal.showLoading()
				    timerInterval = setInterval(() => {
				      const content = Swal.getHtmlContainer()
				      if (content) {
				        const b = content.querySelector('b')
				        if (b) {
				          b.textContent = Swal.getTimerLeft()
				        }
				      }
				    }, 100)
				  },
				  willClose: () => {
				    clearInterval(timerInterval)
				  }
				}).then((result) => {
				  /* Read more about handling dismissals below */
				  if (result.dismiss === Swal.DismissReason.timer) {
					  window.location.href=<%=contextPath + "/"%>+"propertyinspection/index.jsp";
				  }
				})
	      	
		 		 /* window.history.back(); */
		 		 				 		 
		 		Exit();
		 		return 0;
		 		}
		 	
			 	
			 	
			 	
			 	
	     }
		}
	      x.open("GET", "sessionset.jsp",true);
	     x.send();
	  
	   }
		function getInitData(){
			$('.page-loader').show();
			var insptype;
  			var mode='<%=request.getParameter("mode")==null?"":request.getParameter("mode").toString()%>';
  			if(mode=="E"){
  				$('#btnsavesignature').hide();
  			}
  			var requestdocno='<%=request.getParameter("docno")==null?"":request.getParameter("docno").toString()%>';
			var requesttype='<%=request.getParameter("insptype")==null?"":request.getParameter("insptype").toString()%>';
  			if(requesttype!=""){
  				$('.custom-tabs li a').each(function(){
  					if($(this).text()==requesttype){
  						$(this).trigger('click');
  					}
  				});
  			}
  			insptype=$('.custom-tabs li.active a').text();
  			insptype=encodeURIComponent(insptype);
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				items=JSON.parse(items);
	  				$('.user-dropdown-text').text(items.username);
	  				var dochtml='';
	  				$.each(items.docdata, function( index, value ) {
	  					dochtml+='<li class="list-group-item" data-propdocno="'+value.propdocno+'" data-tncdocno="'+value.tncdocno+'" data-inspdocno="'+value.inspdocno+'">';
						dochtml+='<div class="row">';
						dochtml+='<div class="col-xs-3">ID</div>';
						dochtml+='<div class="col-xs-9">'+value.id+'</div>';
						dochtml+='</div>';
						dochtml+='<div class="row">';
						dochtml+='<div class="col-xs-3">Property</div>';
						dochtml+='<div class="col-xs-9">'+value.propname+'</div>';
						dochtml+='</div>';
						dochtml+='<div class="row">';
						dochtml+='<div class="col-xs-3">Owner</div>';
						dochtml+='<div class="col-xs-9">'+value.owner+'</div>';
						dochtml+='</div>';
						dochtml+='<div class="row">';
						dochtml+='<div class="col-xs-3">Tenant</div>';
						dochtml+='<div class="col-xs-9">'+value.tenant+'</div>';
						dochtml+='</div>';
						dochtml+='<div class="row">';
						dochtml+='<div class="col-xs-3">Scheduled</div>';
						dochtml+='<div class="col-xs-9">'+value.scheduledate+'</div>';
						dochtml+='</div>';
						dochtml+='</li>';
	  				});
	  				$('#filterlist').html($.parseHTML(dochtml));
	  				$('.custom-tabs').addClass('m-t-30');
	  				$('.room-outer-container,.feature-container,.button-container,.document-selected,.signature-container').hide();
					$('.document-container').show();
	  				const filterlist = document.querySelectorAll("#filterlist li");
					for(const filteritem of filterlist) {
  						filteritem.addEventListener('click', function(event) {
							var propid=$(this).find('.row').eq(0).find('div').eq(1).text();
							var propdocno=$(this).attr('data-propdocno');
							var tncdocno=$(this).attr('data-tncdocno');
							var inspdocno=$(this).attr('data-inspdocno');
							var propname=$(this).find('.row').eq(1).find('div').eq(1).text();
							var scheduledate=$(this).find('.row').eq(4).find('div').eq(1).text();
							$('#selecteddoc').val(propname+" - "+propid);
							$('#selecteddoc').attr('data-propdocno',propdocno);
							$('#selecteddoc').attr('data-tncdocno',tncdocno);
							$('#selecteddoc').attr('data-inspdocno',inspdocno);
							$('#selecteddoc').attr('data-scheduledate',scheduledate);
							$('.room-outer-container,.feature-container,.button-container,.document-selected').show();
							$('.document-container').hide();
							$('#repairslist').val('');
							signaturePad1.clear();
							signaturePad2.clear();
							getRoomData(propdocno);
							
						});
					}
					
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getInitData.jsp?insptype="+insptype+"&mode="+mode+"&requestdocno="+requestdocno, true);
	  		x.send();
		}
		
		function getRoomData(propdocno){
			//$('.page-loader').show();
			var insptype=$('.custom-tabs li.active a').text();
			var strinsptype=$('.custom-tabs li.active a').text();
  			insptype=encodeURIComponent(insptype);
  			var inspdocno=$('#selecteddoc').attr('data-inspdocno');
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				items=JSON.parse(items);
	  				var roomhtml='';
	  				$.each(items.roomdata, function( index, value ) {
	  					roomhtml+='<a data-toggle="pill" href="#room'+value.roomdocno+'">';
	  					roomhtml+='<div class="room-container text-center img-rounded m-r-10" data-roomdocno="'+value.roomdocno+'">';
						roomhtml+='<img src="images/icons/'+value.roomimg+'" style="width: 40px;height: 40px;" >';
						roomhtml+='<p class="roomname">'+value.roomdesc+'</p>';
						roomhtml+='</div>';     
						roomhtml+='</a>';
	  				});
	  				if(strinsptype=="Hand Back" || strinsptype=="Hand Over"){
	  					$('.outer-wrapper-keys,.key-detail-container').show();
	  					var keyhtml='';
		  				$.each(items.keydata, function( index, value ) {
		  					keyhtml+='<a data-toggle="pill" href="#key'+value.keydocno+'">';
		  					keyhtml+='<div class="key-container text-center img-rounded m-r-10" data-keydocno="'+value.keydocno+'">';
							keyhtml+='<p class="keyname">'+value.keydesc+'</p>';
							keyhtml+='</div>';     
							keyhtml+='</a>';
		  				});
		  				$('.outer-wrapper-keys').html($.parseHTML(keyhtml));	
	  					keyhtml='';
		  				$.each(items.keydata, function( index, value ) {
		  					keyhtml+='<div id="key'+value.keydocno+'" class="tab-pane fade" data-keydocno="'+value.keydocno+'">';
		  					keyhtml+='<div class="panel panel-default">';
							keyhtml+='<div class="panel-heading">';
							keyhtml+='<h4 class="panel-title">';
							keyhtml+='<a>'+value.keydesc+'</a>';
							keyhtml+='</h4>';
							keyhtml+='</div>';
				    		keyhtml+='<div class="panel-body">';
				    		if(value.handoverdata!=""){
				    			keyhtml+='<blockquote>';
								keyhtml+='<small class="text-muted">'+value.handoverdata+'</small>';
				    			keyhtml+='</blockquote>';
				    		}
				    		keyhtml+='<input type="text" name="keycomments" class="form-control" placeholder="Add your comments here" value="'+value.comments+'">';
		  					keyhtml+='</div>';
		  					keyhtml+='</div>';
		  					keyhtml+='</div>'
		  				});
		  				
		  				const keylist = document.querySelectorAll(".outer-wrapper-keys .key-container");
						for(const keyitem of keylist) {
	  						keyitem.addEventListener('click', function(event) {
								$('.key-container').removeClass('active');
								$(this).addClass('active');
							});
						}
						$('.key-detail-container').html($.parseHTML(keyhtml));
	  				}
	  				else{
	  					$('.outer-wrapper-keys,.key-detail-container').hide();
	  				}
	  				
	  				$('.room-outer-container .outer-wrapper').html($.parseHTML(roomhtml));
	  				
	  				var tabhtml='';
	  				$.each(items.roomdata, function( index, value ) {
	  					tabhtml+='<div id="room'+value.roomdocno+'" class="tab-pane fade" data-roomdocno="'+value.roomdocno+'">';
    					tabhtml+='<div class="panel-group" id="accordion'+value.roomdocno+'">';
						$.each(value.furnarray, function( subindex, subvalue ) {
							tabhtml+='<div class="panel panel-default">';
							tabhtml+='<div class="panel-heading">';
							tabhtml+='<h4 class="panel-title">';
							tabhtml+='<a data-toggle="collapse" data-parent="#accordion'+value.roomdocno+'" href="#furn'+subvalue.furndocno+'">'+subvalue.furndesc+'</a>';
						    tabhtml+='</h4>';
							tabhtml+='</div>';
							tabhtml+='<div id="furn'+subvalue.furndocno+'" class="panel-collapse">';
			    			tabhtml+='<div class="panel-body" data-furndocno="'+subvalue.furndocno+'">';
			    			if(subvalue.handoverdata!=""){
			    				tabhtml+='<blockquote>';
								tabhtml+='<small class="text-muted">'+subvalue.handoverdata+'</small>';
			    				tabhtml+='</blockquote>';
			    			}
			    			tabhtml+='<input type="text" name="furncomments" class="form-control" placeholder="Add your comments here" value="'+subvalue.comments+'">';
			      			tabhtml+='<select class="form-control cmbstatus" style="width: 100%;">';
							tabhtml+='<option value="">--Select--</option>';
							$.each(items.insptypedata, function( inspindex,inspvalue ) {
								if(subvalue.inspstatus!="" && subvalue.inspstatus==inspvalue.docno){
									tabhtml+='<option value="'+inspvalue.docno+'" selected>'+inspvalue.name+'</option>';
								}
								else if(subvalue.inspstatus=="" && inspvalue.name=="Good"){
									tabhtml+='<option value="'+inspvalue.docno+'" selected>'+inspvalue.name+'</option>';
								}
								else{
									tabhtml+='<option value="'+inspvalue.docno+'">'+inspvalue.name+'</option>';
								}
							});
			      			tabhtml+='</select>';
							tabhtml+='</div>';
							tabhtml+='</div>';
							tabhtml+='</div>';
						});
						tabhtml+='<select class="form-control cmbattachfurniture" style="width: 100%;margin-top:15px;">';
						tabhtml+='<option value="">--Select--</option><option value="0" selected>General</option>';
						$.each(value.furnarray, function( subindex, subvalue ) {
							tabhtml+='<option value="'+subvalue.furndocno+'">'+subvalue.furndesc+'</option>';
						});
						tabhtml+='</select>';
						tabhtml+='</div>';
						tabhtml+='</div>';
	  				});
					$('.feature-container .tab-content').html($.parseHTML(tabhtml));
					$('.cmbstatus').select2({
						placeholder: "Select a status",
    					allowClear: true
					});
					$('.cmbattachfurniture').select2({
						placeholder: "Furniture to attach",
    					allowClear: true
					});
					const roomlist = document.querySelectorAll(".room-outer-container .outer-wrapper .room-container");
					for(const roomitem of roomlist) {
  						roomitem.addEventListener('click', function(event) {
							$('.room-container').removeClass('active');
							$(this).addClass('active');
						});
					}
					$('.room-outer-container .outer-wrapper a').eq(0).trigger('click');
					$('.room-outer-container .outer-wrapper .room-container').eq(0).addClass('active');
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getRoomData.jsp?propdocno="+propdocno+"&insptype="+insptype+"&inspdocno="+inspdocno, true);
	  		x.send();
		}
	</script>
</body>
</html>