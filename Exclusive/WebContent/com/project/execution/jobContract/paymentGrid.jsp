<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.jobContract.ClsJobContractDAO"%>
<% String contextPath=request.getContextPath();%>
  <%ClsJobContractDAO DAO= new ClsJobContractDAO(); %>
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
  
    .orangeClass
    {
        background-color: #FAD7A0;
    }
  
</style>
    <script type="text/javascript">
    var paymentdata;
     var gridload='<%=gridload%>';
    var docno='<%=docno%>';
    
        $(document).ready(function () { 	
        	
        	if(gridload=="1"){
        		
        		  paymentdata = '<%=DAO.paymentGrid(session,date,enddate,instno1,amount1,gridload,payfre,paydue) %>';
            }
        	if(docno>0){
        		
        		paymentdata = '<%=DAO.payGridLoad(session,docno)%>';
        		
          }
        	
             var num = 0; 
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
            $("#paymentGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                showaggregates: false,
             	showstatusbar:false,
                selectionmode: 'singlecell',
                editable:true,
                sortable: true,
                localization: {thousandsSeparator: ""},
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname: cellclassname,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Due Date', datafield: 'duedate', width: '15%' , editable: true,columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy',enableBrowserBoundsDetection:true, cellclassname: cellclassname},
					{ text: 'Amount', datafield: 'amount', width: '15%',editable:true, cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname: cellclassname},
					{ text: 'Run Total', datafield: 'runtotal', width: '25%',editable:false, cellsformat: 'd2', cellsalign: 'right', align: 'right' , cellclassname: cellclassname},
					//{text: 'Due.After.Service',datafield:'dueser',width:'20%',editable:true},
					{ text: 'Terms',  datafield: 'terms',width:'10%', cellclassname: cellclassname,columntype:'dropdownlist',
								
 								createeditor: function (row, column, editor) {
 									
 		                           billmodelist = ["LEGAL DOCUMENT", "PROFORMA INVOICE", "SERVICE"];
 		                         
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 								
 								},
							 	 initeditor: function (row, cellvalue, editor) {
 		                          
									var terms = $('#paymentGrid').jqxGrid('getcellvalue', row, "terms");
									
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 									
 									 /* editor.on('change',function(event){
 										 
 										
 										var args = event.args;
 										
 									    if (args) {
 									    var index = event.args.index;
 									    var item = event.args.item;
 									    var label = item.label;
 									    var value = item.value;
 									    if(value=="SERVICE"){
 									    	$('#paymentGrid').jqxGrid('setcellvalue',index,'termsid',"91");
 									    	$('#paymentGrid').jqxGrid('selectcell', index, 'service');
 									    	$('#paymentGrid').jqxGrid('showcolumn','service');
 									    }
 									    else{
 									    	$('#paymentGrid').jqxGrid('hidecolumn','service');
 									    }
 									   if(value=="LEGAL DOCUMENT"){
									    	$('#paymentGrid').jqxGrid('setcellvalue',index,'termsid',"99");
									    	
									    }
 									  if(value=="PROFORMA INVOICE"){
									    	$('#paymentGrid').jqxGrid('setcellvalue',index,'termsid',"98");
									    	
									    }
 									    
 									    }
 									    
 									}); */
 									
 		                        }, 
					
					},
					{text: 'Service',datafield:'service',width:'8%',editable:true, cellclassname: cellclassname},
					{text: 'termsid',datafield:'termsid',width:'8%',editable:true,hidden:true, cellclassname: cellclassname},
					{text: 'Description',datafield:'desc1',editable:true, cellclassname: cellclassname},
					{text: 'rowno',datafield:'rowno',width:'8%',hidden:true, cellclassname: cellclassname},
					{text: 'invtrno',datafield:'invtrno',width:'8%',hidden:true, cellclassname: cellclassname},
					]
            });
            if($('#mode').val()=='view'){
           	 $("#paymentGrid").jqxGrid({ disabled: true});
       		
           }
            $("#paymentGrid").jqxGrid('addrow', null, {});
            
            $("#paymentGrid").on('cellendedit', function (event) {
 
          
                // event arguments.
                var args = event.args;
                // column data field.
                var dataField = event.args.datafield;
                // row's bound index.
                if(dataField=="service"){
              
                var rowBoundIndex = event.args.rowindex;
                
                
                // cell value
                var value = event.args.value;
                
                
                // row's data.
                var rowdata = event.args.row;
                
				var len=value.length;
			
				if(len>3){
					document.getElementById("errormsg").innerText="service number shouldnt greater than  3 digits";
					$("#paymentGrid").jqxGrid('setcellvalue', rowBoundIndex, "service", "");
				}
				else{
					document.getElementById("errormsg").innerText="";
				}
				
                }
               /*    if(dataField=="terms"){
                	var value = event.args.value;
                	if(value=="service"){
                		$('#paymentGrid').jqxGrid('showcolumn','service');
					    }
					    else{
					    	$('#paymentGrid').jqxGrid('hidecolumn','service');
					    }
                	
                } */  
              
            });
            
            $("#paymentGrid").on('cellvaluechanged', function (event) 
                    {
            	
				var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    
    		    var summaryData3= $("#paymentGrid").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
	         	var runtotal=summaryData3.sum.replace(/,/g,'');
    		    var contrval=document.getElementById("txtcntrval").value;
    		   
    		    if( datafield=="duedate" )
      		  {
    		    	
    		    	  var invdate=new Date($('#paymentGrid').jqxGrid('getcellvalue', rowBoundIndex, "duedate"));
    				   var curdate=new Date($('#stdate').jqxDateTimeInput('getDate')); 
    				   var enddate=new Date($('#enddate').jqxDateTimeInput('getDate'));
    				   invdate.setHours(0,0,0,0);
    				   curdate.setHours(0,0,0,0);
    				   enddate.setHours(0,0,0,0);
    				   if(invdate<curdate){
    					   
    					   $.messager.alert('Message','Date is not in between Contract dates','warning');
    					   $('#paymentGrid').jqxGrid('setcellvalue', rowBoundIndex, "duedate",new date());
    					return false;
    					}
					if(invdate>enddate){
    					   
    					   $.messager.alert('Message','Date is not in between Contract dates','warning');  
    					   $('#paymentGrid').jqxGrid('setcellvalue', rowBoundIndex, "duedate",new date());
    					return false;
    					}
      		  }
    		    
    		    
    		    if( datafield=="amount" )
    		  {
    		    	
    		    	 var amount= $('#paymentGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
    		    	 runtotal=parseInt(runtotal);
    		    	 
 
    	            	if(runtotal<=contrval){
    	            	
    	            	//	$("#paymentGrid").jqxGrid('addrow', null, {});
    	            	//	$('#paymentGrid').jqxGrid('setcellvalue', rowBoundIndex, "runtotal",runtotal);
    	            		var rows = $("#paymentGrid").jqxGrid('getrows');
    	                      var gridamount=0;
    	                    for(var i=0 ; i < rows.length ; i++){
    	                    var chk=rows[i].amount;
    	                    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
    	                     gridamount=parseFloat(gridamount)+parseFloat(rows[i].amount);
    	         if(i==0){
    	                      $('#paymentGrid').jqxGrid('setcellvalue', i, "runtotal",gridamount);
    	         } else {
    	                      $('#paymentGrid').jqxGrid('setcellvalue', i, "runtotal",gridamount);
    	         }
    	                     }
    	                    var rowindex1 = (rows.length) - 1;
    	                         var amount=$("#paymentGrid").jqxGrid('getcellvalue', rowindex1, "amount");
    	                         if(typeof(amount) != "undefined"){
    	                           $("#paymentGrid").jqxGrid('addrow', null, {});
    	                         }
    	                    }
    	            	}
    	            	else{
    	            		$.messager.alert('Message','Total amount Greater than contract value','warning');
    	            		$('#paymentGrid').jqxGrid('setcellvalue', rowBoundIndex, "runtotal","0");
    	            		$('#paymentGrid').jqxGrid('setcellvalue', rowBoundIndex, "amount",0);
    	            		return 0;
    	            	}
    	            	
    		    	 
    		  }
    		    
            	
                    });
 
       
      
        });
    </script>
    <div id="paymentGrid"></div>
