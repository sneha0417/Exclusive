<%@page import="com.finance.interbranchtransactions.ibbankpayment.ClsIbBankPaymentDAO" %>
<%  ClsIbBankPaymentDAO DAO=new ClsIbBankPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtibbankpaydocno2")==null?"0":request.getParameter("txtibbankpaydocno2"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<script type="text/javascript">
		 
		 var data1;   
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0){   
            	   data1='<%=DAO.ibBankPaymentGridReloading(session,docNo,check)%>';      
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
            
            $("#jqxIbBankPayment").jqxGrid(
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
                    var cell1 = $('#jqxIbBankPayment').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'branch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	BranchSearchContent('branchSearchGrid.jsp');
                          }
                    }
                    
                    //Search Pop-Up
                    var cell1 = $('#jqxIbBankPayment').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	BankSearchContent('ibBankPaymentSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxIbBankPayment').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
                    	var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
                    	if(value==4 || value==5){
                        if (key == 114) {  
                        	 costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbBankPayment");
                        	 $('#jqxIbBankPayment').jqxGrid('render');
                            }
                          }
                    	}
                        
                    var cell3 = $('#jqxIbBankPayment').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxIbBankPayment').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
            	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxIbBankPayment').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbBankPayment&costtype="+value);
    	                	   $('#jqxIbBankPayment').jqxGrid('render');
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
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', editable: true,width: '4%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', datafield: 'currencytype', hidden: true, editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
						]
            });
            
          //Add empty row
            if(temp==0){   
         	  $("#jqxIbBankPayment").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	 }
          
            if(temp>0){
            	$("#jqxIbBankPayment").jqxGrid('disabled', true);
            }
         	  
         	  $("#jqxIbBankPayment").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
           		 if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
          			
         		 var fromamount=document.getElementById("txtfrombaseamount").value;
         		 var toamount=document.getElementById("txttobaseamount").value;
         		
         	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
         	    var rows = $('#jqxIbBankPayment').jqxGrid('getrows');
             	var rowlength= rows.length;
         		for(i=0;i<=rowlength-1;i++)
         		{
         		 var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', i, "dr");
                 var value1= $("#jqxIbBankPayment").jqxGrid('getcellvalue', i, "amount1"); 
                 var rate= $("#jqxIbBankPayment").jqxGrid('getcellvalue', i, "rate");
                 var type= $("#jqxIbBankPayment").jqxGrid('getcellvalue', i, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 
                 if(isNaN(baseamount)){
              	   $('#jqxIbBankPayment').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
              	   $('#jqxIbBankPayment').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
                 }
                 
                 if(!isNaN(baseamount)){
              	   $('#jqxIbBankPayment').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
                 }
                 
                 if(value==true){
                	 if(!isNaN(baseamount)){
                       	dr=dr+baseamount;
                 	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 dr=dr+baseamount;
                 	   }
                 }
                 else{
                	 if(!isNaN(baseamount)){
                   	  	cr=cr+baseamount;
                 	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 cr=cr+baseamount;
                 	   }
                 }
                 
                 if(toamount == ""){
                  	 toamount=0.00;
                  	 dr1=parseFloat(dr) + parseFloat(toamount);
                  	 funRoundAmt(dr1,"txtdrtotal");
                   }
                   
                   if(fromamount == ""){
                  	 fromamount=0.00;
                  	 cr1=parseFloat(cr) + parseFloat(fromamount); 
                  	 funRoundAmt(cr1,"txtcrtotal");
                   }
                   
                   if(!isNaN(toamount)){
                  	 dr1=parseFloat(dr) + parseFloat(toamount);
                  	 funRoundAmt(dr1,"txtdrtotal");
                  	 }
                   
                   if(!isNaN(fromamount)){
                       cr1=parseFloat(cr) + parseFloat(fromamount);
                       funRoundAmt(cr1,"txtcrtotal");
                       }
           	         }
           		 }
           		 
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
         		if(datafield=="type"){
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#jqxIbBankPayment").on('cellvaluechanged', function (event) {
           	   	var rowindexestemp = event.args.rowindex;
           	  	 $('#rowindex').val(rowindexestemp);
           	   
        		var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', rowindexestemp, "type");
       			$('#type').val(value);
              });
            
           $('#jqxIbBankPayment').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 5)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', rowindextemp, "type");
        		    BankSearchContent('ibBankPaymentSearch.jsp?atype='+value);
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
		           var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxIbBankPayment').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbBankPayment");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 12)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxIbBankPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxIbBankPayment').jqxGrid('clearselection');
		           var value = $('#jqxIbBankPayment').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbBankPayment&costtype="+value);
		           }
              } 
	           
	           if(event.args.columnindex == 0)
	      		  {
	      			var rowindexestemp = event.args.rowindex;
	      			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
	      			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "brhid" ,'');
	      			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "branch" ,'');
	      			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
	     			$('#jqxIbBankPayment').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
	                } 
            }); 
          
        });
    </script>
    <div id="jqxIbBankPayment"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/>