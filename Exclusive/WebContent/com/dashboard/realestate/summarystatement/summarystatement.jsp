<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Summary statement</title>                    
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
    width: 300px;
}
  </style>
</head>       
<body onload="getPropertyOwner();">                         
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 custompanel">   
      <div  class="col-xs-12 col-sm-12 col-md-12 col-lg-3">
		               <select class="form-control" name="cmbproperty" id="cmbproperty" required data-name="Property" style="width:100%;"><option value="">--Select--</option></select>
		               <span class="help-block"></span>  
      </div>
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">       
		      <table>
			      <tr>              
			      <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='fromdate' name='fromdate'></div></td>
			      <td  align="right" ><label class="branch" style="font-size: 13px">To Date &nbsp;&nbsp;</label></td> 
			       <td align="left"><div id='todate' name='todate'></div></td>
			      <td align="left" style="padding-left:10px"><button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button></td> 
			      <td align="left"><button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button></td>                                        
			 </tr>
			 </table>         
      </div>        
          <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">               
			<p  style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
        </div>   
      </div>              
    </div>     
    <div class="row">       
            		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-bottom:5px">          
				        <div id="summdiv" class="borderStyle"><jsp:include page="summaryGrid.jsp"></jsp:include></div>               
				    </div>                                
            	</div> 
            	<div class="row" >
            	     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
				        <div id="summasdiv" class="borderStyle"><jsp:include page="summaryASGrid.jsp"></jsp:include></div>               
				    </div>  
				</div>   
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
	     $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $('[data-toggle="tooltip"]').tooltip(); 
        //$('.cmbbaymovupdate,.cmbbaystatus,.cmbbaystatusupdate').select2();              
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
       $("#cmbproperty").select2({
			    placeholder: "Select Property Owner",      
			    allowClear: true,
			    width: '100%'
			});
       
        $('#btnsubmit').click(function(){         
            funload();    
        });          
        $('#btnexcel').click(function(){         
	        $("#summdiv").excelexportjs({     
				containerid: "summdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxsummaryGrid",
				columns: getColumns("jqxsummaryGrid") ,   
				worksheetName:"Summary Statement"       
			});  
	        $("#summasdiv").excelexportjs({     
				containerid: "summasdiv",   
				datatype: 'json',
				dataset: null,
				gridId: "jqxsummaryASGrid",
				columns: getColumns("jqxsummaryASGrid") ,   
				worksheetName:"Summary Statement"       
			});  
        });
        
       $('.warningpanel div button').click(function(){
        	var gridrows=$('#jqxsummaryGrid').jqxGrid('getrows');
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
        		$('#jqxsummaryGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
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
	    	$("#jqxsummaryGrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#jqxsummaryGrid").jqxGrid('applyfilters');     
    	
 	}
   
   function funload(){  
        var docno=$('#cmbproperty').val();
        if (docno == "") {
           swal({
               type: 'warning',
               title: 'Warning',
               text: 'Please select a document'
           });
           return false;
       }
       $("#jqxsummaryGrid").jqxGrid('clear');               
       $("#jqxsummaryASGrid").jqxGrid('clear');       
       $("#overlay, #PleaseWait").show();    
       var tdate=$('#todate').jqxDateTimeInput('val'); 
       $('#summdiv').load("summaryGrid.jsp?ownid="+docno+"&id="+1+"&todate="+tdate);                                                
   }
   function getPropertyOwner(){
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
	  		x.open("GET", "getPropertyOwner.jsp", true);       
	  		x.send();
		}
   
   function loadsummaryASGrid(acno){
          	  $("#overlay, #PleaseWait").show();
          	  var fdate=$('#fromdate').jqxDateTimeInput('val');    
                var tdate=$('#todate').jqxDateTimeInput('val'); 
                var brch="a";
          	  $('#summasdiv').load("summaryASGrid.jsp?accdocno="+acno+"&id="+1+"&fromdate="+fdate+"&todate="+tdate+"&branchval="+brch);       
            }	
  </script>   
</body>    
</html>
