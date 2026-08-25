<%@page import="com.finance.transactions.cashpayment.ClsCashPaymentDAO"%>
<% ClsCashPaymentDAO DAO= new ClsCashPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtcashpaydocno2")==null?"0":request.getParameter("txtcashpaydocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0){   
            	 data1='<%=DAO.cashPaymentGridReloading(session,docNo,check)%>';     
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
     						{name : 'currency', type: 'string'   },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number' },
     						{name : 'costtype', type: 'string'  },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number'  },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number' },
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
            
            $("#jqxCashPayment").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxCashPayment').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxCashPayment').jqxGrid('getcellvalue', cell1.rowindex, "type");
                  	    	CashSearchContent('cashPaymentSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxCashPayment').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxCashPayment').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxCashPayment");
                        	 $('#jqxCashPayment').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#jqxCashPayment').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxCashPayment').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxCashPayment').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxCashPayment&costtype="+value);
    	                	   $('#jqxCashPayment').jqxGrid('render');
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
                            { text: 'Type', datafield: 'type', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', editable: true, width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false},
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '22%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Currency Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' }
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#jqxCashPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	 }
         	  
            if(temp>0){
            	$("#jqxCashPayment").jqxGrid('disabled', true);
            }
            
         	  $("#jqxCashPayment").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
          		 if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
          			 
	         		 var fromamount=document.getElementById("txtfrombaseamount").value;
	         		 var toamount=document.getElementById("txttobaseamount").value;
	         		
	         	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
	         	    var rows = $('#jqxCashPayment').jqxGrid('getrows');
	         	    var rowlength= rows.length;
	         		for(i=0;i<=rowlength-1;i++)
	         		{
	         		 var value = $('#jqxCashPayment').jqxGrid('getcellvalue', i, "dr");
	                 var value1= $("#jqxCashPayment").jqxGrid('getcellvalue', i, "amount1"); 
	                 var rate= $("#jqxCashPayment").jqxGrid('getcellvalue', i, "rate");
	                 var type= $("#jqxCashPayment").jqxGrid('getcellvalue', i, "currencytype");
	                 
	                 var baseamount = getBaseAmountInGrid(value1,rate,type);
	                 
	                 if(isNaN(baseamount)){
	              	   $('#jqxCashPayment').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
	              	   $('#jqxCashPayment').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
	                  }
	                 
	                 if(!isNaN(baseamount)){
	              	   $('#jqxCashPayment').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
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
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
           $('#jqxCashPayment').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 3)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxCashPayment').jqxGrid('getcellvalue', rowindextemp, "type");
                    CashSearchContent('cashPaymentSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 8){
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxCashPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#jqxCashPayment').jqxGrid('clearselection');
    	           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxCashPayment");
    	           }
                } 
        		  
               if(event.args.columnindex == 10){
    	           var rowindextemp = event.args.rowindex;
    	           var value1 = $('#jqxCashPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value1==4 || value1==5){
    	           $('#jqxCashPayment').jqxGrid('clearselection');
    	           var value = $('#jqxCashPayment').jqxGrid('getcellvalue', rowindextemp, "costtype");
    	           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxCashPayment&costtype="+value);
    	           }
                } 
               
               if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
               }
            });
           
           $("#jqxCashPayment").on('cellvaluechanged', function (event) {
        	   var rowindexestemp = event.args.rowindex;
        	   $('#rowindex').val(rowindexestemp);
        	   
     		   var value = $('#jqxCashPayment').jqxGrid('getcellvalue', rowindexestemp, "type");
    			$('#type').val(value);
           });
          
        });
    </script>
    <div id="jqxCashPayment"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/>  