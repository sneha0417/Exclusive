<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Inspection Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://daneden.github.io/animate.css/animate.min.css">
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css"
	rel="stylesheet" />
<jsp:include page="../../../../propertyIncludes.jsp"></jsp:include>
<style type="text/css">
.btn-group
>
.btn


:first-child


:not

 

(
:last-child

 

)
:not

 

(
.dropdown-toggle

 

)
{
border-radius


:

 

30
px

 

!
important


;
}

.panel-body {
  padding: 0px !important;  
}
.btn:focus,.btn:active {
	outline: none !important;
	box-shadow: none;
}

.modalStyle {
	background-color: #33b5e5;
	padding: 10px;
}

.borderStyle {
	margin-bottom: 0;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	border: none;
	line-height: 1.42857143;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
/* 	box-shadow: 1px 2px 7px 0px #d4cece; */
	position: relative;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
}

.iconStyle {
	color: #000000 !important;
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;
}

.btnStyle {
	display: inline-block;
	margin-bottom: 0;
	font-weight: 400;
	margin-right: 5px;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	background-image: none;
	border: none;
	padding: 3px 8px;
	font-size: 14px;
	line-height: 1.42857143;
	border-radius: 30px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);
	position: relative;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
}

@media ( min-width : 900px) {
	.modal-xl {
		width: 100%;
		max-width: 1200px;
	}
}

.textpanel {
	color: blue;
}

.custompanel {
	float: left;
	display: inline-block;
	margin-top: 0px;
	padding-top: 10px;
	padding-bottom: 0px;
	border-radius: 8px;
}

.badge-notify {
	position: absolute;
	right: -5px;
	top: -8px;
	z-index: 2;
	background-color: red;
}

.comment {
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: #fff;
	clear: both;
	float: right;
	display: block;
	padding-top: 8px;
	padding-bottom: 2px;
	padding-left: 10px;
	padding-right: 5px;
	border-radius: 12px;
	border-top-right-radius: 0;
	margin-bottom: 8px;
	transition: all 0.5s ease-in;
}

.msg-details {
	text-align: right;
}

.comments-container {
	height: 400px;
	overflow-y: auto;
	margin-bottom: 8px;
	padding-right: 5px;
}

.comments-outer-container {
	width: 100%;
	height: 100%;
}

.msg {
	word-break: break-all;
}

.rowgap {
	margin-bottom: 6px;
}
.hidden-scrollbar {
	overflow: auto;
	height: 530px;
}

</style>
</head>

