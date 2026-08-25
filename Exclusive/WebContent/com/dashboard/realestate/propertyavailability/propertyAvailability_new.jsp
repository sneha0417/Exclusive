<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.dashboard.realestate.propertyavailability.ClsPropertyAvailabilityDAO"%>
<%
ClsPropertyAvailabilityDAO DAO = new ClsPropertyAvailabilityDAO();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />

<title>GatewayERP(i)</title>

<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://cdn.datatables.net/buttons/1.6.1/js/dataTables.buttons.min.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.flash.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.html5.min.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.print.min.js"></script>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedheader/3.1.2/css/fixedHeader.dataTables.min.css">
<script src="https://cdn.datatables.net/fixedheader/3.1.2/js/dataTables.fixedHeader.min.js" type="text/javascript"></script>


 <style type="text/css">

.btnpdf
{
margin-right: 4px;
}

#example_filter {
	display: none;
}

 tfoot {
	display: table-header-group;
}  

table {
	margin: 0 auto;
	width: 100%;
	clear: both;
	border-collapse: collapse;
	table-layout: fixed;
	word-wrap: break-word;
}

.item {
	position: relative;
	/*  padding-top:20px; 
    display:inline-block;*/
}

.occupied-badge {
	position: absolute;
	right: 35px;
	top: -18px;
	background: red;
	text-align: center;
	border-radius: 15px;
	color: white;
	padding: 5px 10px;
	font-size: 10px;
}

.vacant-badge {
	position: absolute;
	right: 35px;
	top: -18px;
	background: #19d219cf;
	text-align: center;
	border-radius: 15px;
	color: white;
	padding: 5px 10px;
	font-size: 10px;
}

.divproperty {
	margin-top: 3em;
	border: 1px solid #ccc;
	padding: 1em;
	box-shadow: 0px 1px 5px 1px #ccc;
}

.btnfilter {
	margin-top: 10px;
	border: #ccc solid 1px;
	padding: 0.5em;
	background-color: #10e2cb;
	color: #fff;
	font-size: 1.3em;
}

.lblpty {
	padding-right: 1em;
	font-weight: 200 !important;
}

@media only screen and (max-width: 600px) {
	.divproperty {
		padding: 0.3em;
		margin-top: 1em;
	}
}

.hidden-scrollbar {
	overflow: auto;
	height: 550px;
}

.page-header {
	padding-bottom: 0px !important;
	margin: 10px 0 20px !important;
}

.nopadding {
	padding: 2 !important;
	margin: 0 !important;
}

.panel .panel-body {
	padding: 0 10px !important;
}

input,label {
	vertical-align: text-top;
}

.btn {
	padding: 2px 4px !important;
}

#example tr
{
cursor:pointer;
}

 .dataTables_filter,
.dataTables_info ,.dataTables_length{
  display: none;
}
 
</style>
</head>

