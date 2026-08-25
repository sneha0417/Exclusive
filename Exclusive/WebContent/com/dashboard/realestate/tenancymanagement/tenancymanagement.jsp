<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Property Management</title>
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
                        	<td>
                        		<label class="checkbox-inline"><input type="checkbox" name="chkexpiry" id="chkcreated" onchange="setExpiry();" class="chkexpiry">Created</label>
                            	<label class="checkbox-inline"><input type="checkbox" name="chkexpiry" id="chkexpiry" onchange="setExpiry();" class="chkexpiry">Expiry</label>
                            </td>
                            <td align="right"  style="padding-left:5px;">
                                <label class="branch" style="font-size: 13px;padding-top:7px;">From Dt &nbsp;</label>
                            </td>
                            <td align="left">
                                <div id='fromdate' name='fromdate'></div>
                            </td>
                            <td align="right"  style="padding-left:5px;">
                                <label class="branch" style="font-size: 13px;padding-top:7px;">To Dt &nbsp;</label>
                            </td>
                            <td align="left">
                                <div id='todate' name='todate'></div>
                            </td>
                            <td align="left">
                                <select name="cmbmanage" id="cmbmanage" class="form-control">
                                	<option value="">All</option>
                                	<option value="1">Managed</option>
                                	<option value="0">Unmanaged</option>
                                </select>
                            </td>
                            <td style="padding-left:5px;">
                            	<label class="checkbox-inline"><input type="checkbox" name="chkallcontracts" id="chkallcontracts" onchange="setAllContracts();">All</label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="primarypanel custompanel" style="margin-left:15px;">
                    <button type="button" class="btn btn-default " id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnemailtenant" data-toggle="tooltip" title="Email Tenant" data-placement="bottom"><i class="fa fa-envelope " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnemailowner" data-toggle="tooltip" title="Email Landlord" data-placement="bottom"><i class="fa fa-envelope " aria-hidden="true"></i></button>
                </div>
                <div class="otherpanel custompanel">
                	<div class="dropdown" style="display:inline-block;margin-left: 3px;">
                		 <!-- data-tooltip="tooltip" title="Filter" data-placement="bottom" -->
  						<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-filter"></i></button>
  						<ul class="dropdown-menu">
    						<li style="padding:5px;"><select name="cmbtenant" id="cmbtenant" class="form-control" style="width:100%;" multiple="multiple"><option value="">--Select--</option></select></li>
    						<li style="padding:5px;"><select name="cmbowner" id="cmbowner" class="form-control"  style="width:100%;" multiple="multiple"><option value="">--Select--</option></select></li>
    						<li style="padding:5px;"><select name="cmbproperty" id="cmbproperty" class="form-control"  style="width:100%;" multiple="multiple"><option value="">--Select--</option></select></li>
  						</ul>
					</div>
                	<button type="button" class="btn btn-default " id="btnstatusupdate" data-tooltip="tooltip" title="Status Update" data-placement="bottom"><i class="fa fa-pencil " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnrenewal" data-tooltip="tooltip" title="Renewal" data-placement="bottom"><i class="fa fa-plus " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btndatechange" data-tooltip="tooltip" title="Date Change" data-placement="bottom"><i class="fa fa-expand " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnreopencontract" data-tooltip="tooltip" title="Re-Open Contract" data-placement="bottom"><i class="fa fa-mail-forward " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnattach" onClick="funAttach();"  data-tooltip="tooltip" title="Attach" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnaccounts" data-tooltip="tooltip" title="Contract Account Statement" data-placement="bottom"><i class="fa fa-universal-access" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btntenantaccounts" data-tooltip="tooltip" title="Tenant Account Statement" data-placement="bottom"><i class="fa fa-address-book" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnowneraccounts" data-tooltip="tooltip" title="Owner Account Statement" data-placement="bottom"><i class="fa fa-address-card" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnmrfaccounts" data-tooltip="tooltip" title="MRF Account Statement" data-placement="bottom"><i class="fa fa-book" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnjobstatus"  data-toggle="modal" data-target="#modaltaskcreation"  data-tooltip="tooltip" title="Task Creation" data-placement="bottom"><i class="fa fa-plus-square " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnhandback"  data-tooltip="tooltip" title="Hand Back" data-placement="bottom"><i class="fa fa-hand-o-left " aria-hidden="true"></i></button>
                    <div class="btn-group" role="group">                   
            			<button type="button" class="btn btn-default btnStyle" id="btnteamselection" data-tooltip="tooltip" title="Pending Task" data-placement="bottom"><i class="fa fa-newspaper-o " aria-hidden="true"></i></button>
            			<span class="badge badge-notify badge-pendingtask"></span>                                            
          			</div>
                    <button type="button" class="btn btn-default " id="btncomment" data-toggle="modal" data-target="#modalcomments" data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btntncmgmtlog" data-toggle="modal" data-target="#modaltncmgmtlog" data-tooltip="tooltip" title="Log" data-placement="bottom"><i class="fa fa-th-list " aria-hidden="true"></i></button>
                </div>
            </div>
        </div>
         <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="textpanel custompanel" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">
                    <p style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
                </div>
            </div>
         </div>
        <br/>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="ppdiv" class="borderStyle">
                    <jsp:include page="tenancyGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>
        
        <!-- Log Modal -->
        
        <div id="modaltncmgmtlog" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Tenancy Management Log</h4>
                    </div>
                    <div class="modal-body">
						<div id="tncmgmtlogdiv"><jsp:include page="tncMgmtLogGrid.jsp"></jsp:include></div>                        
                    </div>
				</div>
            </div>
        </div>
        
        
        <!-- Pending Task Modal -->
        <div id="modalpendingtask" class="modal fade" role="dialog">     
    		<div class="modal-dialog modal-xl">    
        		<div class="modal-content">
          			<div class="modal-header modalStyle">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title" style="text-align:center">Pending Task</h4>      
          			</div>
       				<div class="modal-body"> 
						<div class="container-fluid">
							<table width="100%">  
	 							<tr> 
			 						<td colspan="6"><div id="pnddiv"><jsp:include page="pendingtaskGrid.jsp"></jsp:include></div></td>
								</tr> 
								<tr> 
			 						<td colspan="6"><div id="flwupdiv"><jsp:include page="taskfollowupGrid.jsp"></jsp:include></div></td>
								</tr>   
								<tr><td>&nbsp;</td></tr>                       
								<tr>  
									<td width="7%" align="right">Select Status</td>      
									<td width="9%"><select id="assgntask" style="width:100%;height: 20px;position: static;"></select></td>
									<td width="7%" align="right">Assign To</td>                
									<td width="4%"><div id="part" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch.jsp"></jsp:include></div>
										<input type="hidden" name="hiduser2" id="hiduser2">         
             						</td>     
									<td width="5%" align="right">Remarks</td>                  
									<td width="25%"><input type="text" style="width:100%;height:20px;" id="remarks"/></td>                            
								</tr>       
							</table> 
							<br/>
							<div class="row rowgap">   
							<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
								<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funpendingUpdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
                    			<button type="button" class="btn btn-default btnStyle" id="btnclose" data-dismiss="modal"><i class="fa fa-times " aria-hidden="true"></i></button>
							</div>
						</div>
        			</div> 
				</div>   
   				<div class="clear"></div>                                   
          	</div>
        <!--<div class="modal-footer" style="background-color:#CDFDFA">
          		<button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default">Update</button>
            	<button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          	</div> -->         
        </div>
	</div>
	
	<!-- Pending Task Model Ends -->
	
	
	<!-- Task Creation Modal  -->
		<div id="modaltaskcreation" class="modal fade" role="dialog">  
      		<div class="modal-dialog">
        		<div class="modal-content"> 
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title" style="text-align:center">Task Creation</h4>                
          			</div>  
					<div class="modal-body"> 
		    			<div class="container-fluid">
        					<div class="row rowgap">   
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Date</div>
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            						<div id="date" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
								</div>  
            				</div>  
						    <div class="row rowgap">   
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Start Time</div>
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            						<div id="vtime" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
								</div>        
            				</div>
       						<div class="row rowgap">   
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Assigned User</div>
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            						<div id="partss" onkeydown="return (event.keyCode!=13);"><jsp:include page="userSearch2.jsp"></jsp:include></div>
                     				<input type="hidden" name="hiduser" id="hiduser">
                     			</div>  
            				</div>
        					<div class="row rowgap">   
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 			<textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="desc"></textarea>
								</div>  
            				</div>
		 					<div class="row rowgap">   
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
									<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funCreateTask();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
									<button type="button" class="btn btn-default btnStyle" id="btnclose" data-dismiss="modal"><i class="fa fa-times " aria-hidden="true"></i></button>
								</div>   
							</div>   
						</div>
					<div class="clear"></div>       
				</div>
          <!-- 	<div class="modal-footer" style="background-color:#CDFDFA">
          			<button type="button" class="btn btn-default" onclick="funSave();">SAVE</button>
            		<button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          		</div>   -->               
        	</div>
      	</div>
    </div>
    
    <!-- task creation modal ends -->
        <!-- status update Modal-->
        <div id="modalstatusupdate" class="modal fade" role="dialog">
            <div class="modal-dialog">
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
                        			<select class="form-control" name="cmbrenewalstatus" id="cmbrenewalstatus" style="width: 100%">
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                    			
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="renewalremarks" id="renewalremarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                    <div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdatesave" id="btnstatuspdatesave">Save Changes</button>
	          		</div>
                </div>
            </div>
        </div>

        <!-- Date Change Modal-->
        <div id="modaldatechange" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Date Change</h4>
                        <p id="clientref1" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="optpreclosure">Type</label>
                    			<div class="col-sm-10">
                        			<label class="radio-inline"><input type="radio" name="optradio" checked id="optpreclosure">Preclosure</label>
									<label class="radio-inline"><input type="radio" name="optradio" id="optextension">Extension</label>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="datechangedate">Date</label>
                    			<div class="col-sm-10">
                        			<div id="datechangedate"></div>
                                    <span class="help-block hidden"></span>
                    			</div>
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="datechangeremarks" id="datechangeremarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                    <div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btndatechangesave" id="btndatechangesave">Save Changes</button>
	          		</div>
                </div>
            </div>
        </div>


        <!--Account Statement Modal-->
        
        <div id="modalaccountstmt" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Contract Accounts Statement</h4>
                    </div>
                    <div class="modal-body">
						<div id="accountsdiv"><jsp:include page="accountsGrid.jsp"></jsp:include></div>                        
                    </div>
				</div>
            </div>
        </div>
        
        <!--Tenant Account Statement Modal-->
        
        <div id="modaltenantaccountstmt" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Tenant Accounts Statement</h4>
                    </div>
                    <div class="modal-body">
						<div id="tenantaccountsdiv"><jsp:include page="tenantAccountsGrid.jsp"></jsp:include></div>                        
                    </div>
                    <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btntenantacprint">Print</button>
          			</div>
				</div>
            </div>
        </div>
        
        <!--Owner Account Statement Modal-->
        
        <div id="modalowneraccountstmt" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Owner Accounts Statement</h4>
                    </div>
                    <div class="modal-body">
						<div id="owneraccountsdiv"><jsp:include page="ownerAccountsGrid.jsp"></jsp:include></div>                        
                    </div>
                    <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnowneracprint">Print</button>
          			</div>
				</div>
            </div>
        </div>
        
        <!--MRF Account Statement Modal-->
        
        <div id="modalmrfaccountstmt" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">MRF Accounts Statement</h4>
                    </div>
                    <div class="modal-body">
						<div id="mrfaccountsdiv"><jsp:include page="mrfAccountsGrid.jsp"></jsp:include></div>                        
                    </div>
                    <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnmrfacprint">Print</button>
          			</div>
				</div>
            </div>
        </div>
        <!-- Owner update Modal-->
        <div id="modalestimateupdate" class="modal fade" role="dialog">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Estimate</h4>
                        <p id="clientref1" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <p>
                            <!-- Some text in the modal. -->
                        </p>
                        <div class="container-fluid">
                            <div class="row rowgap">
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-2" style="padding-left: 0px;">Vendor&nbsp;</div>
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-10">
                                    <div id="vendor" onkeydown="return (event.keyCode!=13);">
                                        <jsp:include page="vendorSearch.jsp"></jsp:include>
                                    </div>
                                    <input type="hidden" name="hidvndid" id="hidvndid">
                                </div>
                            </div>
                            <div class="row rowgap">
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-2">Rate</div>
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-10">
                                    <input type="text" name="txtrate" id="txtrate" onkeypress="return isNumberKey(event)" class="form-control input-sm" placeholder="Enter Rate" style="height:25px;width:200px;">
                                </div>
                            </div>
                            <div class="row rowgap">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
                                    <button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funestimateupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
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
        
         <!-- HaND bACK Modal-->
        <div id="modalhandback" class="modal fade" role="dialog">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center">Hand Back</h4>
                        <p id="clientref1" style="text-align:center;"></p>
                    </div>
                    <div class="modal-body">
                        <p>
                            <!-- Some text in the modal. -->
                        </p>
                        <div class="container-fluid">
                           <div class="row rowgap">   
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">User</div>
            					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-8">  
            						<div id="handback" onkeydown="return (event.keyCode!=13);"><jsp:include page="handbackuserSearch.jsp"></jsp:include></div>
                     				<input type="hidden" name="hidhbuser" id="hidhbuser">     
                     			</div>  
            				</div>
                            <div class="row rowgap">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
                                    <button type="button" class="btn btn-default btnStyle" id="btnupdates" title="Update" data-placement="bottom" onclick="funhbupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
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
        
        </div>
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
        <input type="hidden" name="vocno" id="vocno">
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script type="text/javascript">
        	$(document).on("click", function(e) {
  				if ($(e.target).closest("div.dropdown").length && e.target != "select2-results__option") {
    				$(e.target).closest("div.dropdown").addClass("open")
  				}
			});
            $(document).ready(function() {
                $('[data-tooltip="tooltip"]').tooltip();
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#fromdate").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#todate").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#datechangedate").jqxDateTimeInput({
                    width: '100px',
                    height: '15px',
                    formatString: "dd.MM.yyyy"
                });
                $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
                $("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
                $('[data-toggle="tooltip"]').tooltip();
                $('#cmbrenewalstatus').select2();
                $('#cmbmanage').select2({
                	placeholder:"Select Managed/Unmanaged",
                	allowClear:true
                });
                $('#cmbtenant').select2({
                	placeholder:"Select Tenant",
                	allowClear:true
                });
                $('#cmbowner').select2({
                	placeholder:"Select Owner",
                	allowClear:true
                });
                $('#cmbproperty').select2({
                	placeholder:"Select Property",
                	allowClear:true
                });  
                $('#btnhandback').attr({disabled:true});   
				getInitData();
				//getActivityStatus();
				setExpiry();
				$('.chkexpiry').on('change', function() {
					$('.chkexpiry').not(this).prop('checked', false);
				});
				
				$('#btnhandback').click(function(){
                	$('#modalhandback').modal();   
				});
				$('#btnteamselection').click(function(){
					var userid="<%=session.getAttribute("USERID").toString()%>";     
                	funGetCountData();
                	$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);
                	$('#modalpendingtask').modal();
				});
				$('#btnreopencontract').click(function(){
					var clstatus=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'clstatus');
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    else if(clstatus!="1"){
                    	swal({
                            type: 'warning',
                            title: 'Cannot re-open',
                            text: 'Please select a closed document'
                        });
                        return false;
                    }
                    else{
                    	var docno=$('#hiddocno').val();
                    	var propdocno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propdocno');
                    	var vocno=$('#vocno').val();
                    	Swal.fire({
				  			title: 'Are you sure?',
				  			text: "Do you want to reopen TNC #"+vocno,
				  			icon: 'warning',
				  			showCancelButton: true,
				  			confirmButtonColor: '#3085d6',
				  			cancelButtonColor: '#d33',
				  			confirmButtonText: 'Yes'
						}).then((result) => {
				  			if (result.value) {
				  				var x = new XMLHttpRequest();
					            x.onreadystatechange = function() {
					            	if (x.readyState == 4 && x.status == 200) {
					                	var items = x.responseText.trim();
					                    if(items=="0"){
					                    	swal({
						                    	type: 'success',
						                        title: 'Message',
						                        text: 'Re-opening Successfull'
						                    });
				                            
				                            $('#btnsubmit').trigger('click');
				                            $("#overlay, #PleaseWait").hide();
			                        	}
					                    else if(items=="2"){
					                    	swal({
						                    	type: 'warning',
						                        title: 'Cannot Re-Open',
						                        text: 'Please select latest document'
						                    });
					                    }
					                    else{
					                    	swal({
						                    	type: 'warning',
						                        title: 'Warning',
						                        text: 'Not Updated'
						                    });
					                    }
				               		} else {}
			                	}
					            x.open("GET", "reopenContract.jsp?docno="+docno+"&propdocno="+propdocno+"&vocno="+vocno, true);
					            x.send();
		  					}
		  				});
                    }
				});
				$('#btnaccounts').click(function(){
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    $('#modalaccountstmt').modal();
                    $('#modalaccountstmt .modal-dialog .modal-content .modal-header h4').trigger('click');
				});
				$('#btntenantaccounts').click(function(){
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
					var acname=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'tenantaccountname');
					$('#modaltenantaccountstmt .modal-dialog .modal-content .modal-header h4').text(acname+' Account Statement');
					$('#modaltenantaccountstmt').modal();
                    $('#modaltenantaccountstmt .modal-dialog .modal-content .modal-header h4').trigger('click');
				});
				$('#btnowneraccounts').click(function(){
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
					var acname=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'owneraccountname');
					$('#modalowneraccountstmt .modal-dialog .modal-content .modal-header h4').text(acname+' Account Statement');
                    $('#modalowneraccountstmt').modal();
                    $('#modalowneraccountstmt .modal-dialog .modal-content .modal-header h4').trigger('click');
				});
				$('#btnmrfaccounts').click(function(){
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
					var acname=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'mrfaccountname');
					$('#modalmrfaccountstmt .modal-dialog .modal-content .modal-header h4').text(acname+' Account Statement');
                    $('#modalmrfaccountstmt').modal();
                    $('#modalmrfaccountstmt .modal-dialog .modal-content .modal-header h4').trigger('click');
				});
				$('#btntenantacprint,#btnowneracprint,#btnmrfacprint').click(function(){
					var id=$(this).attr('id');
					var acno=0;
					if(id=="btntenantacprint"){
						acno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'tenantacno');
					}
					else if(id=="btnowneracprint"){
						acno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'owneracno');
					}
					else if(id=="btnmrfacprint"){
						acno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'mrfacno');
					}
					var brnach=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'brhid');  
					var url=document.URL;     
			        var reurl=url.split("realestate");     
			        var netamt=0.00;   
			        var fdate=window.parent.txtaccountperiodfrom.value;
			        fdate=fdate.replace(/-/g, '.');
		            var tdate=window.parent.txtaccountperiodto.value; 
		            tdate=tdate.replace(/-/g, '.');
			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();   
				});
				$('#btndatechange').click(function(){
					if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    var hiddocno=$('#hiddocno').val();
                    var propcontractno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propcontractno');
                    if(hiddocno!=propcontractno){
                    	swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select live contract'
                        });
                        return false;
                    }
                    $('#modaldatechange').modal();
				});
				$('#btndatechangesave').click(function(){
					var docno=$('#hiddocno').val();
                	var vocno=$('#vocno').val();
					var optdatechange=0;
					var datechangeremarks=$('#datechangeremarks').val();
					datechangeremarks=encodeURIComponent(datechangeremarks);
					var datechangedate=$('#datechangedate').jqxDateTimeInput('val');
					if(document.getElementById("optpreclosure").checked==true){
						optdatechange=1;
					}
					else if(document.getElementById("optextension").checked==true){
						optdatechange=2;
					}
					if(optdatechange==0){
						$('#optpreclosure').closest('.form-group').addClass('has-error').find('.help-block').text('Please select an option').removeClass('hidden');
					}
					else{
						$('#optpreclosure').closest('.form-group').removeClass('has-error').find('.help-block').text('').addClass('hidden');
					}
					if(datechangeremarks==''){
                		$('#datechangeremarks').closest('.form-group').addClass('has-error').find('.help-block').text('Remarks is mandatory').removeClass('hidden');
                        errorstatus=1;
                        return false;
                	}
                	else{
                		$('#datechangeremarks').closest('.form-group').removeClass('has-error').find('.help-block').text('').addClass('hidden');
                	}
                	
                	Swal.fire({
			  			title: 'Are you sure?',
			  			text: "Do you want to update TNC #"+vocno+" to "+$('#datechangedate').jqxDateTimeInput('val'),
			  			icon: 'warning',
			  			showCancelButton: true,
			  			confirmButtonColor: '#3085d6',
			  			cancelButtonColor: '#d33',
			  			confirmButtonText: 'Yes'
					}).then((result) => {
			  			if (result.value) {
			  				var x = new XMLHttpRequest();
				            x.onreadystatechange = function() {
				            	if (x.readyState == 4 && x.status == 200) {
				                	var items = x.responseText.trim();
				                    if(items=="0"){
				                    	swal({
					                    	type: 'success',
					                        title: 'Message',
					                        text: 'Updated Successfully'
					                    });
			                            $('#optpreclosure').prop('checked',true);
			                            $('#optextension').prop('checked',false);
			                            $('#renewalremarks').val('');
			                            $("#modaldatechange").modal("hide");
			                            $('#btnsubmit').trigger('click');
			                            $("#overlay, #PleaseWait").hide();
		                        	}
				                    else{
				                    	swal({
					                    	type: 'warning',
					                        title: 'Warning',
					                        text: 'Not Updated'
					                    });
				                    }
			               		} else {}
		                	}
				            x.open("GET", "dateChangeAJAX.jsp?docno="+docno+"&optdatechange="+optdatechange+"&datechangeremarks="+datechangeremarks+"&vocno="+vocno+"&date="+datechangedate, true);
				            x.send();
	  					}
	  				});
				});
				$('#btnrenewal').click(function(){
					var hiddocno=$('#hiddocno').val();
                    var propcontractno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propcontractno');
                    var poststatus=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'poststatus');
                    if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    if(hiddocno!=propcontractno){
                    	swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select live contract'
                        });
                        return false;
                    }
                    if(poststatus=='0' || poststatus==''){
                    	swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please post contract'
                        });
                        return false;
                    }
					var url=document.URL;
					var reurl=url.split("com/");
					var docno=$('#hiddocno').val();
					var pdocno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propdocno');
	       			top.addTab("Tenancy Contract",reurl[0]+"com/realestate/tenancycontract/tenancyContract.jsp?contractdocno="+docno+"&renewalstatus=1&mode=A&pdocno="+pdocno);
				});
				
                $('#btnstatusupdate').click(function() {
                    if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                    var hiddocno=$('#hiddocno').val();
                    var propcontractno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propcontractno');
             /*       if(hiddocno!=propcontractno){
                    	swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select live contract'
                        });
                        return false;
                    } */															
                    $('#modalstatusupdate').modal();
                });
                
                $('#btnstatuspdatesave').click(function(){
                	var docno=$('#hiddocno').val();
                	var vocno=$('#vocno').val();
                	var cmbrenewalstatus=$('#cmbrenewalstatus').val();
                	var strrenewalstatus=$("#cmbrenewalstatus option:selected").text();
                	strrenewalstatus=encodeURIComponent(strrenewalstatus);
                	var renewalremarks=$('#renewalremarks').val();
                	renewalremarks=encodeURIComponent(renewalremarks);
                	var errorstatus=0;
                	if(cmbrenewalstatus==''){
                		$('#cmbrenewalstatus').closest('.form-group').addClass('has-error').find('.help-block').text('Status is mandatory').removeClass('hidden');
                        errorstatus=1;
                        return false;
                	}
                	else{
                		$('#cmbrenewalstatus').closest('.form-group').removeClass('has-error').find('.help-block').text('').addClass('hidden');
                	}
                	if(renewalremarks==''){
                		$('#renewalremarks').closest('.form-group').addClass('has-error').find('.help-block').text('Remarks is mandatory').removeClass('hidden');
                        errorstatus=1;
                        return false;
                	}
                	else{
                		$('#renewalremarks').closest('.form-group').removeClass('has-error').find('.help-block').text('').addClass('hidden');
                	}
                	if(renewalremarks.length>=500){
                		$('#renewalremarks').closest('.form-group').addClass('has-error').find('.help-block').text('Only 500 chars allowed').removeClass('hidden');
                        errorstatus=1;
                        return false;
                	}
                	else{
                		$('#renewalremarks').closest('.form-group').removeClass('has-error').find('.help-block').text('').addClass('hidden');
                	}
                	if(errorstatus==0){
                		Swal.fire({
			  					title: 'Are you sure?',
			  					text: "Do you want to update TNC #"+vocno+" to "+$('#cmbrenewalstatus option:selected').text(),
			  					icon: 'warning',
			  					showCancelButton: true,
			  					confirmButtonColor: '#3085d6',
			  					cancelButtonColor: '#d33',
			  					confirmButtonText: 'Yes'
							}).then((result) => {
			  					if (result.value) {
			  						var propdocno=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'propdocno');
			  						var x = new XMLHttpRequest();
				                	x.onreadystatechange = function() {
				                    	if (x.readyState == 4 && x.status == 200) {
				                        	var items = x.responseText.trim();
				                        	if(items=="0"){
				                        		swal({
					                                type: 'success',
					                                title: 'Message',
					                                text: 'Updated Successfully'
					                            });
					                            $('#cmbrenewalstatus,#renewalremarks').val('');
					                            $("#modalstatusupdate").modal("hide");
					                            $('#btnsubmit').trigger('click');
					                            $("#overlay, #PleaseWait").hide();
				                        	}
				                        	else{
				                        		swal({
					                                type: 'warning',
					                                title: 'Warning',
					                                text: 'Not Updated'
					                            });
				                        	}
				                    	} else {}
				                	}
				                	x.open("GET", "renewalStatusUpdateAJAX.jsp?propdocno="+propdocno+"&docno="+docno+"&cmbrenewalstatus="+cmbrenewalstatus+"&renewalremarks="+renewalremarks+"&vocno="+vocno+"&strrenewalstatus="+strrenewalstatus, true);
				                	x.send();
			  					}
			  				});
                	}
                });
                $('#btnestimateupdate').click(function() {
                    $('#jqxInputOwner').val('');
                    $('#hidownerid').val('');
                    if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
                $('#btnclapprove').click(function() {
                    $('#wdate').val(new Date());
                    if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
                });
                $('#btnsubmit').click(function() {
                	 $("#overlay, #PleaseWait").show();
                    funload();
                    $('.textpanel p').text("");
                    $('#hiddocno').val('');
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
                $('#btnemailowner').click(function(){
                	//Email to landlord
                	if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
            		var owneremail=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "owneremail");
            		var ownerdocno=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "ownerdocno");
            		var ownername=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "owner");       
            		var brchid=1;     
            		var userid="<%= session.getAttribute("USERID").toString() %>";        
               		var contrctno=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "doc_no");                                       
               		var frmdet="TNC";                      
               		var dtype="TNC";        
               		var fname="Tenancy Management";
               		var tncexpirydate=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "todate");
               		var renewalstatus=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "renewalstatus");
               		var propname=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "propname");
               		var renewalmsg="";
               		var currentrent=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "rent");
               		var chequecount=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "chequecount");
               		var subject="";
               		if(renewalstatus.trim()=="90 Days"){
               			subject="90 DAYS NOTICE TO LANDLORD";
               			renewalmsg="In light of the impact COVID-19 is having we would recommend to consider any reasonable offers the Tenant may request in regards to current rental market value, change in payment terms, change in duration of contract and/or additional terms to the contract for provisions of early termination.<br><br>It would be our recommendation to try and retain the current tenant where possible to avoid potentially lengthy periods of vacancy.<br>";
               		}
               		else if(renewalstatus.trim()=="60 Days"){
               			subject="60 DAYS NOTICE TO LANDLORD";
						renewalmsg="If your Tenant has not confirmed if it is their objective to renew, negotiate or vacate we will send an additional Notice to follow up. We will be contacting your Tenant by every available means to establish their intentions for the coming term.  We endeavor to obtain the decision during this period in order to prepare for renewal or to commence advertising of the property for a replacement Tenant.";            			
               		}
               		else if(renewalstatus.trim()=="30 Days"){
               			subject="30 DAYS NOTICE TO LANDLORD";
               			renewalmsg="If the Tenant will be renewing or extending on agreed terms we do request they sign the Tenancy Contract during this 30 day period prior to the expiry and provide payment. This is to prevent a lack of notice period giving should the renewal not proceed and the Tenant vacates.<br><br>Therefore in the event the new contract is not completed at this stage we will market your property for rent to assist us in maximizing the advertising period and to be prepared should the current Tenant not renew/extend. We would establish a recommended price for advertising and notify you accordingly.";
               		}
               		else if(renewalstatus.trim()=="Renewing" || renewalstatus.trim()=="Extending"){
               			subject="RENEWAL NOTICE TO LANDLORD";
               			renewalmsg="Once both you and the Tenant are confirmed and terms approved we will send you the Tenancy Contract for the next term for your signing. As soon as the Tenant has signed the Tenancy Contract and provided the required rental payments you will be notified.";
               		}
               		else if(renewalstatus.trim()=="Vacating"){
               			subject="VACATING NOTICE TO LANDLORD";
               			renewalmsg="If the renewal or extension is not agreed and the Tenant wishes to vacate we will commence marketing of your property as soon as the Tenant notifies us they will be vacating or in event the tenancy contract renewal has still not been completed and it is 30 days before expiry. Recommended market prices will be communicated to you as you will be entitled to request the current rate from a new Tenant.<br><br>We will request your departing Tenant to settle all final utility bills and return the property in its original condition minus any fair wear and tear provision either before or on last day of the current Tenancy Contract. The inspection/hand back process will be discussed with you should it be a requirement. It will be dependent on Government approvals/restrictions imposed and effective at time of the potential property hand back.<br><br>If you would like to discuss the tenancy renewal process further please contact your Property Manager Sarah Uttley at sarah@exclusive-links.com or mobile number +971 50 1113918 within the next 5 days as we will be issuing the Notice to your Tenant after this time.<br><br><br>You will be notified in due course after we have communicated with your Tenant.";
               		}
               		var message="<p>Dear "+ownername+"<br>Please be advised that your Tenancy Contract is due to expire on "+tncexpirydate+" for "+propname+"<br><br>Further to the renewal process we will undertake please see below<br><br>"+renewalmsg+"</p>";
               		var unit=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "unitno"); 
               		unit=unit.replace(/\D/g, "");
               		var cc="";
               		if((unit % 2)==1){
               			cc="sarah@exclusive-links.com";
               		}else {
               			cc="paul@exclusive-links.com";
               		}
               		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+owneremail+"&cldocno="+ownerdocno+"&client="+ownername+"&userid="+userid+"&dtype="+frmdet+"&msg="+encodeURIComponent(message)+"&subject="+subject+"&cc="+cc,"E-Mail","menubar=0,resizable=1,width=900,height=950");
                });
                
                $('#btnemailtenant').click(function(){
                	//Email to landlord
                	if ($('#hiddocno').val() == '') {
                        swal({
                            type: 'warning',
                            title: 'Warning',
                            text: 'Please select a document'
                        });
                        return false;
                    }
            		var tenantemail=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "tenantemail");
            		var tenantdocno=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "cldocno");
            		var tenantname=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "tenantname");       
            		var brchid=1;     
            		var userid="<%= session.getAttribute("USERID").toString() %>";        
               		var contrctno=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "doc_no");                                       
               		var frmdet="TNC";                      
               		var dtype="TNC";        
               		var fname="Tenancy Management";
               		var tncexpirydate=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "todate");
               		var renewalstatus=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "renewalstatus");
               		var propname=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "propname");
               		var renewalmsg="";
               		var currentrent=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "rent");
               		var chequecount=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "chequecount");
               		var message="";
               		var subject="";
               		if(renewalstatus.trim()=="60 Days"){
               			subject="60 DAYS NOTICE TO TENANT";
						message="<p>Dear "+tenantname+",<br>In reference to our previous communications and request to notify us of your intentions to renew or vacate as per your tenancy contract you have not provided sufficient notice if you do not wish to renew.<br>Therefore we have prepared a new tenancy contract as per terms and conditions as existing contract and we require you to sign and provide post dated payments to us on or before "+tncexpirydate+".<br>Please note that you will need to sign a new tenancy agreement and provide post dated payment to us at least 30 days prior to the expiry of your current agreement. Failure to do so will mean that the property is considered available and will be marketed for lease.<br><br>Please contact the office at +971 4 399 4937 to arrange a suitable appointment or for your convenience you may request for our collection of payment.<br><br></p>";            			
               		}
               		else if(renewalstatus.trim()=="30 Days"){
               			subject="30 DAYS NOTICE TO TENANT";
               			message="<p>Dear "+tenantname+"<br><br>Please be advised that (you have yet to advise us if you are renewing the lease or not) (we have yet to receive the rental payment for the renewal).<br>If it is your intention to renew your contract, please contact us urgently to sign your contract and make your rental payment.<br>Failure to contact us means that the property you live in will be marketed as available for lease and you will need to vacate the property on "+tncexpirydate+"<br>As per the terms and conditions of your tenancy contract, failure to renew and not provide sufficient notice could result in the forfeit of your security deposit.<br><br>Should you have any queries, please contact Sarah Uttley at  sarah@exclusive-links.com<br><br></p>";
               		} else if(renewalstatus.trim()=="90 Days"){
               			subject="90 DAYS NOTICE TO TENANT";
               			message="<p>Dear "+tenantname+",<br>Please find attached Notice to Renew Lease or Vacate - tenancy expiring  "+tncexpirydate+" .<br> Could you please ensure you contact us with sufficient notice period as per agreement.<br>Should you have further queries, please do not hesitate in contacting me or our Property Manager Sarah at sarah@exclusive-links.com or mobile number +971 50 1113918.</p>";
               		}
               		var unit=$('#tenancyGrid').jqxGrid('getcelltext',$('#gridrowindex').val(), "unitno"); 
               		unit=unit.replace(/\D/g, "");
               		var cc="";
               		if((unit % 2)==1){
               			cc="sarah@exclusive-links.com";
               		}else {
               			cc="paul@exclusive-links.com";
               		}
               		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+tenantemail+"&cldocno="+tenantdocno+"&client="+tenantname+"&userid="+userid+"&dtype="+frmdet+"&msg="+message+"&subject="+subject+"&cc="+cc,"E-Mail","menubar=0,resizable=1,width=900,height=950");
                });
                $('#btnexcel').click(function() {
                	$("#overlay,#PleaseWait").show();
                	var visiblecolumns=["owner","tenantname","propname","tenantmobile","tenantemail","contactmobile","contactemail","fromdate","todate","renewalstatus","renewalremarks","renewalremarks","rent"];
                	var cols=$("#tenancyGrid").jqxGrid("columns");
                	for(var j=0;j<cols.records.length;j++){
            			var datafield=cols.records[j].datafield;
                		if($.inArray( datafield, visiblecolumns )!== -1){
                			$('#tenancyGrid').jqxGrid('showcolumn', datafield);
                		}
                		else{
                			$('#tenancyGrid').jqxGrid('hidecolumn', datafield);
                		}
                	}
                	$("#ppdiv").excelexportjs({
						containerid: "ppdiv",
						datatype: 'json',
						dataset: null,
						gridId: "tenancyGrid",
						columns: getColumns("tenancyGrid"),
						worksheetName: "Tenancy Management Data"
					});
                	$('#btnsubmit').trigger('click');
                	/* for(var j=0;j<cols.records.length;j++){
            			var datafield=cols.records[j].datafield;
                        var hidden=cols.records[j].hidden;
                        console.log(hidden);
                		if(hidden==true){
                			$('#tenancyGrid').jqxGrid('hidecolumn', datafield);
                		}
                		else{
                			$('#tenancyGrid').jqxGrid('showcolumn', datafield);
                		}
                	}
                	$("#overlay, #PleaseWait").hide(); */
                	
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
                    var gridrows = $('#pagrid').jqxGrid('getrows');
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
                        $('#pagrid').jqxGrid('removefilter', $(this).attr('data-datafield'), true);
                    }
                });
            });
			
			function setExpiry(){
				if(document.getElementById("chkexpiry").checked==true || document.getElementById("chkcreated").checked==true){
					$('.todatepanel table').eq(0).find('tr').eq(0).find('td').eq(1).show();
					$('.todatepanel table').eq(0).find('tr').eq(0).find('td').eq(2).show();
					$('.textpanel').css('width','1000px');
				}
				else{
					$('.todatepanel table').eq(0).find('tr').eq(0).find('td').eq(1).hide();
					$('.todatepanel table').eq(0).find('tr').eq(0).find('td').eq(2).hide();
					$('.textpanel').css('width','1000px');
				}
			}
			function funAttach(){
				var brhid=$('#tenancyGrid').jqxGrid('getcellvalue',$('#gridrowindex').val(),'brhid')
				var frmname="Tenancy Contract";
				var frmcode="TNC";
				if ($("#hiddocno").val()!="") {
					var myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode+"&docno="+document.getElementById("vocno").value+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
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
			
			function setAllContracts(){
				/*if(document.getElementById("chkallcontracts").checked==true){
					$('#fromdate').jqxDateTimeInput({disabled:true});
				}
				else{
					$('#fromdate').jqxDateTimeInput({disabled:false});
				}*/
			}
			function getInitData(){
				var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        items=JSON.parse(items);
                        var statushtml='<option value="">--Select--</option>';
                        $(items.renewalstatusdata).each(function( index ,value) {
 							statushtml+='<option value="'+value.docno+'">'+value.status+'</option>';
						});
						$('#cmbrenewalstatus').html($.parseHTML(statushtml));
						var tenanthtml='<option value="">--Select--</option>';
                        $(items.tenantdata).each(function( index ,value) {
 							tenanthtml+='<option value="'+value.docno+'">'+value.name+'</option>';
						});
						$('#cmbtenant').html($.parseHTML(tenanthtml));
						
						var ownerhtml='<option value="">--Select--</option>';
                        $(items.ownerdata).each(function( index ,value) {
 							ownerhtml+='<option value="'+value.docno+'">'+value.name+'</option>';
						});
						$('#cmbowner').html($.parseHTML(ownerhtml));
						
						var propertyhtml='<option value="">--Select--</option>';
                        $(items.propertydata).each(function( index ,value) {
 							propertyhtml+='<option value="'+value.docno+'">'+value.name+'</option>';
						});
						$('#cmbproperty').html($.parseHTML(propertyhtml));
                    } else {}
                }
                x.open("GET", "getInitData.jsp", true);
                x.send();
			}
            function addGridFilters(id, filtervalue, datafield, filtertype, filtercondition) {
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                if (id == "btnFollowup") {
                    var d = new Date();
                    var day = d.getDate();
                    var month = d.getMonth();
                    var year = d.getFullYear();
                    filtervalue = new Date(year, month, day);
                    filter_or_operator = 0;

                    //var filtercondition = 'contains';
                    var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);

                    filtergroup.addfilter(filter_or_operator, filter1);
                    //filtergroup.addfilter(filter_or_operator, filter2);
                    // add the filters.
                    $("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
                    // apply the filters.
                    $("#pagrid").jqxGrid('applyfilters');
                } else if (id == "btnMeeting") {
                    var d = new Date();
                    var day = d.getDate();
                    var month = d.getMonth();
                    var year = d.getFullYear();
                    filtervalue = new Date(year, month, day);
                    filter_or_operator = 1;

                    //var filtercondition = 'contains';
                    var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    var today = new Date();
                    var s = new Date(today)
                    s.setDate(s.getDate() + 1)
                    var days = s.getDate();
                    var months = s.getMonth();
                    var years = s.getFullYear();
                    filtervalue = new Date(years, months, days);

                    var filter2 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);

                    filtergroup.addfilter(filter_or_operator, filter1);
                    filtergroup.addfilter(filter_or_operator, filter2);
                    // add the filters.
                    $("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
                    // apply the filters.
                    $("#pagrid").jqxGrid('applyfilters');
                } else {
                    //var filtercondition = 'contains';
                    var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);

                    filtergroup.addfilter(filter_or_operator, filter1);
                    //filtergroup.addfilter(filter_or_operator, filter2);
                    // add the filters.
                    $("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
                    // apply the filters.
                    $("#pagrid").jqxGrid('applyfilters');
                }

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
                fileName += ReportTitle.replace(/ /g, "_");

                // newly added 
                var temp = CSV;
                blob = new Blob([temp], {
                    type: 'text/csv'
                });
                var bigcsv = window.webkitURL.createObjectURL(blob);

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
            	var chkexpiry=0;
            	var chkcreated=0;
            	if(document.getElementById("chkexpiry").checked==true){
            		chkexpiry=1;
            	}
            	else{
            		chkexpiry=0;
            	}
            	if(document.getElementById("chkcreated").checked==true){
            		chkcreated=1;
            	}
            	else{
            		chkcreated=0;
            	}
                var fromdate = $('#fromdate').jqxDateTimeInput('val');
                var todate = $('#todate').jqxDateTimeInput('val');
                var cmbmanage=$('#cmbmanage').val();
                var allcontracts=0;
                if(document.getElementById("chkallcontracts").checked==true){
                	allcontracts=1;
                }
                var cmbowner=$('#cmbowner').val();
                var cmbtenant=$('#cmbtenant').val();
                var cmbproperty=$('#cmbproperty').val();
                $('#ppdiv').load("tenancyGrid.jsp?chkcreated="+chkcreated+"&todate="+todate+"&id=1&allcontracts="+allcontracts+"&fromdate="+fromdate+"&chkexpiry="+chkexpiry+"&cmbmanage="+cmbmanage+"&cmbowner="+cmbowner+"&cmbtenant="+cmbtenant+"&cmbproperty="+cmbproperty);
            }

            

            function funestimateupdate() {
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
                            $('#modalestimateupdate').modal('toggle');
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
                x.open("GET", "estimateUpdate.jsp?docno=" + $('#hiddocno').val() + "&vndacno=" + $('#hidvndid').val() + "&rate=" + $('#txtrate').val(), true);
                x.send();
            }

            function funwarrantyupdate() {
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
                            $('#modalwarrantyupdate').modal('toggle');
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
                x.open("GET", "warrantyUpdate.jsp?docno=" + $('#hiddocno').val() + "&wdate=" + $('#wdate').val(), true);
                x.send();
            }

            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && ((charCode < 48) || (charCode > 57)))
                    return false;
                return true;
            }
            
            function funCreateTask(){
    			var reftype="TNC";   
    			var refno=$('#hiddocno').val();
		    	var sdate=$('#date').jqxDateTimeInput('val');
		    	var stime=document.getElementById("vtime").value;
		    	var user=document.getElementById("jqxInputUsers").value;
		    	var hiduser=document.getElementById("hiduser").value;
		    	var desc=document.getElementById("desc").value;
		    	var userid="<%= session.getAttribute("USERID").toString() %>";     
		    	if(refno.trim()==''){
		    		swal({   
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'           
					});
					return false;
		    	}
		    	if(stime=="")   
		    	{
		    		swal({   
						type: 'warning',
						title: 'Warning',
						text: 'Please enter time'           
					});
		   		    document.getElementById('stime').focus();
					return false;
		    	}
		    	if(user=="")
		    	{
		    		swal({   
						type: 'warning',
						title: 'Warning',
						text: 'Please select a user'           
					});
		    		//$.messager.alert('Message','Enter Assigned User','warning');   
		   		    document.getElementById('user').focus();
					return false;
		    	}
		    	if(desc=="")
		    	{
		    		swal({   
						type: 'warning',
						title: 'Warning',
						text: 'Please enter description'           
					});
		    		//$.messager.alert('Message','Enter Description','warning');   
		   		    document.getElementById('desc').focus();
					return false;
		    	}
				
				Swal.fire({
  					title: 'Do you want to save changes?',
  					text:'',
					icon: 'warning',
  					showCancelButton: true,
  					confirmButtonColor: '#3085d6',
  					cancelButtonColor: '#d33',
  					confirmButtonText: 'Yes'
				}).then((result) => {
  					if (result.value) {
    					funCreateTaskAJAX(sdate,stime,user,desc,userid,hiduser,reftype,refno);
  					}
				});
    		}    
    		
    		function funCreateTaskAJAX(sdate,stime,user,desc,userid,hiduser,reftype,refno){       
    			var x=new XMLHttpRequest();
    			x.onreadystatechange=function()
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var msg=x.responseText.trim().split(',');
    					// alert(msg);
    					if(msg=="1"){ 
    			        	document.getElementById("jqxInputUsers").value="";    
    			            document.getElementById("hiduser").value="";
    			            document.getElementById("desc").value=""; 
    			            $('#date').val(new Date());   
    			            $('#vtime').val(new Date());
    			            swal({   
    							type: 'success',
    							title: 'Message',
    							text: 'Successfully Saved'           
    						});
    						funGetCountData();
    						$('#modaltaskcreation').modal('hide');
    			       	}else{
    		            	swal({
    							type: 'error',
    							title: 'Message',  
    							text: 'Not Saved'                         
    						});    
    		            }
    				}
    			}
    			x.open("GET","taskCreate.jsp?sdate="+sdate+"&stime="+stime+"&user="+user+"&desc="+desc+"&userid="+userid+"&hiduser="+hiduser+"&reftype="+reftype+"&refno="+refno,true);
    			x.send();
    		}
    		
    		function funpendingUpdate(){                         
		    	var docno=$('#txtpendocno').val();    
		    	var crtuser=$('#txtcrtuser').val(); 
		     	var status=$('#assgntask').val(); 
		    	var oldstat= document.getElementById("txtoldstatus").value;  
		      	var asgnuser=$('#hiduser2').val();    
		      	var oldassuser=document.getElementById("txtasgnuser").value;   
		    	var userid=$('#hiduser2').val();              
		    	var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{ 
						var items=x.responseText.trim();
						if(items>0){
							document.getElementById("txtcrtuser").value="";  
							document.getElementById("hiduser2").value="";
							document.getElementById("txtpendocno").value="";  
							document.getElementById("jqxInputUser").value=""; 
					 		$('#remarks').val('');
							swal({
								type: 'success',
								title: 'Message',
								text: 'Status Updated'
							});
							//var userid="<%=session.getAttribute("USERID").toString()%>";     
                			funGetCountData();
                			$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);
						}else if(items==-888){  
							swal({
								type: 'error',
								title: 'Warning',
								text: 'Task is not completed'  
							});
						}else{ 
							swal({
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'                               
							});
						}    
					}else
					{
					}    
				}
				x.open("GET","penStatUpdate.jsp?userid="+userid+"&docno="+docno+"&status="+status+"&asgnuser="+asgnuser+"&oldassuser="+oldassuser+"&oldstatus="+oldstat+"&crtuser="+crtuser+"&remarks="+$('#remarks').val(),true);           
				x.send();
    		}
    		function funGetCountData(){
    			var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();                          
						$('.badge-pendingtask').text(items[0]);              
					}      
					else
					{
					}  
				}
				x.open("GET","getCountData.jsp",true);
				x.send();
    		}
    		
    		/* function getActivityStatus(){                 
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						items=JSON.parse(items);
						var optionsbranch=""; 
						$.each(items.statusdata,function(index,value){
							optionsbranch += '<option value="' +value.docno+ '">'  
							+ value.name + '</option>';  
						});
						$("select#assgntask").html(optionsbranch);  
					} else {}         
				}
				x.open("GET","getStatuses.jsp", true);              
				x.send();   
			} */
    		
    		function funstatusval(crtuserid){     
    	    	// var crtuserid=document.getElementById("txtcrtuser").value;  
    	    	 var sesuserid= "<%= session.getAttribute("USERID").toString() %>";
    	    	var optionref="";  
    	    	 if(crtuserid==sesuserid){   
    	    		  optionref += '<option value="Assigned">Assign</option>';
    	    		  optionref += '<option value="Accepted">Accepted</option>';
    	    		  optionref += '<option value="Completed">Completed</option>';
    	    		  optionref += '<option value="Close">Close</option>';          
    	    	      $("select#assgntask").html(optionref); 
    	    	 }else{
    	    		 optionref += '<option value="Assigned">Assign</option>';
    	   		     optionref += '<option value="Accepted">Accepted</option>';
    	   		     optionref += '<option value="Completed">Completed</option>';
    	   	         $("select#assgntask").html(optionref);  
    	    	 }
    	    }
			function funcheckHandBack(docno,propdocno){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText.trim();                          
						 if(parseInt(items)>0){
							 $('#btnhandback').attr({disabled:false});      
						 }else{
							 $('#btnhandback').attr({disabled:true});
						 }           
					}      
					else
					{
					}  
				}    
				x.open("GET","getHandBack.jsp?docno="+docno+"&propdocno="+propdocno,true);   
				x.send();
    		}
			function funhbupdate(){                         
		    	var docno=$('#hiddocno').val();    
		    	var userid=$('#hidhbuser').val(); 
		    	if(userid==""){
		    		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Plsease select user!!!'  
					});
		    		return false;
		    	}
		    	var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{ 
						var items=x.responseText.trim();
						if(items>0){
							document.getElementById("hidhbuser").value="";  
							document.getElementById("jqxHandBackUser").value=""; 
							swal({
								type: 'success',
								title: 'Message',
								text: 'Successfully Updated'
							});
							$('#modalhandback').modal('hide'); 
						}else{ 
							swal({
								type: 'error',
								title: 'Warning',
								text: 'Not Updated'                               
							});
						}    
					}else
					{
					}    
				}
				x.open("GET","handbackUpdate.jsp?userid="+userid+"&docno="+docno,true);               
				x.send();
    		}
        </script>
</body>

</html>