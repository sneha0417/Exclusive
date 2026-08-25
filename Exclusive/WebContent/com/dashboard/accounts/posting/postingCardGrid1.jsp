<%@page import="com.dashboard.accounts.posting.ClsPostingDAO" %>
<%ClsPostingDAO cpd=new ClsPostingDAO(); %>


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
// alert(data);
		data='<%=cpd.postingGridLoading(branchval,fromDate,toDate,payType,check)%>'; 
	
	}
	
	$(document).ready(function () {
	   
		/*if(temp1=='2'){ 
			$("#btnExcel").click(function() {
				if(parseInt(window.parent.chkexportdata.value)=="1") {
				  	JSONToCSVCon(data, 'Posting', true);
				 } else {
					 $("#postingCardGrid").jqxGrid('exportdata', 'xls', 'Posting');
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
							{name : 'cardtype', type: 'string'  },
							{name : 'refno', type: 'String'    },
							{name : 'refdate', type: 'date'    },
							{name : 'paidas', type: 'String'  },
							{name : 'netamt',type:'number'},
							{name : 'amount',type:'number'},
							{name : 'commission',type:'number'},
							{name : 'amountcomm',type:'number'},
							{name : 'cardtypecomm',type:'number'},
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
	        if(typeof(data.amountcomm)=="undefined" || data.amountcomm=="" ){
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
	    
	    
	    $("#postingCardGrid").jqxGrid(
	    {
	        width: '98%',
	        height: 360,
	        source: dataAdapter,
	        columnsresize:true,
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
							{ text: 'Client', datafield: 'refname', width: '17%',cellclassname: cellclassname },
							{ text: 'Description', datafield: 'paydesc', width: '25%',cellclassname: cellclassname },
							{ text: 'Card Type', datafield: 'cardtype', width: '6%',cellclassname: cellclassname },
							{ text: 'Card No.', datafield: 'refno', width: '10%'   ,cellclassname: cellclassname },
							{ text: 'Exp. Date', datafield: 'refdate', width: '6%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
							{ text: 'Paid As', datafield: 'paidas', width: '6%',cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'netamt', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,cellclassname: cellclassname },
							{ text: 'Commission', datafield: 'commission', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,hidden: true,cellclassname: cellclassname },
							{ text: 'Net Amount (com.)', datafield: 'amountcomm', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,hidden: true,cellclassname: cellclassname },
							{ text: 'Card Comm', datafield: 'cardtypecomm', width: '9%',cellsformat:'d2',cellsalign:'right',align:'right' ,hidden: true,cellclassname: cellclassname },
							{ text: 'Dtype', datafield: 'dtype', width: '6%',hidden: true },
							{ text: 'RDocno', datafield: 'rdocno', width: '6%',hidden: true },
							{ text: 'Cldocno', datafield: 'cldocno', width: '6%',hidden: true },
							{ text: 'Brhid', datafield: 'brhid', width: '6%',hidden: true },
							{ text: 'RRV No', datafield: 'srno', width: '6%',hidden: true },
							{ text: 'Type', datafield: 'type', width: '6%',hidden: true },
							{ text: 'Tr No', datafield: 'tr_no', width: '6%',hidden: true }
						]
	
	    });
	
	    
	    var rows=$("#postingCardGrid").jqxGrid("getrows");
	    var rowcount=rows.length;
	    if(rowcount==0){
	    	$("#postingCardGrid").jqxGrid("addrow", null, {});	
	    }
	    
	    $("#postingCardGrid").on('cellvaluechanged', function (event) {
  		var datafield = event.args.datafield;
  		var receipttype = "";
  		
  		if(datafield=="commission"){
  			if($('#txtbipostingcardcomm').val().trim()=="1"){
  				$("#postingJV").jqxGrid('addrow', null, {});
  			}
  		}
  		
	    if(datafield=="commission" || datafield=="amountcomm"){
	      		     
	    var amount1=0.0,commission1=0.0,amountcomm1=0.0;
	    var selectedrows=$("#postingCardGrid").jqxGrid('selectedrowindexes');
	    var i=0,j=0,k=1;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					 var amount = $('#postingCardGrid').jqxGrid('getcellvalue', i, "netamt");
	                 var commission= $("#postingCardGrid").jqxGrid('getcellvalue', i, "commission"); 
	                 var amountcomm= $("#postingCardGrid").jqxGrid('getcellvalue', i, "amountcomm");
	                 var srno = $('#postingCardGrid').jqxGrid('getcellvalue', i, "srno");
	                 var docs = $('#postingCardGrid').jqxGrid('getcellvalue', i, "documentno");
	                 receipttype = $('#postingCardGrid').jqxGrid('getcellvalue', i, "type");
	                 
	                 if(!isNaN(amount)){
	                	 amount1=amount1+amount;
                 	   }else if(isNaN(amount)){
                 		  amount=0.00;
                 		  amount1=amount1+amount;
                   	   }
	    
	                 if($('#txtbipostingcardcomm').val().trim()=="0"){
		                 if(!isNaN(commission)){
		                	 commission1=commission1+commission;
	                 	   }else if(isNaN(amount)){
	                 		  commission=0.00;
	                 		  commission1=commission1+commission;
	                   	   }
	                 }else if($('#txtbipostingcardcomm').val().trim()=="1"){
	                	 if(!isNaN(commission)){
	                			$("#postingJV").jqxGrid('setcellvalue', k, "docno", $('#txtcommdocno').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "type", $('#txtcommatype').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "accounts", $('#txtcommaccid').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "accountname1", $('#txtcommaccname').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "debit", commission);
	                		    if(!isNaN(commission)){
	                			    if($('#txtcommtype').val().trim()=="M"){
	                			    		var commissionbaseamount1 = parseFloat(commission) * parseFloat($('#txtcommrate').val());
	                			    		$("#postingJV").jqxGrid('setcellvalue', k, "baseamount", commissionbaseamount1);
	                			    }else{
	                			    	var commissionbaseamount1 = parseFloat(commission) / parseFloat($('#txtcommrate').val());
	                		    		$("#postingJV").jqxGrid('setcellvalue', k, "baseamount", commissionbaseamount1);
	                			    }
	                		    }
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "description", receipttype+""+srno+" "+docs+" CARD POSTING on "+$('#date').val()+"");
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "currencyid", $('#txtcommcurid').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "currencytype", $('#txtcommtype').val());
	                		    $("#postingJV").jqxGrid('setcellvalue', k, "rate", $('#txtcommrate').val());
	                	 }
	                 }
	                 
	                 if(!isNaN(amountcomm)){
	                	 amountcomm1=amountcomm1+amountcomm;
                 	   }else if(isNaN(amountcomm)){
                 		  amountcomm=0.00;
                 		  amountcomm1=amountcomm1+amountcomm;
                   	   }
	                
	                 k++;
	                 j++; 
			}
         }
	    
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
	    $("#postingJV").jqxGrid('setcellvalue', 0, "description", receipttype+"["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CARD POSTING on "+$('#date').val()+"");
	    $("#postingJV").jqxGrid('setcellvalue', 0, "currencyid", $('#txttypecurid').val());
	    $("#postingJV").jqxGrid('setcellvalue', 0, "currencytype", $('#txttypetype').val());
	    $("#postingJV").jqxGrid('setcellvalue', 0, "rate", $('#txttyperate').val());
	    
	    if($('#txtbipostingcardcomm').val().trim()=="0"){
	    	
	    $("#postingJV").jqxGrid('setcellvalue', 1, "docno", $('#txtcommdocno').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "type", $('#txtcommatype').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "accounts", $('#txtcommaccid').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "accountname1", $('#txtcommaccname').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "debit", commission1);
	    if(!isNaN(commission1)){
		    if($('#txtcommtype').val().trim()=="M"){
		    		var commissionbaseamount1 = parseFloat(commission1) * parseFloat($('#txtcommrate').val());
		    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commissionbaseamount1);
		    }else{
		    	var commissionbaseamount1 = parseFloat(commission1) / parseFloat($('#txtcommrate').val());
	    		$("#postingJV").jqxGrid('setcellvalue', 1, "baseamount", commissionbaseamount1);
		    }
	    }
	    $("#postingJV").jqxGrid('setcellvalue', 1, "description", receipttype+"["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CARD POSTING on "+$('#date').val()+"");
	    $("#postingJV").jqxGrid('setcellvalue', 1, "currencyid", $('#txtcommcurid').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "currencytype", $('#txtcommtype').val());
	    $("#postingJV").jqxGrid('setcellvalue', 1, "rate", $('#txtcommrate').val());
	    
	    var r=2;
	    if(parseInt($('#txtnontaxableentity').val().trim())==1){
	    	
	    	if(parseInt($('#txttaxaccdocno').val().trim())>0){
	    		
		    	$("#postingJV").jqxGrid('addrow', null, {});
		    	var amounttax1=0.0;
		    	
		    	amounttax1=parseFloat(commission1)*(parseFloat($('#txttaxpercentage').val())/100);
		    	
		    	amountcomm1=parseFloat(amountcomm1)-parseFloat(amounttax1);
		    	
		    	$("#postingJV").jqxGrid('setcellvalue', 2, "docno", $('#txttaxaccdocno').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "type", $('#txttaxaccatype').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "accounts", $('#txttaxaccid').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "accountname1", $('#txttaxaccname').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "debit", amounttax1);
			    if(!isNaN(amounttax1)){
				    if($('#txtcurtype').val().trim()=="M"){
				    		var taxbaseamount1 = parseFloat(amounttax1) * parseFloat($('#txttaxaccrate').val());
				    		$("#postingJV").jqxGrid('setcellvalue', 2, "baseamount", taxbaseamount1);
				    }else{
				    	var taxbaseamount1 = parseFloat(amounttax1) / parseFloat($('#txttaxaccrate').val());
			    		$("#postingJV").jqxGrid('setcellvalue', 2, "baseamount", taxbaseamount1);
				    }
			    }
			    $("#postingJV").jqxGrid('setcellvalue', 2, "description", receipttype+"["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CARD POSTING on "+$('#date').val()+"");
			    $("#postingJV").jqxGrid('setcellvalue', 2, "currencyid", $('#txttaxacccurid').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "currencytype", $('#txttaxacccurtype').val());
			    $("#postingJV").jqxGrid('setcellvalue', 2, "rate", $('#txttaxaccrate').val());
			    
			    r=parseInt(r)+1;
	    	}
	    }
	    
	    $("#postingJV").jqxGrid('setcellvalue', r, "docno", $('#txtdocno').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "type", $('#txtatype').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "accounts", $('#txtaccid').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "accountname1", $('#txtaccname').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "debit", amountcomm1);
	    if(!isNaN(amountcomm1)){
		    if($('#txtcurtype').val().trim()=="M"){
		    		var commnetbaseamount1 = parseFloat(amountcomm1) * parseFloat($('#txtrate').val());
		    		$("#postingJV").jqxGrid('setcellvalue', r, "baseamount", commnetbaseamount1);
		    }else{
		    	var commnetbaseamount1 = parseFloat(amountcomm1) / parseFloat($('#txtrate').val());
	    		$("#postingJV").jqxGrid('setcellvalue', r, "baseamount", commnetbaseamount1);
		    }
	    }
	    $("#postingJV").jqxGrid('setcellvalue', r, "description", receipttype+"["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CARD POSTING on "+$('#date').val()+"");
	    $("#postingJV").jqxGrid('setcellvalue', r, "currencyid", $('#txtcurid').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "currencytype", $('#txtcurtype').val());
	    $("#postingJV").jqxGrid('setcellvalue', r, "rate", $('#txtrate').val());
	    
	    }else if($('#txtbipostingcardcomm').val().trim()=="1"){
	    	
	    	$("#postingJV").jqxGrid('setcellvalue', k, "docno", $('#txtdocno').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "type", $('#txtatype').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "accounts", $('#txtaccid').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "accountname1", $('#txtaccname').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "debit", amountcomm1);
		    if(!isNaN(amountcomm1)){
			    if($('#txtcurtype').val().trim()=="M"){
			    		var commnetbaseamount1 = parseFloat(amountcomm1) * parseFloat($('#txtrate').val());
			    		$("#postingJV").jqxGrid('setcellvalue', k, "baseamount", commnetbaseamount1);
			    }else{
			    	var commnetbaseamount1 = parseFloat(amountcomm1) / parseFloat($('#txtrate').val());
		    		$("#postingJV").jqxGrid('setcellvalue', k, "baseamount", commnetbaseamount1);
			    }
		    }
		    $("#postingJV").jqxGrid('setcellvalue', k, "description", receipttype+"["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CARD POSTING on "+$('#date').val()+"");
		    $("#postingJV").jqxGrid('setcellvalue', k, "currencyid", $('#txtcurid').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "currencytype", $('#txtcurtype').val());
		    $("#postingJV").jqxGrid('setcellvalue', k, "rate", $('#txtrate').val());
	     }
	    }
	     
	    });
	    
	    $("#overlay, #PleaseWait").hide();
	   
	});

	
	
</script>
<div id="postingCardGrid"></div>