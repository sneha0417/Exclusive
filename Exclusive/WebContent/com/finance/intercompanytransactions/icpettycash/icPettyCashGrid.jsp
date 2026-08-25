<%@page import="com.finance.intercompanytransactions.icpettycash.ClsIcPettyCashDAO"%>
<% ClsIcPettyCashDAO DAO= new ClsIcPettyCashDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txticpettycashdocno2")==null?"0":request.getParameter("txticpettycashdocno2");
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
                            {name : 'compbranch', type: 'string' },
                            {name : 'intrcompid', type: 'int' },
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
     						{name : 'currencytype', type: 'string'   },
     						{name : 'intrbrhid', type: 'int' },
     						{name : 'dbname', type: 'string' }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AP', 'AR', 'GL', 'HR'];
            
            $("#icPettyCashGridID").jqxGrid(
            {
                width: '99%',
                height: 350,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                selectionmode: 'singlecell',
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cells1 = $('#icPettyCashGridID').jqxGrid('getselectedcell');
                    if (cells1 != undefined && cells1.datafield == 'compbranch') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	BranchSearchContent('interCompanyBranchSearchGrid.jsp');
                          }
                    }
                    
                    var cell1 = $('#icPettyCashGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell1.rowindex, "dbname");
                        	icPettyCashSearchContent('icPettyCashSearch.jsp?atype='+value+'&dbname='+dbnamevalue); 
                          }
                    }
                    
                    var cell2 = $('#icPettyCashGridID').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                    		var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell2.rowindex, "dbname");
                        	costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
                        	 $('#icPettyCashGridID').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#icPettyCashGridID').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#icPettyCashGridID').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', cell3.rowindex, "dbname");
    	                	   costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
    	                	   $('#icPettyCashGridID').jqxGrid('render');
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
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '14%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', editable: true, width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '6%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '20%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Intr brhid', datafield: 'intrbrhid', hidden: true, editable: false, width: '10%' },
							{ text: 'Database', hidden: true, datafield: 'dbname', editable: false, width: '10%' },
						]
            });
            
            //Add empty row
            if(temp==0){   
         	   $("#icPettyCashGridID").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
          	 }
         	  
            if(temp>0){
            	$("#icPettyCashGridID").jqxGrid('disabled', true);
            }
            
         	  $("#icPettyCashGridID").on('cellvaluechanged', function (event) 
         	  {         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
          		
         		 if(datafield=="amount1" || datafield=="rate"){

         		 var value1= $("#icPettyCashGridID").jqxGrid('getcellvalue', rowindexestemp, "amount1"); 
                 var rate= $("#icPettyCashGridID").jqxGrid('getcellvalue', rowindexestemp, "rate");
                 var type= $("#icPettyCashGridID").jqxGrid('getcellvalue', rowindexestemp, "currencytype");
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 
                 if(isNaN(baseamount)){
	              	   $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,"0.00");
	              	   $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,"0.00");
	                  }
	                 
	               if(!isNaN(baseamount)){
	                	 $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,baseamount);
	               }
	               
                var totalbase=$('#icPettyCashGridID').jqxGrid('getcolumnaggregateddata', 'baseamount1', ['sum'], true);
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
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#icPettyCashGridID").on('cellvaluechanged', function (event) {
           	   var rowindexestemp = event.args.rowindex;
           	   $('#rowindex').val(rowindexestemp);
           	   
        		var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindexestemp, "type");
       			$('#type').val(value);
              });
         	 
           $('#icPettyCashGridID').on('celldoubleclick', function (event) {
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
        		    var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "type");
        		    var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
        		    icPettyCashSearchContent('icPettyCashSearch.jsp?atype='+value+'&dbname='+dbnamevalue);
                  } 
        	  
        	  if(event.args.columnindex == 10){
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#icPettyCashGridID').jqxGrid('clearselection');
    	           var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
    	           costTypeSearchContent('costTypeSearchGrid.jsp?dbname='+dbnamevalue);
    	           }
                } 
        		  
               if(event.args.columnindex == 12){
    	           var rowindextemp = event.args.rowindex;
    	           var value1 = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value1==4 || value1==5){
    	           $('#icPettyCashGridID').jqxGrid('clearselection');
    	           var value = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "costtype");
    	           var dbnamevalue = $('#icPettyCashGridID').jqxGrid('getcellvalue', rowindextemp, "dbname");
    	           costCodeSearchContent('costCodeSearchGrid.jsp?costtype='+value+"&dbname="+dbnamevalue);
    	           }
                } 
               
               if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "intrcompid" ,'');
      			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "compbranch" ,'');
     			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   			$('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   		    $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "dbname" ,'');
 	   		    $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindexestemp, "intrbrhid" ,'');
               }
               
            }); 
          
        });
    
</script>
<div id="icPettyCashGridID"></div>
    
<input type="hidden" id="rowindex"/>
<input type="hidden" id="type"/>  