<body onload="getPropertyType();">

	<div class='hidden-scrollbar'>
		<div class="container-fluid">
			<div class="row" id="btnfiltermenu"
				style="padding: 0em; border: #ccc 1px solid; box-shadow: 0px 1px 5px 1px #ccc;">
				<div class="col-md-12 ">
					<div class="col-md-1 nopadding">
						<div class="form-group">
							To
							<div id="todate" name="todate"></div>
						</div>
					</div>
				<!-- 	<div class="col-md-2 nopadding" style="">
						&nbsp;
						<div class="form-group">
							<input type="radio" value="Sale" id="rdotype1" name="rdotype"><label
								for="rdotype1">Sale</label> <input type="radio" value="Rent"
								id="rdotype2" name="rdotype"><label for="rdotype2">Rent</label>
							<input type="checkbox" value="managed" id="chkmanaged"> 
							<label for="chkmanaged">Managed Property</label>
						</div>
					</div> -->
					<div class="col-md-2 nopadding">
						<div class="form-group">
							Area <br />
							<%-- <select id="ddlarea" style="width: 100%;"></select>  --%>
							<input id="jqxArea" placeHolder="Enter Area" type="text"
								style="width: 90%;" />
						</div>
					</div>
					<div class="col-md-2 nopadding">
						<div class="form-group">
							Unit Type <br /> <input id="jqxunittype" placeHolder="Enter Unit Type"
								type="text" style="width: 90%;" />
							<%-- <select id="ddlunittype" style="width: 100%;"></select> --%>
						</div>
					</div>
					<div class="col-md-2 nopadding">
						<div class="form-group">
							Nearest Landmark <br /> <input id="jqxlandmark"
								placeHolder="Enter Landmark" type="text" style="width: 90%;" />
							<%-- <select id="ddllandmark" style="width: 100%;"></select> --%>
						</div>
					</div>
					<div class="col-md-1 nopadding">
						<!-- <input type="checkbox" value="BLD" id="chkBLD" name="prtype">
						<label for="chkBLD">BUILDING</label>
						&nbsp; &nbsp;
						<input type="checkbox" value="VIL" id="chkVIL"
							name="prtype">
							<label for="chkVIL">VILLA</label> 
							&nbsp; <br /> 
							<input type="checkbox" value="PTH" id="chkPTH" name="prtype"><label for="chkPTH">PENT
						HOUSE&nbsp;</label>
						<input type="checkbox" value="APT" id="chkAPT"
							name="prtype"><label for="chkAPT">APT </label><input type="checkbox"
							value="OTH" id="chkOTH" name="prtype"><label for="chkOTH">OTHER</label> &nbsp; -->							
							<div class="form-group">
							Property Type <br />  
						 <select id="cmbpropertype" style="width: 100%;"></select> 
						</div>
					</div>
					<div class="col-md-2" style="padding-top: 22px;">
						<button type="button" style="" class="btn btn-info "
							id="btnSearch" onclick="load_searchdata();">
							<i class="fa fa-search" aria-hidden="true"></i>&nbsp;
						</button>
						<button type="button" style="" class="btn btn-warning "
							onclick="clear_data();">
							<i class="fa fa-close" aria-hidden="true"></i>&nbsp;
						</button>
						 <!--  <button type="button" class="btn btn-primary" style="width: 15%;height: 26px;" onclick="exportToPdf()">
							<i class="fa fa-print" aria-hidden="true"></i>
						</button>
						<button type="button" class="btn btn-success" style="width: 15%;height: 26px;" onclick="exportToExcel()">
							<i class="fa fa-file-excel-o" aria-hidden="true"></i>
						</button>  -->
					</div>
				</div>
			</div>
			
			<div class="row" style="padding:0;display:none;">
			<div class="col-md-6" style="height: 75px;" id="divptypechart">
		<!-- 	<div id="ptypewisechart" style="width: 100%; height: 100px;"></div>	 -->		
		<canvas id="canvas1" style="width: 500px;height: 85px;"  ></canvas> 