<body onload="getStatuslist();getUserlist();">

	<div class='hidden-scrollbar'>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div class="todatepanel custompanel">
					<table>
						<tr>
						    <td align="left"><input type="radio" id="hndover" name="hndover1" onchange="fundisable();" value="hndover" >
						    <label for="hndover" class="branch" style="font-size: 13px">Hand Over &nbsp;&nbsp;</label>&nbsp;&nbsp;
							<input type="radio" id="hndback" name="hndover1"  onchange="fundisable();" value="hndback" >	
							<label for="hndback" class="branch" style="font-size: 13px">Hand Back &nbsp;&nbsp;</label></td>
								
							<!-- <td align="right"><label class="branch"
								style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>
							<td align="left"><div id='fromdate' name='fromdate'></div></td>
							<td align="right"><label class="branch"
								style="font-size: 13px">To Date &nbsp;&nbsp;</label></td>
							<td align="left"><div id='todate' name='todate'></div></td> -->
						</tr>
					</table>
				</div>
				<div class="primarypanel custompanel" style="margin-left: 15px;">
					<button type="button" class="btn btn-default btnStyle"
						id="btnsubmit" data-toggle="tooltip" title="Submit"
						data-placement="bottom">
						<i class="fa fa-refresh iconStyle" aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-default btnStyle"
						id="btnexcel" data-toggle="tooltip" title="Excel Export"
						data-placement="bottom">
						<i class="fa fa-file-excel-o " aria-hidden="true"></i>
					</button>
					<!-- <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button> -->
				</div>
				<div class="actionpanel custompanel">
					<!-- <button type="button" class="btn btn-default btnStyle"
						id="btnstatusupdate" data-toggle="modal" data-tooltip="tooltip"
						title="Status Update" data-target="#modalstatusupdate"
						data-placement="bottom">
						<i class="fa fa-database " aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-default btnStyle"
						id="btnscheduledate" data-toggle="modal" data-tooltip="tooltip"
						title="Schedule Inspection date" data-target="#modalscheduledate"
						data-placement="bottom">
						<i class="fa fa-calendar" aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-default btnStyle" id="btnestimateupdate" data-toggle="modal" data-target="#modalestimateupdate" data-tooltip="tooltip" title="Estimate" data-placement="bottom"><i class="fa fa-usd " aria-hidden="true"></i></button>
					<button type="button" class="btn btn-default btnStyle"
						id="btnemail" data-toggle="modal" data-tooltip="tooltip"
						title="Email to Owner" data-placement="bottom">
						<i class="fa fa-envelope " aria-hidden="true"></i>
					</button> -->
				    <button type="button" class="btn btn-default btnStyle"
						id="btnassign"   data-tooltip="tooltip" data-toggle="modal"
						title="Assign" data-placement="bottom" data-target="#modalassignuser">
						<i class="fa fa-file-text-o " aria-hidden="true"></i>
					</button> 
					
					<!-- <button type="button" class="btn btn-default btnStyle" id="btnaccounted"  data-toggle="modal"  data-target="#modalAccounts" data-tooltip="tooltip" title="Accounted" data-placement="bottom"><i class="fa fa-tasks " aria-hidden="true"></i></button> -->
					<!--  <button type="button" class="btn btn-default btnStyle" id="btnbill"   data-tooltip="tooltip" title="Bill" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button> -->
				</div>
				<div class="otherpanel custompanel">
					<!--   <button type="button" class="btn btn-default btnStyle" id="btncomment"  data-toggle="modal" data-target="#modalcomments"  data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnconfirm"  data-toggle="modal"  data-tooltip="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check " aria-hidden="true"></i></button> -->
				</div>
				<div class="textpanel custompanel"
					style="padding-top: 0; margin-top: 0; padding-bottom: 0; margin-bottom: 0;">
					<p
						style="font-size: 75%; margin: 0px; padding-top: 15px; padding-left: 6px;">&nbsp;</p>
				</div>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				<div id="ppdiv" class="borderStyle"><jsp:include
						page="handoverbackGrid.jsp"></jsp:include></div>
			</div>
		</div>
			<%-- <div class="row  ">
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
			<h5>Status Update History</h5>
				<div id="statushisdiv"><jsp:include
						page="statushistoryGrid.jsp"></jsp:include></div>
			</div>
			<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6"  >
				<h5>Schedule Date History</h5>
				<div id="schedulehisdiv"><jsp:include
						page="schedulehistoryGrid.jsp"></jsp:include></div>
			</div>
		</div> --%>
 
 
 </div>
 
 </div>
		<!-- schedule ins date -->
		<div id="modalscheduledate" class="modal fade" role="dialog">
			<div class="modal-dialog   modal-sm">
				<div class="modal-content">
					<div class="modal-header modalStyle">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" style="text-align: center">Schedule
							Inspection Date</h4>
						<p id="clientref1" style="text-align: center;"></p>
					</div>
					<div class="modal-body">
						<p>
							<!-- Some text in the modal. -->
						</p>
						<div class="container-fluid">
							<!-- <div class="row rowgap">
								<div class="col-md-6">Inspection Type</div>
								<div class="col-md-6">
									<select class="cmbleadstatus" name="cmbinstype" id="cmbinstype"
										style="width: 100%">
										<option value="">--Select--</option>
										<option value="HY">Half Yealy</option>
										<option value="Q">Quaterly</option>
										<option value="M">Monthly</option>
									</select>
								</div>
							</div>
							<div class="row rowgap">
								<div class=" col-md-6 ">As Per</div>
								<div class=" col-md-6 ">
									<select class="cmbleadstatus" name="cmbinsper" id="cmbinsper"
										style="width: 100%">
										<option value="">--Select--</option>
										<option value="T">Tenancy</option>
										<option value="P">Property</option>
									</select>
								</div>
							</div>
							<hr/> -->
						<!-- 	<div class="row rowgap">
								<div class=" col-md-6 ">Schedule a Date	</div>
								<div class=" col-md-6 ">
									<input type="checkbox" id="chkschedule" name="chkschedule" >
								</div>
							</div> -->
							<div class="row rowgap">
								<div class=" col-md-6 ">Date</div>
								<div class=" col-md-6 ">
									<div id="insdate" name="insdate"></div>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
									style="text-align: center;">
									<button type="button" class="btn btn-default btnStyle"
										id="btnscheduleupdate" title="Update" data-placement="bottom"
										onclick="funscheduleinspection();">
										<i class="fa fa-floppy-o " aria-hidden="true"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
				</div>
			</div>
		</div>


		<!-- status update Modal-->
		<div id="modalstatusupdate" class="modal fade" role="dialog">
			<div class="modal-dialog   modal-sm">
				<div class="modal-content">
					<div class="modal-header modalStyle">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" style="text-align: center">Status
							Update</h4>
						<p id="clientref1" style="text-align: center;"></p>
					</div>
					<div class="modal-body">
						<p>
							<!-- Some text in the modal. -->
						</p>
						<div class="container-fluid">
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Status</div>
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
									<select class="cmbinsstatus" name="cmbinsstatus"
										id="cmbinsstatus" style="width: 100%">
									</select>
								</div>
							</div>
								<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Remarks</div>
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
									 <textarea id="txtstatusremarks" name="txtstatusremarks" rows="3" style="width: 100%"></textarea>
								</div>
							</div>
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
									style="text-align: center;">
									<button type="button" class="btn btn-default btnStyle"
										id="btnupdate" title="Update" data-placement="bottom"
										onclick="funstatusupdate();">
										<i class="fa fa-floppy-o " aria-hidden="true"></i>
									</button>
								</div>
							</div>
							 
						</div>
					</div>
					<!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
				</div>
			</div>
		</div>
		
		<!-- status assign Modal-->
		<div id="modalassignuser" class="modal fade" role="dialog">
			<div class="modal-dialog   modal-sm">
				<div class="modal-content">
					<div class="modal-header modalStyle">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" style="text-align: center">Assign User
							</h4>
						<p id="clientref1" style="text-align: center;"></p>
					</div>
					<div class="modal-body">
						<p>
							<!-- Some text in the modal. -->
						</p>
						<div class="container-fluid">
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">User</div>
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
									<select class="cmbuser" name="cmbuser"
										id="cmbuser" style="width: 100%">
									</select>
								</div>
							</div>
								<!-- <div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Remarks</div>
								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
									 <textarea id="txtstatusremarks" name="txtstatusremarks" rows="3" style="width: 100%"></textarea>
								</div>
							</div> -->
							<div class="row rowgap">
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
									style="text-align: center;">
									<button type="button" class="btn btn-default btnStyle"
										id="btnassign" title="Assign" data-placement="bottom"
										onclick="funassignupdate();">
										<i class="fa fa-floppy-o " aria-hidden="true"></i>
									</button>
								</div>
							</div>
							 
						</div>
					</div>
					<!--   <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:F32020">Close</button>
          </div> -->
				</div>
			</div>
		</div>
		 
		  
	<input type="hidden" name="hidpdate" id="hidpdate">
	<input type="hidden" name="hidtdate" id="hidtdate">
	<input type="hidden" name="hidtdocno" id="hidtdocno">
	<input type="hidden" name="hidtemail" id="hidtemail">
	<input type="hidden" name="hidinsdate" id="hidinsdate">	
	<input type="hidden" name="hidcomments" id="hidcomments">
	<input type="hidden" name="txtrefname" id="txtrefname">
	<input type="hidden" name="clientid" id="clientid">
	<input type="hidden" name="txtoldstatus" id="txtoldstatus">
	<input type="hidden" name="statusid" id="statusid">
	<input type="hidden" name="txtcrtuser" id="txtcrtuser">
	<input type="hidden" name="txtasgnuser" id="txtasgnuser">
	<input type="hidden" name="txttrno" id="txttrno">
	<input type="hidden" name="txtpendocno" id="txtpendocno">
	<input type="hidden" name="hidastatus" id="hidastatus">
	<input type="hidden" name="hiddocno" id="hiddocno">
	
	<input type="hidden" name="statuchk" id="statuchk">
	<input type="hidden" name="hidtentacno" id="hidtentacno">
	<input type="hidden" name="hidownacno" id="hidownacno">
	<input type="hidden" name="hidownacname" id="hidownacname">
	<input type="hidden" name="hidsupacname" id="hidsupacname">
	<input type="hidden" name="hidsupacno" id="hidsupacno">
	<input type="hidden" name="hidestcost" id="hidestcost">
	<input type="hidden" name="hidmargin" id="hidmargin">
	<input type="hidden" name="hidtrno" id="hidtrno">
	<input type="hidden" name="hidproperty" id="hidproperty">
	<input type="hidden" name="hidmrfacno" id="hidmrfacno">
	<input type="hidden" name="hidjob" id="hidjob">
	<input type="hidden" name="hidhnd" id="hidhnd">
	<input type="hidden" name="hidposttrno" id="hidposttrno">
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
	<script type="text/javascript">   
	
