<%@page import="com.dashboard.accounts.commercialreceiptposting.ClsCommercialReceiptPostingDAO" %>
<%ClsCommercialReceiptPostingDAO cpd=new ClsCommercialReceiptPostingDAO(); %>
 <% String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
 String payType = request.getParameter("paytype")==null?"0":request.getParameter("paytype").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>

 <style>
 .greenClass{
            background-color: #ACF6CB;
        }
.whiteClass{
           background-color: #fff;
        }
 </style>


<script type="text/javascript">
 var temp='<%=branchval%>';
 var temp1='<%=payType%>';
 
	var data;
	if(temp!='NA')
	{ 
		data='<%=cpd.postingGridLoading(branchval,fromDate,toDate,payType,check)%>'; 
	
	}
	
	$(document).ready(function () {
	   
		/*if(temp1=='3'){ 
			$("#btnExcel").click(function() {
				if(parseInt(window.parent.chkexportdata.value)=="1") {
				  	JSONToCSVCon(data, 'Posting', true);
				 } else {
					 $("#postingChequeGrid").jqxGrid('exportdata', 'xls', 'Posting');
				 }
			});
		}*/
		
	    // prepare the data
	    var source =
	    {
	        datatype: "json",
	        datafields: [
	
	                  		{name : 'date' , type: 'date' },
							{name : 'documentno', type: 'String'  },
							{name : 'clacno', type: 'int'  },
							{name : 'refname', type: 'String'  },
							{name : 'paydesc', type: 'String'  },
							{name : 'refno', type: 'String'    },
							{name : 'refdate', type: 'date'    },
							{name : 'paidas', type: 'String'  },
							{name : 'netamt',type:'number'},
							{name : 'totalamount',type:'number'},
							{name : 'dtype',type:'String'},
							{name : 'rdocno',type:'int'},
							{name : 'cldocno',type:'int'},
							{name : 'brhid',type:'int'},
							{name : 'srno',type:'int'},
							{name : 'type',type:'String'},
							{name : 'tr_no',type:'int'}
							],
					    localdata: data,
	        
	        
	        pager: function (pagenum, pagesize, oldpagenum) {
	            // callback called when a page or page size is changed.
	        }
	    };
	    
	    
	    var cellclassname = function (row, column, value, data) {
	        if(typeof(data.totalamount)=="undefined" || data.totalamount=="" ){
	        	return "whiteClass"; 
	        }
	        else{
	        	return "greenClass";
	        };
	          };
	    
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    		 {
	        		loadError: function (xhr, status, error) {
	                alert(error);    
	                }
			            
		            }		
	    );
	    
	    
	    $("#postingChequeGrid").jqxGrid(
	    {
	        width: '98%',
	        height: 360,
	        source: dataAdapter,
	        showaggregates:true,
	        filtermode:'excel',
	        filterable: true,
	        selectionmode: 'checkbox',
	        pagermode: 'default',
	        sortable:false,
	        
	        columns: [
							{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
							{ text: 'Doc No', datafield: 'documentno', width: '6%',cellclassname: cellclassname },
							{ text: 'Client A/c', datafield: 'clacno', width: '6%'  ,cellclassname: cellclassname },
							{ text: 'Client', datafield: 'refname', width: '20%',cellclassname: cellclassname },
							{ text: 'Description', datafield: 'paydesc', width: '28%',cellclassname: cellclassname },
							{ text: 'Cheque No.', datafield: 'refno', width: '10%'   ,cellclassname: cellclassname },
							{ text: 'Chq. Date', datafield: 'refdate', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
							{ text: 'Paid As', datafield: 'paidas', width: '6%',cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'netamt', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname },
							{ text: 'Net Amount', datafield: 'totalamount', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,hidden: true,cellclassname: cellclassname },
							{ text: 'Dtype', datafield: 'dtype', width: '6%',hidden: true },
							{ text: 'RDocno', datafield: 'rdocno', width: '6%',hidden: true },
							{ text: 'Cldocno', datafield: 'cldocno', width: '6%',hidden: true },
							{ text: 'Brhid', datafield: 'brhid', width: '6%',hidden: true },
							{ text: 'CMR No', datafield: 'srno', width: '6%',hidden: true },
							{ text: 'Type', datafield: 'type', width: '6%',hidden: true },
							{ text: 'Tr No', datafield: 'tr_no', width: '6%',hidden: true }
						]
	
	    });
	
	    
	    var rows=$("#postingChequeGrid").jqxGrid("getrows");
	    var rowcount=rows.length;
	    if(rowcount==0){
	    	$("#postingChequeGrid").jqxGrid("addrow", null, {});	
	    }
	    
	    $("#postingChequeGrid").on('cellvaluechanged', function (event) {
	  		 var datafield = event.args.datafield;
		     
	  		if(datafield=="totalamount"){
		      		     
		    var amount1=0.0,amountcomm1=0.0,chequeno="",chequedate="",receipt="";
		    var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
		    var i=0,j=0;
		    
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						 var amount = $('#postingChequeGrid').jqxGrid('getcellvalue', i, "netamt");
		                 var amountcomm= $("#postingChequeGrid").jqxGrid('getcellvalue', i, "totalamount");
		                 chequeno= $("#postingChequeGrid").jqxGrid('getcellvalue', i, "refno");
		                 chequedate= $("#postingChequeGrid").jqxGrid('getcelltext', i, "refdate");
						 receipt= $("#postingChequeGrid").jqxGrid('getcelltext', i, "srno");
		                 
		                 if(!isNaN(amount)){
		                	 amount1=amount1+amount;
	                 	   }else if(isNaN(amount)){
	                 		  amount=0.00;
	                 		  amount1=amount1+amount;
	                   	   }
		                 
		                 if(!isNaN(amountcomm)){
		                	 amountcomm1=amountcomm1+amountcomm;
	                 	   }else if(isNaN(amountcomm)){
	                 		  amountcomm=0.00;
	                 		  amountcomm1=amountcomm1+amountcomm;
	                   	   }
		                
		                 j++; 
				}
	         }
		    
		    $('#txtchequedescription').val("Posting CMR#"+receipt+"# Cheque No. "+chequeno+" Dated "+chequedate+" on  "+$('#date').val()+"");
		    
		    $("#postingJV").jqxGrid('setcellvalue', 0, "docno", $('#txttypedocno').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "type", $('#txttypeatype').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "accounts", $('#txttypeaccid').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "accountname1", $('#txttypeaccname').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "credit", amount1);
		    if(!isNaN(amount1)){
			    if($('#txttypetype').val().trim()=="M"){
			    		var baseamount1 = parseFloat(amount1) * parseFloat($('#txttyperate').val());
			    		$("#postingJV").jqxGrid('setcellvalue', 0, "baseamount", baseamount1);
			    }else{
			    	var baseamount1 = parseFloat(amount1) / parseFloat($('#txttyperate').val());
		    		$("#postingJV").jqxGrid('setcellvalue', 0, "baseamount", baseamount1);
			    }
		    }
		   
		    $("#postingJV").jqxGrid('setcellvalue', 0, "currencyid", $('#txttypecurid').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "currencytype", $('#txttypetype').val());
		    $("#postingJV").jqxGrid('setcellvalue', 0, "rate", $('#txttyperate').val());
		    
		    $("#postingJV").jqxGrid('setcellvalue', 1, "docno", $('#txtdocno').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "type", $('#txtatype').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "accounts", $('#txtaccid').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "accountname1", $('#txtaccname').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "debit", amountcomm1);
		    if(!isNaN(amountcomm1)){
			    if($('#txtcurtype').val().trim()=="M"){
			    		var commnetbaseamount1 = parseFloat(amountcomm1) * parseFloat($('#txtrate').val());
			    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commnetbaseamount1);
			    }else{
			    	var commnetbaseamount1 = parseFloat(amountcomm1) / parseFloat($('#txtrate').val());
		    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commnetbaseamount1);
			    }
		    }
		    $("#postingJV").jqxGrid('setcellvalue', 1, "currencyid", $('#txtcurid').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "currencytype", $('#txtcurtype').val());
		    $("#postingJV").jqxGrid('setcellvalue', 1, "rate", $('#txtrate').val());
		   
		     }
		    });
	    
	    $("#overlay, #PleaseWait").hide();
	   
	});

	
	
</script>
<div id="postingChequeGrid"></div>