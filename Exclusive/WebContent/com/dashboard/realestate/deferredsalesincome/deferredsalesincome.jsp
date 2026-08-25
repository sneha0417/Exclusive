<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Deferred Sales Income</title>    
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
	            <div class="todatepanel custompanel" style="padding-right:10px;">
			       <div>          
					    <table>
					         <tr>
					            <td align="center"><input type="radio" id="rsumm" name="stkled" onchange="fundisable();" value="rsumm"><label for="rsumm" class="branch" style="font-size: 13px">Posting</label>&nbsp;&nbsp;
			                    <input type="radio" id="rdet" name="stkled" onchange="fundisable();" value="rdet"><label for="rdet" class="branch" style="font-size: 13px">List</label></td></tr>
						</table> 
				    </div>	
			    </div>   
                <div class="todatepanel custompanel">
                    <table>
                        <tr>
                         <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
		                      <td align="left"><div id='fromdate' name='fromdate'></div></td>
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
                	<button type="button" class="btn btn-default " id="btnjvcreate"  data-toggle="modal" data-target="#modaljvcreate" data-tooltip="tooltip" title="JV Create" data-placement="bottom"><i class="fa fa-money " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btnattach" onClick="funAttach();"  data-tooltip="tooltip" title="Attach" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btninvoice" onClick="viewInvoice();"  data-tooltip="tooltip" title="Property Invoice" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default " id="btncomment" data-toggle="modal" data-target="#modalcomments" data-tooltip="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
                </div>     
                <div class="textpanel custompanel" style="padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;">           
                    <p style="font-size:75%;margin:0px;padding-top:15px;padding-left:6px;">&nbsp;</p>
                </div>
            </div>      
        </div>
        <br/>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="sumdiv">
                <div id="summarydiv" class="borderStyle">
                    <jsp:include page="summaryGrid.jsp"></jsp:include>
                </div>
            </div>   
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"  id="detdiv">
                <div id="detaildiv" class="borderStyle">
                    <jsp:include page="detailGrid.jsp"></jsp:include>
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
                            <div class="row">
                              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
	                             <div class="form-group">
	                    			<label  for="invdate">Inv Date</label>            
	                        		<div id="invdate" class="borderStyle"></div>  
	                  			 </div>  
	                  		  </div> 
	                  		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
	                  			 <div class="form-group">  
	                    			<label  for="account">Account</label>                 
	                        		<div id="account"><jsp:include page="accountSearch.jsp"></jsp:include></div>
	        					    <input type="hidden" name="hidacno" id="hidacno">
	                  			 </div> 
	                  			</div>            
                  			</div>
                  			<div class="row">    
                  			     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    			      <label for="desc">Description</label>         
                        			  <input type="text" id="jvdescription" name ="jvdescription" style="width:100%;" class="borderStyle">  
                    			</div>
                  			</div>     
                  			 <div class="row" id="hidejvdiv">  
					            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
					                <div id="jvdiv" class="borderStyle" style="padding-top:5px;">   
					                    <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
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
        <input type="hidden" name="hidjvtrno" id="hidjvtrno">  
        <input type="hidden" name="hidstatus" id="hidstatus">  
        <input type="hidden" name="hiddescription" id="hiddescription">      
        <input type="hidden" name="hidamount" id="hidamount">  
        <input type="hidden" name="hidcalc" id="hidcalc">  
        <input type="hidden" name="hidcalc" id="hidrowno">                                                                                   
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                document.getElementById('rsumm').checked=true;
     		    $('#sumdiv').show();
     		    $('#detdiv').hide();
     		    $('#btnjvcreate').show();
                //$('[data-tooltip="tooltip"]').tooltip();
                $('[data-tooltip="tooltip"]').tooltip({trigger:"hover"});
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                $("#todate").jqxDateTimeInput({
                    width: '100px',
                    height: '23px',
                    formatString: "dd.MM.yyyy"
                });
                $("#fromdate").jqxDateTimeInput({
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
                $('#btnjvcreate').click(function() {       
               	    var docno = $('#hiddocno').val();
               	 	var jvtrno = $('#hidjvtrno').val();
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
                    $("#hidejvdiv").hide(); 
                    $('#hidcalc').val(0);
                    $('#jvdescription').val('');
                    $('#jqxAccount').val('');
                    $('#invdate').val(new Date()); 
                    $('#jqxjvGrid').jqxGrid('clear');
                    document.getElementById("clientref3").innerHTML=$('#hidvocno').val()+" - "+$('#txtrefname').val();   
               });
                $('#btnsubmit').click(function() {                
                	 $("#overlay, #PleaseWait").show();
                    funload();
                    $('.textpanel p').text("");
                    $('#hiddocno').val('');
                    $('#hidvocno').val('');
                    $('#hidrowno').val('');
                    $('#txtrefname').val(''); 
                    $('#hidbrhid').val(''); 
                    $('#clientref3').val(''); 
                    $('#hidjvtrno').val(''); 
                    $('#hiddescription').val('');
                    $('#hidcalc').val(0);
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
                	if(document.getElementById('rsumm').checked) {
                		$("#summarydiv").excelexportjs({
                    		containerid: "summarydiv", 
                    		datatype: 'json', 
                    		dataset: null, 
                    		gridId: "jqxsummaryGrid", 
                    		columns: getColumns("jqxsummaryGrid") , 
                    		worksheetName:"Deferred sales income posting"
                    		});
        		    }else if(document.getElementById('rdet').checked) {    
        			     $("#detaildiv").excelexportjs({
                     		containerid: "detaildiv", 
                     		datatype: 'json', 
                     		dataset: null, 
                     		gridId: "jqxdetailGrid", 
                     		columns: getColumns("jqxdetailGrid") , 
                     		worksheetName:"Deferred sales income list"   
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

            });

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
                var fromdate = $('#fromdate').jqxDateTimeInput('val');
                var todate = $('#todate').jqxDateTimeInput('val');
                if(document.getElementById('rsumm').checked) {
                	 $('#summarydiv').load("summaryGrid.jsp?todate="+todate+"&fromdate="+fromdate+"&id="+1);
     		    }else if(document.getElementById('rdet').checked) {    
     			     $('#detaildiv').load("detailGrid.jsp?todate="+todate+"&fromdate="+fromdate+"&id="+1);   
     		    }
            }
            function funjvload() {
            	var amount=$('#hidamount').val();	   
            	var acno=$('#hidacno').val();  	   
                $('#jvdiv').load("journalVoucherGrid.jsp?amount="+amount+"&acno="+acno+"&id="+1);  
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
            	var clacid=$('#hidcalc').val();
            	if(parseInt(clacid)!=1){
            		swal({
						type: 'warning',
						title: 'Warning',
						text: 'Please calculate first'  
					});
					return false;	
            	}
            	var desc=$('#jvdescription').val();      
            	 $('#hiddescription').val(desc);   
	 		 	 if ($(hiddescription).val().indexOf('"') >= 0) { $(hiddescription).val($(hiddescription).val().replace(/["']/g, ''));};
			 	 if (($(hiddescription).val()).includes(',')) { $(hiddescription).val($(hiddescription).val().replace(/,/g, ''));}
            	var invdate = $('#invdate').jqxDateTimeInput('val');
            	var brhid=$("#hidbrhid").val();
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
	                     } else {
	                         swal({
	                             type: 'error',
	                             title: 'Warning',
	                             text: 'Not Created'      
	                         });
	                     }
	                 } else {}
	             }
	             x.open("GET", "createjv.jsp?jvarray=" + encodeURIComponent(gridarray)+ "&brhid=" +brhid+ "&amount=" +amount + "&invdate=" +invdate + "&desc=" + encodeURIComponent(desc)+"&rowno="+$('#hidrowno').val(), true);         
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
            function fundisable(){  
        		if(document.getElementById('rsumm').checked) {
        			   $('#sumdiv').show();
        			   $('#detdiv').hide();  
        			   $('#btnjvcreate').show();
        		  }else if(document.getElementById('rdet').checked) {    
        			   $('#sumdiv').hide();
        			   $('#detdiv').show(); 
        			   $('#btnjvcreate').hide();
        		 }
        	}  
          function funcalculate(){
        	     var acno=$('#hidacno').val(); 
        	     if(acno==""){
        	    	 swal({
                         type: 'warning',
                         title: 'Warning',
                         text: 'Please select account'  
                     });
                     return false;
        	     }
            	 $("#hidejvdiv").show(); 
            	 $('#hidcalc').val(1);   
            	 funjvload();  	  
            }
        </script>     
</body>
</html>