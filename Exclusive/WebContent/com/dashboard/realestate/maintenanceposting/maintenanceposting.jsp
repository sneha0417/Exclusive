<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Maintenance Posting</title>                    
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
		      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
		 </table>          
      </div>        
        <div class="primarypanel custompanel" style="margin-left:15px;">              
  			<button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-tooltip="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
        </div>    
      <div class="actionpanel custompanel">                                                             
         <button type="button" class="btn btn-default btnStyle" id="btnsave" data-tooltip="tooltip" title="Save" data-placement="bottom"><i class="fa fa-save " aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default  btnStyle" id="btnpurchase"  data-tooltip="tooltip" title="Purchase Create" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default  btnStyle" id="btninoice"  data-tooltip="tooltip" title="Invoice Create" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default  btnStyle" id="btnblkamt" onclick="funrelease();" data-tooltip="tooltip" title="Unblock Amount" data-placement="bottom"><i class="fa fa-check-square " aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default btnStyle" id="btnrmbrsmnt"  data-tooltip="tooltip" title="Reimbursement" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
        </div>       
        <div class="otherpanel custompanel">                          
          <button type="button" class="btn btn-default btnStyle" id="btncomment"  data-toggle="modal" data-target="#modalcomments"  data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-tooltip="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementap" data-tooltip="tooltip" title="Owner Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementgl" data-tooltip="tooltip" title="MRF Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnaccstatementtenant" onclick="gettenantprint();" data-tooltip="tooltip" title="Tenant Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
          <button type="button" class="btn btn-default btnStyle" id="btnconfirm"  data-toggle="modal"  data-tooltip="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check " aria-hidden="true"></i></button>    
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
    <br/>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="reqdiv" class="borderStyle"><jsp:include page="requestGrid.jsp"></jsp:include></div>   
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
       <!-- Modal Invoice -->          
    <div id="modalinvoice" class="modal fade" role="dialog">              
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>     
            <h4 class="modal-title" style="text-align:center">Invoice Create</h4>                            
              <p id="clientref2"  style="text-align:center"></p>   
          </div>                             
          <div class="modal-body" id="invmod">
            <p><!-- Some text in the modal. --></p>    
            <div class="container-fluid">
              <div class="row rowgap">  
                	<div class="col-md-4">  
            			<div class="form-group">
            				<label>Ref No</label>
            				<input type="text" name="txtrefno" id="txtrefno" onkeypress="return isNumberKey(event)" class="form-control input-sm"  placeholder="Enter Refno" style="height:25px;width:100px;">	
            			</div>
            		</div>
            		<div class="col-md-4">
            			<div class="form-group">  
            				<label>PO No</label>
            				<input type="text" name="pono" id="pono" onkeypress="return isNumberKey(event)" class="form-control input-sm"  placeholder="Enter PO No" style="height:25px;width:100px;">	
            			</div>
            		</div>
            		<div class="col-md-4">
            			<div class="form-group">
            				<label>PO Date</label>
            				<div id='podate' name='podate'></div>         	
            			</div>
            		</div>
            	</div>	
            	<div class="row rowgap">  
            		<div class="col-md-3"> 
							  <div class="form-group">
							        <label  for="invamount">Amount</label>         
							        <input type="text" id="invamount" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>        
							   </div>
					</div>
					<div class="col-md-3"> 
							  <div class="form-group">
							        <label  for="invincl" style="text-align:center">Inclusive</label>              
							       <input type="checkbox" id="invincl" class="form-control input-sm" style="width:20px;height:23px;" onchange="inclusivetest1();">                                
							   </div>
					</div>
					<div class="col-md-3"> 
							  <div class="form-group">
							        <label  for="purvatamt">Vat Amount</label>         
							        <input type="text" id="invvatamt" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>             
							   </div>
					</div>
					<div class="col-md-3">   
							  <div class="form-group"> 
							        <label  for="purnetamt">Net Amount</label>         
							        <input type="text" id="invnetamt" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>        
							   </div>
					</div> 
				</div>	                                                                 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">     
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" data-toggle="tooltip" title="Create" data-placement="bottom" onclick="funinvoice();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>            
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
     <!-- Modal Purchase -->             
    <div id="modalpurchase" class="modal fade" role="dialog">              
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>       
            <h4 class="modal-title" style="text-align:center">Purchase Create</h4>                       
             <p id="clientref1" style="text-align:center"></p>       
          </div>                             
          <div class="modal-body" id="purmod">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">  
                 <div class="row rowgap">
                   <div class="col-md-2"> 
							  <div class="form-group">
							        <label  for="purinvno">Inv No</label>  
							        <input type="text" id="purinvno" class="form-control input-sm" style="width:130px;height:23px">        
							   </div>
					</div> 
					<div class="col-md-2">    
							  <div class="form-group">
							        <label  for="purinvdate">Inv Date</label>   
							        <div id="purinvdate"></div>                
							   </div>  
					</div> 
					<div class="col-md-2"> 
							  <div class="form-group">
							        <label  for="puramount">Amount</label>       
							        <input type="text" id="puramount" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>        
							   </div>
					</div>
					<div class="col-md-2" style="text-align:center"> 
							  <div class="form-group">
							        <label  for="purincl">Inclusive</label>              
							        <input type="checkbox" id="purincl" class="form-control input-sm" style="width:20px;height:23px;margin-left: 50px;" onchange="inclusivetest();">                       
							        <input type="hidden" id="hidpurincl" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>
							   </div>
					</div>
					<div class="col-md-2"> 
							  <div class="form-group">
							        <label  for="purvatamt">Vat Amount</label>         
							        <input type="text" id="purvatamt" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>             
							   </div>
					</div>
					<div class="col-md-2">   
							  <div class="form-group">
							        <label  for="purnetamt">Net Amount</label>         
							        <input type="text" id="purnetamt" class="form-control input-sm" style="width:130px;height:23px;text-align:right" readonly>        
							   </div>
					</div>  
            	</div> 
            	<div class="row rowgap">         
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">      
						<button type="button" class="btn btn-default btnStyle" id="btnupdate"  data-toggle="tooltip" title="Create" data-placement="bottom" onclick="funCreateNiPurchase();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
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
   <input type="hidden" name="hidblockamt" id="hidblockamt">   
  <input type="hidden" name="hidjvtrno" id="hidjvtrno">   
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
    	 $('#vendoracwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
	     $('#vendoracwindow').jqxWindow('close');
		 $('#jobsearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '90%' ,maxWidth: '80%' ,title: 'Insurance Type Search' , position: { x: 150, y: 50 }, keyboardCloseKey: 27});
		 $('#jobsearchwindow').jqxWindow('close');      
    	 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#purinvdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#podate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#invdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
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
       
        $('#btnrmbrsmnt').click(function() {       
                    funjvload();        
               });
        $('#btnconfirm').click(function(){    
	        var actdocno=$('#hidvocno').val();     
	    	if(actdocno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	 var blockamt=$('#hidblockamt').val();         
		    	if(parseFloat(blockamt)>0){             
		    		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Cannot confirm amount is blocked'                 
					});
		    		return false;
		    	}
		    	getConfirmconfig();
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
        $('#btnaccstatementap').click(function(){                         
        	if($('#hidvocno').val()==''){   
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
        	if($('#hidvocno').val()==''){   
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	getGLprint();
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
        });          
        $('#btnexcel').click(function(){         
	        $("#ppdiv").excelexportjs({
				containerid: "ppdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "pagrid",
				columns: getColumns("pagrid") ,   
				worksheetName:"Maintenance Posting"  
			});   
        });
        $('#btnsave').click(function(){ 
            funsave();        
	    });
        $('#btnpurchase').click(function(){ 
        	$('#purinvno').val(''); 
	    	$('#purinvdate').val(new Date());   
            funpurchasevalidations();           
	    });
	    $('#btninoice').click(function(){
	    	$('#txtrefno').val(''); 
	    	$('#pono').val(''); 
	    	$('#podate').val(new Date());    
	        funinvoicevalidations();       
	    });
	    $('#btncommentsend').click(function(){
       	 var actdocno=$('#hidvocno').val();
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
   
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){   
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	
    	    //var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
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
	function getConfirmconfig(){    
   	 var x=new XMLHttpRequest();  
   	 x.onreadystatechange=function()  
   			{
   				if(x.readyState==4 && x.status==200)
   				{
   					var items = x.responseText.trim();
   					funConfirm(items);  
   				}                  
   			}    
   			x.open("GET","getConfirmconfig.jsp",true);           
   			x.send();                          
   }
    function funConfirm(validval){
 	   var vocno=$('#hidvocno').val();
 	   var brhid=$('#hidbrhid').val();
 	   var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
	   var val=0,exval=0,val1=0,exval2=0;      
	   for(var i=0;i<rows.length;i++){        
		 	var chk=rows[i].rowno;
		 	var cpudoc=rows[i].cpudoc;
		 	var invdoc=rows[i].invdoc;   
		 	var rmbjvtrno=rows[i].rmbjvtrno;  
		 	var vndacno=rows[i].vendor_docno;     
		 	var reimbursement=rows[i].reimbursement;  
		 	if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){  
		 	     val=1;         
		 	     if(parseInt(reimbursement)==1){    
		 	         if(parseInt(rmbjvtrno)==0){               
		 	        	val1=1;                                      
		 	         } 
		 	     }else{
		 	    	if(vndacno!=validval){                           
		 	    		if(parseInt(cpudoc)==0 || parseInt(invdoc)==0){       
			 	        	exval=1;                                      
			 	         } 
		 	    	}else{
		 	    		if(parseInt(invdoc)==0){       
		 	    			exval2=1;                                      
			 	         }
		 	    	} 
		 	     }   
		 	}
	    }
	 	if(exval==1){    
	 		swal({
					type: 'warning',     
					title: 'Warning',
					text: 'Purchase invoice or Property invoice is not created for some documents'                                     
				});
	 		return false;
	 	}
	 	if(exval2==1){    
	 		swal({
					type: 'warning',     
					title: 'Warning',
					text: 'Property invoice is not created for some documents'                                     
				});
	 		return false;
	 	}
	 	if(val1==1){            
	 		swal({
					type: 'warning',     
					title: 'Warning',
					text: 'JV is not created for some documents'                                     
				});           
	 		return false;
	 	}
    	var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 			if (x.readyState==4 && x.status==200)
 			{
 				var items=x.responseText.trim();
 				if(items!=''){ 
 					swal({
 						type: 'success',
 						title: 'Message',
 						text: 'Successfully Confirmed'
 					}); 
 					funload();
 					$("#jqxRequestGrid").jqxGrid('clear');      
 				}else{
 					swal({
 						type: 'warning',
 						title: 'Warning',
 						text: 'Not Confirmed'                                     
 					});
 				}
 						
 			}	   
 			else
 			{
 			}
 		}
 		x.open("GET","confirmUpdate.jsp?vocno="+vocno+"&confirm="+1+"&brhid="+brhid,true);            
 		x.send();          
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
   function funload(){      
	   $("#overlay, #PleaseWait").show();   
	   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
	   var todate=$('#todate').jqxDateTimeInput('val');  
	   $("#jqxRequestGrid").jqxGrid('clear');         
       $('#ppdiv').load("propertyGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1);                              
   }
		 function isNumberKey(evt){   
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))           
		        return false;
		    return true;   
		}
		function funloadestgrid(){
			$('#reqdiv').load("requestGrid.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&id="+1);  
		}
		
		function funpurchasevalidations(){                 
			    var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
			    var val=0,val2=0,val3=0;
			    var total=0.0;           
			 	for(var i=0;i<rows.length;i++){  
				 	var check=rows[i].chk;
				 	var chk=rows[i].rowno;  
				 	var amt=rows[i].est_cost;
				 	var cpudoc=rows[i].cpudoc;  
				 	var rmbrsmnt=rows[i].reimbursement;
					if(check){ 
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				 		     total=total + amt;                                                       
				 	         val=1;
				 	         if(cpudoc>0){    
				 	         	val2=1;
				 	         } 
				 	        if(rmbrsmnt>0){    
				 	         	val3=1;
				 	         }
				 	    }          
				     }     
			    }          
				if(val==0){      
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document!!!'  
						});
					 return false;    
				}
				if(val2==1){        
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Purchase invoice already created!!!'    
						});
					 return false;    
				}
				if(val3==1){        
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Purchase invoice cannot create for this document!!!'    
						});
					 return false;    
				}
				funRoundAmt(total,"puramount");      
			    document.getElementById("purincl").checked=true;
			    document.getElementById("hidpurincl").value="1";
				inclusivetest();
				$('#modalpurchase').modal('toggle');                        
		   }
		   function inclusivetest(){
		   		var puramount=$('#puramount').val();
		   		if(puramount==""){  
		   		   puramount=0.0;
		   		}
		   		var purvatamt=0.0,purnetamt=0.0;           
		   		if(document.getElementById("purincl").checked){                  
					  purvatamt=parseFloat(puramount)-((parseFloat(puramount)/105)*100);    
					  funRoundAmt(purvatamt,"purvatamt");  
		              funRoundAmt(puramount,"purnetamt");
		              document.getElementById("hidpurincl").value="1";
				 }
				 else{
					purvatamt=(parseFloat(puramount)*5)/100;
					purnetamt=purvatamt+parseFloat(puramount);         
					funRoundAmt(purvatamt,"purvatamt");    
		            funRoundAmt(purnetamt,"purnetamt"); 
		            document.getElementById("hidpurincl").value="0";        
				 }    
		   } 
		   function funRoundAmt(value,id){  
			  var res=parseFloat(value).toFixed(window.parent.amtdec.value);  
			  var res1=(res=='NaN'?"0":res);
			  document.getElementById(id).value=res1;  
		   }
		   function funCreateNiPurchase(){     
				$.messager.confirm('Message', 'Do you want to create purchase invoice?', function(r){             
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }  
			     	else {  
			     		funCreateNiPurchase1();                          
			     	}  
			 }); 
			}
		   function funCreateNiPurchase1(){    
		        var gridarray=new Array();   
		        var desc="CPU - PTR - "+$('#hidvocno').val()+", inv#"+$('#purinvno').val()+", "+$('#hidproperty').val();               
		        var purnetamt=$('#purnetamt').val(); 
		        var purincl=$('#hidpurincl').val(); 
		        var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
			 	for(var i=0;i<rows.length;i++){   
				 	var check=rows[i].chk;  
				 	var chk=rows[i].rowno;                               
					if(check){    
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){   
                            gridarray.push(rows[i].rowno);                            
				 	    }          
				     }   
			    }   
		        var x=new XMLHttpRequest();
	 		    x.onreadystatechange=function(){
	 			if (x.readyState==4 && x.status==200)
	 			{
	 				var items=x.responseText.trim().split('###');  
	 				if(parseInt(items[0])>0){    
	 					swal({
	 						type: 'success',
	 						title: 'Success',
	 						text: 'CPU -'+items[1]+' Successfully Created'                
	 					});
	 					$('#modalpurchase').modal('toggle');     
	 					funloadestgrid();
	 				}
	 				else{
	 					swal({
	 						type: 'error',
	 						title: 'Error', 
	 						text: 'Not Created'
	 					});
	 				}   
	 			}
	 			else    
	 			{       
	 			}               
	 		}
	 		x.open("GET","createCPU.jsp?gridarray="+gridarray+"&purnetamt="+purnetamt+"&desc="+encodeURIComponent(desc)+"&invno="+$('#purinvno').val()+"&invdate="+$('#purinvdate').val()+"&brhid="+$('#hidbrhid').val()+"&vocno="+$('#hidvocno').val()+"&purincl="+purincl,true);                          
	 		x.send();   
		   }
		   function funinvoicevalidations(){  
		   		var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
			    var val=0,val2=0,val3=0,val4=0;
			    var total=0.0;           
			 	for(var i=0;i<rows.length;i++){  
				 	var check=rows[i].chk;
				 	var chk=rows[i].rowno;  
				 	var invdoc=rows[i].invdoc;
				 	var amt=rows[i].total;   
				 	var paytype=rows[i].pay;    
				 	var rmbrsnt=rows[i].reimbursement;    
					if(check){ 
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				 	         val=1;
				 	         total=total+amt;  
				 	         if(invdoc>0){    
				 	         	val2=1;
				 	         } 
				 	         if(paytype=="Expenses"){
				 	         	val3=1;
				 	         }
				 	        if(rmbrsnt>0){
				 	         	val4=1;
				 	         }
				 	    }          
				     }     
			    }          
				if(val==0){      
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Please select a document!!!'  
						});
					 return false;    
				}
				if(val2==1){        
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Property invoice already created!!!'       
						});
					 return false;    
				} 
				if(val3==1){        
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Property invoice can not create for pay type expense!!!'       
						});
					 return false;    
				} 
				if(val4==1){        
					swal({
							type: 'warning',
							title: 'Warning',
							text: 'Property invoice cannot create for this document!!!'           
						});
					 return false;    
				} 
				funRoundAmt(total,"invamount");      
			    document.getElementById("invincl").checked=true;
				inclusivetest1();                
				$('#modalinvoice').modal('toggle');               
		   } 
		function inclusivetest1(){
		   		var invamount=$('#invamount').val();
		   		if(invamount==""){  
		   		   invamount=0.0;
		   		}
		   		var invvatamt=0.0,invnetamt=0.0;             
		   		if(document.getElementById("invincl").checked){                  
					  invvatamt=parseFloat(invamount)-((parseFloat(invamount)/105)*100);    
					  funRoundAmt(invvatamt,"invvatamt");  
		              funRoundAmt(invamount,"invnetamt");  
				 }
				 else{
					invvatamt=(parseFloat(invamount)*5)/100;   
					invnetamt=invvatamt+parseFloat(invamount);         
					funRoundAmt(invvatamt,"invvatamt");    
		            funRoundAmt(invnetamt,"invnetamt");                     
				 }      
		   } 
		function funinvoice(){     
			$.messager.confirm('Message', 'Do you want to create invoice?', function(r){       
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }  
		     	else {
		     		funinvoice1();                   
		     	}  
		 }); 
		}   
	    function funinvoice1(){
	    		 var inclusive=""; 
	             if(document.getElementById("invincl").checked){ 
	                    inclusive="YES";            
				 }
				 else{
				 		inclusive="NO";   
				 }               
		        var rowarray=new Array();
		        var desc="PTR - "+$('#hidvocno').val()+" Maintenance";            
		        var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
			 	for(var i=0;i<rows.length;i++){   
				 	var check=rows[i].chk;  
				 	var chk=rows[i].rowno;  
				 	var amt=rows[i].total;
					if(check){    
				 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){   
                             rowarray.push(rows[i].rowno);        
				 	    }          
				     }   
			    }    
		        var x=new XMLHttpRequest();
	 		    x.onreadystatechange=function(){     
	 			if (x.readyState==4 && x.status==200)
	 			{
	 				var items=x.responseText.trim().split('###');  
	 				if(parseInt(items[0])>0){    
	 					swal({
	 						type: 'success',
	 						title: 'Success',
	 						text: 'PRIV -'+items[1]+' Successfully Created'                
	 					});
	 					$('#modalinvoice').modal('toggle');
	 					funloadestgrid();    
	 				}
	 				else{
	 					swal({
	 						type: 'error',
	 						title: 'Error', 
	 						text: 'Not Created'
	 					});
	 					$('#modalinvoice').modal('toggle');      
	 				}   
	 			}
	 			else    
	 			{       
	 			}               
	 		}
	 		x.open("GET","createInvoice.jsp?rowarray="+rowarray+"&desc="+desc+"&pono="+$('#pono').val()+"&podate="+$('#podate').val()+"&brhid="+$('#hidbrhid').val()+"&refno="+$('#txtrefno').val()+"&inclusive="+inclusive+"&vocno="+$('#hidvocno').val()+"&mrfacno="+$('#hidmrfacno').val(),true);                          
	 		x.send();   
		   } 
	    function funsave(){               
		    var gridarray=new Array();   
		    var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
		    var val=0,exval=0;      
		 	for(var i=0;i<rows.length;i++){
			 	var check=rows[i].chk;
			 	var chk=rows[i].rowno;
			 	var cpudoc=rows[i].cpudoc;
			 	var invdoc=rows[i].invdoc;     
				if(check){ 
			 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){  
			 		     $('#hiddescription').val(rows[i].description);
			 		 	 if ($(hiddescription).val().indexOf('"') >= 0) { $(hiddescription).val($(hiddescription).val().replace(/["']/g, ''));};
					 	 if (($(hiddescription).val()).includes(',')) { $(hiddescription).val($(hiddescription).val().replace(/,/g, ''));}
			 		     gridarray.push(rows[i].pay+"::"+rows[i].est_cost+"::"+rows[i].margin+"::"+rows[i].total+"::"+$('#hiddescription').val()+"::"+rows[i].rowno);                                                         
			 	         val=1;
			 	         if(parseInt(cpudoc)>0 || parseInt(invdoc)>0){       
			 	        	exval=1;                                      
			 	         } 
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
		     if(exval==1){
		             swal({
							type: 'warning',
							title: 'Warning',
							text: 'Purchase or Invoice already created!!!'     
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
		 						text: 'Successfully Updated'          
		 					});
		 					funloadestgrid();   
		 				}
		 				else{
		 					swal({
		 						type: 'error',
		 						title: 'Error', 
		 						text: 'Not Updated'            
		 					});
		 				}   
		 			}
		 			else    
		 			{       
		 			}                
		 		}
		 		x.open("GET","saveData.jsp?gridarray="+encodeURIComponent(gridarray)+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                              
		 		x.send();      
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
	   							type: 'warning',
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
	   							type: 'warning',    
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
    function funrelease(){    
    	if($("#hidvocno").val()==""){                                     
	 		swal({
					type: 'warning',     
					title: 'Warning',
					text: 'Please select a document'                                            
				});
	 		return false;
	 	}
    	var jvtrno=$('#hidjvtrno').val();     
    	if(parseInt(jvtrno)==0){     
	 		swal({
					type: 'warning',     
					title: 'Warning',
					text: 'Amount is not blocked'                                     
				});
	 		return false;
	 	}
    	var x=new XMLHttpRequest();
 		x.onreadystatechange=function(){
 			if (x.readyState==4 && x.status==200)
 			{
 				var items=x.responseText.trim();
 				if(items!=''){ 
 					swal({
 						type: 'success',
 						title: 'Message',
 						text: 'Successfully Released'
 					}); 
 					funload();
 					$("#jqxRequestGrid").jqxGrid('clear');
 				}else{
 					swal({
 						type: 'warning',
 						title: 'Warning',
 						text: 'Not Released'                                     
 					});   
 				}
 						
 			}	   
 			else
 			{
 			}
 		}
 		x.open("GET","confirmUpdate.jsp?jvtrno="+jvtrno+"&block="+1+"&vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val(),true);                 
 		x.send();   
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
    function funjvload() {
	        var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
	        var amount=0.0;
	        var val=0,val1=0,val2=0;
		 	for(var i=0;i<rows.length;i++){   
			 	var check=rows[i].chk;  
			 	var chk=rows[i].rowno;  
			    var total=rows[i].total;
			    var reimbursement=rows[i].reimbursement;
			    var rmbjvtrno=rows[i].rmbjvtrno;
				if(check){    
			 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){ 
			 		  val=1;
			 		  amount=amount+parseFloat(total); 
			 		  if(reimbursement>0){
			 			 val1=1;   
			 		  }
			 		 if(rmbjvtrno>0){
			 			val2=1;   
			 		  }
			 	    }          
			     }         
		    }
		 	if(val==0){      
				swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please select a document!!!'  
					});
				 return false;    
			}
		 	if(val1==0){      
				swal({
						type: 'warning',
						title: 'Warning',
						text: 'JV cannot create for this document!!!'         
					});
				 return false;    
			}
		 	if(val2>0){      
				swal({
						type: 'warning',
						title: 'Warning',
						text: 'JV already created'         
					});
				 return false;    
			}
		   $('#modaljvcreate').modal('toggle');   	
           $('#jvdiv').load("journalVoucherGrid.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&amount="+amount+"&id="+1);
    }
    
    function funjvcreate(){ 
    	
    	var rows = $("#jqxjvGrid").jqxGrid('getrows');  
        var missingAccount = false;

        for (var i = 0; i < rows.length; i++) {
            if (!rows[i].account || $.trim(rows[i].account) == "" || rows[i].account == "0") {
                missingAccount = true;
                break;
            }
        }

        if (missingAccount) { 
            swal({
                type: 'warning',
                title: 'Warning',
                text: 'You cannot create JV. Account is missing in one or more entries.'
            });
            return false;  
        }
        
		$.messager.confirm('Message', 'Do you want to create jv?', function(r){       
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }  
	     	else {  
	     		funjvcreate1();                       
	     	}  
	 }); 
	}
    function funjvcreate1(){   
    	var invdate = $('#invdate').jqxDateTimeInput('val');
    	var brhid=$("#hidbrhid").val();
    	var gridarray=new Array();  
        var rows = $("#jqxjvGrid").jqxGrid('getrows');  
        var amount=0.0;
        var j=0;
        var description="";
        var mprowarray=new Array();  
		var rows2=$('#jqxRequestGrid').jqxGrid('getrows');         
		for(j=0;j<rows2.length;j++){   
			 	var check=rows2[j].chk;  
			 	var chk=rows2[j].rowno; 
			 	var job=rows2[j].job; 
				if(check){    
			 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){   
			 		  mprowarray.push(rows2[j].rowno);    
			 		  if(j==0){
			 			 description=job;   
			 		  }
			 	    }          
			     }         
		    }
		var desc="PTR - "+$('#hidvocno').val()+" Maintenance - "+description; 
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
                 } else {
                     swal({
                         type: 'error',
                         title: 'Warning',
                         text: 'Not Created'      
                     });
                 }
             } else {}
         }
         x.open("GET", "createjv.jsp?jvarray=" + encodeURIComponent(gridarray)+ "&brhid=" +brhid+ "&mprows=" +mprowarray+ "&amount=" +amount + "&invdate=" +invdate+ "&docno=" + $('#hidvocno').val() + "&desc=" + encodeURIComponent(desc), true);         
         x.send();       
    }  
  </script>             
</body>
</html>
