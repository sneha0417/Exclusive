<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Maintenance Management</title>                    
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<jsp:include page="../../../../propertyIncludes.jsp"></jsp:include> 
  <style type="text/css"> 
  
  .btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {     
    border-radius: 30px !important;       
} 
  .btn:focus,.btn:active {
   outline: none !important;
   box-shadow: none;
   }
   .modalStyle {      
    background-color:#33b5e5; 
    padding: 10px; 
   }
   .borderStyle{  
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
    box-shadow: 1px 2px 7px 3px #d4cece;                          
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }   
  .iconStyle{
	color: #000000 !important;  
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;   
  }
  .btnStyle{  
  	display: inline-block;   
    margin-bottom: 0;
    font-weight: 400;
    margin-right:5px;
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
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
  </style>
</head>       
<body onload="funGetCountData();">                     
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
       <div class="todatepanel custompanel">
	      <table>
		      <tr>              
		      <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='fromdate' name='fromdate'></div></td>
		      <td  align="right" ><label class="branch" style="font-size: 13px">To Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
		 </table>          
      </div>        
        <div class="primarypanel custompanel" style="margin-left:15px;">            
  			<button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-tooltip="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
        	<!-- <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button> -->      
        </div>    
      <div class="actionpanel custompanel">                                                      
         <!--  <button type="button" class="btn btn-default btnStyle" id="btnstatusupdate" data-toggle="modal" data-tooltip="tooltip"  title="Status Update"  data-target="#modalstatusupdate" data-placement="bottom"><i class="fa fa-database " aria-hidden="true"></i></button> -->       
          <button type="button" class="btn btn-default btnStyle" id="btnestimateupdate" data-toggle="modal" data-target="#modalestimateupdate" data-tooltip="tooltip" title="Estimate" data-placement="bottom"><i class="fa fa-usd " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnemail"  data-toggle="modal"  data-tooltip="tooltip" title="Email to Owner" data-placement="bottom"><i class="fa fa-share " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnapprovalupdate" data-toggle="modal" data-target="#modalestimateupdate" data-tooltip="tooltip" title="Owner Approval" data-placement="bottom"><i class="fa fa-thumbs-o-up " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnworkcomplete" data-toggle="modal" data-target="#modalestimateupdate" data-tooltip="tooltip" title="Work Complete" data-placement="bottom"><i class="fa fa-check-circle " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnjvcreate"  data-toggle="modal" data-target="#modaljvcreate" data-tooltip="tooltip" title="Block Amount" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnconfirm"  data-toggle="modal"  data-tooltip="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check " aria-hidden="true"></i></button> 
        </div> 
        <div class="warningpanel custompanel">     
          <div class="btn-group" role="group">        
          	<button type="button" class="btn btn-default btnStyle" id="btnOwnerapvl"  data-toggle="tooltip" title="Owner Approval" data-placement="bottom"  data-filtervalue="1" data-datafield="owneraprvl"><i class="fa fa-thumbs-o-up " aria-hidden="true"></i></button>
          	<span class="badge badge-notify badge-Ownerapvl"></span>                                                    
          </div>                         
        </div>                                                    
        <div class="otherpanel custompanel">      
          <button type="button" class="btn btn-default btnStyle" id="btnsummarystmt"  data-toggle="modal" data-target="#modalsummarystmt" data-tooltip="tooltip" title="Summary Statement" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>  
          <button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-tooltip="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementap" data-tooltip="tooltip" title="Owner Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementgl" data-tooltip="tooltip" title="MRF Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementtenant" onclick="gettenantprint();" data-tooltip="tooltip" title="Tenant Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnstatistics" data-toggle="modal" data-target="#modalstatistics" ><i class="fa fa-bar-chart " aria-hidden="true" data-toggle="tooltip" title="Statistics" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btncomment"  data-toggle="modal" data-target="#modalcomments"  data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
        </div>       
          <div class="textpanel custompanel" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">        
			<p  style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
        </div>   
      </div>  
    </div>     
    <br/>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="ppdiv" class="borderStyle"><jsp:include page="propertyGrid.jsp"></jsp:include></div>               
      </div>
    </div>
    
      <!-- Statistics Modal-->
    <div id="modalstatistics" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header modalStyle" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Statistics</h4> </br>
          </div>     
          <div class="modal-body">   
          <div id="statdiv"><jsp:include page="statisticsGrid.jsp"></jsp:include></div>
          </div>
        </div>  
      </div>
    </div>
    <!-- Summary Modal-->           
    <div id="modalsummarystmt" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Summary statement</h4>                             
             <p id="summdesc" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">  
                 <div class="row rowgap">       
            		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
				        <div id="summdiv" class="borderStyle"><jsp:include page="summaryGrid.jsp"></jsp:include></div>               
				    </div>                                
            	</div>  
            	<div class="row rowgap" >
            	     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
				        <div id="summasdiv" class="borderStyle"><jsp:include page="summaryASGrid.jsp"></jsp:include></div>               
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
   
   <div id="modaljvcreate" class="modal fade" role="dialog">   
            <div class="modal-dialog  modal-md">        
                <div class="modal-content">
                    <div class="modal-header modalStyle">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>      
                        <h4 class="modal-title" style="text-align:center">JV Create</h4>   
                        <p id="jvdesc" style="text-align:center;"></p>      
                    </div>
                    <div class="modal-body">
	                     <div class="row">
						    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
	                             <div class="form-group">
	                    			<label for="invdate">Date</label>                
	                    			<div>
	                        			  <div id="jvdate" class="borderStyle"></div>
	                    			</div>
	                  			</div>  
	                     	</div>
	                     	 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
	                             <div class="form-group">
	                    			<label for="pay">Pay</label>            
	                    			<div>
	                        	    <select class="cmbpay" name="cmbpay" id="cmbpay" style="width: 100%">
		                        	    <option value="">--Select--</option>
		                        	    <option value="O">Owner</option>
		                        	    <option value="M">MRF</option> 
		                        	    <option value="T">Tenant</option>            
						           </select>       
	                    			</div>
	                  			</div>  
	                     	</div>
	                     	 <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
	                             <div class="form-group">
	                    			<label for="blockamt">Block Amount</label>            
	                    			<div>
	                        			  <input type="text" id="blockamt" class="borderStyle" style="text-align:right" onblur="funRoundAmt(this.value,this.id);"/>  
	                    			</div>
	                  			</div>  
	                     	</div>
	                    </div>	    	 
                  			 <div class="row">
                  			   <div id="hidejv">      
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
	                	<button type="button" class="btn btn-default btn-primary" name="btncalc" id="btncalc" onclick="funcalculate();">Calculate</button>    
	                	<button type="button" class="btn btn-default btn-primary" name="btnjv" id="btnjv" onclick="funjvcreate();">Create</button> 
	          		</div>         
                </div>
            </div>
        </div> 
    <!-- Execute Modal-->      
    <div id="modalexecute" class="modal fade" role="dialog">
      <div class="modal-dialog   modal-sm">
        <div class="modal-content">
          <div class="modal-header modalStyle">          
            <button type="button" class="close" data-dismiss="modal">&times;</button>   
            <h4 class="modal-title" style="text-align:center">Executed</h4>             
            <p id="clientref1" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>     
            <div class="container-fluid">      
            	<div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-2">Status</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-10">
            			 <select class="cmbstatus" name="cmbstatus" id="cmbstatus" style="width: 100%">       
						  </select>    
						          
					</div>                        
            	</div>
            	<div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funleadstatusupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>     
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
            <h4 class="modal-title" style="text-align:center">Status Update</h4> 
            <p id="clientref1" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>     
            <div class="container-fluid">      
            	<div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-2">Status</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-10">
            			<select class="cmbleadstatus" name="cmbleadstatus" id="cmbleadstatus" style="width: 100%">       
						  <option value="">--Select--</option>
									<option value="4">Owner Approval</option>
									<option value="5">Work Completed</option>
						  </select>              
					</div>                        
            	</div>
            	<div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funleadstatusupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>     
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
<!-- Warranty Extend Modal-->                                                  
    <div id="modalclapprove" class="modal fade" role="dialog">          
      <div class="modal-dialog  modal-sm">
        <div class="modal-content">
          <div class="modal-header modalStyle">   
            <button type="button" class="close" data-dismiss="modal">&times;</button>   
            <h4 class="modal-title" style="text-align:center">Client Approval</h4> 
             <p id="clientref1" style="text-align:center;"></p>   
          </div>                             
         <div class="modal-body">
            <p><!-- Some text in the modal. --></p>     
            <div class="container-fluid">      
            	<div class="row rowgap">      
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Warranty</div>          
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">
            				<div id="wdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
					</div>                        
            	</div>
            	<div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funwarrantyupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>     
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

      <!-- Estimate Modal-->           
    <div id="modalestimateupdate" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center" id="modname"></h4>                          
             <p id="clientref1" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">  
            <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
				        <div id="reqdiv" class="borderStyle"><jsp:include page="requestGrid.jsp"></jsp:include></div>               
				    </div>                                
            	</div>  
            	<div class="row rowgap" >
            	<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
					<div class="form-group">	
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funmodewiseoperate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>
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
     <!-- Tenant history modal-->       
     <div id="modalsplinstruction" class="modal fade" role="dialog">            
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Special Instruction</h4>    
             <p id="historyname3" style="text-align:center;"></p>      
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>    
            <div class="container-fluid">   
             <div class="row">            
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                            
		        <div id="splinsdiv"><jsp:include page="splinstructionGrid.jsp"></jsp:include></div>               
		      </div>                                  
		    </div>                 	    
            	</div>   
            </div>  
           
          </div>  
        </div>  
      </div>  
    <input type="hidden" name="hidmstatus" id="hidmstatus">
    <input type="hidden" name="hidmodtype" id="hidmodtype">  
    <input type="hidden" name="hidbrhid" id="hidbrhid">  
    <input type="hidden" name="hidvocno" id="hidvocno">        
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
  <input type="hidden" name="hidposttrno" id="hidposttrno">
  <input type="hidden" name="hidowneracno" id="hidowneracno">       
  <input type="hidden" name="hiddescription" id="hiddescription">  
  <input type="hidden" name="hidjvtrno" id="hidjvtrno">    
  <input type="hidden" name="hidcalc" id="hidcalc">    
  <input type="hidden" name="hidownid" id="hidownid">
  <input type="hidden" name="hidownername" id="hidownername">    

  	<div id="jobsearchwindow">
			<div></div>
		</div>
		<div id="vendoracwindow">
			<div></div>
		</div>   
</div>		
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){ 
    //$('[data-tooltip="tooltip"]').tooltip();   
    $('[data-tooltip="tooltip"]').tooltip({trigger:"hover"});
    
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 $('#vendoracwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Provider Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
	     $('#vendoracwindow').jqxWindow('close');
		 $('#jobsearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Job Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
		 $('#jobsearchwindow').jqxWindow('close');      
    	 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});  
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
    	 $("#wdate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy"});
    	 $("#jvdate").jqxDateTimeInput({
                    width: '100px',
                    height: '23px',
                    formatString: "dd.MM.yyyy"
                });
         $("#hidejv").hide(); 
         $("#hidcalc").val(0);
       	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));    
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));  
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				  // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){  
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }});                                  
    	 $('[data-toggle="tooltip"]').tooltip(); 
        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();              
        $('#btnsummarystmt').click(function() {       
               	    var docno = $('#hiddocno').val();
                    if (docno == "") {
                       swal({
                           type: 'warning',
                           title: 'Warning',
                           text: 'Please select a document'
                       });
                       return false;
                   }
                   document.getElementById("summdesc").innerHTML=$('#hidownername').val();
                   $("#jqxsummaryGrid").jqxGrid('clear'); 
                   $("#jqxsummaryASGrid").jqxGrid('clear');       
                   $("#overlay, #PleaseWait").show();    
                   var tdate=$('#todate').jqxDateTimeInput('val'); 
                   $('#summdiv').load("summaryGrid.jsp?ownid="+$('#hidownid').val()+"&id="+1+"&todate="+tdate);
               });
        $('#btnjvcreate').click(function() {       
               	    var docno = $('#hiddocno').val();
                    if (docno == "") {
                       swal({
                           type: 'warning',
                           title: 'Warning',
                           text: 'Please select a document'
                       });
                       return false;
                   }
                    var jvtrno = $('#hidjvtrno').val();
                    if (parseInt(jvtrno)>0) {
                       swal({
                           type: 'warning',
                           title: 'Warning',
                           text: 'Amount already blocked'                
                       });
                       return false;
                   } 
                   document.getElementById("jvdesc").innerHTML=$('#hiddocno').val()+' - '+ $("#hidproperty").val();    
                   $("#cmbpay").val('');
                   $("#blockamt").val('');
                   $("#jvdate").val(new Date()); 
                   $("#jqxjvGrid").jqxGrid('clear');
                   $("#hidejv").hide();
                   $("#hidcalc").val(0);
               });
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
        	var status=$('#hidmstatus').val(); 
	          if(parseInt(status)<2){               
	      		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Not estimated...'           
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
        $('#btnaccstatementap').click(function(){                         
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	getAPprint();  
        });
        $('#btnaccstatementgl').click(function(){                     
        	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	getGLprint();
        });
        $('#btnstatistics').click(function(){                                    
        	var fromdate=$('#fromdate').jqxDateTimeInput('val');         
      	    var todate=$('#todate').jqxDateTimeInput('val');          
            $('#statdiv').load("statisticsGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1);  
        });    
         $('#btnestimateupdate').click(function(){     
            document.getElementById('modname').innerText="Estimate";     
            document.getElementById('hidmodtype').value="E";
         	if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	} 
        	funloadestgrid();
        }); 
          $('#btnapprovalupdate').click(function(){
          if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	} 
	         var status=$('#hidmstatus').val(); 
	          if(parseInt(status)<2){               
	      		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Not estimated...'           
					});
	      		return false;
	      	} 
            document.getElementById('modname').innerText="Owner Approval"; 
            document.getElementById('hidmodtype').value="O";       
        	funloadestgrid();
        }); 
          $('#btnworkcomplete').click(function(){       
           if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
            var status=$('#hidmstatus').val(); 
            if(parseInt(status)<4){                      
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Not Approved...'   
				});
        		return false;
        	}  
            document.getElementById('modname').innerText="Work Complete"; 
             document.getElementById('hidmodtype').value="W";                  
        	funloadestgrid();  
        });  
         $('#btnclapprove').click(function(){
            $('#wdate').val(new Date());
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
            funload();    
            $('.textpanel p').text("");
            $('#hiddocno').val(''); 
            $('#hidmrfacno').val(''); 
            $('#hidowneracno').val(''); 
            $('#hidproperty').val(''); 
            $('#hidbrhid').val(''); 
            $('#hidvocno').val(''); 
            $('#jvdesc').val('');       
            $("#hidejv").hide();
            $("#hidcalc").val(0);
            $('#hidtentacno').val(''); 
            $('#summdesc').val(''); 
        });          
        $('#btncomment').click(function(){    
        	getComments(); 	
        var actdocno=$('#hidvocno').val();
    	if(actdocno==""){  
    		swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document'      
			});
    		return false;
    	}
        }); 
        $('#btnexcel').click(function(){         
	        $("#ppdiv").excelexportjs({
				containerid: "ppdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "pagrid",
				columns: getColumns("pagrid") ,   
				worksheetName:"Maintenance Management"  
			});   
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
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{
        		$('#pagrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function getvendorac(rowindex){   
	 	 $('#vendoracwindow').jqxWindow('open');
	 	 vendorSearchContent('vendorSearch.jsp?rowindex='+rowindex); 	 
	}
	        	 
	function vendorSearchContent(url) { 
	 	 $.get(url).done(function (data) { 
			 $('#vendoracwindow').jqxWindow('setContent', data); 
		 	 }); 
	     }
	
	function getjob(rowindex){   
	 	 $('#jobsearchwindow').jqxWindow('open');
	 	jobSearchContent('jobSearch.jsp?rowindex='+rowindex); 	 
	} 
	        	 
	function jobSearchContent(url) { 
	 	 $.get(url).done(function (data) { 
			 $('#jobsearchwindow').jqxWindow('setContent', data); 
		 	 }); 
	     }
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#pagrid").jqxGrid('applyfilters');
 	}
     
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hidvocno').val();
    	$('#hidcomments').val($('#txtcomment').val());
   	    if (($(hidcomments).val()).includes('$')) { $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));};if (($(hidcomments).val()).includes('%')) { $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));};
   	    if (($(hidcomments).val()).includes('^')) { $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));};if (($(hidcomments).val()).includes('`')) { $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));};
   	    if (($(hidcomments).val()).includes('~')) { $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));};if ($(hidcomments).val().indexOf('\'')  >= 0 ) { $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));};
   	    if (($(hidcomments).val()).includes(',')) { $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));}
   	    if ($(hidcomments).val().indexOf('"') >= 0) { $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));};
   	    if (($(hidcomments).val()).match(/\\/g)) { $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));}; 
    
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				$('#txtcomment').val('');
				getComments(); 		
			}
			else
			{
			}   
		}
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);
		x.send();
    }
    function getComments(){
    	var enqno=$('#hidvocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='';
				if(items!=''){ 
				for(var i=0;i<items.length;i++){
					str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
				}
				$('.comments-container').html($.parseHTML(str));		
				}else{}	
			}   
			else
			{
			}
		}
		x.open("GET","getComments.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);     
		x.send();      
    }
    
   function funleadstatusupdate(){
	   var statval=$('#cmbleadstatus').val();
	   //alert("statval========"+statval);
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
							text: 'Successfully Updated'
						}); 
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
			x.open("GET","statusUpdate.jsp?docno="+enqno+"&status="+statval,true);     
			x.send();     
   }
   
   function funConfirm(){
	   var vocno=$('#hidvocno').val();
	   var brhid=$('#hidbrhid').val();
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
		x.open("GET","statusUpdate.jsp?vocno="+vocno+"&confirm="+1+"&brhid="+brhid,true);       
		x.send();     
   }
   
   function statucheck(){
	   var doc=$('#hiddocno').val();
	   
	   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				var str='';
				if(items!=''){ 
					document.getElementById("statuchk").value=items;
				}else{
					
				}
						
			}	   
			else
			{
			}
		}
		x.open("GET","statusCheck.jsp?docno="+doc,true);     
		x.send();
		
		
   }
    
   function funEmail(){
		var doc=$('#hiddocno').val();
		if(doc=='' || doc==0 || doc=='undefined'){ 
		            swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document...'
						});    
			return 0;
		}  
		 var statu=$('#statuchk').val();
		if( statu==3){
		        swal({
							type: 'warning',
							title: 'Warning',
							text: 'Email Already Send...'   
						})
			return 0;
		}
		else{
				funSendMail();	  
		}
	}
   
   function funEmailStatUpdate(){   
	   var statval="3";
	   var vocno=$('#hidvocno').val();
	   var brhid=$('#hidbrhid').val();
	   	var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					var str='';
					if(items!=''){ 
						funload();
						funStatus(); 
					}else{
						
					}
							
				}	   
				else
				{
				}
			}
			x.open("GET","statusUpdate.jsp?vocno="+vocno+"&brhid="+brhid+"&status="+statval,true);          
			x.send();      
	   
	   
   }
   
	function funSendMail(){   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
		var items=x.responseText.trim().split("::");
		var email="";
		var cldocno="";
		var msg="";      
		var client="";
		if(items!=""){
		 msg=items[0];
	     email=items[1];
	     cldocno=items[2];
	     //client=items[3];  
		}
		var brchid="<%= session.getAttribute("BRANCHID").toString() %>";    
		var userid="<%= session.getAttribute("USERID").toString() %>";     
  		var contrctno=document.getElementById("hiddocno").value; 
  		funEmailStatUpdate();
  		var frmdet="PPTY";  
  		var dtype="MMT";        
  		var fname="Maintenance Management"; 
  		var subject="Maintenance Work Approval";
		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&subject="+subject+"&dtype="+frmdet+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950");
		}
		}      
		x.open("GET","sendMail.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true); 
		x.send();         
		}
   function funload(){ 
	   funGetCountData();      
	   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
	   var todate=$('#todate').jqxDateTimeInput('val');  
       $('#ppdiv').load("propertyGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1);                              
   }
   
		function funestimateupdate(){                                                  
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items=x.responseText.trim();
					//alert(items);       
					if(parseInt(items)>0){  
					swal({
							type: 'success',
							title: 'Message',
							text: 'Successfully Updated'
						}); 
						$('#modalestimateupdate').modal('toggle');              
						funload();         
					}else{ 
						swal({
							type: 'error',
							title: 'Warning',
							text: 'Not Updated'                                     
						});
					}     
				} else {     
				}   
			}
			x.open("GET", "estimateUpdate.jsp?docno="+$('#hiddocno').val()+"&vndacno="+$('#hidvndid').val()+"&rate="+$('#txtrate').val()+"&margin="+$('#txtmargin').val(), true);                            
			x.send();
		}
		
		function funwarrantyupdate(){                                           
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items=x.responseText.trim();
					if(parseInt(items)>0){  
					swal({
							type: 'success',
							title: 'Message',
							text: 'Successfully Updated'
						}); 
						$('#modalwarrantyupdate').modal('toggle');  
						funload();             
					}else{ 
						swal({
							type: 'error',
							title: 'Warning',
							text: 'Not Updated'                                   
						});  
					}     
				} else {       
				}   
			}
			x.open("GET", "warrantyUpdate.jsp?docno="+$('#hiddocno').val()+"&wdate="+$('#wdate').val(), true);                 
			x.send();
		}
		 function isNumberKey(evt){   
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
		        return false;
		    return true;   
		}
		
		function funsaveestimate(){               
		    var gridarray=new Array();   
		    var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
		    var val=0;
		    var provider=0;
		    var payval=0;  
		 	for(var i=0;i<rows.length;i++){
		 	var check=rows[i].chk;
		 	 var vendor_docno=rows[i].vendor_docno;
		 	var pay=rows[i].pay;                   
		 	var chk=rows[i].job_docno;
			if(check){ 
		 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){           
		 		     gridarray.push(rows[i].job_docno+"::"+rows[i].vendor_docno+"::"+rows[i].pay+"::"+rows[i].est_cost+"::"+rows[i].margin+"::"+rows[i].total+"::"+rows[i].rowno+"::"+rows[i].doc_no+"::"+rows[i].voc_no+"::"+rows[i].brhid+"::"+rows[i].workscope);                                          
		 	         val=1;
		 	          if(typeof(vendor_docno) == "undefined" || typeof(vendor_docno) == "NaN" || vendor_docno == ""){
		 	              provider=1;                  
		 	         }
		 	         if(typeof(pay) == "undefined" || typeof(pay) == "NaN" || pay == ""){
		 	              payval=1;                                  
		 	         } 
		 	    }          
		     } 
		    }
		    if(val==0){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document'
						});
						return false; 
		    } 
		     if(provider==1){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Provider name is mandatory'
						});
						return false; 
		    } 
		    if(payval==1){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Pay is mandatory'       
						});
						return false; 
		    }   
		    var x=new XMLHttpRequest();
		 		x.onreadystatechange=function(){
		 			if (x.readyState==4 && x.status==200)
		 			{  
		 				var items=x.responseText.trim();
		 				if(parseInt(items)>0){                                     
		 					swal({
		 						type: 'success',
		 						title: 'Success',   
		 						text: 'Successfully Saved'          
		 					});
		 					funStatus();
		 					funload();
		 					$('#modalestimateupdate').modal('toggle');  
		 				}
		 				else{
		 					swal({
		 						type: 'error',
		 						title: 'Error', 
		 						text: 'Not Saved'  
		 					});
		 					$('#modalestimateupdate').modal('toggle'); 
		 				}   
		 			}
		 			else    
		 			{       
		 			}                
		 		}
		 		x.open("GET","saveEstimateData.jsp?gridarray="+encodeURIComponent(gridarray)+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                              
		 		x.send();      
		}
		function funsaveapproval(){                
		    var gridarray=new Array();   
		    var rows=$('#jqxRequestGrid').jqxGrid('getrows');  
		    var val=0;
		 	for(var i=0;i<rows.length;i++){
		 	var check=rows[i].chk;
		 	var chk=$('#jqxRequestGrid').jqxGrid('getcellvalue',i,'doc_no');    
			if(check){ 
		 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){                   
		 		      gridarray.push(rows[i].doc_no);    
		 		      val=1;                                                 
		 	    }          
		     } 
		    }
		    if(val==0){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document'
						});
						return false; 
		    } 
		    var x=new XMLHttpRequest();
		 		x.onreadystatechange=function(){
		 			if (x.readyState==4 && x.status==200)
		 			{  
		 				var items=x.responseText.trim();
		 				if(parseInt(items)>0){                                     
		 					swal({
		 						type: 'success',
		 						title: 'Success',   
		 						text: 'Successfully Approved'  
		 					});
		 					funStatus();
		 				    funload();
		 				    $('#modalestimateupdate').modal('toggle');   
		 				}
		 				else{
		 					swal({
		 						type: 'error',
		 						title: 'Error', 
		 						text: 'Not Approved'  
		 					});
		 					$('#modalestimateupdate').modal('toggle'); 
		 				}   
		 			}
		 			else    
		 			{       
		 			}                
		 		}
		 		x.open("GET","saveApprovalData.jsp?gridarray="+encodeURIComponent(gridarray)+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                              
		 		x.send();      
		}
		function funsavecomplete(){            
		    var gridarray=new Array();  
		    var gridarray2=new Array(); 
		    var rows=$('#jqxRequestGrid').jqxGrid('getrows');
		    var val=0;  
		 	for(var i=0;i<rows.length;i++){
		 	var check=rows[i].chk;
		 	var chk=$('#jqxRequestGrid').jqxGrid('getcellvalue',i,'doc_no');
			if(check){ 
		 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){  
		 		    $('#hiddescription').val(rows[i].description);    
		 		    if ($(hiddescription).val().indexOf('"') >= 0) { $(hiddescription).val($(hiddescription).val().replace(/["']/g, ''));};
				 	if (($(hiddescription).val()).includes(',')) { $(hiddescription).val($(hiddescription).val().replace(/,/g, ''));}
		 		     gridarray.push(rows[i].doc_no);
		 		     gridarray2.push(rows[i].rowno+" :: "+$('#hiddescription').val());                     
		 		     val=1; 
		 		     $('#hiddescription').val('');  
		 	    }          
		     } 
		    }
		     if(val==0){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document'
						});
						return false; 
		    }  
		    var x=new XMLHttpRequest();
		 		x.onreadystatechange=function(){
		 			if (x.readyState==4 && x.status==200)
		 			{  
		 				var items=x.responseText.trim();
		 				if(parseInt(items)>0){                                     
		 					swal({
		 						type: 'success',
		 						title: 'Success',   
		 						text: 'Successfully Completed'  
		 					});
		 					funStatus();
		 					funload();
		 					$('#modalestimateupdate').modal('toggle'); 
		 				}
		 				else{
		 					swal({
		 						type: 'error',
		 						title: 'Error', 
		 						text: 'Not Completed'  
		 					});
		 					$('#modalestimateupdate').modal('toggle'); 
		 				}   
		 			}
		 			else    
		 			{       
		 			}                
		 		}
		 		x.open("GET","saveCompleteData.jsp?gridarray="+encodeURIComponent(gridarray)+"&descarray="+encodeURIComponent(gridarray2)+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                                      
		 		x.send();      
		}
		function funmodewiseoperate(){   
			if($('#hidmodtype').val()=="E"){  
			    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }  
			     	else {
			     		funsaveestimate();              
			     	}  
			 }); 
			}
			if($('#hidmodtype').val()=="O"){
			    funsaveapproval();
			}
			if($('#hidmodtype').val()=="W"){   
			     funsavecomplete();    
			}
		}
		
		function funStatus(){ 
			    var x=new XMLHttpRequest();
		 		x.onreadystatechange=function(){
		 			if (x.readyState==4 && x.status==200)
		 			{  
		 				var items=x.responseText.trim();
		 			    $('#hidmstatus').val(items);      
		 			}
		 			else    
		 			{       
		 			}                
		 		}
		 		x.open("GET","getStatus.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                                          
		 		x.send();      
		}
	function funloadestgrid(){
		   $('#reqdiv').load("requestGrid.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&status="+$('#hidmstatus').val()+"&id="+1);  
		}
		
	function funAttach(){
		var brchid=$('#hidbrhid').val();   
		var frmname="Maintenance Request";   
		var frmcode="PMR";                    
		
		if ($("#hiddocno").val()!="") {	  
			
			var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode
					 +"&docno="+document.getElementById("hidvocno").value+"&brchid="+brchid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
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
    
    function getAPprint(){ 
         var type="AP";        
    	 var x=new XMLHttpRequest();  
    	 x.onreadystatechange=function()  
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var items = x.responseText.trim();
    					var acno=items; 
    					if(acno==0){      
    						swal({
   							type: 'error',
   							title: 'Message',  
   							text: 'Account Satatement is not created'              
   						});  
    					}else{
    					var brnach="a";  
    					var url=document.URL;     
    			        var reurl=url.split("realestate");     
    			        var netamt=0.00;   
    			        var fdate=$('#fromdate').jqxDateTimeInput('val');    
	                    var tdate=$('#todate').jqxDateTimeInput('val');   
    			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    			        win.focus();        
    					}
    				}                  
    			}    
    			x.open("GET","getapprintdatas.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&type="+type,true);        
    			x.send();                      
    }
    
function getGLprint(){ 
         var type="GL";        
    	 var x=new XMLHttpRequest();  
    	 x.onreadystatechange=function()  
    			{
    				if(x.readyState==4 && x.status==200)
    				{
    					var items = x.responseText.trim();
    					var acno=items; 
    					if(acno==0){      
    						swal({
   							type: 'error',
   							title: 'Message',  
   							text: 'Account Satatement is not created'              
   						});       
    					}else{
    					var brnach="a";    
    					var url=document.URL;     
    			        var reurl=url.split("realestate");     
    			        var netamt=0.00;   
    			        var fdate=$('#fromdate').jqxDateTimeInput('val');    
	                    var tdate=$('#todate').jqxDateTimeInput('val'); 
    			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    			        win.focus();        
    					}
    				}                  
    			}    
    			x.open("GET","getapprintdatas.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&type="+type,true);        
    			x.send();                          
    }
	function funDelete(rowno){            
	    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{  
					var items=x.responseText.trim();     
				}
				else    
				{       
				}                     
			}
			x.open("GET","deleterows.jsp?rowno="+rowno,true);                                          
			x.send();      
	}
	  function funjvcreate(){ 
		        if(parseInt($("#hidcalc").val())==0){       
		        	swal({
                        type: 'warning',
                        title: 'Warning',
                        text: 'Please calculate before creating Journal Vouchers'              
                    });
                    return false;
		        }
            	var desc="Blocked for maintenance request no -"+$('#hidvocno').val()+" - "+$('#hidproperty').val().replace(/,/g,' ');        
            	alert(desc);
            	var invdate = $('#jvdate').jqxDateTimeInput('val');
            	var brhid=$("#hidbrhid").val();
            	var invdocno=$("#hidvocno").val();   
            	var gridarray=new Array();
                var rows = $("#jqxjvGrid").jqxGrid('getrows');  
                var amount=0.0;
       		    for(var i=0 ; i < rows.length ; i++){  
       		    	gridarray.push(rows[i].account+" :: "+desc+" :: "+ 1 +" :: "+ 1 +" :: "+rows[i].baseamt+" :: "+rows[i].baseamt+" ::"+ 2 +" :: "+rows[i].id+" :: "+""+" :: "+""+" :: ");   
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
	                         $("#hidejv").hide(); 
	                         $("#hidcalc").val(0);
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
	             x.open("GET", "createjv.jsp?jvarray=" + encodeURIComponent(gridarray)+ "&brhid=" +brhid+ "&invdocno=" +invdocno+ "&amount=" +amount + "&invdate=" +invdate+ "&docno=" + $('#hidvocno').val() + "&desc=" + desc, true);         
	             x.send();       
            }  
            function funcalculate(){
                var acno=0;
                var cmbpay=$("#cmbpay").val();
                if(cmbpay=="O"){
                    acno=$("#hidowneracno").val();
                }else if(cmbpay=="M"){
                	acno=$("#hidmrfacno").val();
                }else if(cmbpay=="T"){
                	acno=$("#hidtentacno").val();
                }else{
                        swal({
	                             type: 'warning',
	                             title: 'Warning',
	                             text: 'Please select pay'      
	                         });
	                         return false;
                }
                var blockamt=$("#blockamt").val();
                if(blockamt==""){
                	swal({
                        type: 'warning',
                        title: 'Warning',
                        text: 'Please enter Block Amount'          
                    });
                    return false;	
                }
                $("#hidejv").show();     
                $("#hidcalc").val(1);    
                $('#jvdiv').load("journalVoucherGrid.jsp?blockamt="+blockamt+"&acno="+acno+"&id="+1); 
            }
          function gettenantprint(){
		        	       if($("#hidvocno").val()==""){          
								swal({
								type: 'error',
								title: 'Message',  
								text: 'Select a Account'              
							    }); 
								return false;
							}
           					var acno=$("#hidtentacno").val(); 
           					if(acno==0){      
           						swal({
          							type: 'error',
          							title: 'Message',  
          							text: 'Select a Account'              
          						}); 
           						return false;
           					}else{
           					var brnach="a";    
           					var url=document.URL;     
           			        var reurl=url.split("realestate");     
           			        var netamt=0.00;   
           			        var fdate=$('#fromdate').jqxDateTimeInput('val');    
       	                    var tdate=$('#todate').jqxDateTimeInput('val'); 
           			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
           			        win.focus();        
           					}
           }
          function funRoundAmt(value,id){
        	    var res=parseFloat(value).toFixed(window.parent.amtdec.value);
        	    var res1=(res=='NaN'?"0":res);
        	    document.getElementById(id).value=res1;  
        	   }
          function loadsummaryASGrid(acno){
        	  $("#overlay, #PleaseWait").show();
        	  var fdate=$('#fromdate').jqxDateTimeInput('val');    
              var tdate=$('#todate').jqxDateTimeInput('val'); 
              var brch="a";
        	  $('#summasdiv').load("summaryASGrid.jsp?accdocno="+acno+"&id="+1+"&fromdate="+fdate+"&todate="+tdate+"&branchval="+brch);       
          }
          function funGetCountData(){
        	var fdate=$('#fromdate').jqxDateTimeInput('val');    
            var tdate=$('#todate').jqxDateTimeInput('val');    
          	var x=new XMLHttpRequest();
      		x.onreadystatechange=function(){
      			if (x.readyState==4 && x.status==200)
      			{
      				var items=x.responseText.trim();  
      				$('.badge-Ownerapvl').text(items);       
      			}      
      			else
      			{
      			}  
      		}
      		x.open("GET","getCountData.jsp?fromdate="+fdate+"&todate="+tdate,true);                         
      		x.send();
          }    
  </script>      
</body>     
</html>
