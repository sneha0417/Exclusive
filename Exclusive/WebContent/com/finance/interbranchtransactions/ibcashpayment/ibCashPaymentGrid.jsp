<%@page import="com.finance.interbranchtransactions.ibcashpayment.ClsIbCashPaymentDAO" %>
<%  ClsIbCashPaymentDAO DAO=new ClsIbCashPaymentDAO(); %>
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
            	   data1='<%=DAO.ibCashPaymentGridReloading(session,docNo, check)%>';      
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
            
            $("#jqxIbCashPayment").jqxGrid(
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
                    var cell1 = $('#jqxIbCashPayment').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'branch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	BranchSearchContent('branchSearchGrid.jsp');
                          }
                    }
                    
                    //Search Pop-Up
                    var cell1 = $('#jqxIbCashPayment').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	CashSearchContent('ibCashPaymentSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxIbCashPayment').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
                    	var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
                    	if(value==4 || value==5){
                        if (key == 114) {  
                        	 costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbCashPayment");
                        	 $('#jqxIbCashPayment').jqxGrid('render');
                            }
                          }
                    	}
                        
                    var cell3 = $('#jqxIbCashPayment').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxIbCashPayment').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
            	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxIbCashPayment').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbCashPayment&costtype="+value);
    	                	   $('#jqxIbCashPayment').jqxGrid('render');
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
							{ text: 'Rate', datafield: 'rate', editable: true, width: '4%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '6%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Currency Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
            	 $("#jqxIbCashPayment").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	 }
            
            if(temp>0){
            	$("#jqxIbCashPayment").jqxGrid('disabled', true);
            }
         	  
         	  $("#jqxIbCashPayment").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
          		 if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
          			 
         		 var fromamount=document.getElementById("txtfrombaseamount").value;
         		 var toamount=document.getElementById("txttobaseamount").value;
         		
         	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
         	    var rows = $('#jqxIbCashPayment').jqxGrid('getrows');
             	var rowlength= rows.length;
         		for(i=0;i<=rowlength-1;i++)
         		{
         		 var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', i, "dr");
                 var value1= $("#jqxIbCashPayment").jqxGrid('getcellvalue', i, "amount1"); 
                 var rate= $("#jqxIbCashPayment").jqxGrid('getcellvalue', i, "rate");
                 var type= $("#jqxIbCashPayment").jqxGrid('getcellvalue', i, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);

                 if(isNaN(baseamount)){
	              	   $('#jqxIbCashPayment').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
	              	   $('#jqxIbCashPayment').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
	                  }
	                 
	                 if(!isNaN(baseamount)){
	              	   $('#jqxIbCashPayment').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
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
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
        });
             
         	 $("#jqxIbCashPayment").on('cellvaluechanged', function (event) {
         	   	var rowindexestemp = event.args.rowindex;
         	  	 $('#rowindex').val(rowindexestemp);
         	   
      		    var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', rowindexestemp, "type");
     			$('#type').val(value);
            });
            
           $('#jqxIbCashPayment').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 5)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', rowindextemp, "type");
                    CashSearchContent('ibCashPaymentSearch.jsp?atype='+value);
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
		           var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxIbCashPayment').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxIbCashPayment");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 12)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxIbCashPayment').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxIbCashPayment').jqxGrid('clearselection');
		           var value = $('#jqxIbCashPayment').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxIbCashPayment&costtype="+value);
		           }
               } 
	           
	           if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "branch" ,'');	
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "brhid" ,'');
     			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#jqxIbCashPayment').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxCashPayment').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
               }
            }); 
          
        });
    </script>
    <div id="jqxIbCashPayment"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/>