$(document).ready(function(){ 
    	     	
	   document.getElementById("hndover").checked=true;
	   document.getElementById("hidhnd").value="1";  
    	 $('[data-tooltip="tooltip"]').tooltip();
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 /* $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"}); */
    	/*  $("#wdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});    
    	 $("#invdate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"}); */
    	 $("#insdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	 
       	/*  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));    
			  
	     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));  
	     $('#todate').on('change', function (event) {
					
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  
		 	 
		   if(fromdates>todates){  
			    $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   return false;
		  }});    */                
	     
    	 $('[data-toggle="tooltip"]').tooltip(); 
       
         $('#btnconfirm').click(function(){                
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	funConfirm();
        }); 
        $('#btnemail').click(function(){                
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	funEmail();
        });
        $('#btnstatusupdate').click(function(){                
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}   
        });          
        
        $('#btnassign').click(function(){                
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}   
        });   
        
        $('#btnscheduledate').click(function(){                
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}        	
        });         
         
        $('#btnsubmit').click(function(){ 
        	 $("#overlay, #PleaseWait").show();
            funload();    
            $('.textpanel p').text("");
            $('#hiddocno').val('');                       
        });          
         
        $('#btnexcel').click(function(){
        	if(document.getElementById("hndover").checked){
		//        JSONToCSVCon(dataexcel, 'Hand Over', true);
        		 $("#pagrid").excelexportjs({
						containerid: "pagrid",
						datatype: 'json',
						dataset: null,
						gridId: "pagrid",
						columns: getColumns("pagrid"),
						worksheetName: "Hand Over"
					});
        	}
        	if(document.getElementById("hndback").checked){
       	//	 JSONToCSVCon(dataexcel, 'Hand Back', true);
        		 $("#pagrid").excelexportjs({
						containerid: "pagrid",
						datatype: 'json',
						dataset: null,
						gridId: "pagrid",
						columns: getColumns("pagrid"),
						worksheetName: "Hand Back"
					});
        	}
        });
        $('#btncommentsend').click(function(){
        	 var actdocno=$('#hiddocno').val();
        	var txtcomment=$('#txtcomment').val();  
        	if(actdocno==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
        
       $('.warningpanel div button').click(function(){
        	var gridrows=$('#pagrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');  
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#pagrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    
	 function getStatuslist() { 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var statIdItems  = items[0].split(",");
					var statItems = items[1].split(",");
					
					var statusoptions='<option value=""> select</option>';
					for (var i = 0; i < statItems.length; i++) {
						statusoptions += '<option value="' + statIdItems[i].trim() + '">'
								+ statItems[i] + '</option>';
					}
					$("select#cmbinsstatus").html(statusoptions);
				} else {
				}  
			}
			x.open("GET","getStatus.jsp",true);   
			x.send();
		} 
	 
	 function getUserlist() { 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var statIdItems  = items[0].split(",");
					var statItems = items[1].split(",");
					
					var statusoptions='<option value=""> select</option>';
					for (var i = 0; i < statItems.length; i++) {
						statusoptions += '<option value="' + statIdItems[i].trim() + '">'
								+ statItems[i] + '</option>';
					}
					$("select#cmbuser").html(statusoptions);
				} else {
				}  
			}
			x.open("GET","getUser.jsp",true);   
			x.send();
		} 
	 
    function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

        var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
        
       // alert("arrData");
        var CSV = '';    
        //Set Report title in first row or line
        
        CSV += ReportTitle + '\r\n\n';

        //This condition will generate the Label/Header
        if (ShowLabel) {
            var row = "";
            
            //This loop will extract the label from 1st index of on array
            for (var index in arrData[0]) {
                
                //Now convert each value to string and comma-seprated
                row += index + ',';
            }

            row = row.slice(0, -1);
            
            //append Label row with line break
            CSV += row + '\r\n';
        }
        
        //1st loop is to extract each row
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            
            //2nd loop will extract each column and convert it in string comma-seprated
            for (var index in arrData[i]) {
                row += '"' + arrData[i][index] + '",';
            }

            row.slice(0, row.length - 1);
            
            //add a line break after each row
            CSV += row + '\r\n';
        }

        if (CSV == '') {        
            alert("Invalid data");
            return;
        }   
        
        //Generate a file name
        var fileName = "";
        //this will remove the blank-spaces from the title and replace it with an underscore
        fileName += ReportTitle.replace(/ /g,"_");   
        
    	 // newly added 
        var temp = CSV;
        blob = new Blob([temp],{type: 'text/csv'});
        var bigcsv= window.webkitURL.createObjectURL(blob);  
        //Initialize file format you want csv or xls
      //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV); 
        // Now the little tricky part.
        // you can use either>> window.open(uri);
        // but this will not work in some browsers
        // or you will not get the correct file extension    
        
        //this trick will generate a temp <a /> tag
        var link = document.createElement("a");    
         //  link.href = uri;
          link.href = bigcsv;
        
        //set the visibility hidden so it will not effect on your web-layout
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        
        //this part will append the anchor tag and remove it after automatic click
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
       
    function funscheduleinspection(){
 	/*   var instype=$('#cmbinstype').val();
 	  var insper=$('#cmbinsper').val(); */
      var tdocno=$('#hidtdocno').val();
 	  var docno=$('#hiddocno').val();
 	  var insdate=$('#insdate').jqxDateTimeInput('val');
 	 
 	   	var x=new XMLHttpRequest();
 			x.onreadystatechange=function(){
 				if (x.readyState==4 && x.status==200)
 				{
 					var items=x.responseText.trim();
 					var str='';
 					if(items!=''){ 
 						swal({
 							type: 'success',
 							title: 'Message',
 							text: 'Successfully Updated'
 						});  						
 						$('#modalscheduledate').modal('toggle');
 						 funload();    
 					}else{
 						swal({
 							type: 'error',
 							title: 'Warning',
 							text: 'Not Updated'                                     
 						});
 					} 							
 				}	   
 				else
 				{
 				}
 			}
 			x.open("GET","scheduleUpdate.jsp?docno="+docno +"&tdocno="+tdocno+"&insdate="+insdate,true);     
 			x.send();     
    }
    
   function funstatusupdate(){
	   var statval=$('#cmbinsstatus').val();
	   var remarks=$('#txtstatusremarks').val();	  
	   var tdocno=$('#hidtdocno').val();
	 	var docno=$('#hiddocno').val();
	  
	   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var str='';
					if(items!=''){ 
						swal({
							type: 'success',
							title: 'Message',
							text: 'Successfully Updated'
						}); 
						$('#cmbinsstatus').val('');
						$('#modalstatusupdate').modal('toggle');
						$('#txtstatusremarks').val('');
					}else{
						swal({
							type: 'error',
							title: 'Warning',
							text: 'Not Updated'                                     
						});
					}							
				}	   
				else
				{
				}
			}
			x.open("GET","statusUpdate.jsp?docno="+docno+"&status="+statval+"&remarks="+remarks+"&tdocno="+tdocno,true);     
			x.send();     
   }
   
   function funassignupdate(){
	   var statval=$('#cmbuser').val();	  
	   var tdocno=$('#hidtdocno').val();
	 	var docno=$('#hiddocno').val();
	 	var hand=$('#hidhnd').val();
	  
	   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var str='';
					if(items!=''){ 
						swal({
							type: 'success',
							title: 'Message',
							text: 'Successfully Updated'
						}); 
						$('#cmbuser').val('');
						$('#modalassignupdate').modal('toggle');
						funload();
						
					}else{
						swal({
							type: 'error',
							title: 'Warning',
							text: 'Not Updated'                                     
						});
					}							
				}	   
				else
				{
				}
			}
			x.open("GET","assignUpdate.jsp?docno="+docno+"&status="+statval+"&tdocno="+tdocno+"&hand="+hand,true);     
			x.send();     
   }
   
   function funConfirm(){	
	var enqno=$('#hiddocno').val();
   	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				var str='';
				if(items!=''){ 
					swal({
						type: 'success',
						title: 'Message',
						text: 'Successfully Confirmed'
					}); 
					funload();
				}else{
					swal({
						type: 'error',
						title: 'Warning',
						text: 'Not Confirmed'                                     
					});
				}						
			}	   
			else
			{
			}
		}
		x.open("GET","statusUpdate.jsp?docno="+enqno+"&confirm=1",true);     
		x.send();     
   }
    
   function funEmail(){
		var doc=$('#hiddocno').val();
		if(doc=='' || doc==0 || doc=='undefined'){    
			$.messager.alert('Message', ' Please select a document.','warning');
			return 0;
		}  
		 var statu=$('#statuchk').val();
		if( statu==3){
			$.messager.alert('Message', ' Email Already Send.','warning');
		}
		else{
		 $.messager.confirm('Message', 'Do you want to send E-mail?', function(r){
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }  
	     	else{
	     		funSendMail();	
	     	}
		});
		}
	}
   
   function fundisable(){
	    if(document.getElementById("hndover").checked){
		   //document.getElementById("hndback").checked=false;
		   document.getElementById("hidhnd").value="1";
	   }
	   else if(document.getElementById("hndback").checked){
		   //document.getElementById("hndover").checked=false;
		   document.getElementById("hidhnd").value="2";
	   } 
	  
   }
   
   function funEmailStatUpdate(){
	   var statval="3";
	   //alert("statval========"+statval);
	   var enqno=$('#hiddocno').val();
	   	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var str='';
					if(items!=''){ 
						
					}else{
						
					}
				}	   
				else
				{
				}
			}
			x.open("GET","statusUpdate.jsp?docno="+enqno+"&status="+statval,true);     
			x.send();     
   }
   
	function funSendMail(){   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim().split("::");
		var email=$('#hidtemail').val();		
		var insdate=$('#hidinsdate').val();
		
		var cldocno="";
		var msg="";      
		var client="";
		if(items!=""){
		 msg=items[0];
	   /*   email=items[1];
	     cldocno=items[2]; */
	     //client=items[3];  
		}
		var brchid="<%=session.getAttribute("BRANCHID").toString()%>";    
		var userid="<%=session.getAttribute("USERID").toString()%>";     
  		var contrctno=document.getElementById("hiddocno").value; 
  		funEmailStatUpdate();
  		var frmdet="PPTY";  
  		var dtype="IMT";        
  		var fname="Inspection Management"; 
  		var subject="Inspection Confirmation";
		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="
									+ dtype + "&docno=" + contrctno
									+ "&brchid=" + brchid + "&frmname=" + fname
									+ "&recipient=" + email + "&cldocno="
									+ cldocno + "&client=" + client
									+ "&userid=" + userid + "&subject="
									+ subject + "&dtype=" + frmdet + "&msg="
									+ encodeURIComponent(msg), "E-Mail",
							"menubar=0,resizable=1,width=900,height=950");
				}
			}
			x.open("GET", "sendMail.jsp?docno=" + $('#hiddocno').val()
					+ "&brhid=" + $('#cmbbranch').val()+ "&insdate=" + $('#hidinsdate').val(), true);
			x.send();
		}
	
		function funload() {
			/* var fromdate = $('#fromdate').jqxDateTimeInput('val');
			var todate = $('#todate').jqxDateTimeInput('val'); */
			var hand=document.getElementById("hidhnd").value;
			$('#ppdiv').load(
					"handoverbackGrid.jsp?hand="+hand+"&id=" + 1);			
			
		} 
		
		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode
			if (charCode > 31 && ((charCode < 48) || (charCode > 57)))
				return false;
			return true;
		}
		
		/* attachimages */
		function funAttach(){
			var brchid="<%=session.getAttribute("BRANCHID").toString()%>";   
			var frmname="Property Master";
			var frmcode="PPM";
			
			if ($("#hiddocno").val()!="") {
				 
				 var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+ 
						 				+ frmcode +"&docno="
										+ document.getElementById("hiddocno").value
										+ "&brchid="
										+ brchid +
										+ "&frmname="+ 
										+ frmname,
								"_blank",
								"top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();

			} else {
				
				swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false; 
			}
		}
	</script>
</body>

</html>
