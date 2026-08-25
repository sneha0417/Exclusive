<%@page import="com.finance.intercompanytransactions.icbankpayment.ClsIcBankPaymentDAO"%>
<% ClsIcBankPaymentDAO DAO= new ClsIcBankPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txticcashpaydocno2")==null?"0":request.getParameter("txticcashpaydocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 

        	var temp='<%=docNo%>';
             
             if(temp>0){   
            	 data1='<%=DAO.icbankpaymentGridReloading(session,docNo,check)%>';
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
     						{name : 'accounts', type: 'string' },
     						{name : 'accountname1', type: 'string' },
     						{name : 'currency', type: 'string' },
     						{name : 'currencyid', type: 'int' },
     						{name : 'rate', type: 'number' },
     						{name : 'costtype', type: 'string'  },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number'  },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number' },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'grtype', type: 'int'  },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'sr_no', type: 'int' },
     						{name : 'intrbrhid', type: 'int' },
     						{name : 'dbname', type: 'string' }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AR', 'AP', 'GL', 'HR'];
            
            $("#icBankPaymentGridId").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cells1 = $('#icBankPaymentGridId').jqxGrid('getselectedcell');
                    if (cells1 != undefined && cells1.datafield == 'compbranch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	BranchSearchContent('interCompanyBranchSearchGrid.jsp');
                          }
                    }
                    
                    var cell1 = $('#icBankPaymentGridId').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell1.rowindex, "dbname");
                        	BankSearchContent('icBankPaymentSearch.jsp?atype='+value+'&dbname='+dbnamevalue); 
                          }
                    }
                    
                    var cell2 = $('#icBankPaymentGridId').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
                    	var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                        if (key == 114) {  
                        	var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell2.rowindex, "dbname");
                        	costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
                        	 $('#icBankPaymentGridId').jqxGrid('render');
                          }
                    	}
                    }
    	               
                    var cell3 = $('#icBankPaymentGridId').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', cell3.rowindex, "dbname");
    	                	   costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
    	                	   $('#icBankPaymentGridId').jqxGrid('render');
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
							{ text: 'Company / Branch', datafield: 'compbranch',  editable: false, width: '14%' },
                            { text: 'Inter-Company Id', hidden: true, datafield: 'intrcompid', editable: false, width: '10%' },
							{ text: 'Type', datafield: 'type', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '13%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '4%' },
							{ text: 'Rate', datafield: 'rate', editable: true, cellsformat: 'd2', width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '6%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '18%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Intr brhid', datafield: 'intrbrhid', hidden: true, editable: false, width: '10%' },
							{ text: 'Database', hidden: true, datafield: 'dbname', editable: false, width: '10%' }
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#icBankPaymentGridId").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
          	 }
            
            if(temp>0){
            	$("#icBankPaymentGridId").jqxGrid('disabled', true);
            }
         	  
         	  $("#icBankPaymentGridId").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
      		     if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
	         		 var fromamount=document.getElementById("txtfrombaseamount").value;
	         		
	         	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
	         	    var rows = $('#icBankPaymentGridId').jqxGrid('getrows');
	           	    var rowlength= rows.length;
	         		for(i=0;i<=rowlength-1;i++)
	         		{
	         		 var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', i, "dr");
	                 var value1= $("#icBankPaymentGridId").jqxGrid('getcellvalue', i, "amount1"); 
	                 var rate= $("#icBankPaymentGridId").jqxGrid('getcellvalue', i, "rate");
	                 var type= $("#icBankPaymentGridId").jqxGrid('getcellvalue', i, "currencytype");
	                 
	                 var baseamount = getBaseAmountInGrid(value1,rate,type);
	                 
	                 if(isNaN(baseamount)){
                  	    $('#icBankPaymentGridId').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
                  	    $('#icBankPaymentGridId').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
                       }
                     
                     if(!isNaN(baseamount)){
                  	     $('#icBankPaymentGridId').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
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
	                 
	                 if(fromamount == ""){
	                	 fromamount=0.00;
	                	 cr1=parseFloat(cr) + parseFloat(fromamount); 
	                	 funRoundAmt(cr1,"txtcrtotal");
	                 }
	                 
	                 if(!isNaN(dr)){
	                	 dr1=parseFloat(dr);
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
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#icBankPaymentGridId").on('cellvaluechanged', function (event) {
          	   var rowindexestemp = event.args.rowindex;
          	   $('#rowindex').val(rowindexestemp);
          	   
       		   var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindexestemp, "type");
      			$('#type').val(value);
             });
         	 
           $('#icBankPaymentGridId').on('celldoubleclick', function (event) {
        	   if(event.args.columnindex == 2)
	       		  {
	 		      	    var rowIndexTemp = event.args.rowindex;
	 		      	    document.getElementById("rowindex").value = rowIndexTemp;
	 		      	    BranchSearchContent('interCompanyBranchSearchGrid.jsp');
	       		  }
        	   
        	  if(event.args.columnindex == 5)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "type");
        		    var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "dbname");
                    BankSearchContent('icBankPaymentSearch.jsp?atype='+value+'&dbname='+dbnamevalue);
                  } 
        	  
        	  if(event.args.columnindex == 10){
   	           var rowindextemp = event.args.rowindex;
   	           var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "grtype");
   	           document.getElementById("rowindex").value = rowindextemp;
   	           if(value==4 || value==5){
   	           $('#icBankPaymentGridId').jqxGrid('clearselection');
 	           var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "dbname");
 	           costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
               } 
        	  }
       		  
              if(event.args.columnindex == 12){
   	           var rowindextemp = event.args.rowindex;
   	           var value1 = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "grtype");
   	           document.getElementById("rowindex").value = rowindextemp;
   	           if(value1==4 || value1==5){
   	           $('#icBankPaymentGridId').jqxGrid('clearselection');
 	           var value = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "costtype");
 	           var dbnamevalue = $('#icBankPaymentGridId').jqxGrid('getcellvalue', rowindextemp, "dbname");
 	           costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
               }
              }
              
              if(event.args.columnindex == 0)
    		  {
    			var rowindexestemp = event.args.rowindex;
    			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
    			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "intrcompid" ,'');
      			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "compbranch" ,'');
    			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
	   			$('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "dbname" ,'');
 	   		    $('#icBankPaymentGridId').jqxGrid('setcellvalue', rowindexestemp, "intrbrhid" ,'');
              }
              
            }); 
          
        });
    </script>
    <div id="icBankPaymentGridId"></div>
    
 <input type="hidden" id="rowindex"/>
 <input type="hidden" id="type"/>  