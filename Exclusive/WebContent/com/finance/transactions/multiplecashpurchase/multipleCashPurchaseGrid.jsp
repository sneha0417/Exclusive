<%@page import="com.finance.transactions.multiplecashpurchase.ClsmultipleCashPurchaseDAO"%>
<% ClsmultipleCashPurchaseDAO DAO= new ClsmultipleCashPurchaseDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtpettycashdocno2")==null?"0":request.getParameter("txtpettycashdocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 

<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
          
            var temp='<%=docNo%>';
             
             if(temp>0){  
            	 data1='<%=DAO.multipleCashPurchaseGridReloading(session,docNo,check)%>';       
           	 }
             
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
         	var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'docno', type: 'int' },
                            {name : 'vendor', type: 'string' },
                            {name : 'tinno', type: 'string' },
                            {name : 'invno', type: 'string' },
                            {name : 'invdate', type: 'date' },
                            {name : 'tax', type: 'string' },
                            {name : 'srvtaxper', type: 'number' },
                            
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'currency', type: 'string'   },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number' },
     						{name : 'costtype', type: 'string'  },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number'  },
     						{name : 'amount1', type: 'number' },
     						{name : 'taxamt', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'rowno', type: 'int'  },
     						{name : 'vendorid', type: 'number'  },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'hidinvdate', type: 'string' },
     						{name : 'trno', type: 'string' },
     						{name : 'psrno', type: 'string' },
     						{name : 'qty', type: 'number' },
     						{name : 'unitprice', type: 'number' },
     						//{name : 'tax', type: 'string'   }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AP', 'AR', 'GL', 'HR'];
            
            $("#jqxMultipleCashPurchase").jqxGrid(
            {
                width: '99.5%',
                height: 350,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxMultipleCashPurchase').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	McpSearchContent('multipleCashPurchaseSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxMultipleCashPurchase').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxMultipleCashPurchase");
                        	 $('#jqxMultipleCashPurchase').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#jqxMultipleCashPurchase').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxMultipleCashPurchase&costtype="+value);
    	                	   $('#jqxMultipleCashPurchase').jqxGrid('render');
    	        	           }
    	                   }
    	               }
                },
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', hidden: true, datafield: 'docno',  width: '5%' },
							
							{ text: 'Vendor', datafield: 'vendor',  editable: false, width: '7%' },
							{ text: 'Tin No', datafield: 'tinno',  editable: false, width: '5%' },
							{ text: 'Inv No', datafield: 'invno',  editable: true, width: '4%' },
			                { text: 'Inv Date', datafield: 'invdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%',
								  cellbeginedit: function (row) {
								    var temp=document.getElementById("mode").value;
								    if (temp =="view"){
								          return false;
								     }
								   }	
							},
			            

							{ text: 'tax', datafield: 'tax',  editable: false, width: '7%', hidden:true },
							
                            { text: 'Type', datafield: 'type', width: '3%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '4%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '15%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', editable: true, width: '2%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Qty', datafield: 'qty', width: '5%' },
							{ text: 'Unit Price', datafield: 'unitprice', cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '5%',editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tax %', datafield: 'srvtaxper', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d2' , width: '5%' },
							{ text: 'Tax Amount', datafield: 'taxamt', editable: false, cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Total', datafield: 'total', editable: false, cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Vendorid',datafield:'vendorid',width:'12%',editable:false,hidden:true},
							{ text: 'rowno',datafield:'rowno',width:'12%',editable:false,hidden:true},
							{ text: 'Hid-Inv-Date', datafield: 'hidinvdate', editable: false, hidden: true,  width: '10%' },
							//{ text: 'dtype',datafield:'dtype',width:'12%',editable:false,hidden:true},
							{ text: 'PSRNO', datafield: 'psrno', width: '5%',hidden:true },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#jqxMultipleCashPurchase").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
          	 }
         	  
            if(temp>0){
            	$("#jqxMultipleCashPurchase").jqxGrid('disabled', true);
            }
            
         	  $("#jqxMultipleCashPurchase").on('cellvaluechanged', function (event) 
         	  {         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
          		 if(datafield=="qty" || datafield=="unitprice"){
          		 
          		 var qty=  $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "qty");
          		 
          		 var uprice=  $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "unitprice");
          		 
          		 var amnt=parseFloat(qty)*parseFloat(uprice);
          		 
          		  $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,amnt);
          		 
          		 }
         		 if(datafield=="amount1" || datafield=="rate" || datafield=="srvtaxper"){

                 var taxper= $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "srvtaxper");
         		 var value1= $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "amount1"); 
                 var rate= $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "rate");
                 //alert(taxper+"==="+rate+"===="+value1);
                 var type= $("#jqxMultipleCashPurchase").jqxGrid('getcellvalue', rowindexestemp, "currencytype");
                 
                
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 var intrst = parseFloat(value1)*(parseFloat(taxper)/100);
                 var total1 = value1+intrst;
                
	                	 $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "taxamt" ,intrst);
	                	 $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "total" ,total1);
	               
	               
                var totalbase=$('#jqxMultipleCashPurchase').jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
                //alert(totalbase);
                totalbase1=parseFloat(totalbase.sum.replace(',','')).toFixed(2);
          		//var totalbase2= totalbase1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                document.getElementById("txtbaseamount").value=totalbase1;
                
                rate = $('#txtrate').val(); 
	            baseamount = totalbase1;
	            //alert(rate);
		    	currencytype = $('#hidcurrencytype').val().trim();
		    	
			    	if(!isNaN(totalbase1)){
					    //if(currencytype=="M"){
						    	//var result = parseFloat(baseamount) / parseFloat(rate);
						    	//funRoundAmt(result,"txtamount");
					    	//}else{
						    	var result = parseFloat(baseamount) * parseFloat(rate);
								funRoundAmt(result,"txtamount");
					    	//}
			    	}else if(isNaN(totalbase1)){
				    		 $('#txtbaseamount').val(0.00);
					    	 $('#txtamount').val(0.00);
				    	 
				    }
				     
				      
         		}
         		
         		 if(datafield=="invdate")
	        {
	            var issdate = $('#jqxMultipleCashPurchase').jqxGrid('getcelltext', rowindexestemp, "invdate");
	            $('#jqxMultipleCashPurchase').jqxGrid('setcellvalue',rowindexestemp, "hidinvdate",issdate);
	         } 
         		if(datafield=="type"){
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#jqxMultipleCashPurchase").on('cellvaluechanged', function (event) {
           	   var rowindexestemp = event.args.rowindex;
           	   $('#rowindex').val(rowindexestemp);
           	   
        		var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindexestemp, "type");
       			$('#type').val(value);
              });
         	 
           $('#jqxMultipleCashPurchase').on('celldoubleclick', function (event) {
           
        		if(event.args.datafield=="description")
            	   {
            		 var rowindextemp = event.args.rowindex;
                     document.getElementById("prdsetrowno").value = rowindextemp;
            		getproductdetails();
            	   }   
             if(event.args.columnindex == 2)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
                    var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindextemp, "type");
                    // alert(rowindextemp);
        		    VendorSearchContent('vendorsearch.jsp?rowindex='+rowindextemp);
                  }
           
           
        	  if(event.args.columnindex == 8)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindextemp, "type");
        		    McpSearchContent('multipleCashPurchaseSearch.jsp?atype='+value);
        		    //accountSearchContent(<%=contextPath+"/"%>+"com/finance/transactions/multiplecashpurchase/accountsDetailsSearch.jsp?atype="+value);
                  } 
        	  
        	  if(event.args.columnindex == 13){
        	       
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#jqxMultipleCashPurchase').jqxGrid('clearselection');
    	           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxMultipleCashPurchase");
    	           
    	          }
               
                } 
                
                
                if(event.args.columnindex == 15){
        	        
        	       //alert(777);
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           var cell3 = $('#jqxMultipleCashPurchase').jqxGrid('getselectedcell');
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           //alert(999);
    	           $('#jqxMultipleCashPurchase').jqxGrid('clearselection');
    	           var value1=  $('#jqxMultipleCashPurchase').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	           //alert(value1);
    	           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxMultipleCashPurchase&costtype="+value1);
    	           
    	          }
               
                } 
        		
        		
               if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "taxamt" ,'0.00');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   			$('#jqxMultipleCashPurchase').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
               }
               
            }); 
        });
    
</script>
<div id="jqxMultipleCashPurchase"></div>
    
<input type="hidden" id="rowindex"/>
<input type="hidden" id="type"/>  