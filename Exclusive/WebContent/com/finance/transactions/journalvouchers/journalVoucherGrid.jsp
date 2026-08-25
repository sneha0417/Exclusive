<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>
<% ClsJournalVouchersDAO DAO= new ClsJournalVouchersDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtjournalvouchersdocno2")==null?"0":request.getParameter("txtjournalvouchersdocno2");
   String date = request.getParameter("date")==null?"0":request.getParameter("date").trim();
   String documentNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<style type="text/css">
        .redClass
        {
            background-color: #FF4D4D/* #FFEBEB */;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
</style>

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
            var temp1='<%=documentNo%>';
            
             if(temp>0){     
            	 data1='<%=DAO.journalVoucherGridReloading(session, docNo,check)%>';      
             }else if(temp1>0){     
            	 data1='<%=DAO.journalVoucherExcelImportGridLoading(documentNo,date)%>';      
             } 
                            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'int' },
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'id', type: 'int'  },
     						{name : 'typevalid', type: 'number'  },
     						{name : 'accvalid', type: 'number'  },
     						{name : 'grtypevalid', type: 'number'  },
     						{name : 'costvalid', type: 'number'  }
                        ],
                         localdata: data1,  
                deleterow: function (rowid, commit) {
                    // synchronize with the server - send delete command
                    // call commit with parameter true if the synchronization with the server is successful 
                    // and with parameter false if the synchronization failed.
                    commit(true);
                },
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var celltypeclassname = function (row, column, value, data) {
        		if (data.typevalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellaccclassname = function (row, column, value, data) {
            	if (data.accvalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellgrtypeclassname = function (row, column, value, data) {
            	if (data.grtypevalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var cellcostclassname = function (row, column, value, data) {
            	if (data.costvalid == '1') {
                    return "redClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['GL', 'HR','AP','AR'];
            
            $("#jqxJournalVoucher").jqxGrid(
            {
                width: '99.5%',
                height: 410,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                altRows: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxJournalVoucher').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	  var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	  AccountSearchContent('journalVoucherSearch.jsp?atype='+value);
                          }
                    }
                    
                    var cell2 = $('#jqxJournalVoucher').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                        if (key == 114) { 
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxJournalVoucher");
                        	$('#jqxJournalVoucher').jqxGrid('render');
             	            }
                          }
                    	}
                        
                        var cell3 = $('#jqxJournalVoucher').jqxGrid('getselectedcell');
                        if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxJournalVoucher').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxJournalVoucher').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxJournalVoucher&costtype="+value);
    	                	   $('#jqxJournalVoucher').jqxGrid('render');
    	        	           }
    	                   }
    	               }
                },
                
               
                
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No',  hidden: true, datafield: 'docno',  width: '5%' },
                            { text: 'Type', datafield: 'type', cellclassname: celltypeclassname, width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts', cellclassname: cellaccclassname, editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Cost Type', datafield: 'costgroup', cellclassname: cellgrtypeclassname, width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%', hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', cellclassname: cellcostclassname, width: '5%',editable: false },
							{ text: 'Debit', datafield: 'debit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxJournalVoucher').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Credit', datafield: 'credit', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxJournalVoucher').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', editable: false, width: '10%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No',  hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' },
							{ text: 'Type Valid',  hidden: true, datafield: 'typevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Acc Valid',  hidden: true, datafield: 'accvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Gr-Type Valid',  hidden: true, datafield: 'grtypevalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							{ text: 'Cost Vaild',  hidden: true, datafield: 'costvalid', editable: false, width: '5%',  cellsformat: 'd2', aggregates: ['sum'] },
							
						]
            });
            
          //Add empty row
            if(temp==0){   
         	   $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
          	  } 
          
            if(temp>0){ 
            	$("#jqxJournalVoucher").jqxGrid({ disabled: true});
            }
         	  
         	 $("#jqxJournalVoucher").on('cellvaluechanged', function (event){
               
                var datafield = event.args.datafield;
         		var rowindexestemp = event.args.rowindex;
         		
         		if(datafield=="debit" || datafield=="credit"){
         		
         		var fromamount = $('#txtdrtotal').val();
      		    var toamount = $('#txtcrtotal').val();
         		
         		var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
          	    var rows = $('#jqxJournalVoucher').jqxGrid('getrows');
          	    var rowlength= rows.length;
          		for(i=0;i<=rowlength-1;i++)
          		{
          		  var debit = $('#jqxJournalVoucher').jqxGrid('getcellvalue', i, "debit");
          		  var credit = $('#jqxJournalVoucher').jqxGrid('getcellvalue', i, "credit"); 
                  var rate= $("#jqxJournalVoucher").jqxGrid('getcellvalue', i, "rate");
                  var type= $("#jqxJournalVoucher").jqxGrid('getcellvalue', i, "currencytype");
                  
                  if(debit>0){
                	  var baseamount = getBaseAmountInGrid(debit,rate,type);
                  	  
                	  if(isNaN(baseamount)){
   	              	   $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "debit" ,"0.00");
   	              	   $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "baseamount" ,"0.00");
   	                  }
   	                 
   	                  if(!isNaN(baseamount)){
   	                	 $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
   	                   }
   	                 
	   	              if(!isNaN(baseamount)){
	                  	dr=dr+baseamount;
	            	   }else if(isNaN(baseamount)){
	            		 baseamount=0.00;
	            		 dr=dr+baseamount;
	            	   }
                  }
                  
                  if(credit>0){
                	  var baseamount = getBaseAmountInGrid(credit,rate,type);
                 	 
                	  if(isNaN(baseamount)){
      	              	   $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "credit" ,"0.00");
      	              	   $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "baseamount" ,"0.00");
      	                  }
      	                 
      	               if(!isNaN(baseamount)){
      	                	 $('#jqxJournalVoucher').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
      	               }
      	               
      	             if(!isNaN(baseamount)){
                 	      cr=cr+baseamount;
                 	   }else if(isNaN(baseamount)){
                   		  baseamount=0.00;
                   		  cr=cr+baseamount;
                   	   }
                  }
          	  }
                 
                 if(fromamount == ""){
                	 fromamount=0.00;
                	 funRoundAmt(fromamount,"txtcrtotal");
                 }
                 
                 if(toamount == ""){
                	 toamount=0.00;
                     funRoundAmt(toamount,"txtdrtotal");
                 }
                 
                 if(!isNaN(fromamount)){
                     dr1=parseFloat(dr);
                     funRoundAmt(dr1,"txtdrtotal");
                 }else if(isNaN(fromamount)){
                     dr1=0.00;
                     funRoundAmt(dr1,"txtdrtotal");
                 }
                 
                 if(!isNaN(toamount)){
                	 cr1=parseFloat(cr); 
                	 funRoundAmt(cr1,"txtcrtotal");
                  }else if(isNaN(toamount)){
                	 cr1=0.00; 
                	 funRoundAmt(cr1,"txtcrtotal");
                  }
         		}
         		
        		if(datafield=="type"){
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
        			
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "typevalid" ,'0');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accvalid" ,'0');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "grtypevalid" ,'0');
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costvalid" ,'0');
        			
        			 var typevalid1="",typevalid2="",accvalid1="",accvalid2="",grtypevalid1="",grtypevalid2="",costvalid1="",costvalid2="";
        			 
        			var typevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'typevalid', ['sum'], true);
   	                typevalid1=typevalid.sum;
   	                typevalid2=typevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	         	    if(!(isNaN(typevalid2))){
   	         		  $('#txtexceltypevalidation').val(typevalid2);
   	        	    }else if(isNaN(typevalid2)){
   	        		  $('#txtexceltypevalidation').val(0.00);
   	        	    }
   	          	 
   	         	    var accvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'accvalid', ['sum'], true);
   	         	    accvalid1=accvalid.sum;
   	         	    accvalid2=accvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	        	    if(!(isNaN(accvalid2))){
   	        		  $('#txtexcelaccvalidation').val(accvalid2);
   	       	        }else if(isNaN(accvalid2)){
   	       		      $('#txtexcelaccvalidation').val(0.00);
   	       		    }
   	        	  
   	        	    var grtypevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'grtypevalid', ['sum'], true);
   	        	    grtypevalid1=grtypevalid.sum;
   	        	    grtypevalid2=grtypevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	         	    if(!(isNaN(grtypevalid2))){
   	         		  $('#txtexcelgrtypevalidation').val(grtypevalid2);
   	        	    }else if(isNaN(grtypevalid2)){
   	        		  $('#txtexcelgrtypevalidation').val(0.00);
   	        	   }
   	         	  
   	         	    var costvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'costvalid', ['sum'], true);
   	         	    costvalid1=costvalid.sum;
   	         	    costvalid2=costvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	        	    if(!(isNaN(costvalid2))){
   	        		  $('#txtexcelcostvalidation').val(costvalid2);
   	       	        }else if(isNaN(costvalid2)){
   	       		     $('#txtexcelcostvalidation').val(0.00);
   	       	        }
   	        	  
     			}
        		
        		if(datafield=="costtype"){
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
        			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costvalid" ,'0');
        			
        			var typevalid1="",typevalid2="",accvalid1="",accvalid2="",grtypevalid1="",grtypevalid2="",costvalid1="",costvalid2="";
       			 
        			var typevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'typevalid', ['sum'], true);
   	                typevalid1=typevalid.sum;
   	                typevalid2=typevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	         	    if(!(isNaN(typevalid2))){
   	         		  $('#txtexceltypevalidation').val(typevalid2);
   	        	    }else if(isNaN(typevalid2)){
   	        		  $('#txtexceltypevalidation').val(0.00);
   	        	    }
   	          	 
   	         	    var accvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'accvalid', ['sum'], true);
   	         	    accvalid1=accvalid.sum;
   	         	    accvalid2=accvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	        	    if(!(isNaN(accvalid2))){
   	        		  $('#txtexcelaccvalidation').val(accvalid2);
   	       	        }else if(isNaN(accvalid2)){
   	       		      $('#txtexcelaccvalidation').val(0.00);
   	       		    }
   	        	  
   	        	    var grtypevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'grtypevalid', ['sum'], true);
   	        	    grtypevalid1=grtypevalid.sum;
   	        	    grtypevalid2=grtypevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	         	    if(!(isNaN(grtypevalid2))){
   	         		  $('#txtexcelgrtypevalidation').val(grtypevalid2);
   	        	    }else if(isNaN(grtypevalid2)){
   	        		  $('#txtexcelgrtypevalidation').val(0.00);
   	        	   }
   	         	  
   	         	    var costvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'costvalid', ['sum'], true);
   	         	    costvalid1=costvalid.sum;
   	         	    costvalid2=costvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
   	        	    if(!(isNaN(costvalid2))){
   	        		  $('#txtexcelcostvalidation').val(costvalid2);
   	       	        }else if(isNaN(costvalid2)){
   	       		     $('#txtexcelcostvalidation').val(0.00);
   	       	        }
    			}
  
             }); 
         	 
         	$("#jqxJournalVoucher").on('cellvaluechanged', function (event) {
            	   var rowindexestemp = event.args.rowindex;
            	   $('#rowindex').val(rowindexestemp);
            	   
         		var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindexestemp, "type");
        			$('#type').val(value);
               });
         	 
         	  $("#jqxJournalVoucher").on('cellendedit', function (event) 
         			{
         			    var datafield = event.args.datafield;
         			    var rowBoundIndex = event.args.rowindex;
         			    if(datafield=="debit"){
         			    var value = event.args.value;
         			    if(value=="" || value=="undefined"){
         				  $('#jqxJournalVoucher').jqxGrid('setcellvalue',rowBoundIndex, "debit",0);  
         			     }
         			    }
         			    else if(datafield=="credit"){
             			    var value = event.args.value;     
             			    if(value=="" || value=="undefined"){
             				  $('#jqxJournalVoucher').jqxGrid('setcellvalue',rowBoundIndex, "credit",0);  
             			   }
         			   }
         			   
         			}); 
            
             $('#jqxJournalVoucher').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 3)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindextemp, "type");
                    AccountSearchContent('journalVoucherSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 5)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxJournalVoucher').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxJournalVoucher");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 7)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxJournalVoucher').jqxGrid('clearselection');
		           var value = $('#jqxJournalVoucher').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxJournalVoucher&costtype="+value);
		           }
              } 
	           
	           if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "debit" ,'0.00');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "credit" ,'0.00');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "baseamount" ,'0.00');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "id" ,'');
 	   			$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "typevalid" ,'0');
				$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "accvalid" ,'0');
				$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "grtypevalid" ,'0');
				$('#jqxJournalVoucher').jqxGrid('setcellvalue', rowindexestemp, "costvalid" ,'0');
               }
            }); 
             
              if(temp1>0){ 
                     var debit1="",debit2="",credit1="",credit2="",typevalid1="",typevalid2="",accvalid1="",accvalid2="",grtypevalid1="",grtypevalid2="",costvalid1="",costvalid2="";
        	 	  
		         	  var debit=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
		         	  debit2=debit.sum;
		         	  debit1=debit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		         	 if(!(isNaN(debit1))){
		        		  funRoundAmt(debit1,"txtdrtotal");
		        	  }else if(isNaN(credit1)){
		        		  funRoundAmt(0.00,"txtdrtotal");
		        	  }
        		
        	     var credit=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
        	     credit2=credit.sum;
        	     credit1=credit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	if(!(isNaN(credit1))){
	              	funRoundAmt(credit1,"txtcrtotal");
	         	  }else if(isNaN(credit1)){
	             	 funRoundAmt(0.00,"txtcrtotal");
	         	  }
	         	
	         	  var typevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'typevalid', ['sum'], true);
	              typevalid1=typevalid.sum;
	              typevalid2=typevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	  if(!(isNaN(typevalid2))){
	         		 $('#txtexceltypevalidation').val(typevalid2);
	        	  }else if(isNaN(typevalid2)){
	        		  $('#txtexceltypevalidation').val(0.00);
	        	  }
	          	 
	         	 var accvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'accvalid', ['sum'], true);
	         	 accvalid1=accvalid.sum;
	         	 accvalid2=accvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	        	  if(!(isNaN(accvalid2))){
	        		 $('#txtexcelaccvalidation').val(accvalid2);
	       	     }else if(isNaN(accvalid2)){
	       		    $('#txtexcelaccvalidation').val(0.00);
	       		 }
	        	  
	        	  var grtypevalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'grtypevalid', ['sum'], true);
	        	  grtypevalid1=grtypevalid.sum;
	        	  grtypevalid2=grtypevalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	  if(!(isNaN(grtypevalid2))){
	         		 $('#txtexcelgrtypevalidation').val(grtypevalid2);
	        	  }else if(isNaN(grtypevalid2)){
	        		  $('#txtexcelgrtypevalidation').val(0.00);
	        	  }
	         	  
	         	 var costvalid=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'costvalid', ['sum'], true);
	         	 costvalid1=costvalid.sum;
	         	 costvalid2=costvalid1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	        	  if(!(isNaN(costvalid2))){
	        		 $('#txtexcelcostvalidation').val(costvalid2);
	       	     }else if(isNaN(costvalid2)){
	       		     $('#txtexcelcostvalidation').val(0.00);
	       	     }
	        	  
        	    }
              $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
              // create context menu
              var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
              $("#jqxJournalVoucher").on('contextmenu', function () {
                  return false;
              });
              
              $("#Menu").on('itemclick', function (event) {
           	   var args = event.args;
                  var rowindex = $("#jqxJournalVoucher").jqxGrid('getselectedrowindex');
                  if($.trim($(args).text()) == "Delete Selected Row"){
                      var rowid = $("#jqxJournalVoucher").jqxGrid('getrowid', rowindex);
                      $("#jqxJournalVoucher").jqxGrid('deleterow', rowid);
                      var debit=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
		         	  debit2=debit.sum;
		         	  debit1=debit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		         	 if(!(isNaN(debit1))){
		        		  funRoundAmt(debit1,"txtdrtotal");
		        	  }else if(isNaN(credit1)){
		        		  funRoundAmt(0.00,"txtdrtotal");
		        	  }
        		
        	     var credit=$('#jqxJournalVoucher').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
        	     credit2=credit.sum;
        	     credit1=credit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	if(!(isNaN(credit1))){
	              	funRoundAmt(credit1,"txtcrtotal");
	         	  }else if(isNaN(credit1)){
	             	 funRoundAmt(0.00,"txtcrtotal");
	         	  } 
                  }
               
              });
			$("#jqxJournalVoucher").on('rowclick', function (event) {
				if (event.args.rightclick) {
       		   		if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" || document.getElementById("mode").value=="EDIT"){
       		   			$("#jqxJournalVoucher").jqxGrid('selectrow', event.args.rowindex);
                      	var scrollTop = $(window).scrollTop();
                      	var scrollLeft = $(window).scrollLeft();
                      	contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                      	return false;
                  	}
       		   	}
			});
              
              var rows=$("#jqxJournalVoucher").jqxGrid("getrows");
              if(rows.length==0){
           	   $("#jqxJournalVoucher").jqxGrid("addrow", null, {});   
              }
              
       
             
        });

</script>
<div id='jqxWidget'>
	<div id="jqxJournalVoucher"></div>
    <div id="popupWindow">
		<div id='Menu'>
        	<ul>
            	<li>Delete Selected Row</li>
        	</ul>
      	</div>
	</div>
</div>

<input type="hidden" id="rowindex"/> 
<input type="hidden" id="type"/> 