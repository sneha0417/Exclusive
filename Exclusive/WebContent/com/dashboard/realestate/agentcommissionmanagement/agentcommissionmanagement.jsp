<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Agent Commission Management</title>    
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
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="todatepanel custompanel">
                    <table>
                        <tr>
                            <td align="right">
                                <label class="branch" style="font-size: 13px">To Date &nbsp;&nbsp;</label>
                            </td>
                            <td align="left">
                                <div id='todate' name='todate'></div>       
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="primarypanel custompanel" style="margin-left:15px;">
                    <button type="button" class="btn btn-default " id="btnsubmit" data-tooltip="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
                </div>
                <div class="otherpanel custompanel">
                	<button type="button" class="btn btn-default " id="btnstatusupdate"  data-toggle="modal" data-target="#modalstatusupdate" data-tooltip="tooltip" title="Status Update" data-placement="bottom"><i class="fa fa-pencil " aria-hidden="true"></i></button>
                	<button type="button" class="btn btn-default " id="btnclaimupdate"  data-toggle="modal" data-target="#modalclaimvalupdate" data-tooltip="tooltip" title="Claim Value Update" data-placement="bottom"><i class="fa fa-pencil " aria-hidden="true"></i></button>
                	<button type="button" class="btn btn-default " id="btnjvcreate"  data-toggle="modal" data-target="#modaljvcreate" data-tooltip="tooltip" title="JV Create" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnattach" onClick="funAttach();"  data-tooltip="tooltip" title="Attach" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btninvoice" onClick="viewInvoice();"  data-tooltip="tooltip" title="Property Invoice" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btncomment" data-toggle="modal" data-target="#modalcomments" data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default btnStyle" id="btnconfirm"  data-tooltip="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check " aria-hidden="true"></i></button>
                </div>     
                <div class="textpanel custompanel" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">           
                    <p style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
                </div>
            </div>      
        </div>
        <br/>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="ppdiv" class="borderStyle">
                    <jsp:include page="agentcommGrid.jsp"></jsp:include>
                </div>
            </div>        
        </div>

        <!-- status update Modal-->
        <div id="modalstatusupdate" class="modal fade" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Status Update</h4>
                        <p id="clientref1" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Status</label>
                    			<div class="col-sm-10">  
                        			<select class="form-control" name="cmbstatus" id="cmbstatus" style="width: 100%">
                                    <option value="1">Claimed</option><option value="2">Approve</option></select>
                                    <span class="help-block hidden"></span>
                    			</div>
                    			
                  			</div>
                  			<!-- <div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="txtremarks" id="txtremarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div> -->           
                		</div>
                    </div>
                    <div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdatesave" id="btnstatuspdatesave" onclick="funstatusupdate();">Save Changes</button>
	          		</div>
                </div>
            </div>
        </div>
 <!-- status update Modal-->
        <div id="modalclaimvalupdate" class="modal fade" role="dialog">
            <div class="modal-dialog  modal-md">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Claim Value Update</h4>
                        <p id="clientref2" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">    
                  			<div class="form-group">
                    			<label class="col-sm-6 control-label" for="claimvalue">Claim Value</label>         
                    			<div class="col-sm-6">
                        			<input type="text" class="form-control"  name="claimval" id="claimval" style="width: 100%"/>
                    			</div>
                  			</div>   
                  			<!-- <div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="txtremarks" id="txtremarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div> -->           
                		</div>
                    </div>
                    <div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnclaimvalpdatesave" id="btnclaimvalpdatesave" onclick="funclaimupdate();">Save Changes</button>
	          		</div>
                </div>
            </div>
        </div>
        <!-- JV create Modal-->    
        <div id="modaljvcreate" class="modal fade" role="dialog">   
            <div class="modal-dialog  modal-md">        
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">JV Create</h4>   
                        <p id="clientref3" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                        <div class="form-group">
                    			<label class="col-sm-2" for="invdate">Inv Date</label>         
                    			<div class="col-sm-10">
                        			  <div id="invdate" class="borderStyle"></div>
                    			</div>
                  			</div>   
                  			 <div class="row">
					            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					                <div id="jvdiv" class="borderStyle">   
					                    <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
					                </div>
					            </div>        
					        </div>          
                		</div>
                    </div>
                    <div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnjv" id="btnjv" onclick="funjvcreate();">Create</button>
	          		</div>         
                </div>
            </div>
        </div> 
        <!-- Comments Modal-->
        <div id="modalcomments" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Comments</h4>
                    </div>
                    <div class="modal-body">
                        <div class="comments-outer-container container-fluid">
                            <div class="comments-container">

                            </div>
                            <div class="create-msg-container">
                                <!-- <div class="container-fluid"> -->
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                                            <div class="input-group-btn">
                                                <button type="button" id="btncommentsend" class="btn btn-default">
                                                    <i class="fa fa-paper-plane"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- </div> -->
                            </div>
                        </div>
                    </div>
                    <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
                </div>
            </div>
        </div>
        </div>
        <input type="hidden" name="hidrowindex" id="hidrowindex">    
        <input type="hidden" name="hidcomments" id="hidcomments">
        <input type="hidden" name="txtrefname" id="txtrefname">
        <input type="hidden" name="hiddocno" id="hiddocno">
        <input type="hidden" name="hidvocno" id="hidvocno">
        <input type="hidden" name="hidbrhid" id="hidbrhid">    
        <input type="hidden" name="hidrowno" id="hidrowno">   
        <input type="hidden" name="hidacno" id="hidacno">
        <input type="hidden" name="hidcommval" id="hidcommval">       
        <input type="hidden" name="hidclaimval" id="hidclaimval"> 
        <input type="hidden" name="hidjvtrno" id="hidjvtrno">  
        <input type="hidden" name="hidstatus" id="hidstatus">  
        <input type="hidden" name="hiddescription" id="hiddescription">  
        <input type="hidden" name="hidcommpercent" id="hidcommpercent">                                                                                   
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                //$('[data-tooltip="tooltip"]').tooltip();
                $('[data-tooltip="tooltip"]').tooltip({trigger:"hover"});
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#todate").jqxDateTimeInput({
                    width: '100px',
                    height: '23px',
                    formatString: "dd.MM.yyyy"
                });
                $("#invdate").jqxDateTimeInput({
                    width: '100px',
                    height: '23px',
                    formatString: "dd.MM.yyyy"
                });
                $('[data-toggle="tooltip"]').tooltip();
                
                $('#btnconfirm').click(function() {  
                	  var docno = $('#hiddocno').val();	
                	  if (docno == "") {
                          swal({
                              type: 'warning',
                              title: 'Warning',
                              text: 'Please select a document'
                          });
                          return false;
                      }
                	  funconfirm();    
                });
                $('#btnjvcreate').click(function() {       
               	    var docno = $('#hiddocno').val();
               	 	var jvtrno = $('#jqxAgentGrid').jqxGrid('getcellvalue',$('#hidrowindex').val(),'jvtrno');    
               		var claimamt = $('#hidclaimval').val();
               		var status = $('#hidstatus').val();
                    if (docno == "") {
                       swal({
                           type: 'warning',
                           title: 'Warning',
                           text: 'Please select a document'
                       });
                       return false;
                   }
                    if (parseInt(jvtrno)>0) {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Journal Vouchers already created'        
                        });
                        return false;
                    }
                    if (parseFloat(claimamt) == 0) {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Claim amount is 0'      
                        });
                        return false;
                    }
                    document.getElementById("clientref3").innerHTML=$('#hidvocno').val()+" - "+$('#txtrefname').val();
                    funjvload();        
               });
                $('#btnsubmit').click(function() {                
                    funload();
                    $('.textpanel p').text("");
                    $('#hiddocno').val('');
                    $('#hidvocno').val('');
                    $('#hidrowno').val('');
                    $('#txtrefname').val(''); 
                    $('#hidbrhid').val(''); 
                    $('#clientref3').val(''); 
                    $('#clientref2').val(''); 
                    $('#clientref1').val(''); 
                    $('#hidjvtrno').val(''); 
                    $('#hidclaimval').val(''); 
                    $('#hidcommval').val(''); 
                    $('#hiddescription').val('');
                    $('#hidcommpercent').val('');
                });
                $('#btnstatusupdate').click(function() {
                    var docno = $('#hiddocno').val();
                    if (docno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;   
                    }
                    document.getElementById("clientref1").innerHTML=$('#hidvocno').val()+" - "+$('#txtrefname').val();
                });
                $('#btnclaimupdate').click(function() {
                	 var docno = $('#hiddocno').val();
                     if (docno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                     document.getElementById("clientref2").innerHTML=$('#hidvocno').val()+" - "+$('#txtrefname').val();
                });
                $('#btncomment').click(function() {
                    getComments();
                    var actdocno = $('#hiddocno').val();
                    if (actdocno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
                $('#btnexcel').click(function() {
                	$("#ppdiv").excelexportjs({
                		containerid: "ppdiv", 
                		datatype: 'json', 
                		dataset: null, 
                		gridId: "jqxAgentGrid", 
                		columns: getColumns("jqxAgentGrid") , 
                		worksheetName:"Agent Commission Management"
                		});
                });
                $('#btncommentsend').click(function() {
                    var actdocno = $('#hiddocno').val();
                    var txtcomment = $('#txtcomment').val();
                    if (actdocno == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    if (txtcomment == "") {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please type in comment'
                        });
                        return false;
                    }
                    saveComment();
                });

                $('.warningpanel div button').click(function() {
                    var gridrows = $('#jqxAgentGrid').jqxGrid('getrows');
                    if (gridrows.length == 0) {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please submit'
                        });
                        return false;
                    }
                    $(this).toggleClass('active');
                    if ($(this).hasClass('active')) {
                        addGridFilters($(this).attr('id'), $(this).attr('data-filtervalue'), $(this).attr('data-datafield'), $(this).attr('data-filtertype'), $(this).attr('data-filtercondition'));
                    } else {
                        $('#jqxAgentGrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                    }
                });
            });

            function addGridFilters(id, filtervalue, datafield, filtertype, filtercondition) {
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                    //var filtercondition = 'contains';
                    var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);

                    filtergroup.addfilter(filter_or_operator, filter1);
                    //filtergroup.addfilter(filter_or_operator, filter2);
                    // add the filters.
                    $("#jqxAgentGrid").jqxGrid('addfilter', datafield, filtergroup);
                    // apply the filters.
                    $("#jqxAgentGrid").jqxGrid('applyfilters');
            }

            function saveComment() {
                var comment = $('#txtcomment').val();
                var enqno = $('#hiddocno').val();
                $('#hidcomments').val($('#txtcomment').val());
                if (($(hidcomments).val()).includes('$')) {
                    $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));
                };
                if (($(hidcomments).val()).includes('%')) {
                    $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));
                };
                if (($(hidcomments).val()).includes('^')) {
                    $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));
                };
                if (($(hidcomments).val()).includes('`')) {
                    $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));
                };
                if (($(hidcomments).val()).includes('~')) {
                    $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));
                };
                if ($(hidcomments).val().indexOf('\'') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));
                };
                if (($(hidcomments).val()).includes(',')) {
                    $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));
                }
                if ($(hidcomments).val().indexOf('"') >= 0) {
                    $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));
                };
                if (($(hidcomments).val()).match(/\\/g)) {
                    $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));
                };

                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        $('#txtcomment').val('');
                        getComments();
                    } else {}
                }
                x.open("GET", "saveComment.jsp?comment=" + encodeURIComponent($('#hidcomments').val()) + "&docno=" + enqno, true);
                x.send();
            }

            function getComments() {
                var enqno = $('#hiddocno').val();
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim().split(",");
                        var str = '';
                        if (items != '') {
                            for (var i = 0; i < items.length; i++) {
                                str += '<div class="comment"><div class="msg"><p>' + items[i].split("::")[0] + '</p></div><div class="msg-details"><p>' + items[i].split("::")[1] + ' - ' + items[i].split("::")[2] + '</p></div></div>';
                            }
                            $('.comments-container').html($.parseHTML(str));
                        } else {}
                    } else {}
                }
                x.open("GET", "getComments.jsp?docno=" + enqno, true);
                x.send();
            }

            function funload() {
            	 $("#overlay, #PleaseWait").show();
                var todate = $('#todate').jqxDateTimeInput('val');
                $('#ppdiv').load("agentcommGrid.jsp?todate="+todate+"&id="+1);
            }
            function funjvload() {
            	var acno=$('#hidacno').val();       
            	var commval=$('#hidcommval').val();	   
            	var claimval=$('#hidclaimval').val();	
                $('#jvdiv').load("journalVoucherGrid.jsp?claimval="+claimval+"&commval="+commval+"&acno="+acno+"&id="+1);
            }
            function funstatusupdate() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();    
                        if (parseInt(items) > 0) {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Updated'
                            });
                            $('#modalstatusupdate').modal('toggle');
                            funload();
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated'
                            });
                        }
                    } else {}
                }
                x.open("GET", "statusUpdate.jsp?docno=" + $('#hidrowno').val() + "&status=" + $('#cmbstatus').val(), true);
                x.send();
            }
            function funclaimupdate() {    
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        //alert(items);       
                        if (parseInt(items) > 0) {
                            swal({
                                type: 'success',
                                title: 'Message',
                                text: 'Successfully Updated'
                            });
                            $('#modalclaimvalupdate').modal('toggle');   
                            funload();   
                        } else {
                            swal({
                                type: 'error',
                                title: 'Warning',
                                text: 'Not Updated'
                            });
                        }
                    } else {}
                }
                x.open("GET", "claimUpdate.jsp?docno=" + $('#hidrowno').val() + "&claim=" + $('#claimval').val(), true);
                x.send();
            }
            function isNumberKey(evt) {     
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && ((charCode < 48) || (charCode > 57)))
                    return false;
                return true;
            }
            function funAttach(){
				var brhid=$("#hidbrhid").val();
				var frmname="Property Invoice";         
				var frmcode="PRIV";             
				if ($("#hiddocno").val()!="") {
					var myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode+"&docno="+document.getElementById("hidvocno").value+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					myWindow.focus();
				}else{
					swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
					return false;
				}
			}
            function funjvcreate(){   
            	var desc="INV"+$('#hidvocno').val()+", "+$('#hidcommpercent').val()+"% Agency Commission for "+$('#txtrefname').val();      
            	 $('#hiddescription').val(desc);   
	 		 	 if ($(hiddescription).val().indexOf('"') >= 0) { $(hiddescription).val($(hiddescription).val().replace(/["']/g, ''));};
			 	 if (($(hiddescription).val()).includes(',')) { $(hiddescription).val($(hiddescription).val().replace(/,/g, ''));}
	 		     
            	var invdate = $('#invdate').jqxDateTimeInput('val');
            	var brhid=$("#hidbrhid").val();
            	var invdocno=$("#hiddocno").val();
            	var gridarray=new Array();
                var rows = $("#jqxjvGrid").jqxGrid('getrows');  
                var amount=0.0;
       		    for(var i=0 ; i < rows.length ; i++){  
       		    	gridarray.push(rows[i].account+" :: "+$('#hiddescription').val()+" :: "+ 1 +" :: "+ 1 +" :: "+rows[i].baseamt+" :: "+rows[i].baseamt+" ::"+ 2 +" :: "+rows[i].id+" :: "+""+" :: "+""+" :: ");   
       		        amount=amount + parseFloat(rows[i].debit);      
       		    }
	       		 var x = new XMLHttpRequest();
	             x.onreadystatechange = function() {
	                 if (x.readyState == 4 && x.status == 200) {
	                     var items = x.responseText.trim();    
	                     if (parseInt(items) > 0) {
	                         swal({
	                             type: 'success',
	                             title: 'Message',
	                             text: 'JVT - '+items+' Successfully Created'    
	                         });
	                         $('#modaljvcreate').modal('toggle'); 
	                         $('#hiddescription').val('');  
	                         funload();
	                     } else {
	                         swal({
	                             type: 'error',
	                             title: 'Warning',
	                             text: 'Not Created'      
	                         });
	                     }
	                 } else {}
	             }
	             x.open("GET", "createjv.jsp?jvarray=" + encodeURIComponent(gridarray)+ "&brhid=" +brhid+ "&invdocno=" +invdocno+ "&amount=" +amount + "&invdate=" +invdate+ "&docno=" + $('#hidvocno').val() + "&desc=" + encodeURIComponent(desc)+"&rowno="+$('#hidrowno').val(), true);         
	             x.send();       
            }  
            function viewInvoice(){   
            	 var docno = $('#hiddocno').val();
                 if (docno == "") {
                    swal({
                        type: 'warning',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }
            	 var path1="",detName="";    
               	 var url=document.URL;
         	 	 var reurl=url.split("com/");
         	 	 var mod="v";
         	 		  detName= "Property Invoice";
         	 		window.parent.formName.value="Property Invoice";
         	 		window.parent.formCode.value="PRIV";
         	 		 var doc=$('#hiddocno').val();     
         	 		 
         	 		 path1='com/realestate/propertyinvoice/savePropertyInvoice?mode=view&docno='+doc; 
         	 			    //var path= path1+"?&docno="+doc+"&accname="+acname;
         	    		    top.addTab( detName,reurl[0]+""+path1);   
            }   
            function funconfirm(){ 
            	var confirm=1;
            	var invno=$('#hiddocno').val();    
            	 var x = new XMLHttpRequest();
	             x.onreadystatechange = function() {
	                 if (x.readyState == 4 && x.status == 200) {
	                     var items = x.responseText.trim();    
	                     if (parseInt(items) > 0) {
	                         swal({
	                             type: 'success',
	                             title: 'Message',
	                             text: 'Successfully Confirmed'    
	                         });
	                         funload();
	                     } else {
	                         swal({
	                             type: 'error',
	                             title: 'Warning',
	                             text: 'Not Confirmed'         
	                         });
	                     }
	                 } else {}
	             }
	             x.open("GET", "statusUpdate.jsp?confirm=" + confirm+ "&invno=" +invno+"&docno="+$('#hidrowno').val(), true);         
	             x.send(); 
            }
            
            function disableBtns(){
            	
            }
        </script>     
</body>
</html>