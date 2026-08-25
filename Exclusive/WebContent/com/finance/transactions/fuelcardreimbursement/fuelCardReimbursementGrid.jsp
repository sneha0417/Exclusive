<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.transactions.fuelcardreimbursement.ClsFuelCardReimbursementDAO"%>
<%ClsFuelCardReimbursementDAO DAO= new ClsFuelCardReimbursementDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtfuelcardreimbursementdocno2")==null?"0":request.getParameter("txtfuelcardreimbursementdocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0){   
            	 data1='<%=DAO.fuelcardreimbursementGridReloading(session,docNo,check)%>';     
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
     						{name : 'costtype', type: 'string'  },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number'  },
							{name : 'reg_no', type: 'string'  },
     						{name : 'amount1', type: 'number' },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string'   }
                        ],
                         localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxFuelCardReimbursement").jqxGrid(
            {
                width: '90%',
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
                    var cell1 = $('#jqxFuelCardReimbursement').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	if (key == 114) { 
                        	 costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxFuelCardReimbursement");
                        	 $('#jqxFuelCardReimbursement').jqxGrid('render');
             	           }
                    	}
                        
                    var cell2 = $('#jqxFuelCardReimbursement').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxFuelCardReimbursement').jqxGrid('getcellvalue', cell2.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxFuelCardReimbursement&costtype="+value);
    	                	   $('#jqxFuelCardReimbursement').jqxGrid('render');
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
							{ text: 'Cost Type', datafield: 'costgroup', width: '10%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '10%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '10%',editable: false },
							{ text: 'Reg. No.', datafield: 'reg_no', width: '10%',editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '12%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '12%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '41%' },
						]
            });
            
            if(temp==0){   
         	   $("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","amount1": "","baseamount1": "","description": ""});
          	 }
         	  
            if(temp>0){
            	$("#jqxFuelCardReimbursement").jqxGrid('disabled', true);
            }
            
         	  $("#jqxFuelCardReimbursement").on('cellvaluechanged', function (event) 
         	  {         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
          		
         		 if(datafield=="amount1"){

         		 var rate = $('#txtrate').val();
         		 var value1= $("#jqxFuelCardReimbursement").jqxGrid('getcellvalue', rowindexestemp, "amount1"); 
                 var type= $('#hidcurrencytype').val().trim();
                 
                 var baseamount = getBaseAmountInGrid(value1,rate,type);
                 
                 if(isNaN(baseamount)){
	              	   $('#jqxFuelCardReimbursement').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,"0.00");
	              	   $('#jqxFuelCardReimbursement').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,"0.00");
	                  }
	                 
	               if(!isNaN(baseamount)){
	                	 $('#jqxFuelCardReimbursement').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,baseamount);
	               }
	               
                var totalbase=$('#jqxFuelCardReimbursement').jqxGrid('getcolumnaggregateddata', 'baseamount1', ['sum'], true);
                totalbase1=totalbase.sum;
          		var totalbase2= totalbase1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                document.getElementById("txtbaseamount").value=totalbase2;
                
                
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
         		
         		if(datafield=="costtype"){
         			$('#jqxFuelCardReimbursement').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	 
           $('#jqxFuelCardReimbursement').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 1){
    	           var rowindextemp = event.args.rowindex;
    	           document.getElementById("rowindex").value = rowindextemp;
    	           $('#jqxFuelCardReimbursement').jqxGrid('clearselection');
    	           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxFuelCardReimbursement");
                } 
        		  
               if(event.args.columnindex == 3){
    	           var rowindextemp = event.args.rowindex;
    	           document.getElementById("rowindex").value = rowindextemp;
    	           $('#jqxFuelCardReimbursement').jqxGrid('clearselection');
    	           var value = $('#jqxFuelCardReimbursement').jqxGrid('getcellvalue', rowindextemp, "costtype");
    	           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxFuelCardReimbursement&costtype="+value);
                } 
               
            }); 
          
        });
    </script>
    <div id="jqxFuelCardReimbursement"></div>
    
 <input type="hidden" id="rowindex"/>