<!-- 		<input type="button" class="btn btn-info" value="+" id="btnview">  -->
			</div>
			<div class="col-md-6"  id="divroomchart">
			<!-- <div id="roomwisechart" style="width: 100%; height: 100px;"></div> -->
			<canvas id="canvas2" style="width: 500px;height: 85px;" ></canvas>
			</div>			
			<!-- <div class="col-md-4">
			<div id="mngdwisechart" style="width: 100%; height: 150px;"></div>
			</div> -->			
			</div> 			
			<div class="row" style="padding: 0;margin-top:0 !important;">
				<div class="table-responsive" style="height:500px">
					<table id="example" class="demo table table-fixed table-bordered table-hover"
						style="width: auto; font-size: 12px;">
						<thead>
							<tr>
								<th>doc#</th>
								<th>S</th>
								<th>R</th>
								<th>HC</th>
								<th>Managed</th>
								<th>Area</th>
								<th>Type</th>
								<th>Prop.ID</th>
								<th>Address</th>
								<th>Build Up Area</th>
								<th>Property Description</th>
								<th>Special Note</th>
								<th>Owner</th>
								<th>Contact Number</th>
								<th>Rooms</th> 
								<th>Avai.Date</th>
								<th>Status</th>
								 
							</tr>
						</thead>
						<tfoot>
						<th>doc#</th>
						<th>S</th>
						<th>R</th>
						<th>HC</th>
						<th>Managed</th>
						<th>Area</th>
						<th>Type</th>
						<th>Prop.ID</th>
						<th>Address</th>
						<th>Build Up Area</th>
						<th>Property Description</th>
						<th>Special Note</th>
						<th>Owner</th>
						<th>Contact Number</th>
						<th>Rooms</th>
						
						<th>Avai.Date</th>
						<th>Status</th>							
						</tfoot>
					</table>
				</div>
			</div>
			<!-- <div id="divlist"></div> -->
		</div>
	</div>

	<input type="hidden" name="areaid" id="areaid">
	<input type="hidden" name="typeid" id="typeid">
	<input type="hidden" name="nlmid" id="nlmid">
	
	<!-- Modal -->
<div id="Modalptype" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Property Type Wise Chart</h4>
      </div>
      <div class="modal-body">
       <canvas id="canvasm1"></canvas>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>

<div id="Modalroomwise" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Room Wise Chart</h4>
      </div>
      <div class="modal-body">
       <canvas id="canvasm2"></canvas>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>

  </div>
</div>
	
	<script type="text/javascript"> 
