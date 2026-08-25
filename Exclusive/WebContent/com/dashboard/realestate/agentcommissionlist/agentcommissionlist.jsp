<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Agent Commission List</title>    
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
        .addpadding{
            padding-left: 5px;
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

<body onload="getAgent();">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="custompanel">           
			      <table>
				      <tr>              
				      <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
				      <td align="left"><div id='fromdate' name='fromdate'></div></td>
				      <td  align="right" ><label class="branch" style="font-size: 13px">&nbsp;&nbsp;To Date &nbsp;&nbsp;</label></td>  
				      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
				 </table>          
		       </div>        
		       <div  class="custompanel addpadding">    
		               <select class="form-control" name="cmbagent" id="cmbagent" required data-name="Agent" style="width:100%;height:28px"><option value="">--Select--</option></select>
		               <span class="help-block"></span>            
                </div> 
                <div  class="custompanel addpadding" >        
		               <select class="form-control" name="cmbgroup" id="cmbgroup" onchange="fungrouping();" style="width:100%;height:28px">
		               <option value="">--Select--</option><option value="A">Agent</option><option value="T">Team</option></select>
                </div>  
                <div class="custompanel addpadding">       
                    <button type="button" class="btn btn-default " id="btnsubmit" data-tooltip="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnexcel" data-tooltip="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnattach" onClick="funAttach();"  data-tooltip="tooltip" title="Attach" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btninvoice" onClick="viewInvoice();"  data-tooltip="tooltip" title="Property Invoice" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnprint" onclick="funPrint();" data-tooltip="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btncomment" data-toggle="modal" data-target="#modalcomments" data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
                </div>     
                <!-- <div class="col-xs-12 col-sm-12 col-md-12 col-lg-3" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">           
                    <p style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
                </div> -->
            </div>      
        </div>
        <br/>
        <div class="row" id="dethide">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="ppdiv" class="borderStyle">
                    <jsp:include page="agentcommGrid.jsp"></jsp:include>
                </div>
            </div>        
        </div>
       <div class="row" id="sumhide">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="sumdiv" class="borderStyle">
                    <jsp:include page="agentsummaryGrid.jsp"></jsp:include>
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
        <input type="hidden" name="hidreftype" id="hidreftype">                                                                                         
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
            	$('#dethide').show();
            	$('#sumhide').hide();
                //$('[data-tooltip="tooltip"]').tooltip();
                $('[data-tooltip="tooltip"]').tooltip({trigger:"hover"});
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
       	        $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
                $('[data-toggle="tooltip"]').tooltip();
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
			    $("#cmbagent").select2({
				    placeholder: "Select Agent",       
				    allowClear: true,
				    width: '100%'              
				});
                $('#btnsubmit').click(function() {                
                	 $("#overlay, #PleaseWait").show();
                    funload();
                    $('.textpanel p').text("");
                    $('#hiddocno').val('');
                    $('#hidvocno').val('');
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
                	var group=$('#cmbgroup').val();
                	if(group=="A" || group=="T"){            
                		$("#sumdiv").excelexportjs({  
                    		containerid: "sumdiv", 
                    		datatype: 'json', 
                    		dataset: null, 
                    		gridId: "jqxAgentSummaryGrid", 
                    		columns: getColumns("jqxAgentSummaryGrid") , 
                    		worksheetName:"Agent Commission List"
                    		});  
	               	  }else{
	               		$("#ppdiv").excelexportjs({
	                		containerid: "ppdiv", 
	                		datatype: 'json', 
	                		dataset: null, 
	                		gridId: "jqxAgentGrid", 
	                		columns: getColumns("jqxAgentGrid") , 
	                		worksheetName:"Agent Commission List"
	                		});      
	               	  }
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
                var reftype=$("#hidreftype").val();   
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
                x.open("GET", "saveComment.jsp?comment=" + encodeURIComponent($('#hidcomments').val()) + "&docno=" + enqno+ "&reftype=" + reftype, true);      
                x.send();
            }

            function getComments() {
                var reftype=$("#hidreftype").val(); 
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
                x.open("GET", "getComments.jsp?docno=" + enqno+ "&reftype=" + reftype, true);
                x.send();
            }

            function funload() {
            	var group=$('#cmbgroup').val();
              if(group=="A" || group=="T"){            
            	    var todate = $('#todate').jqxDateTimeInput('val');
                    var fromdate = $('#fromdate').jqxDateTimeInput('val'); 
                    var salid=$('#cmbagent').val();          
                    $('#sumdiv').load("agentsummaryGrid.jsp?todate="+todate+"&fromdate="+fromdate+"&salid="+salid+"&id="+1);   
           	  }else{
	           		var todate = $('#todate').jqxDateTimeInput('val');
	                var fromdate = $('#fromdate').jqxDateTimeInput('val'); 
	                var salid=$('#cmbagent').val();   
	                $('#ppdiv').load("agentcommGrid.jsp?todate="+todate+"&fromdate="+fromdate+"&salid="+salid+"&id="+1);       
           	  }
            }
           
            function isNumberKey(evt) {     
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && ((charCode < 48) || (charCode > 57)))
                    return false;
                return true;
            }
            function funAttach(){    
				var brhid=$("#hidbrhid").val(); 
				var reftype=$("#hidreftype").val();   
				var frmname="",frmcode="";       
				if(reftype=="PRIV"){            
					 frmname="Property Invoice";              
					 frmcode="PRIV";    
				}else if(reftype=="TNC"){ 
					 frmname="Tenancy Contract";                  
					 frmcode="TNC";    
				}else{}
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
            
            function funPrint(){
      	      var agent=$('#cmbagent').val();
      	      var group=$('#cmbgroup').val();
	      	  var todate = $('#todate').jqxDateTimeInput('val');
	          var fromdate = $('#fromdate').jqxDateTimeInput('val');    
      		  var url=document.URL;        
      	      var reurl=url.split("agentcommissionlist.jsp");                         
      	      var win= window.open(reurl[0]+"printagentcommissionlist?agent="+agent+"&fromdate="+fromdate+"&todate="+todate+"&group="+group,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
      	      win.focus();           
      		}
            
            function getAgent(){
    			var x = new XMLHttpRequest();
    	  		x.onreadystatechange = function() {
    	  			if (x.readyState == 4 && x.status == 200) {
    	  				var items = x.responseText.trim();
    	  				var insurtypedata=JSON.parse(items.trim());
    	  				var insurtypehtmldata='<option value="">--Select--</option>';
    	  				$.each(insurtypedata.insurtypearray, function( index, value ) {
    	  					insurtypehtmldata+='<option value="'+value.split("***")[0]+'">'+value.split("***")[1]+'</option>'
    	  				});
    	  				$('#cmbagent').html($.parseHTML(insurtypehtmldata));
    	  				$('.page-loader').hide();     
    	  			}
    	  		}
    	  		x.open("GET", "getAgent.jsp", true);    
    	  		x.send();
    		}
            function fungrouping(){
            	  var group=$('#cmbgroup').val();
            	  if(group=="A" || group=="T"){   
            		  $('#dethide').hide();
                  	  $('#sumhide').show();   
            	  }else{
            		  $('#dethide').show();
                  	  $('#sumhide').hide();         
            	  }
            	
            }
        </script>     
</body>
</html>