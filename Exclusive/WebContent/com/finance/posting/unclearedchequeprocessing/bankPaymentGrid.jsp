<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.posting.unclearedchequeprocessing.ClsUnclearedChequeProcessingDAO"%>
<%ClsUnclearedChequeProcessingDAO DAO= new ClsUnclearedChequeProcessingDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtbankpaydocno2")==null?"0":request.getParameter("txtbankpaydocno2");
   String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
   String postingDate = request.getParameter("postingDate")==null?"0":request.getParameter("postingDate");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>  
<script type="text/javascript">
        
       	var data1; 
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
             
             if(temp>0){     
            	 data1='<%=DAO.bankPaymentGridReloading(session,docNo,dtype,postingDate,check)%>';      
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
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number'  },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'pdc', type: 'int'  }
                        ],
                		   localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxBankPayment").jqxGrid(
            {
            	width: '99%',
                height: 180,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
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
                            { text: 'Type', datafield: 'type', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts',   width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname1', width: '20%' },	
							{ text: 'Currency', datafield: 'currency', width: '4%' },
							{ text: 'Currency Id', datafield: 'currencyid', hidden: true,  width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd2',  width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',  },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%' },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', width: '22%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true,  width: '10%' },
							{ text: 'Curr Type', datafield: 'currencytype', hidden: true,  width: '4%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true,  width: '3%' },
							{ text: 'PDC', datafield: 'pdc', hidden: true,  width: '3%' }
						]
            });
            
            //Add empty row
            if(temp==0){   
        	   $("#jqxBankPayment").jqxGrid('addrow', null, {});
         	 }   
           
            if(temp==0){
            	$("#jqxBankPayment").jqxGrid('disabled', true);
            }
            
            $("#overlay, #PleaseWait").hide();
            
            var fromamount=0.0;
      		var toamount=0.0;
      	    var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
      	    var rows = $('#jqxBankPayment').jqxGrid('getrows');
  	        var rowlength= rows.length;
      		for(i=0;i<=rowlength-1;i++)
      		{
      		   var value = $('#jqxBankPayment').jqxGrid('getcellvalue', i, "dr");
              var value1= $("#jqxBankPayment").jqxGrid('getcellvalue', i, "amount1"); 
              var rate= $("#jqxBankPayment").jqxGrid('getcellvalue', i, "rate");
              var type= $("#jqxBankPayment").jqxGrid('getcellvalue', i, "currencytype");
              
              var baseamount = getBaseAmountInGrid(value1,rate,type);
              $('#jqxBankPayment').jqxGrid('setcellvalue', i, "baseamount1" ,baseamount);
              
              if(value==true){
                 dr=dr+baseamount;
              }
              else{
             	  cr=cr+baseamount;
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
           
        });
    </script>
    <div id="jqxBankPayment"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/>