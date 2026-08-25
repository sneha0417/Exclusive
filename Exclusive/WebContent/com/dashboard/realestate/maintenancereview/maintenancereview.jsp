<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Maintenance Review</title>                    
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
    
.select2-selection--single {
    width: 100%;
}
  </style>
</head>       
<body onload="getProperty();getUnitno();">                         
  <div class="container-fluid" >
    <div class="row" >
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 custompanel">
      <div class="col-md-3">
	      <table>
		      <tr>              
		      <td  align="right" ><label class="branch" style="font-size: 13px">From&nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='fromdate' name='fromdate'></div></td>
		      <td  align="right" ><label class="branch" style="font-size: 13px">To&nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='todate' name='todate'></div></td>
		      
		      
		      </tr>                                          
		 </table>          
      </div>        
    <div  class="col-md-2">
                       <select class="form-control" name="cmbunitno" id="cmbunitno"  ><option value="">--Select--</option></select>
		               <!-- <span class="help-block"></span>  -->
  </div>     
      <div  class="col-md-2">
		               <select class="form-control" name="cmbproperty" id="cmbproperty" required data-name="Property" ><option value="">--Select--</option></select>
		               <span class="help-block"></span>         
      </div> 
       <div  class="col-md-2">
		               <select class="form-control" name="cmbfrmld" id="cmbfrmld"><option value="all">ALL</option><option value="pending">PENDING</option></select>
		               <span class="help-block"></span>         
      </div>        
        <div  class="col-md-3" >              
  			<button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
            <button type="button" class="btn btn-default btnStyle" id="btnmr" onclick="funPrintMR();" data-tooltip="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-tooltip="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default btnStyle" id="btnemail"  data-toggle="modal"  data-tooltip="tooltip" title="Send Email" data-placement="bottom"><i class="fa fa-envelope" aria-hidden="true"></i></button>
        </div>      
         <!--  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">               
			<p  style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
        </div>  -->       
      </div>      
    </div>     
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="ppdiv" class="borderStyle"><jsp:include page="propertyGrid.jsp"></jsp:include></div>               
      </div>
    </div>
       <input type="hidden" name="hidbrhid" id="hidbrhid">  
       <input type="hidden" name="hidvocno" id="hidvocno"> 
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
    	 $('[data-toggle="tooltip"]').tooltip(); 
        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();              
       $("#cmbproperty").select2({
			    placeholder: "Select Property",    
			    allowClear: true,
			    width: '100%'
			});
       $("#fromdate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});
       $("#cmbunitno").select2({
		    placeholder: "Select Unit No",              
		    allowClear: true,
		    width: '100%'
		});
       
        $('#btnsubmit').click(function(){         
            funload();    
        });          
        $('#btnexcel').click(function(){         
	        $("#ppdiv").excelexportjs({
				containerid: "ppdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "pagrid",
				columns: getColumns("pagrid") ,   
				worksheetName:"Maintenance Review"       
			});   
        });
        $('#btnemail').click(function(){                
         	if($('#cmbproperty').val()==''){   
         		swal({
 					type: 'warning',
 					title: 'Warning',
 					text: 'Please select a document'
 				});
         		return false;
         	}
         	/* var email=$("#hidemail").val();
         	if(!validateEmail(email)){        
				 return false;   
			 } */
			 $.messager.confirm('Message', 'Do you want to Email Owner? ', function(r){
					if(r==false)
					{
						return false; 
					}
					else
					{
						funEmail(); 
					}
			 });   
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
    	    //var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	//filtergroup.addfilter(filter_or_operator, filter2);
	    	// add the filters.
	    	$("#pagrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#pagrid").jqxGrid('applyfilters');     
    	
 	}
   
   function funload(){  
        var property=$('#cmbproperty').val();
        var cmbunitno=$('#cmbunitno').val();
        var fromdate=$('#fromdate').val();
        var todate=$('#todate').val();
        var frmld=$('#cmbfrmld').val();
        if(property==""){
            $.messager.alert('warning','Please select a property');              
			return false;
        }    
       $('#ppdiv').load("propertyGrid.jsp?pdocno="+property+"&unitno="+encodeURIComponent(cmbunitno)+"&id="+1+"&frmld="+frmld+"&from="+fromdate+"&to="+todate);                                          
   }
   function getProperty(){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				var insurtypedata=JSON.parse(items.trim());
	  				var insurtypehtmldata='<option value="">--Select--</option>';
	  				$.each(insurtypedata.insurtypearray, function( index, value ) {
	  					insurtypehtmldata+='<option value="'+value.split("***")[0]+'">'+value.split("***")[1]+'</option>'
	  				});
	  				$('#cmbproperty').html($.parseHTML(insurtypehtmldata));
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getProperty.jsp", true);    
	  		x.send();
		}
   function getUnitno(){
		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText.trim();
 				var insurtypedata=JSON.parse(items.trim());
 				var insurtypehtmldata='<option value="">--Select--</option>';
 				$.each(insurtypedata.insurtypearray, function( index, value ) {
 					insurtypehtmldata+='<option value="'+value.split("***")[0]+'">'+value.split("***")[1]+'</option>'
 				});
 				$('#cmbunitno').html($.parseHTML(insurtypehtmldata));
 				$('.page-loader').hide();
 			}
 		}
 		x.open("GET", "getUnitno.jsp", true);    
 		x.send();
	}
	 function funPrintMR(){
	      var property=$('#cmbproperty').val();
	      var frmld=$('#cmbfrmld').val();
	      var fromdate=$('#fromdate').val();
	      var todate=$('#todate').val();
	      //alert("property========="+property);
	      if(property==""){           
	            $.messager.alert('warning','Please select a property');         
				return false;
	      }    
		  var url=document.URL;    
	      var reurl=url.split("maintenancereview.jsp");                  
	      var win= window.open(reurl[0]+"printmainetenacereview?property="+property+"&frmld="+frmld+"&from="+fromdate+"&to="+todate,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();           
		}	
	function funAttach(){     
		var brchid=$('#hidbrhid').val();   
		var frmname="Maintenance Request";   
		var frmcode="PMR";              
		
		if ($("#hidvocno").val()!="") {	       
			
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
    	  var property=$('#cmbproperty').val();
	      var frmld=$('#cmbfrmld').val();  
	      var fromdate=$('#fromdate').val();
	      var todate=$('#todate').val();
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
	      x.open("GET","sendMail.jsp?docno="+property+'&frmld='+frmld+"&from="+fromdate+"&to="+todate,true);                         
	      x.send();    
     }
  </script>   
</body>    
</html>