var table;
 
	$(document).ready(function() {
		
		  var tbl = $('#example').DataTable();		  
			$("#example tbody").delegate("tr", "click", function() {
				 // var firstCellText = $("td:first", this).text();
				 // var fourthCellText = $("td:eq(3)", this).text();
				 var pdoc = $("td:first", this).text();
				 //alert(pdoc);
				 showPropertyMasterInTab( pdoc);
			});

			$("#todate").jqxDateTimeInput({
				width : '80px',
				height : '25px',
				formatString : "dd.MM.yyyy"
			});

			$("body")
					.prepend(
							'<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
			$("body")
					.prepend(
							"<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
 
			autocompleteArea();
			autocompleteType();
			autocompleteLandmark();
			//load_data();
		$('#example tfoot th').each(function() {
			$(this).html('<input type="text" placeholder="" style="width:100%;" />');
		});
 	
		  //load charts
		  var ptypedata= '<%=DAO.ptypewisedata()%>';
		  var obj = JSON.parse(ptypedata);
		  var labels = obj.map( function(e) {
			   return e.type;
			});
			var data = obj.map( function(e){
			   return e.num;
			});

			var ctx = canvas1.getContext('2d');
			var config = {
			   type: 'line',
			   data: {
			      labels: labels,
			      datasets: [{
			         label: 'Property Type Wise ',
			         data: data,
			         borderWidth: 1,
			         backgroundColor:'transparent',
			         borderColor:'#c70a36'
			      }]
			   },
			   options: {
	                responsive: false,
	                scales: {
	                    yAxes: [{
	                        ticks: {
	                            display: false
	                        }
	                    }]
	                }
	            }
			};

			var chart = new Chart(ctx, config);
			
			var ctx2 = canvasm1.getContext('2d');
			var config2 = {
			   type: 'line',
			   data: {
			      labels: labels,
			      datasets: [{
			         label: 'Property Type Wise ',
			         data: data,
			         borderWidth: 1,
			         backgroundColor:'transparent',
			         borderColor:'#c70a36'
			      }]
			   },
			   options: {
	                responsive: false,
	                scales: {
	                    yAxes: [{
	                        ticks: {
	                            display: false
	                        }
	                    }]
	                }
	                
	            }
			};
			var chart = new Chart(ctx2, config2);
			  
             /* 	roomwise chart */
			   var roomdata= '<%=DAO.roomewisedata()%>';
			   var obj1 = JSON.parse(roomdata);
			   var labels1 = obj1.map( function(e) {
					   return e.room;
					});
					var data1 = obj.map( function(e){
					   return e.num;
					});

					var ctx1 = canvas2.getContext('2d');
					var config1 = {
					   type: 'line',
					   data: {
					      labels: labels1,
					      datasets: [{
					         label: 'Room Wise',
					         data: data1,
					         borderWidth: 1,
					         backgroundColor:'transparent',
					         borderColor:'#1f0ac7'
					      }]
					   },
					   options: {
			                responsive: false,
			                scales: {
			                    yAxes: [{
			                        ticks: {
			                            display: false
			                        }
			                    }]
			                }
			            }
					};

					var chart = new Chart(ctx1, config1);
					
					// for modal
					var ctx3 = canvasm2.getContext('2d');
					var config3 = {
					   type: 'line',
					   data: {
					      labels: labels1,
					      datasets: [{
					         label: 'Room Wise',
					         data: data1,
					         borderWidth: 1,
					         backgroundColor:'transparent',
					         borderColor:'#1f0ac7'
					      }]
					   },
					   options: {
			                responsive: false,
			                scales: {
			                    yAxes: [{
			                        ticks: {
			                            display: false
			                        }
			                    }]
			                }
			            }
					};

					var chart = new Chart(ctx3, config3);
					 
	});

	function load_searchdata() {
		var todate, rdotype, unittype, area, landmark, prtype, mgprpty;

		todate = $('#todate').val();

		if ($('#jqxArea').val() != "")
			area = $('#areaid').val();
		else
			area = "";
		if ($('#jqxlandmark').val() != "")
			landmark = $('#nlmid').val();
		else
			landmark = "";
	 	rdotype = $("input[name='rdotype']:checked").val();
		if ($('#jqxType').val() != "")
			unittype = $('#typeid').val();
		else
			unittype = "";
 
		prtype=$('#cmbpropertype').val();

		$.ajax({
			type : "GET",
			url : 'getPropertyDetails.jsp',
			dataType : 'json',
			data : {
				todate : todate,
				area : area,
				landmark : landmark,
				type : rdotype,
				unittype : unittype
				/* mgprpty : mgprpty,
				prtype : prtype */
			},
			success : function(obj, textstatus) {
				console.log(obj.property);
				
				table=$('#example').DataTable({					 
					 "bLengthChange" : false,  
					"paging" : false,
					 "bInfo" : false,	  
					destroy : true, 
					data : obj.property,
					columns : [ 
					            {
						data : 'doc_no',
						width:'50px'
					},{
						data : 'pfors',
						width:'30px'
					},{
						data : 'pforr',
						width:'30px'
					},{
						data : 'pforhc',
						width:'30px'
					}, {
						data : 'mgprpty',
						width:'60px'

					},{
						data : 'area',
						width:'100px'
					}, {
						data : 'ptype',
						width:'50px'
						
					}, {
						data : 'prid',
						width:'100px'
						
					}, {
						data : 'accname',
						width:'250px'
						
					}, {
						data : 'builduparea',
						width:'100px'
						
					}, {
						data : 'desc',
						width:'250px'
						
					}, {
						data : 'splnote',
						width:'200px'
					}, {
						data : 'owner',
						width:'200px'
					}, {
						data : 'contactno',
						width:'100px'
					}, {
						data : 'no_of_rooms',
						width:'50px'
					}, {
						data : 'availabilitydate',
						type: 'de_date',
						width:'75px'
						 
					}, {
						data : 'status',
						width:'50px'
						 
					},  ],
					/* dom : 'Bfrtip',
					  buttons : [ {
						extend : 'excel',
						text : '<i class="fa fa-file-excel-o" aria-hidden="true"></i>&nbsp;Excel',
						width:'150px',
						className:'btn btn-success pull-right btnexcel',
						title:'Property Availability',
						filename : 'Property Availability'
					}, {
						extend : 'pdf',
						text : '<i class="fa fa-print" aria-hidden="true"></i>&nbsp;PDF',
						className:'btn btn-primary pull-right btnpdf',
						title:'Property Availability',
						filename : 'Property Availability'
					} ]    */
					/*  buttons: [
					             'excel', 'pdf', 'print'
					        ]
 */
				}).columns().every(function() {
					var that = this;
					$('input', this.footer()).on('keyup change', function() {
						if (that.search() !== this.value) {
							that.search(this.value).draw();
						}
					});
				});
				 
			},
			error : function(obj, textstatus) {
				alert(obj.msg);
			}
		});
	}
	
	 function exportToExcel() {
		/*  var table=$('#example').DataTable();
		  table.button('.buttons-excel').click(); */
	 }
	 function exportToPdf() {
		 /* var table=$('#example').DataTable();
		    table.button('.buttons-pdf').trigger(); */
		 }

	function autocompleteArea() {
		$.ajax({
					type : "GET",
					url : 'getArea.jsp',
					dataType : 'json',
					success : function(obj, textstatus) {
						var source = {
							datatype : "json",
							
							datafields : [ {
								name : 'id',
								type : 'string'
							}, {
								name : 'text',
								type : 'string'
							}, ],
							localdata : obj,
						};
						var dataAdapter = new $.jqx.dataAdapter(source);
						// Create a jqxInput  

						$("#jqxArea").jqxInput({
							source : dataAdapter,
							displayMember : "text",
							valueMember : "id",
							items : 20
						});
						$("#jqxArea").on(
										'select',
										function(event) {
											if (event.args) {
												var item = event.args.item;
												if (item) {
													for (var i = 0; i < dataAdapter.records.length; i++) {
														if (item.value == dataAdapter.records[i].id) {
															document
																	.getElementById("areaid").value = dataAdapter.records[i].id;
															break;
														}
													}
												}
											}
										});
					}
				});
	}
	function autocompleteType() {
		$.ajax({
					type : "GET",
					url : 'getUnitType.jsp',
					dataType : 'json',
					success : function(obj, textstatus) {
						var source = {
							datatype : "json",
							datafields : [ {
								name : 'id',
								type : 'string'
							}, {
								name : 'text',
								type : 'string'
							}, ],
							localdata : obj,
						};
						var dataAdapter = new $.jqx.dataAdapter(source);
						// Create a jqxInput  

						$("#jqxunittype").jqxInput({
							source : dataAdapter,
							displayMember : "text",
							valueMember : "id",
							items : 20
						});
						$("#jqxunittype").on(
										'select',
										function(event) {
											if (event.args) {
												var item = event.args.item;
												if (item) {
													for (var i = 0; i < dataAdapter.records.length; i++) {
														if (item.value == dataAdapter.records[i].id) {
															document
																	.getElementById("typeid").value = dataAdapter.records[i].id;
															break;
														}
													}
												}
											}
										});
					}
				});

	}

	function autocompleteLandmark() {
		$.ajax({
					type : "GET",
					url : 'getLandmark.jsp',
					dataType : 'json',
					success : function(obj, textstatus) {
						var source = {
							datatype : "json",
							datafields : [ {
								name : 'id',
								type : 'string'
							}, {
								name : 'text',
								type : 'string'
							}, ],
							localdata : obj,
						};
						var dataAdapter = new $.jqx.dataAdapter(source);
						// Create a jqxInput  

						$("#jqxlandmark").jqxInput({
							source : dataAdapter,
							displayMember : "text",
							valueMember : "id",
							items : 20
						});
						$("#jqxlandmark").on(
										'select',
										function(event) {
											if (event.args) {
												var item = event.args.item;
												if (item) {
													for (var i = 0; i < dataAdapter.records.length; i++) {
														if (item.value == dataAdapter.records[i].id) {
															document
																	.getElementById("nlmid").value = dataAdapter.records[i].id;
															break;
														}
													}
												}
											}
										});
					}
				});

	}
	// area autocomplete
	/* $("#ddlarea").select2({
		minimumInputLength : 1,
		placeholder : 'Search Area',
		ajax : {
			url : 'getArea.jsp',
			dataType : 'json',
			type : "GET",
			quietMillis : 50,
			data : function(params) {
				return {
					term : params.term
				};
			},
			processResults : function(data) {
				return {
					results : data
				};
			}
		}
	}); */
	// area autocomplete
	//Landmark
	/* $("#ddllandmark").select2({
		minimumInputLength : 1,
		placeholder : 'Search Landmark',
		ajax : {
			url : 'getLandmark.jsp',
			dataType : 'json',
			type : "GET",
			quietMillis : 50,
			data : function(params) {
				return {
					term : params.term
				};
			},
			processResults : function(data) {
				return {
					results : data
				};
			}
		}
	}); */
	//landmark
	//unittype
	/* $("#ddlunittype").select2({
		minimumInputLength : 1,
		placeholder : 'Search Type',
		ajax : {
			url : 'getUnitType.jsp',
			dataType : 'json',
			type : "GET",
			quietMillis : 50,
			data : function(params) {
				return {
					term : params.term
				};
			},
			processResults : function(data) {
				return {
					results : data
				};
			}
		}
	}); */
	//unittype
	//Contact Person
	/* $("#ddlcontact").select2({
		minimumInputLength : 1,
		placeholder : 'Search Contact',
		ajax : {
			url : 'getContactPerson.jsp',
			dataType : 'json',
			type : "GET",
			quietMillis : 50,
			data : function(params) {
				return {
					term : params.term
				};
			},
			processResults : function(data) {
				return {
					results : data
				};
			}
		}
	}); */
	//Contact Person
	function funExportBtn() {
		JSONToCSVCon(padata, 'Product Availability', true);
	}

	function funreload(event) {

	}

	function funClearData() {

	}

	function clickfun() {
		$('.box').animate({
			width : 'toggle'
		}, '1200');
		/* var x = document.getElementById("btnfiltermenu");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
		} */
	}

	/* $('#btnSearch').click(function() {
		alert();
		load_searchdata();
	});
	 */

	function clear_data() {
		$("input[type=text]").val("");
		$('input:checkbox').attr('checked', false);
		$('input:radio').attr('checked', false);
	}

	function showPropertyMasterInTab(pdocno) {
		var path1 = "com/realestate/propertymaster/propertyMaster.jsp";
		var name = "Property Master";
		var url = document.URL;
		var reurl = url.split("com");
		var mode = "pview";

		window.parent.formName.value = "Property Master";
		window.parent.formCode.value = "PPM";
		var detName = "Property Master";

		var path = path1
				+ "?pdocno="
				+ pdocno
				+ "&mode="
				+ mode;
				/* + "&pname="
				+ pname.replace("/\s/g", "%20").replace('#', '%23').replace(
						'&', '%26'); */
		top.addTab(detName, reurl[0] + "" + path);
	}
	
	function getPropertyType() { 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var prtypeIdItems  = items[0].split(",");
				var prtypeItems = items[1].split(",");
				
				var prtypeoptions='<option value=""> select</option>';
				for (var i = 0; i < prtypeItems.length; i++) {
					prtypeoptions += '<option value="' + prtypeIdItems[i].trim() + '">'
							+ prtypeItems[i] + '</option>';
				}
				$("select#cmbpropertype").html(prtypeoptions);
			} else {
			}  
		}
		x.open("GET","getPropertyType.jsp",true);   
		x.send();
	} 
	
	
	$("#divptypechart").on('click',function() {
	/* 	alert(); */
		  $('#Modalptype').modal('toggle');
		});

	$("#divroomchart").on('click',function() {
	/* 	alert(); */
		  $('#Modalroomwise').modal('toggle')
		  ;
		});
</script>
	
</body>
</html>