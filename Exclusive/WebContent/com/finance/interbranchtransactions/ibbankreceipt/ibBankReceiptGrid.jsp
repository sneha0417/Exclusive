<%@page import="com.finance.interbranchtransactions.ibbankreceipt.ClsIbBankReceiptDAO" %>
<%  ClsIbBankReceiptDAO DAO=new ClsIbBankReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtibbankreceiptdocno2")==null?"0":request.getParameter("txtibbankreceiptdocno2"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<script type="text/javascript">
		 
		 var data1;   
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0)
           	 {   
            	   data1='<%=DAO.ibBankReceiptGridReloading(session,docNo,check)%>';      
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'docno', type: 'int' },
                            {name : 'branch', type: 'string' },
                            {name : 'brhid', type: 'int' },
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'currency', type: 'string'   },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number'   },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number'  },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'sr_no', type: 'int'  }
                        ],
                           localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AR', 'AP', 'GL', 'HR'];
            
            $("#jqxIbBankReceipt").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up for branch
                    var cell1 = $('#jqxIbBankReceipt').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'branch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	BranchSearchContent('branchSearchGrid.jsp');
                          }
                    }
                    
                    //Search Pop-Up
                    var cell1 = $('#jqxIbBankReceipt').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	 var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	 BankSearchContent('ibBankReceiptSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxIbBankReceipt').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
                    	if(value==4 || value==5){
                        if (key == 114) {  
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbBankReceipt");
                        	$('#jqxIbBankReceipt').jqxGrid('render');
                            }
                          }
                    	}
                        
                    var cell3 = $('#jqxIbBankReceipt').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
            	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxIbBankReceipt').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbBankReceipt&costtype="+value);
    	                	   $('#jqxIbBankReceipt').jqxGrid('render');
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
							{ text: 'Doc No', hidden: true, datafield: 'docno',  width: '5%' },
                            { text: 'Branch', datafield: 'branch', width: '10%' },
                            { text: 'Branch Id', hidden: true, datafield: 'brhid', editable: false, width: '10%' },
                            { text: 'Type', datafield: 'type', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '6%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '15%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '5%' },
							{ text: 'Rate', datafield: 'rate', editable: true,width: '4%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Cr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Currency Type', datafield: 'currencytype', hidden: true, editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
            	$("#jqxIbBankReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	 }
            
            if(temp>0){
            	$("#jqxIbBankReceipt").jqxGrid('disabled', true);
            }
         	  
         	  $("#jqxIbBankReceipt").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
      		     if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
      		    	
         		 var fromamount=document.getElementById("txtfrombaseamount").value;
         		 var toamount=document.getElementById("txttobaseamount").value;
         		
         	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
         	    var rows = $('#jqxIbBankReceipt').jqxGrid('getrows');
             	var rowlength= rows.length;
         		for(i=0;i<=rowlength-1;i++)
         		{
         		 var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', i, "dr");
                 var value1= $("#jqxIbBankReceipt").jqxGrid('getcellvalue', i, "amount1"); 
                 var rate= $("#jqxIbBankReceipt").jqxGrid('getcellvalue', i, "rate");
                 var type= $("#jqxIbBankReceipt").jqxGrid('getcellvalue', i, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 
                 if(isNaN(baseamount)){
              	   $('#jqxIbBankReceipt').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
              	   $('#jqxIbBankReceipt').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
                 }
                 
                 if(!isNaN(baseamount)){
              	   $('#jqxIbBankReceipt').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
                 }
                 
                 if(value==true){
                	 if(!isNaN(baseamount)){
               	      cr=cr+baseamount;
               	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 cr=cr+baseamount;
                 	   }
                 }
                 else{
                	 if(!isNaN(baseamount)){
                  	  	dr=dr+baseamount;
                	   }else if(isNaN(baseamount)){
                		    baseamount=0.00;
                		 	dr=dr+baseamount;
                	   }
                 }
                 
                 if(toamount == ""){
                  	 toamount=0.00;
                  	 dr1=parseFloat(dr) + parseFloat(fromamount);
                       funRoundAmt(dr1,"txtdrtotal");
                   }
                   
                   if(fromamount == ""){
                  	 fromamount=0.00;
                  	 cr1=parseFloat(cr) + parseFloat(toamount); 
                  	 funRoundAmt(cr1,"txtcrtotal");
                   }
                   
                   if(!isNaN(fromamount)){
                       dr1=parseFloat(dr) + parseFloat(fromamount);
                       funRoundAmt(dr1,"txtdrtotal");
                  	 }
                   
                   if(!isNaN(toamount)){
                  	 cr1=parseFloat(cr) + parseFloat(toamount); 
                  	 funRoundAmt(cr1,"txtcrtotal");
                    }
         	      }
      		    }
         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
         		if(datafield=="type"){
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
        });
         	  
         	 $("#jqxIbBankReceipt").on('cellvaluechanged', function (event) {
            	   	var rowindexestemp = event.args.rowindex;
            	  	 $('#rowindex').val(rowindexestemp);
            	   
         		var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', rowindexestemp, "type");
        			$('#type').val(value);
               });
          
           $('#jqxIbBankReceipt').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 5)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', rowindextemp, "type");
        		    BankSearchContent('ibBankReceiptSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 2)
      		  {
		      	    var rowIndexTemp = event.args.rowindex;
		      	    document.getElementById("rowindex").value = rowIndexTemp;
		      	    BranchSearchContent('branchSearchGrid.jsp');
      		  }
        	  
        	  if(event.args.columnindex == 10)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxIbBankReceipt').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbBankReceipt");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 12)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxIbBankReceipt').jqxGrid('clearselection');
		           var value = $('#jqxIbBankReceipt').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbBankReceipt&costtype="+value);
		           }
                } 
	           
	           if(event.args.columnindex == 0)
	    		  {
	    			var rowindexestemp = event.args.rowindex;
	    			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
	    			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "brhid" ,'');
	    			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "branch" ,'');	
	    			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
		   			$('#jqxIbBankReceipt').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
	              }
	           
            }); 
          
        });
    </script>
    <div id="jqxIbBankReceipt"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/>