
<%@page
	import="com.dashboard.project.contractpaymentscheduleupdate.ClsContractPaymentScheduleUpdateDAO"%>
<% ClsContractPaymentScheduleUpdateDAO DAO=new ClsContractPaymentScheduleUpdateDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%
 String gridload=request.getParameter("gridload")==null?"0":request.getParameter("gridload").trim().toString().trim(); 
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString().trim();
 String date = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
 String enddate = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
 String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
 String payfre = request.getParameter("cmbpaytype")==null?"0":request.getParameter("cmbpaytype");
 String paydue = request.getParameter("paydueafter")==null?"0":request.getParameter("paydueafter");
 %>
<style type="text/css">
.yellowClass {
	background-color: #F8E489;
}

.orangeClass {
	background-color: #FAD7A0;
}

.greenClass {
	background-color: #7AFA90;
}

.whiteClass {
	background-color: #FFFFFF;
}
</style>
<script type="text/javascript">
    var paymentdata;
     var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
        	
        	if(gridload=="1"){
        		
        		  paymentdata = '<%=DAO.paymentGridFillLoading(session,date,enddate,instno1,amount1,gridload,payfre,paydue) %>';
            }
        	if(docno>0){
        		
        		paymentdata = '<%=DAO.paymentDetailsGridLoading(session,docno)%>';
        		
          }
        	
            var source =
            {
                datatype: "json",
                datafields: [
                          
     						{name : 'duedate', type: 'date'  },
                          	{name : 'amount', type: 'number'  },
     						{name : 'runtotal', type: 'number'  },
     						{name : 'dueser', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
     						{name : 'terms', type: 'String'  },
     						{name : 'termsid', type: 'String'  },
     						{name : 'service', type: 'String'  },
     						{name : 'rowno', type: 'String'  },
     						{name : 'invtrno', type: 'number'  },
                          	],
                 localdata: paymentdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var rendererstring=function (aggregates){
            	var value=aggregates['sum'];
            	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            }
            
            
            $("#paymentDetailsGridID").on("bindingcomplete", function (event) {
				 
            	var rows = $("#paymentDetailsGridID").jqxGrid('getrows');
  			    for(var i=0 ; i < rows.length ; i++){
  				    var chk=rows[i].rowno;
  				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  				    	var chks=rows[i].invtrno;
  				    	if(chks>0) {
  				    		
  				    		$('#installments').val('');$('#paydueafter').val('');$('#cmbpaytype').val('1');
  				  			$('#installments').attr('readonly', true);
  				  			$('#paydueafter').attr('readonly', true);
  				  			$('#cmbpaytype').attr('disabled', true);
  				  			$('#btnAdd').attr('disabled', true);
  				  			$('#finsdate').jqxDateTimeInput({disabled: true});
  				  			$('#stdate').jqxDateTimeInput({disabled: true});
  				  			$('#enddate').jqxDateTimeInput({disabled: true});
  				    		
  				  			return false;
  				    	}
  	  					
  	  			    }
  			    }
				 
       		});
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            
            var cellclassname = function (row, column, value, data) {
              
                	if(data.invtrno>0){
                    	return "orangeClass";
                    }
                
                  };
            $("#paymentDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 190,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                showaggregates: false,
             	showstatusbar:false,
                selectionmode: 'singlecell',
                editable:true,
                sortable: true,
                localization: {thousandsSeparator: ""},
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false, cellclassname: cellclassname,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Due Date', datafield: 'duedate', width: '15%' , editable: true,columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',enableBrowserBoundsDetection:true, cellclassname: cellclassname,
						cellbeginedit: function (row) {
					        if ($('#paymentDetailsGridID').jqxGrid('getcellvalue', row, "invtrno")>0)
					         {
//				              	  return false;
				        		  return true;
					         }}
					},
					{ text: 'Amount', datafield: 'amount', width: '15%',editable:true, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: cellclassname,
						cellbeginedit: function (row) {
					        if ($('#paymentDetailsGridID').jqxGrid('getcellvalue', row, "invtrno")>0)
					         {
//				              	  return false;
				        		  return true;
			        		  }}
					},
					{ text: 'Run Total', datafield: 'runtotal', width: '25%',editable:false, cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: cellclassname },
					//{text: 'Due.After.Service',datafield:'dueser',width:'20%',editable:true},
					{ text: 'Terms',  datafield: 'terms',width:'10%',columntype:'dropdownlist', cellclassname: cellclassname,
 								createeditor: function (row, column, editor) {
 		                           billmodelist = ["", "LEGAL DOCUMENT", "PROFORMA INVOICE", "SERVICE"];
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 		                        }, 
 		                       cellbeginedit: function (row) {
 							        if ($('#paymentDetailsGridID').jqxGrid('getcellvalue', row, "invtrno")>0)
 							         {
//  							              return false;
							        		  return true;
 							         }}
 					 },
					{text: 'Service',datafield:'service',width:'8%',editable: true, cellclassname: cellclassname,
 						cellbeginedit: function (row) {
					        if ($('#paymentDetailsGridID').jqxGrid('getcellvalue', row, "invtrno")>0)
					         {
//				              	  return false;
				        		  return true;
					         }}
					},
					{text: 'termsid',datafield:'termsid',width:'8%',editable: true,hidden: true, cellclassname: cellclassname},
					{text: 'Description',datafield:'desc1',editable: true, cellclassname: cellclassname,
						cellbeginedit: function (row) {
					        if ($('#paymentDetailsGridID').jqxGrid('getcellvalue', row, "invtrno")>0)
					         {
//				              	  return false;
				        		  return true;					         
			        		  }}
					},
					{text: 'rowno',datafield:'rowno',width:'8%',hidden: true, cellclassname: cellclassname},
					{text: 'invtrno',datafield:'invtrno',width:'8%',hidden: true, cellclassname: cellclassname},
					]
            });
            
            $("#paymentDetailsGridID").jqxGrid('addrow', null, {});
            
            $("#paymentDetailsGridID").on('cellendedit', function (event) {
                var dataField = event.args.datafield;
                // row's bound index.
                if(dataField=="service"){
              
                var rowBoundIndex = event.args.rowindex;
                
                
                // cell value
                var value = event.args.value;
                
                
                // row's data.
                var rowdata =  event.args.row;
                
				var len=value.length;
			
				if(len>3){
					$.messager.alert('Message','Service number shouldnt greater than  3 digits.','warning');
					$("#paymentDetailsGridID").jqxGrid('setcellvalue', rowBoundIndex, "service", "");
				}
				else{
					//document.getElementById("errormsg").innerText="";
				}
				
                }
               /*    if(dataField=="terms"){
                	var value =  event.args.value;
                	if(value=="service"){
                		$('#paymentDetailsGridID').jqxGrid('showcolumn','service');
					    }
					    else{
					    	$('#paymentDetailsGridID').jqxGrid('hidecolumn','service');
					    }
                	
                } */  
              
            }); 
            
            $("#paymentDetailsGridID").on('cellvaluechanged', function (event) 
                    {
            	
				var datafield = event.args.datafield;
        		
    		    var rowBoundIndex =  event.args.rowindex;
    		    
    		    var summaryData3= $("#paymentDetailsGridID").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
	         	var runtotal=summaryData3.sum.replace(/,/g,'');
    		    var contrval=document.getElementById("txtcntrval").value;
    		   
    		    if( datafield=="duedate" )
      		  {
    		    	
    		    	  var invdate=new Date($('#paymentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "duedate"));
    				   var curdate=new Date($('#stdate').jqxDateTimeInput('getDate')); 
    				   var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
    				   invdate.setHours(0,0,0,0);
    				   curdate.setHours(0,0,0,0);
    				   enddate.setHours(0,0,0,0);
    				   if(invdate<curdate){
    					   
    					   $.messager.alert('Message','Date is not in between Contract dates','warning');
    					   $('#paymentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "duedate",new date());
    					return false;
    					}
					if(invdate>enddate){
    					   
    					   $.messager.alert('Message','Date is not in between Contract dates','warning');  
    					   $('#paymentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "duedate",new date());
    					return false;
    					}
      		  }
    		    
    		    
    		    if( datafield=="amount" )
    		  {
    		    	var rows = $("#paymentDetailsGridID").jqxGrid('getrows');
    		    	for(var i=0 ; i < rows.length ; i++){
    		    	 var amount= $('#paymentDetailsGridID').jqxGrid('getcellvalue', i, "amount");
    		    	 if(i==0){runtotal=0;}
    		    	 else{
    		    	 runtotal=$('#paymentDetailsGridID').jqxGrid('getcellvalue', i-1, "runtotal");
    		    	}
    		    	 runtotal=parseFloat(runtotal)+parseFloat(amount);
    		    	 $('#paymentDetailsGridID').jqxGrid('setcellvalue', i, "runtotal",runtotal);
    		    	}
//     	            	if(runtotal<=contrval){
    	            	
    	            		var rows = $('#paymentDetailsGridID').jqxGrid('getrows');
    	                	var rowlength= rows.length;
    	                	var rowindex1 = rowlength - 1;
    	              	    var amountcheck=$("#paymentDetailsGridID").jqxGrid('getcellvalue', rowindex1, "amount");
    	              	    if(typeof(amountcheck) != "undefined" && typeof(amountcheck) != "NaN" && amountcheck != "" && amountcheck != "0.00"){
    	                    	$("#paymentDetailsGridID").jqxGrid('addrow', null, {});
    	              	    }
    	            		
//     	            	}
//     	            	else{
//     	            		$.messager.alert('Message','Total amount Greater than Contract value.','warning');
//     	            		$('#paymentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "runtotal","0");
//     	            		$('#paymentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "amount",0);
//     	            		return 0;
//     	            	}
    	            	
    		    	 
    		  }
    		    
    		    if( datafield=="terms" )
        		  {
    		    	var termsvalue= $('#paymentDetailsGridID').jqxGrid('getcellvalue', rowBoundIndex, "terms");
    		    	
    		    	if(rowBoundIndex>0 && termsvalue=='PROFORMA INVOICE'){
    		    		$('#paymentDetailsGridID').jqxGrid('setcellvalue', rowBoundIndex, "terms","");
    		    	}
        		  }
    		    
            	
               });
       
      
        });
    </script>
<div id="paymentDetailsGridID"></div>
