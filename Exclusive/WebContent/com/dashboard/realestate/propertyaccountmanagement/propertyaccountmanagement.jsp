<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Property Account Management</title>         
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
      /* background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
      background-color:#f99595;
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
<body>                     
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
       <div class="todatepanel custompanel">
	      <table>
		      <tr>              
		      <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='fromdate' name='fromdate'></div></td>
		      <td  align="right" ><label class="branch" style="font-size: 13px">To Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='todate' name='todate'></div></td>
		      <td align="left"><label class="branch" style="font-size: 13px">&nbsp;&nbsp; Type &nbsp;&nbsp;</label></td>
		     <td align="left"><select id="acntype" style="width:100%;height: 20px;position: static;"><option value="a">All</option><option value="1">Active</option><option value="0">InActive</option></select></td>
		      </tr>                                          
		 </table>          
      </div>        
        <div class="primarypanel custompanel" style="margin-left:15px;">                              
  			<button type="button" class="btn btn-default btnStyle" id="btnsubmit"   data-tooltip="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
          	<button type="button" class="btn btn-default btnStyle" id="btnexcel"  data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
        	<!-- <button type="button" class="btn btn-default btnStyle" id="btninactive"  data-tooltip="tooltip" title="Inactive Property" data-placement="bottom"><i class="fa fa-ban " aria-hidden="true"></i></button> -->
        	<button type="button" class="btn btn-default btnStyle" id="btnmrfstmt" data-toggle="modal" data-target="#modalstmt"   data-tooltip="tooltip" title="MRF Statement" data-placement="bottom"><i class="fa fa-file-text" aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default btnStyle" id="btnownerstmt" data-toggle="modal" data-target="#modalstmt"   data-tooltip="tooltip" title="Owner Statement" data-placement="bottom"><i class="fa fa-file-text" aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default btnStyle" id="btntnthistory" data-toggle="modal" data-target="#modaltnthistory"   data-tooltip="tooltip" title="Tenancy History" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default btnStyle" id="btnmnchistory" data-toggle="modal" data-target="#modalmnchistory"   data-tooltip="tooltip" title="Maintenance History" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default btnStyle" id="btninshistory" data-toggle="modal" data-target="#modalinshistory"   data-tooltip="tooltip" title="Inspection History" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>    
            <button type="button" class="btn btn-default btnStyle" id="btnpropertyaccount" onclick="funPrintPropertyAccount();" data-tooltip="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default btnStyle" id="btnsummarystmt"  data-toggle="modal" data-target="#modalsummarystmt" data-tooltip="tooltip" title="Summary Statement" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default btnStyle" id="btnemail"  data-toggle="modal"  data-tooltip="tooltip" title="Email" data-placement="bottom"><i class="fa fa-envelope" aria-hidden="true"></i></button>
        </div>                  
      <div class="actionpanel custompanel">                                                              
          <button type="button" class="btn btn-default btnStyle" id="btnjobstatus"  data-toggle="modal" data-target="#modaltaskcreation"  data-tooltip="tooltip" title="Task Creation" data-placement="bottom"><i class="fa fa-plus-square " aria-hidden="true"></i></button>
        </div>                           
       <div class="warningpanel custompanel">                        
          <div class="btn-group" role="group">              
            <button type="button" class="btn btn-default btnStyle" id="btnteamselection"  data-toggle="modal" data-target="#modalpendingtask"  data-tooltip="tooltip" title="Pending Task" data-placement="bottom"><i class="fa fa-newspaper-o " aria-hidden="true"></i></button>
            <span class="badge badge-notify badge-pendingtask"></span>                                            
          </div>
        </div>                       
        <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default btnStyle" id="btncomment"  data-toggle="modal" data-target="#modalcomments"  data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
              <button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-tooltip="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>
               <button type="button" class="btn btn-default btnStyle" id="btnviewroom"   data-tooltip="tooltip" title="Furniture" data-placement="bottom"><i class="fa fa-bed" aria-hidden="true"></i></button>
        </div> 
          <div class="textpanel custompanel" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;top:20px;position:absolute;">        
			<p  style="font-size:0.9em;float:left;" id="selectedrow">&nbsp;</p>&nbsp;&nbsp;&nbsp;&nbsp;
        </div>  
      </div>
    </div>  
    <br/>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="ppdiv" class="borderStyle"><jsp:include page="propertyGrid.jsp"></jsp:include></div>               
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
     <!-- Inspection history  modal-->                   
    <div id="modalinshistory" class="modal fade" role="dialog">            
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Inspection history</h4> 
             <p id="historyname3" style="text-align:center;"></p>      
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
             <div class="row">            
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
		        <div id="insdiv"><jsp:include page="inspectionGrid.jsp"></jsp:include></div>               
		      </div>                                  
		    </div>                 	    
            	</div>   
            </div>  
           
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
<!-- Pending Modal-->        
       <div id="modalpendingtask" class="modal fade" role="dialog">     
      <div class="modal-dialog modal-xl">    
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Pending Task</h4>      
          </div>
          <div class="modal-body">
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
          </div>
        <!--   <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" name="btnupdate" id="btnupdate" onclick="funpendingUpdate();" class="btn btn-default">Update</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div> -->         
        </div>
      </div>
    </div>

<!-- task creation Modal-->
    <div id="modaltaskcreation" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Task Creation</h4>                
          </div>  
		<div class="modal-body"> 
		    <div class="container-fluid">
		   <!--  <div class="row rowgap">   
		            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Select a Reference Type</div>
		            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
		            			<select id="reftype" style="width:69%;">
									<option value="Enquiry">Enquiry</option>
									<option value="Quotation">Quotation</option>
									<option value="Others">Others</option>
								</select>
							</div>  
		            	</div>
		
		      <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Reference No</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<input type="number" placeholder="Ref.No" id="refno" style="width:69%;">
					</div>  
            	</div> -->

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
                     	<input type="hidden" name="hiduser" id="hiduser">  	</div>  
            	</div>
            	   
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="desc"></textarea>
					</div>  
            	</div>
		 <div class="row rowgap">   
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">
					<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funSave();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					<button type="button" class="btn btn-default btnStyle" id="btnclose" data-dismiss="modal"><i class="fa fa-times " aria-hidden="true"></i></button>
					</div>   
				</div>   
</div>
<div class="clear"></div>       
</div>
          <!-- <div class="modal-footer" style="background-color:#CDFDFA">
          <button type="button" class="btn btn-default" onclick="funSave();">SAVE</button>
            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
          </div>   -->               
        </div>
      </div>
    </div>
  <!-- task creation Modal-->
  
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
       <!-- Comments Modal--> 
  <!-- stmt  modal-->             
    <div id="modalstmt" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center" id="stmtname"></h4> 
             <p id="stmtdesc" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
             <div class="row">      
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
		        <div id="stmtdiv"><jsp:include page="accountsStatementGrid.jsp"></jsp:include></div>               
		      </div>                                  
		    </div>                 	
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnstmtprint" title="Statement Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
					</div>
				</div>                   
            	</div>   
            </div>  
           
          </div>  
        </div>  
      </div>                
      <!-- stmt modal-->
   <!-- Tenant history  modal-->                   
    <div id="modaltnthistory" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Tenancy history</h4> 
             <p id="historyname" style="text-align:center;"></p>      
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
             <div class="row">      
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
		        <div id="tntdiv"><jsp:include page="tenantGrid.jsp"></jsp:include></div>               
		      </div>                                  
		    </div>                 	    
            	</div>   
            </div>  
           
          </div>  
        </div>  
      </div>                
      <!-- Tenant history modal-->    
   <!-- Maintenance history  modal-->                  
    <div id="modalmnchistory" class="modal fade" role="dialog">                  
      <div class="modal-dialog modal-xl">     
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Maintenance history</h4> 
             <p id="historyname2" style="text-align:center;"></p>           
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
             <div class="row">      
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">                       
		        <div id="mncdiv"><jsp:include page="maintenanceGrid.jsp"></jsp:include></div>                   
		      </div>                                  
		    </div>  
		    <div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">      
						<button type="button" class="btn btn-default btnStyle" id="btnmhisprint" title="Maintenace Review Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
					</div>
				</div>                 	
            </div>      
            </div>  
          </div>  
        </div>  
      </div>                
      <!-- Maintenance history modal-->        
    <!-- attachment modal-->        
    <div id="modalattach" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Attachment</h4> 
             <p id="clientref1" style="text-align:center;"></p>  
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap">   
            		<div class=" col-md-4">Existing Owner</div>            
            		<div class=" col-md-8 ">            			
	                    <input type="text" name="txtexistowner" id="txtexistowner" disabled  style="width:70%">                
					</div>                          
            	</div>    
            	            	
            <div class="row rowgap">   
            		<div class="col-md-4">New Owner</div>            
            		<div class="col-md-8 ">
            		<%-- 	<div id="owner"  onkeydown="return (event.keyCode!=13);"><jsp:include page="ownerSearch.jsp"></jsp:include></div>
	                    <input type="hidden" name="hidownerid" id="hidownerid">              --%>
	                    
	                    <select id="cmbowner" name="cmbowner" style="width:70%;"></select>   
					</div>                          
            	</div>  
            	<div class="row rowgap">      
            		<div class="col-md-4 ">Remarks</div>          
            		<div class=" col-md-8">
            				<textarea id="txtownerremarks" name="txtownerremarks" rows="3" style="width:70%"></textarea>
					</div>                        
            	</div>                                                                   
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Update" data-placement="bottom" onclick="funownerupdate();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>
				</div>                   
            	</div>   
            </div>  
           
          </div>  
        </div>  
      </div>                
      <!-- attachment modal-->            
      
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
  <input type="hidden" name="hidowneracno" id="hidowneracno">  
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidmrfacno" id="hidmrfacno">  
  <input type="hidden" name="hidmode" id="hidmode">  
  <input type="hidden" name="hidmacno" id="hidmacno">  
  <input type="hidden" name="hidoacno" id="hidoacno">  
  <input type="hidden" name="hidmaccount" id="hidmaccount">  
  <input type="hidden" name="hidoaccount" id="hidoaccount"> 
  <input type="hidden" name="hidproperty" id="hidproperty">  
  <input type="hidden" name="hidownid" id="hidownid">   
  <input type="hidden" name="hidemail" id="hidemail">                                                      
  	<!-- rooms modal -->
	<div class="modal fade" id="roomfurnitureModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
					<h4>Rooms -Furniture & Fixtures</h4>
				</div>

				<div class="modal-body">
					 <div id="accordion"></div>
				</div>

			</div>
		</div>
	</div>

	<!-- rooms modal -->
  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  

/* attachimages */
function funAttach(){            
	var brchid=$("#hidbrhid").val();        
	var frmname="Property Master";
	var frmcode="PPM";
	
	if ($("#hiddocno").val()!="") {	  
		
		var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode
				 +"&docno="+document.getElementById("hiddocno").value+"&brchid="+brchid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
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
 
function LoadRoomsFurniture(){	
 	var dno=$('#hiddocno').val();
 	//alert(dno);
	var html='';var m=''; var i; var k=0;var j=0; var menu=''; 
	var url=document.URL;
	var reurl=url.split("com/"); 	  
	var m,menu;
	$.ajax({
		url:'getRoomsFurniture.jsp',
		data: {docno:dno},
		type:'get',
		success:function(bidata)
		{  
			var data = JSON.parse(bidata);
			 			//console.log(data.property[0].main);			
			if(typeof(data.property[0].main) !='' && typeof(data.property[0].main)!='undefined')
			{
				for(i=0;i<data.property.length;i++ ) 
				{  
					if(m !=data.property[i].main)  { 
						
					  j++;		 
					  html += '<div class="panel panel-default">';
					  html += '	<div class="panel-heading" style="padding: 5px 8px;">';
					  html += '<h5 class="panel-title" style="font-size:14px;">';
					  html += '<a data-toggle="collapse" data-parent="#accordion"';
					  html += ' href="#collapse'+j+'">'+data.property[i].main+'</a>';
					  html += '</h5> </div>';
					  html += '<div id="collapse'+j+'" class="collapse panel-collapse">';
					  html += '<div class="panel-body">';  					  
					  
					  menu=data.property[i].main;	
	
					  for(k=0;k<data.property.length;k++)
						{
						   if(menu==data.property[k].main)
							   { 
								    html += '<a href="javascript:void(0);" style="line-height:2;cursor:default;text-decoration:none;color:#000;">'+data.property[k].sub+'</a> <br />';
							   } 
						} 
					  html +='</div> </div>';
					  }
					else
						{
						  html +='</div>';
						}					
					   m=data.property[i].main;					    
					   //console.log(m+"::"+i+"::"+data.property[i].main);
				}
				
				$('#accordion').empty();				
				$('#accordion').append(html);
			}
			else
				
			{
				$('#accordion').empty();
				html+='<p>No Data Found</p>';
				$('#accordion').append(html);	
			}
		} 
	});
	
	$('#roomfurnitureModal').modal('toggle');
	
}  

    $(document).ready(function(){        
    	 $('[data-tooltip="tooltip"]').tooltip({trigger:"hover"});	
         //$('[data-tooltip="tooltip"]').tooltip();
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
    	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    	 $("#vtime").jqxDateTimeInput({ width: '30%', height: '16px', formatString:'HH:mm', showCalendarButton: false});
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
    	reload();  
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
                   document.getElementById("summdesc").innerHTML=$("#txtexistowner").val();
                   $("#jqxsummaryGrid").jqxGrid('clear'); 
                   $("#jqxsummaryASGrid").jqxGrid('clear');       
                   $("#overlay, #PleaseWait").show();    
                   var tdate=$('#todate').jqxDateTimeInput('val'); 
                   $('#summdiv').load("summaryGrid.jsp?ownid="+$('#hidownid').val()+"&id="+1+"&todate="+tdate);
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
         	var email=$("#hidemail").val();
         	if(!validateEmail(email)){        
				 return false;   
			 }
         	funEmail();       
         });
       $('#btntnthistory').click(function(){ 
	    	 if($('#hiddocno').val()==''){   
	        		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'     
					});
	        		return false;
	        	}
	    	 document.getElementById('historyname').innerText=$('#hidproperty').val();   
	    	 $('#tntdiv').load("tenantGrid.jsp?pdocno="+$('#hiddocno').val()+"&id="+1);                                              
	       }); 
	     $('#btnmnchistory').click(function(){ 
	    	 if($('#hiddocno').val()==''){   
	        		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	    	 document.getElementById('historyname2').innerText=$('#hidproperty').val();         
	    	 $('#mncdiv').load("maintenanceGrid.jsp?pdocno="+$('#hiddocno').val()+"&id="+1);                                   
	       }); 
	     $('#btninshistory').click(function(){ 
	    	 if($('#hiddocno').val()==''){   
	        		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	    	 document.getElementById('historyname3').innerText=$('#hidproperty').val();         
	    	 $('#insdiv').load("inspectionGrid.jsp?pdocno="+$('#hiddocno').val()+"&id="+1);                                        
	       }); 
         $('#btnmrfstmt').click(function(){       
           if($('#hiddocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
            document.getElementById('stmtname').innerText="MRF Statement"; 
            document.getElementById('stmtdesc').innerText=$('#hidmacno').val()+" - "+$('#hidmaccount').val();               
            document.getElementById('hidmode').value="M"; 
            var mode="M";   
        	funloadstmtgrid(mode);            
        });  
         $('#btnstmtprint').click(function(){          
              var mode=document.getElementById('hidmode').value;  
              getstmtprint(mode);                                
          }); 
         $('#btnmhisprint').click(function(){          
             getmhisprint();                                    
         }); 
         $('#btnownerstmt').click(function(){       
             if($('#hiddocno').val()==''){   
          		swal({
  					type: 'warning',
  					title: 'Warning',
  					text: 'Please select a document'
  				});
          		return false;
          	}
            document.getElementById('stmtname').innerText="Owner Statement";
            document.getElementById('stmtdesc').innerText=$('#hidoacno').val()+" - "+$('#hidoaccount').val(); 
            document.getElementById('hidmode').value="O"; 
            var mode="O";   
          	funloadstmtgrid(mode);            
          });  
         $('#btninactive').click(function(){   
        	 $("#overlay, #PleaseWait").show();
            funloadinactive();    
            $('.textpanel p').text("");
            $('#hiddocno').val('');                       
         	funGetCountData();                 
        });   
        
        $('#btnsubmit').click(function(){
        	 $("#overlay, #PleaseWait").show();
            funload();    
            $('.textpanel p').text("");
            $('#hiddocno').val('');    
            $('#hidbrhid').val('');                       
            document.getElementById('stmtname').innerText=""; 
            document.getElementById('stmtdesc').innerText=""; 
            document.getElementById('historyname').innerText="";
            document.getElementById('historyname2').innerText="";
            document.getElementById('hidmode').value="";  
            document.getElementById('hidemail').value="";   
         	funGetCountData();                 
        });          
        $('#btnteamselection').click(function(){ 
        	reload();
        });
        funGetCountData();  
        $('#btncomment').click(function(){    
        	getComments(); 	
        var actdocno=$('#hiddocno').val();
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
        	// JSONToCSVCon(dataexcel, 'Property Management', true);
        	 $("#pagrid").excelexportjs({
 				containerid: "ppdiv",   
 				datatype: 'json',
 				dataset: null,
 				gridId: "pagrid",
 				columns: getColumns("pagrid") ,   
 				worksheetName:"Property Info"  
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
        
        
        $('#btnviewroom').click(function(){    
            
            var actdocno=$('#hiddocno').val();
        	if(actdocno==""){  
        		swal({
    				type: 'warning',
    				title: 'Warning',
    				text: 'Please select a document'      
    			});
        		return false;
        	}
        	else
        	 {
        		LoadRoomsFurniture();
        	 }
            }); 
        
        $('#btnattach').click(function(){    
         
        var actdocno=$('#hiddocno').val();
    	if(actdocno==""){  
    		swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document'      
			});
    		return false;
    	}
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
    
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){   
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnFollowup"){
			var d=new Date();
			var day=d.getDate();
			var month=d.getMonth();
			var year=d.getFullYear();    		   
    		filtervalue=new Date(year,month,day);
    		filter_or_operator=0;
	        
	        //var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);  
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	//filtergroup.addfilter(filter_or_operator, filter2);
	    	// add the filters.
	    	$("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#pagrid").jqxGrid('applyfilters');
    	}else if(id=="btnMeeting"){
    	    var d=new Date();
			var day=d.getDate();
			var month=d.getMonth();
			var year=d.getFullYear();    		
    		filtervalue=new Date(year,month,day);
    		filter_or_operator=1;
	        
	        //var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	        var today=new Date();
	        var s = new Date(today)
            s.setDate(s.getDate() + 1)  
			var days=s.getDate();
			var months=s.getMonth();
			var years=s.getFullYear();    		
    		filtervalue=new Date(years,months,days);
	       
	        var filter2 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	filtergroup.addfilter(filter_or_operator, filter2);  
	    	// add the filters.
	    	$("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#pagrid").jqxGrid('applyfilters');  
    	}else{
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
     
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hiddocno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&docno="+enqno,true);
		x.send();
    }
    function getComments(){
    	var enqno=$('#hiddocno').val();
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
		x.open("GET","getComments.jsp?docno="+enqno,true);     
		x.send();      
    }
    
   function funload(){   
	   var typess=$('#acntype').val();    
	   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
	   var todate=$('#todate').jqxDateTimeInput('val');  
       $('#ppdiv').load("propertyGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1+"&status=1"+"&actype="+typess);                              
   }
   
   function funloadinactive(){      
	   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
	   var todate=$('#todate').jqxDateTimeInput('val');  
       $('#ppdiv').load("propertyGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1+"&status=0");                              
   }
   
    function reload(){         
  	    var userid= "<%= session.getAttribute("USERID").toString() %>";   
  		$('#pnddiv').load('pendingtaskGrid.jsp?userid='+userid);    
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
					funGetCountData();
					reload();         
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
    function getActivityStatus(){                 
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var status = items[1].split(",");
				//var optionsbranch = '<option value="" selected>-- Select -- </option>';  
				var optionsbranch="";   
				for (var i = 0; i < status.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'  
							+ status[i] + '</option>';  
				}
				$("select#cmbactivitystatus").html(optionsbranch);  
				
			} else {}         
		}
		x.open("GET","getStatuses.jsp", true);              
		x.send();   
	}
   
    function funSave(){
    	//var reftype=document.getElementById("reftype").value;   
    	//var refno=document.getElementById("refno").value;
    	var sdate=$('#date').jqxDateTimeInput('val');
    	var stime=document.getElementById("vtime").value;
    	var user=document.getElementById("jqxInputUsers").value;
    	var hiduser=document.getElementById("hiduser").value;
    	var desc=document.getElementById("desc").value;
    	var userid="<%= session.getAttribute("USERID").toString() %>";     
    	
    	if(stime=="")   
    	{
    		$.messager.alert('Message','Enter time','warning');   
   		    document.getElementById('stime').focus();
			 return 0;
    	}
    	if(user=="")
    	{
    		$.messager.alert('Message','Enter Assigned User','warning');   
   		    document.getElementById('user').focus();
			 return 0;
    	}
    	if(desc=="")
    	{
    		$.messager.alert('Message','Enter Description','warning');   
   		    document.getElementById('desc').focus();
			 return 0;
    	}

    	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		    	     saveDatasss(sdate,stime,user,desc,userid,hiduser);       
		     	}  
		 });      
    	
    }    
    function saveDatasss(sdate,stime,user,desc,userid,hiduser){       
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
    			               
    			              } else{
    		            	swal({
    							type: 'error',
    							title: 'Message',  
    							text: 'Not Saved'                         
    						});    
    		            }
    				}         
    			}
    			x.open("GET","taskCreate.jsp?sdate="+sdate+"&stime="+stime+"&user="+user+"&desc="+desc+"&userid="+userid+"&hiduser="+hiduser,true);
    			x.send();
    }
 	
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
		function funownerupdate(){                                           
			$.messager.confirm('Message', 'Do you want to change Owner for this Property? ', function(r){
				if(r==false)
				{
					return false; 
				}
				else
				{
					 updateowner();
				}
			}); 
		}
		function updateowner()
		{
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
						$('#modalownerupdate').modal('toggle');  
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
			x.open("GET", "ownerUpdate.jsp?docno="+$('#hiddocno').val()+"&ownerid="+$('#hidownerid').val()+"&remarks="+$('#txtownerremarks').val(), true);                 
			x.send();
		} 
		
		function funpropertystatusupdate(){  
			
			var stat=$('#cmbpstatus').val();
			var mng=$('#cmbpmngd').val();
			
			if(stat=="")
			{
				$.messager.alert('Message','Please select a Status','warning');   
	   		    document.getElementById('cmbpstatus').focus();
				 return 0;
			}
			else
			{			
				$.messager.confirm('Message', 'Do you want to change Status? ', function(r){
					if(r==false)
					{
						return false; 
					}
					else
					{
						updatepstatus();
					}
				}); 
			}
		}
		
		function updatepstatus()
		{
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
						$('#modalstatusupdate').modal('toggle');  
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
			x.open("GET", "statusUpdate.jsp?docno="+$('#hiddocno').val()+"&status="+$('#cmbpstatus').val()+"&mng="+$('#cmbpmngd').val()+"&remarks="+$('#txtstatusremarks').val(), true);                 
			x.send();
		}
		
		function funwarrantyupdate(){                                           
			$.messager.confirm('Message', 'Do you want to change Warranty Date? ', function(r){
				if(r==false)
				{
					return false; 
				}
				else
				{
					updatewarranty();
				}
			}); 
		}
		
		function updatewarranty()
		{
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
			x.open("GET", "warrantyUpdate.jsp?docno="+$('#hiddocno').val()+"&wdate="+$('#wdate').val()+"&remarks="+$('#txtwarratyremarks').val(), true);                 
			x.send();
		}
		
		function getOwner() { 
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var ownerIdItems  = items[0].split(",");
					var ownerItems = items[1].split(",");
					
					var owneroptions='<option value=""> select</option>';
					for (var i = 0; i < ownerItems.length; i++) {
						owneroptions += '<option value="' + ownerIdItems[i].trim() + '">'
								+ ownerItems[i] + '</option>';
					}
					$("select#cmbowner").html(owneroptions);
				} else {
				}  
			}
			x.open("GET","getOwner.jsp",true);   
			x.send();
		} 
		function funloadstmtgrid(type){                           
			   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
			   var todate=$('#todate').jqxDateTimeInput('val');  
			   var branchval=$('#hidbrhid').val();
			   var accdocno=0;
			   if(type=="M"){
				    accdocno=$('#hidmrfacno').val();     
			   }else if(type=="O"){
				    accdocno=$('#hidowneracno').val();       
			   }else{}
		       $('#stmtdiv').load("accountsStatementGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branchval="+branchval+"&accdocno="+accdocno+"&id="+1);                                     
		   }
		
		function getstmtprint(acctype){  
		   var acno=0;
		   var type="";   
	       if(acctype=="M"){
	    	    acno=$('#hidmrfacno').val(); 
			    type="GL";     
		   }else if(acctype=="O"){
			    acno=$('#hidowneracno').val();
			    type="AP";          
		   }else{}
			if(acno==0){      
				swal({
					type: 'error',
					title: 'Message',  
					text: 'Account Satatement is not created'              
				    }); 
				return false;
			}	
			var brnach="a";    
			var url=document.URL;     
	        var reurl=url.split("realestate");     
	        var netamt=0.00;   
	        var fdate=$('#fromdate').jqxDateTimeInput('val');    
            var tdate=$('#todate').jqxDateTimeInput('val'); 
	        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();                     
	    }
	    
	     function funPrintPropertyAccount(){    
	      var property=$('#hiddocno').val();
	      var acno=$('#hidowneracno').val();
	      if(property==""){           
	            $.messager.alert('warning','Please select a document');             
				return false;
	      }    
	      var fdate=$('#fromdate').jqxDateTimeInput('val');             
          var tdate=$('#todate').jqxDateTimeInput('val');   
		  var url=document.URL;  
	      var reurl=url.split("propertyaccountmanagement.jsp");                  
	      var win= window.open(reurl[0]+"printpropertyaccount?docno="+property+'&fromDate='+fdate+'&toDate='+tdate+'&acno='+acno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();           
		} 
	     function getmhisprint(){
                var property=$('#hiddocno').val();				
				var url=document.URL;     
		        var reurl=url.split("propertyaccountmanagement");        
		        var win= window.open(reurl[0]+"maintenancereview/printmainetenacereview?property="+property,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();                     
		    }
	     function loadsummaryASGrid(acno){
       	  $("#overlay, #PleaseWait").show();
       	  var fdate=$('#fromdate').jqxDateTimeInput('val');    
             var tdate=$('#todate').jqxDateTimeInput('val'); 
             var brch="a";
       	  $('#summasdiv').load("summaryASGrid.jsp?accdocno="+acno+"&id="+1+"&fromdate="+fdate+"&todate="+tdate+"&branchval="+brch);       
         }
	     function validateEmail($email) {  
	   	  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	   	  if(emailReg.test( $email )){
	   			return true;
	   		}
	   		else{
	   			swal({   
	   				type: 'warning',
	   				title: 'Warning', 
	   				text: 'Email Address Not Valid!!!'                             
	   			});
	   			return false;
	   		}
	   	  return true;
	   	}
	     function funEmail(){
	    	  $("#overlay, #PleaseWait").show();
	    	  var property=$('#hiddocno').val();
		      var acno=$('#hidowneracno').val();
		      var fdate=$('#fromdate').jqxDateTimeInput('val');             
	          var tdate=$('#todate').jqxDateTimeInput('val');    
	          var x=new XMLHttpRequest();   
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){
		      		var items=x.responseText.trim(); 
		      		if(parseInt(items)>0){  
						swal({
								type: 'success',
								title: 'Message',
								text: 'E-Mail successfully Sended'       
							}); 
						$("#overlay, #PleaseWait").hide();
						}else{ 
							swal({
								type: 'error',
								title: 'Warning',
								text: 'E-Mail not Sent'                                     
							}); 
						$("#overlay, #PleaseWait").hide();
						} 
		      	 }
		      }     
		      x.open("GET","sendMail.jsp?docno="+property+'&acno='+acno+'&fdate='+fdate+'&tdate='+tdate,true);                         
		      x.send();    
	     }
  </script>
</body>
</html>
