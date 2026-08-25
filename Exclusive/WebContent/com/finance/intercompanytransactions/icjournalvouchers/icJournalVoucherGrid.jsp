<%@page import="com.finance.intercompanytransactions.icjournalvouchers.ClsIcJournalVouchersDAO"%>
<% ClsIcJournalVouchersDAO DAO= new ClsIcJournalVouchersDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txticjournalvouchersdocno2")==null?"0":request.getParameter("txticjournalvouchersdocno2");
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
            
             if(temp>0){     
            	 data1='<%=DAO.journalVoucherGridReloading(session, docNo,check)%>';      
             }
                            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'int' },
							{name : 'compbranch', type: 'string' },
	                        {name : 'intrcompid', type: 'int' },
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
     						{name : 'intrbrhid', type: 'int' },
     						{name : 'dbname', type: 'string' }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['GL', 'HR','AP','AR'];
            
            $("#icJournalVoucherGridID").jqxGrid(
            {
                width: '99.5%',
                height: 410,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cells1 = $('#icJournalVoucherGridID').jqxGrid('getselectedcell');
                    if (cells1 != undefined && cells1.datafield == 'compbranch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if($("#rowindex").val()!="0") {
                        		BranchSearchContent('interCompanyBranchSearchGrid.jsp');
                        	}
                          }
                    }
                    
                    var cell1 = $('#icJournalVoucherGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell1.rowindex, "dbname");
                        	AccountSearchContent('icJournalVoucherSearch.jsp?atype='+value+'&dbname='+dbnamevalue); 
                          }
                    }
                    
                    var cell2 = $('#icJournalVoucherGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                    		var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell2.rowindex, "dbname");
                        	costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
                        	 $('#icJournalVoucherGridID').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#icJournalVoucherGridID').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', cell3.rowindex, "dbname");
    	                	   costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
    	                	   $('#icJournalVoucherGridID').jqxGrid('render');
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
							{ text: 'Company / Branch', datafield: 'compbranch',  editable: false, width: '14%' },
                            { text: 'Inter-Company Id', hidden: true, datafield: 'intrcompid', editable: false, width: '10%' },
                            { text: 'Type', datafield: 'type', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts', editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '14%' },	
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%', hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Debit', datafield: 'debit', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#icJournalVoucherGridID').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Credit', datafield: 'credit', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#icJournalVoucherGridID').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', editable: false, width: '10%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No',  hidden: true, datafield: 'sr_no', editable: false, width: '10%' },
							{ text: 'Intr brhid', datafield: 'intrbrhid', hidden: true, editable: false, width: '10%' },
							{ text: 'Database', hidden: true, datafield: 'dbname', editable: false, width: '10%' },
							
						]
            });
            
          //Add empty row
            if(temp==0){   
         	   $("#icJournalVoucherGridID").jqxGrid('addrow', null, {});
          	  } 
          
            if(temp>0){ 
            	$("#icJournalVoucherGridID").jqxGrid({ disabled: true});
            }
         	  
         	 $("#icJournalVoucherGridID").on('cellvaluechanged', function (event){
               
                var datafield = event.args.datafield;
         		var rowindexestemp = event.args.rowindex;
         		
         		
         		if(datafield=='compbranch'){
         			
         			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			
         			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			
         		}
         		
         		
         		
         		
         		
         		
         		
         		if(datafield=="debit" || datafield=="credit"){
         		
         		var fromamount = $('#txtdrtotal').val();
      		    var toamount = $('#txtcrtotal').val();
         		
         		var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
          	    var rows = $('#icJournalVoucherGridID').jqxGrid('getrows');
          	    var rowlength= rows.length;
          		for(i=0;i<=rowlength-1;i++)
          		{
          		  var debit = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', i, "debit");
          		  var credit = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', i, "credit"); 
                  var rate= $("#icJournalVoucherGridID").jqxGrid('getcellvalue', i, "rate");
                  var type= $("#icJournalVoucherGridID").jqxGrid('getcellvalue', i, "currencytype");
                  
                  if(debit>0){
                	  var baseamount = getBaseAmountInGrid(debit,rate,type);
                  	  
                	  if(isNaN(baseamount)){
   	              	   $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "debit" ,"0.00");
   	              	   $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "baseamount" ,"0.00");
   	                  }
   	                 
   	                  if(!isNaN(baseamount)){
   	                	 $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
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
      	              	   $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "credit" ,"0.00");
      	              	   $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "baseamount" ,"0.00");
      	                  }
      	                 
      	               if(!isNaN(baseamount)){
      	                	 $('#icJournalVoucherGridID').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
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
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
   	        	  
     			}
        		
        		if(datafield=="costtype"){
        			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
    			}
  
             }); 
         	 
         	$("#icJournalVoucherGridID").on('cellvaluechanged', function (event) {
            	   var rowindexestemp = event.args.rowindex;
            	   $('#rowindex').val(rowindexestemp);
            	   
         		var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindexestemp, "type");
        			$('#type').val(value);
               });
         	 
         	  $("#icJournalVoucherGridID").on('cellendedit', function (event) 
         			{
         			    var datafield = event.args.datafield;
         			    var rowBoundIndex = event.args.rowindex;
         			    if(datafield=="debit"){
         			    var value = event.args.value;
         			    if(value=="" || value=="undefined"){
         				  $('#icJournalVoucherGridID').jqxGrid('setcellvalue',rowBoundIndex, "debit",0);  
         			     }
         			    }
         			    else if(datafield=="credit"){
             			    var value = event.args.value;    
             			    if(value=="" || value=="undefined"){
             				  $('#icJournalVoucherGridID').jqxGrid('setcellvalue',rowBoundIndex, "credit",0);  
             			   }
         			   }
         			   
         			}); 
            
             $('#icJournalVoucherGridID').on('celldoubleclick', function (event) {
            	 if(event.args.columnindex == 2)
	       		  {
	 		      	    var rowIndexTemp = event.args.rowindex;
	 		      	    document.getElementById("rowindex").value = rowIndexTemp;
	 		      	    if(rowIndexTemp!="0") {
	 		      	    	BranchSearchContent('interCompanyBranchSearchGrid.jsp');
	 		      	    }
	       		  }
            	
	        	  if(event.args.columnindex == 5)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "type");
        		    var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
                    AccountSearchContent('icJournalVoucherSearch.jsp?atype='+value+'&dbname='+dbnamevalue);
                  } 
        	  
	        	  if(event.args.columnindex == 7){
	    	           var rowindextemp = event.args.rowindex;
	    	           var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "grtype");
	    	           document.getElementById("rowindex").value = rowindextemp;
	    	           if(value==4 || value==5){
	    	           $('#icJournalVoucherGridID').jqxGrid('clearselection');
	    	           var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
	    	           costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
	    	           }
	                } 
	        		  
	               if(event.args.columnindex == 9){
	    	           var rowindextemp = event.args.rowindex;
	    	           var value1 = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "grtype");
	    	           document.getElementById("rowindex").value = rowindextemp;
	    	           if(value1==4 || value1==5){
	    	           $('#icJournalVoucherGridID').jqxGrid('clearselection');
	    	           var value = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
	    	           var dbnamevalue = $('#icJournalVoucherGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
	    	           costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
	    	           }
	                } 
	           
	           if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "intrcompid" ,'');
      			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "compbranch" ,'');
     			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "debit" ,'0.00');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "credit" ,'0.00');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "baseamount" ,'0.00');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   		    $('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "dbname" ,'');
	   		    $('#icJournalVoucherGridID').jqxGrid('setcellvalue', rowindexestemp, "intrbrhid" ,'');
               }
            }); 
             
        });

</script>

<div id="icJournalVoucherGridID"></div>

<input type="hidden" id="rowindex"/> 
<input type="hidden" id="type"/> 