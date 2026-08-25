<%@page import="com.finance.transactions.debitnote.ClsDebitNoteDAO"%>
<% ClsDebitNoteDAO DAO= new ClsDebitNoteDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtdebitnotedocno2")==null?"0":request.getParameter("txtdebitnotedocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0)
           	 {   
            	 data1='<%=DAO.debitNoteGridReloading(session,docNo,check)%>';
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
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number' },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'currencytype', type: 'string'   }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['GL', 'HR','AP','AR'];
            
            $("#jqxDebitNote").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                   
                    //Search Pop-Up
                    var cell1 = $('#jqxDebitNote').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxDebitNote').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	DebitSearchContent('debitNoteSearch.jsp?atype='+value);
                          }
                    }
                    
                    var cell2 = $('#jqxDebitNote').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxDebitNote').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                        if (key == 114) {  
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxDebitNote");
                        	 $('#jqxDebitNote').jqxGrid('render');
                            }
                          }
                    	}
                        
                    var cell3 = $('#jqxDebitNote').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0;
    	                   var value1 = $('#jqxDebitNote').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxDebitNote').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxDebitNote&costtype="+value);
    	                	   $('#jqxDebitNote').jqxGrid('render');
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
							{ text: 'Rate', datafield: 'rate', editable: true, cellsformat: 'd2', width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Cr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '22%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#jqxDebitNote").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","sr_no":"","currencytype": ""});
         	 }
            
            if(temp>0){
            	$("#jqxDebitNote").jqxGrid('disabled', true);
          	 }
         	  
         	  $("#jqxDebitNote").on('cellvaluechanged', function (event) 
         	  {
         		 var datafield = event.args.datafield;
          		 if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
          			 
         		 var amount=document.getElementById("txtbaseamount").value;
         		
         	     var dr=0.0,cr=0.0,dr1=0.0;
         	     var rows = $('#jqxDebitNote').jqxGrid('getrows');
         	     var rowlength= rows.length;
         		 for(i=0;i<=rowlength-1;i++)
         		 {
         		 var value = $('#jqxDebitNote').jqxGrid('getcellvalue', i, "dr");
                 var value1= $("#jqxDebitNote").jqxGrid('getcellvalue', i, "amount1"); 
                 var rate= $("#jqxDebitNote").jqxGrid('getcellvalue', i, "rate");
                 var type= $("#jqxDebitNote").jqxGrid('getcellvalue', i, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                
                 if(isNaN(baseamount)){
	              	   $('#jqxDebitNote').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
	              	   $('#jqxDebitNote').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
	              }
	                 
	              if(!isNaN(baseamount)){
	              	   $('#jqxDebitNote').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
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
                 
                  funRoundAmt(cr,"txtcrtotal");
                  
                  if(amount == ""){
                      amount=0.00;
                      dr1=parseFloat(dr) + parseFloat(amount); 
                 	  funRoundAmt(dr1,"txtdrtotal");
                     }
                  
                  if(!isNaN(amount)){
                	 dr1=parseFloat(dr) + parseFloat(amount); 
                	 funRoundAmt(dr1,"txtdrtotal");
                   }
         	      }
          		 }
         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
         		if(datafield=="type"){
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
        });
         	  
         	 $("#jqxDebitNote").on('cellvaluechanged', function (event) {
             	   var rowindexestemp = event.args.rowindex;
             	   $('#rowindex').val(rowindexestemp);
             	   
          		var value = $('#jqxDebitNote').jqxGrid('getcellvalue', rowindexestemp, "type");
         			$('#type').val(value);
                });
            
           $('#jqxDebitNote').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 3){
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxDebitNote').jqxGrid('getcellvalue', rowindextemp, "type");
        		    DebitSearchContent('debitNoteSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 8){
		           var rowindextemp = event.args.rowindex;
		           var value = $('#jqxDebitNote').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxDebitNote').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxDebitNote");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 10){
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxDebitNote').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxDebitNote').jqxGrid('clearselection');
		           var value = $('#jqxDebitNote').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxDebitNote&costtype="+value);
		           }
                }
	           
	           if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxDebitNote').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
               }
	           
            }); 
           
        });
    </script>
    <div id="jqxDebitNote"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/> 