<%@page import="com.finance.transactions.multiplechequepreparation.ClsMultipleChequePreparationDAO"%>
<% ClsMultipleChequePreparationDAO DAO= new ClsMultipleChequePreparationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtmultiplechequepreparationdocno2")==null?"0":request.getParameter("txtmultiplechequepreparationdocno2");
   String acno = request.getParameter("acno")==null?"0":request.getParameter("acno");
   String chequeStartDate = request.getParameter("chequestartdate")==null?"0":request.getParameter("chequestartdate");
   String chequeNo = request.getParameter("chequeno")==null?"0":request.getParameter("chequeno");
   String chequeDuration = request.getParameter("chequeduration")==null?"0":request.getParameter("chequeduration");
   String chequeFrequency = request.getParameter("chequefrequency")==null?"0":request.getParameter("chequefrequency");
   String noOfCheques = request.getParameter("noofcheques")==null?"0":request.getParameter("noofcheques");
   String description = request.getParameter("description")==null?"0":request.getParameter("description");
   String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
   String instAmount = request.getParameter("instamount")==null?"0":request.getParameter("instamount");
   String fillChequeDetails = request.getParameter("fillchequedetails")==null?"0":request.getParameter("fillchequedetails");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");%>  
<script type="text/javascript">
        
       	var data1; 
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
            var temp1='<%=fillChequeDetails%>';
             
             if(temp1>0){     
           	 	data1='<%=DAO.fillChequeDetailsGridLoading(acno,description,chequeStartDate,chequeNo,chequeFrequency,amount,noOfCheques,instAmount,chequeDuration,check)%>';      
          	 }
             
             if(temp>0){     
            	 data1='<%=DAO.multiChequePreparationGridReloading(session,docNo,check)%>';      
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
     						{name : 'rate', type: 'number'   },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number'  },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'chequeno', type: 'string'    },
							{name : 'chequedate', type: 'date'    },
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
            
            $("#chequeDetailsGridID").on("bindingcomplete", function (event) {
            	
            	 if(temp1>0 ||  temp>0){
	            	var debit1="";
	            	
	            	var debit=$('#chequeDetailsGridID').jqxGrid('getcolumnaggregateddata', 'baseamount1', ['sum'], true);
	       	        debit1=debit.sum;
		         	if(!(isNaN(debit1))){
		              	funRoundAmt(debit1,"txtdrtotal");
		         	} else if(isNaN(debit1)){
		             	 funRoundAmt(0.00,"txtdrtotal");
		         	}
            	 }
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#chequeDetailsGridID").jqxGrid(
            {
            	width: '99.5%',
                height: 280,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', datafield: 'docno',  hidden: true, width: '5%' },
                            { text: 'Type', datafield: 'type', width: '5%',  editable: false},
							{ text: 'Account', datafield: 'accounts',  editable: false,  width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', datafield: 'currencyid', hidden: true, editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', editable: true, width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: false, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', cellsformat: 'd2', editable: false, width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Cheque No', datafield: 'chequeno', width: '7%' },
							{ text: 'Cheque Date', datafield: 'chequedate', width: '7%', cellsformat: 'dd.MM.yyyy', columntype: 'datetimeinput' },
							{ text: 'Description', datafield: 'description', width: '22%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', datafield: 'currencytype', hidden: true, editable: false, width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' }
						]
            });
            
            //Add empty row
            if(temp==0){   
        	   $("#chequeDetailsGridID").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","dr": true,"amount1": "","baseamount1": "","chequeno": "","chequedate": "","description": "","grtype": "","currencytype": "","sr_no":""});
         	 }   
           
            if(temp>0){
            	$("#chequeDetailsGridID").jqxGrid('disabled', true);
            }
         	  
            $("#chequeDetailsGridID").on('cellvaluechanged', function (event) 
               	  {
            	
            	var datafield = event.args.datafield;
         		if(datafield=="dr" || datafield=="amount1" || datafield=="rate"){
               		 var fromamount=document.getElementById("txtfrombaseamount").value;
               		 var toamount=document.getElementById("txttobaseamount").value;
               		
               	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
               	    var rows = $('#chequeDetailsGridID').jqxGrid('getrows');
           	        var rowlength= rows.length;
               		for(i=0;i<=rowlength-1;i++)
               		{
               		   var value = $('#chequeDetailsGridID').jqxGrid('getcellvalue', i, "dr");
                       var value1= $("#chequeDetailsGridID").jqxGrid('getcellvalue', i, "amount1"); 
                       var rate= $("#chequeDetailsGridID").jqxGrid('getcellvalue', i, "rate");
                       var type= $("#chequeDetailsGridID").jqxGrid('getcellvalue', i, "currencytype");
                       
                       var baseamount = getBaseAmountInGrid(value1,rate,type);
                       
                       if(isNaN(baseamount)){
                    	   $('#chequeDetailsGridID').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
                    	   $('#chequeDetailsGridID').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
                           }
                       
                       if(!isNaN(baseamount)){
                    	   $('#chequeDetailsGridID').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
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
                       
                       if(!isNaN(toamount)){
                      	 dr1=parseFloat(dr) + parseFloat(toamount);
                      	 funRoundAmt(dr1,"txtdrtotal");
                      	 }
                       
                       if(!isNaN(fromamount)){
                           cr1=parseFloat(cr) + parseFloat(fromamount);
                           funRoundAmt(cr1,"txtcrtotal");
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
               	       }
            		  }
     
         		    var datafield = event.args.datafield;
              		var rowindexestemp = event.args.rowindex;
             		if(datafield=="type"){
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "chequeno" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "chequedate" ,'');
             			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
          			}
             		
              });
            
           $('#chequeDetailsGridID').on('celldoubleclick', function (event) {
	           if(event.args.columnindex == 0)
      		  {
      			var rowindexestemp = event.args.rowindex;
      			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
      			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "chequeno" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "chequedate" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
     			$('#chequeDetailsGridID').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
                } 
             });
           
        });
</script>
<div id="chequeDetailsGridID"></div>
