<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Maintenance Audit</title>                    
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
         <button type="button" class="btn btn-default btnStyle" id="btnsave" data-tooltip="tooltip" title="Edit" data-placement="bottom"><i class="fa fa-save " aria-hidden="true"></i></button>
       </div>                  
        <div class="otherpanel custompanel">                          
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
    <br/>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="reqdiv" class="borderStyle"><jsp:include page="requestGrid.jsp"></jsp:include></div>   
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
 
    <input type="hidden" name="hidbrhid" id="hidbrhid">  
    <input type="hidden" name="hidvocno" id="hidvocno"> 
    <input type="hidden" name="hiddocno" id="hiddocno">        
    <input type="hidden" name="hidcomments" id="hidcomments">
    <input type="hidden" name="txtrefname" id="txtrefname"> 
  
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
    	 $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
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
        $('#btnsave').click(function(){ 
              funsave();             
  	    });
        $('#btnsubmit').click(function(){         
            funload();    
            $('.textpanel p').text("");
            $('#hiddocno').val(''); 
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
				worksheetName:"Maintenance Audit"      
			});   
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
	
   
   function funload(){      
	   $("#overlay, #PleaseWait").show();   
	   var fromdate=$('#fromdate').jqxDateTimeInput('val');    
	   var todate=$('#todate').jqxDateTimeInput('val');  
	   $("#jqxRequestGrid").jqxGrid('clear');         
       $('#ppdiv').load("propertyGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&id="+1);                              
   }
	
	function funloadestgrid(){
		$('#reqdiv').load("requestGrid.jsp?vocno="+$('#hidvocno').val()+"&brhid="+$('#hidbrhid').val()+"&id="+1);  
	}
	function funsave(){     
		$.messager.confirm('Message', 'Do you want to update changes?', function(r){          
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }  
	     	else {
	     		saveData();                   
	     	}  
	 }); 
	}   
    function saveData(){               
	    var gridarray=new Array();   
	    var rows=$('#jqxRequestGrid').jqxGrid('getrows'); 
	    var val=0;      
	 	for(var i=0;i<rows.length;i++){
		 	var chk=rows[i].rowno;
		 	   if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){      
		 		      gridarray.push(rows[i].est_cost+"::"+rows[i].margin+"::"+rows[i].total+"::"+rows[i].rowno+"::"+rows[i].rowdelete);                                                                 
		 	          val=1;
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
  </script>             
</body>
</html>
