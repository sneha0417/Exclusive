<%@page import="com.finance.transactions.pettycash.ClsPettyCashDAO"%>
<% ClsPettyCashDAO DAO= new ClsPettyCashDAO(); %>
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
            	 data1='<%=DAO.pettyCashGridReloading(session,docNo,check)%>';     
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
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string'   },
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
            var list = ['AP', 'AR', 'GL', 'HR'];
            
            $("#jqxPettyCash").jqxGrid(
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
                    var cell1 = $('#jqxPettyCash').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxPettyCash').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	PettyCashSearchContent('pettyCashSearch.jsp?atype='+value); 
                          }
                    }
                    
                    var cell2 = $('#jqxPettyCash').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxPettyCash').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxPettyCash");
                        	 $('#jqxPettyCash').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#jqxPettyCash').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxPettyCash').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxPettyCash').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxPettyCash&costtype="+value);
    	                	   $('#jqxPettyCash').jqxGrid('render');
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
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '25%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
          	 }
         	  
            if(temp>0){
            	$("#jqxPettyCash").jqxGrid('disabled', true);
            }
            
         	  $("#jqxPettyCash").on('cellvaluechanged', function (event) 
         	  {         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
          		
         		 if(datafield=="amount1" || datafield=="rate"){

         		 var value1= $("#jqxPettyCash").jqxGrid('getcellvalue', rowindexestemp, "amount1"); 
                 var rate= $("#jqxPettyCash").jqxGrid('getcellvalue', rowindexestemp, "rate");
                 var type= $("#jqxPettyCash").jqxGrid('getcellvalue', rowindexestemp, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 
                 if(isNaN(baseamount)){
	              	   $('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,"0.00");
	              	   $('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,"0.00");
	                  }
	                 
	               if(!isNaN(baseamount)){
	                	 $('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,baseamount);
	               }
	               
                var totalbase=$('#jqxPettyCash').jqxGrid('getcolumnaggregateddata', 'baseamount1', ['sum'], true);
                totalbase1=totalbase.sum;
          		var totalbase2= totalbase1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                document.getElementById("txtbaseamount").value=totalbase2;
                
                rate = $('#txtrate').val(); 
	            baseamount = totalbase2;
		    	currencytype = $('#hidcurrencytype').val().trim();
		    	
			    	if(!isNaN(baseamount)){
					    if(currencytype=="M"){
						    	var result = parseFloat(baseamount) / parseFloat(rate);
						    	funRoundAmt(result,"txtamount");
					    	}else{
						    	var result = parseFloat(baseamount) * parseFloat(rate);
								funRoundAmt(result,"txtamount");
					    	}
			    	}else if(isNaN(baseamount)){
				    		 $('#txtbaseamount').val(0.00);
					    	 $('#txtamount').val(0.00);
				    	 
				    }
         		}
         		 
         		if(datafield=="type"){
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#jqxPettyCash").on('cellvaluechanged', function (event) {
           	   var rowindexestemp = event.args.rowindex;
           	   $('#rowindex').val(rowindexestemp);
           	   
        		var value = $('#jqxPettyCash').jqxGrid('getcellvalue', rowindexestemp, "type");
       			$('#type').val(value);
              });
         	 
           $('#jqxPettyCash').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 3)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxPettyCash').jqxGrid('getcellvalue', rowindextemp, "type");
        		    PettyCashSearchContent('pettyCashSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 8){
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxPettyCash').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#jqxPettyCash').jqxGrid('clearselection');
    	           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxPettyCash");
    	           }
                } 
        		  
               if(event.args.columnindex == 10){
    	           var rowindextemp = event.args.rowindex;
    	           var value1 = $('#jqxPettyCash').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value1==4 || value1==5){
    	           $('#jqxPettyCash').jqxGrid('clearselection');
    	           var value = $('#jqxPettyCash').jqxGrid('getcellvalue', rowindextemp, "costtype");
    	           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxPettyCash&costtype="+value);
    	           }
                } 
               
               if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   			$('#jqxPettyCash').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
               }
               
            }); 
          
        });
    
</script>
<div id="jqxPettyCash"></div>
    
<input type="hidden" id="rowindex"/>
<input type="hidden" id="type"/>  