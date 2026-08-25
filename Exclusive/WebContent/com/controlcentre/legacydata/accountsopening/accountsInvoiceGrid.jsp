<%@page import="com.controlcentre.legacydata.accountsopening.ClsAccountsOpeningDAO" %>
<%ClsAccountsOpeningDAO cad=new ClsAccountsOpeningDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String trNo = request.getParameter("txttrno2")==null?"0":request.getParameter("txttrno2"); %>
<% String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");%>
<script type="text/javascript">
       var data1;
        $(document).ready(function () { 	
              
            var temp='<%=trNo%>';
            var temp1='<%=accountno%>';
            
             if(temp>0){     
            	 data1='<%=cad.applyInvoiceGridReloading(trNo)%>';      
             } 
             else if(temp1>0)
             {
            	 data1='<%=cad.applyInvoiceGridLoading(session,accountno)%>';
             }
             
             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'date', type: 'date' },
     						{name : 'doc_no', type: 'int' },
     						{name : 'tr_no', type: 'int' },
     						{name : 'debit', type: 'number' },
     		     		    {name : 'credit', type: 'number'   },
     		     		  	{name : 'baseamount', type: 'number' },
     		     		    {name : 'description', type: 'string' }
                        ],
                		  localdata: data1,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });

            $("#jqxAppliedAccounts").jqxGrid(
            {
                width: '99%',
                height: 350,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxAppliedAccounts').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxAppliedAccounts').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
                            rowlength++;                           
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
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput',  cellsformat: 'dd.MM.yyyy' ,  width: '9%' },	
							{ text: 'Doc No.', datafield: 'doc_no',  width: '8%' },
							{ text: 'Tr No.', datafield: 'tr_no',  hidden: true, width: '10%' },
							{ text: 'Debit', datafield: 'debit', width: '11%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxAppliedAccounts').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Credit', datafield: 'credit', width: '11%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#jqxAppliedAccounts').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', editable: false, cellsformat: 'd2', width: '11%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description',  width: '45%' },
						]
            });   
            
            //Add empty row
          	   $("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
            
          	 if(temp>0){ 
             	$("#jqxAppliedAccounts").jqxGrid({ disabled: true});
             }
        	 
          	 $("#jqxAppliedAccounts").on('cellendedit', function (event) 
          			{
          			    var datafield = event.args.datafield;
          			    var rowBoundIndex = event.args.rowindex;
          			    if(datafield=="debit"){
          			    var value = event.args.value;
          			    if(value=="" || value=="undefined"){
          				  $('#jqxAppliedAccounts').jqxGrid('setcellvalue',rowBoundIndex, "debit",0);  
          			     }
          			    }
          			    else if(datafield=="credit"){
              			    var value = event.args.value;
              			    if(value=="" || value=="undefined"){
              				  $('#jqxAppliedAccounts').jqxGrid('setcellvalue',rowBoundIndex, "credit",0);  
              			   }
          			   }
          			    
          			  var year = window.parent.txtaccountperiodfrom.value;
          			  var newDate = year.split('-');
          			  year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
          			  var styear = new Date(year);
          			  if(datafield=="date"){
          			    var value = event.args.value;    
          			    value = new Date(value);
          			    styear.setHours(0,0,0,0);
          			    value.setHours(0,0,0,0);
          			    if(value>=styear){
          			    	$("#jqxAppliedAccounts").jqxGrid('showvalidationpopup', rowBoundIndex, "date", "Date should be before accounting period.");
              		        $('#txtvalidation').val(1);
              		         return true;    
          			     }
          			    else{
            		        $("#jqxAppliedAccounts").jqxGrid('hidevalidationpopups');
            		        $('#txtvalidation').val(0);
            		        return false;  
            		        }
          			    }
          			}); 
          	 
         	 $("#jqxAppliedAccounts").on('cellvaluechanged', function (event){
               
         		//var fromamount = $('#txtdebittotal').val();
      		    //var toamount = $('#txtcredittotal').val();
      		    var rate = $('#txtrate').val();
      		    var currencytype = $('#hidcurrencytype').val();
      		  
         		var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
          	    var rows = $('#jqxAppliedAccounts').jqxGrid('getrows');
          	    var rowlength= rows.length;
          		for(i=0;i<=rowlength-1;i++)
          		{
          		  var debit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "debit");
          		  var credit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "credit"); 
                  
                  if(debit>0){
                	  var baseamount = getBaseAmountInGrid(debit,rate,currencytype);
                  	  $('#jqxAppliedAccounts').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
                   	  dr=dr+baseamount;
                  }
                  if(credit>0){
                	  var baseamount = getBaseAmountInGrid(credit,rate,currencytype);
                 	  $('#jqxAppliedAccounts').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
                   	  cr=cr+baseamount;
                  }
                  if(credit==0 && debit==0){
                	  //var baseamount = getBaseAmountInGrid(credit,rate,currencytype);
                 	  $('#jqxAppliedAccounts').jqxGrid('setcellvalue', i, "baseamount" ,0);
                   	  //cr=cr+baseamount;
                  }
          	  }
                 
                 /* if(fromamount == ""){
                	 fromamount=0.00;
                	 funRoundAmt(fromamount,"txtcredittotal");
                 }
                 
                 if(toamount == ""){
                	 toamount=0.00;
                     funRoundAmt(toamount,"txtdebittotal");
                 }
                 
                 if(!isNaN(fromamount)){
                     dr1=parseFloat(dr);
                     funRoundAmt(dr1,"txtdebittotal");
                 }else if(isNaN(fromamount)){
                     dr1=0.00;
                     funRoundAmt(dr1,"txtdebittotal");
                 }
                 
                 if(!isNaN(toamount)){
                	 cr1=parseFloat(cr); 
                	 funRoundAmt(cr1,"txtcredittotal");
                  }else if(isNaN(toamount)){
                	 cr1=0.00; 
                	 funRoundAmt(cr1,"txtcredittotal");
                  } */ 
                  
                  var debittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
                  var debitamount=debittotal.sum;
                  document.getElementById("txtdebittotal").value=debitamount;
                  
                  var credittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
                  var creditamount=credittotal.sum;
                  document.getElementById("txtcredittotal").value=creditamount;
                 
      		    if(!isNaN(debitamount || creditamount)){ 
      		    var totbalance= parseFloat(debitamount) - parseFloat(creditamount);
      		    funRoundAmt(totbalance,"txtnettotal");
      		    
      		   if(currencytype=="M"){
				    	var result = parseFloat(totbalance) * parseFloat(rate);
				    	funRoundAmt(result,"txtbaseamount");
			    }else{
				    	var result = parseFloat(totbalance) / parseFloat(rate);
						funRoundAmt(result,"txtbaseamount");
			       }
      		     } 
     		    
        });
  		    
	  		$('#txtdebittotal').val(0.00);
	  		$('#txtcredittotal').val(0.00);
  		  
     		/* var temp=0.0,temp1=0.0;
      	    var rows = $('#jqxAppliedAccounts').jqxGrid('getrows');
      	    var rowlength= rows.length;
      		for(i=0;i<=rowlength-1;i++)
      		{
      		  var debit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "debit");
      		  var credit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "credit"); 
              var baseamount = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "baseamount");
              
              if(debit>0){
               	  temp=parseFloat(baseamount)+parseFloat($('#txtdebittotal').val());
               	  funRoundAmt(temp,"txtdebittotal");
              }
              if(credit>0){
            	  temp1=parseFloat(baseamount)+parseFloat($('#txtcredittotal').val());
               	  funRoundAmt(temp1,"txtcredittotal");
              }
      	  } */
             
            var rate = $('#txtrate').val();
            var currencytype = $('#hidcurrencytype').val();
            
            var debittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            var debitamount=debittotal.sum;
            document.getElementById("txtdebittotal").value=debitamount;
            
            var credittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            var creditamount=credittotal.sum;
            document.getElementById("txtcredittotal").value=creditamount;
            
  		    if(!isNaN(debitamount || creditamount)){
  		    var totbalance= parseFloat(debitamount) - parseFloat(creditamount);
  		    funRoundAmt(totbalance,"txtnettotal");
  		    
  		   if(currencytype=="M"){
			    	var result = parseFloat(totbalance) * parseFloat(rate);
			    	funRoundAmt(result,"txtbaseamount");
		    }else{
			    	var result = parseFloat(totbalance) / parseFloat(rate);
					funRoundAmt(result,"txtbaseamount");
		       }
  		    } 
  		    
  		  $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
  	    // create context menu
  	       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
  	       $("#jqxAppliedAccounts").on('contextmenu', function () {
  	           return false;
  	       });
  	       
  	       $("#Menu").on('itemclick', function (event) {
  	    	   var args = event.args;
  	           var rowindex = $("#jqxAppliedAccounts").jqxGrid('getselectedrowindex');
  	           if ($.trim($(args).text()) == "Edit Selected Row") {
  	               editrow = rowindex;
  	               var offset = $("#jqxAppliedAccounts").offset();
  	               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
  	               // get the clicked row's data and initialize the input fields.
  	               var dataRecord = $("#jqxAppliedAccounts").jqxGrid('getrowdata', editrow);
  	               // show the popup window.
  	               $("#popupWindow").jqxWindow('show');
  	           }
  	           else {
  	               var rowid = $("#jqxAppliedAccounts").jqxGrid('getrowid', rowindex);
  	               $("#jqxAppliedAccounts").jqxGrid('deleterow', rowid);
  	               
  	             var rate = $('#txtrate').val();
       		    var currencytype = $('#hidcurrencytype').val();
       		  
          		var dr=0.0,cr=0.0,dr1=0.0,cr1=0.0;
           	    var rows = $('#jqxAppliedAccounts').jqxGrid('getrows');
           	    var rowlength= rows.length;
           		for(i=0;i<=rowlength-1;i++)
           		{
           		  var debit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "debit");
           		  var credit = $('#jqxAppliedAccounts').jqxGrid('getcellvalue', i, "credit"); 
                   
                   if(debit>0){
                 	  var baseamount = getBaseAmountInGrid(debit,rate,currencytype);
                   	  $('#jqxAppliedAccounts').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
                    	  dr=dr+baseamount;
                   }
                   if(credit>0){
                 	  var baseamount = getBaseAmountInGrid(credit,rate,currencytype);
                  	  $('#jqxAppliedAccounts').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
                    	  cr=cr+baseamount;
                   }
           	  }
           		
           		var debittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
                var debitamount=debittotal.sum;
                document.getElementById("txtdebittotal").value=debitamount;
                
                var credittotal=$('#jqxAppliedAccounts').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
                var creditamount=credittotal.sum;
                document.getElementById("txtcredittotal").value=creditamount;
               
    		    if(!isNaN(debitamount || creditamount)){ 
    		    var totbalance= parseFloat(debitamount) - parseFloat(creditamount);
    		    funRoundAmt(totbalance,"txtnettotal");
    		    
    		   if(currencytype=="M"){
				    	var result = parseFloat(totbalance) * parseFloat(rate);
				    	funRoundAmt(result,"txtbaseamount");
			    }else{
				    	var result = parseFloat(totbalance) / parseFloat(rate);
						funRoundAmt(result,"txtbaseamount");
			       }
    		     } 
           		
           		
  	           }
  	       });
  	       $("#jqxAppliedAccounts").on('rowclick', function (event) {
  	           if (event.args.rightclick) {
  			   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
  	               $("#jqxAppliedAccounts").jqxGrid('selectrow', event.args.rowindex);
  	               var scrollTop = $(window).scrollTop();
  	               var scrollLeft = $(window).scrollLeft();
  	               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
  	               return false;
  	           }
  			   }
  	       });
  		    
  		    
         	 
});

</script>
<div id='jqxWidget'>
<div id="jqxAppliedAccounts"></div>
<div id="popupWindow">
<div id='Menu'>
  <ul>
      <li>Delete Selected Row</li>
  </ul>
</div>
</div>
</div>
      
 