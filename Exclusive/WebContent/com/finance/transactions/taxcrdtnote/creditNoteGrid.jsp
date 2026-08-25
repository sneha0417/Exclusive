<%@page import="com.finance.transactions.taxcrdtnote.ClsTaxCreditNoteDAO"%>
<% ClsTaxCreditNoteDAO DAO= new ClsTaxCreditNoteDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("txtcreditnotedocno2")==null?"0":request.getParameter("txtcreditnotedocno2");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<script type="text/javascript">
		 var data1;  
        $(document).ready(function () { 
           
            var temp='<%=docNo%>';
             
             if(temp>0)
           	 {   
            	 data1='<%=DAO.creditNoteGridReloading(session,docNo,check)%>';
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
     						{name : 'rate', type: 'number'   },
     						{name : 'costtype', type: 'string'    },
							{name : 'costgroup', type: 'string'    },
							{name : 'costcode', type: 'number'    },
     						{name : 'dr', type: 'bool' },
     						{name : 'amount1', type: 'number' },
     						{name : 'baseamount1', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'tax', type: 'string' },
     						{name : 'taxamount', type: 'string' },
     						{name : 'nettotal', type: 'string' },
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
            
            $("#jqxCreditNote").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                   
                    //Search Pop-Up
                    var cell1 = $('#jqxCreditNote').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	 var value = $('#jqxCreditNote').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	 CreditSearchContent('creditNoteSearch.jsp?atype='+value);
                          }
                      }
                    
                    var cell2 = $('#jqxCreditNote').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxCreditNote').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) {  
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxCreditNote");
                        	 $('#jqxCreditNote').jqxGrid('render');
                    	    }
                          }
                    	}
                        
                    var cell3 = $('#jqxCreditNote').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxCreditNote').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxCreditNote').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxCreditNote&costtype="+value);
    	                	   $('#jqxCreditNote').jqxGrid('render');
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
                            { text: 'Type', datafield: 'type', width: '4%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                               
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '5%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '20%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', editable: true, cellsformat: 'd2', width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true ,editable: true},
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',editable: false },
							{ text: 'Dr', datafield: 'dr', columntype: 'checkbox', editable: true, checked: true, width: '3%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amount', datafield: 'baseamount1', editable: false, cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right' },
							{ text: 'Tax%', datafield: 'tax', editable: false, width: '3%' },
							{ text: 'Tax Amount', datafield: 'taxamount', cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right' },
							{ text: 'NetTotal', datafield: 'nettotal', cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description', width: '22%' },
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'Sr. No.', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
						]
            });
            
          //Add empty row
            if(temp==0){   
         	   $("#jqxCreditNote").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","sr_no":"","currencytype": ""});
         	 }
            
            if(temp>0){
            	$("#jqxCreditNote").jqxGrid('disabled', true);
          	 }
         	  
         	  $("#jqxCreditNote").on('cellvaluechanged', function (event) 
         	  {
         		 //getCrTotal();
         		 var datafield = event.args.datafield;
          		 if(datafield=="dr" || datafield=="amount1" || datafield=="rate" || datafield=="nettotal"){
          		 
	         	   var amount=document.getElementById("txtbaseamount").value;
	         		
	         	   var dr=0.0,cr=0.0,cr1=0.0;
	         	   var rows = $('#jqxCreditNote').jqxGrid('getrows');
	         	   var rowlength= rows.length;
	         		for(var i=0;i<=rowlength-1;i++)
	         		{
	         		 var value = $('#jqxCreditNote').jqxGrid('getcellvalue', i, "dr");
	                 
	                 var rate= $("#jqxCreditNote").jqxGrid('getcellvalue', i, "rate");
	                 var type= $("#jqxCreditNote").jqxGrid('getcellvalue', i, "currencytype");
	                 var amountk= $("#jqxCreditNote").jqxGrid('getcellvalue', i, "amount1");
	             	 var tax=$("#jqxCreditNote").jqxGrid('getcellvalue', i, "tax");
	             	  
	             	  //alert(amount+"====="+tax);
	             	 if(parseFloat(tax)>0)
	      			{ 
	             		 var taxempamount=(parseFloat(amountk)*(parseFloat(tax)/100)).toFixed(2); 
	             		//alert("====="+taxempamount);
	             		 $('#jqxCreditNote').jqxGrid('setcellvalue', i, "taxamount",taxempamount);
	          		  
	          		     var taxtotalamount=(parseFloat(amountk)+parseFloat(taxempamount)).toFixed(2); 
	          		 // alert("====="+taxtotalamount);
	          		     $('#jqxCreditNote').jqxGrid('setcellvalue', i, "nettotal",taxtotalamount);
	          			 
	      			}
	             	var value1= $("#jqxCreditNote").jqxGrid('getcellvalue', i, "nettotal");
	                 var baseamount = getBaseAmountInGrid(value1,rate,type);
	                 //alert(value1+"====="+baseamount);
	                 if(isNaN(baseamount)){
	                	 //alert("innot========");
		              	   $('#jqxCreditNote').jqxGrid('setcellvalue', i, "amount1" ,"0.00");
		              	   $('#jqxCreditNote').jqxGrid('setcellvalue', i, "baseamount1" ,"0.00");
		                  }
		                 
		                 if(!isNaN(amountk)){
		              	   $('#jqxCreditNote').jqxGrid('setcellvalue', i, "baseamount1" ,amountk);
		          
		                   }
	                 //alert(value+"==="+baseamount);
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
	                 //alert("dr====="+dr);
	                 // funRoundAmt(dr,"txtdrtotal");
	                  
	                     if(amount == ""){
	                    	 //alert("in amount");
	                     amount=0.00;
	                   	 cr1=parseFloat(cr) + parseFloat(amount); 
	                   	 funRoundAmt(cr1,"txtcrtotal");
	                    }
	                  
	                  if(!isNaN(amount)){
	                	 cr1=parseFloat(cr) + parseFloat(amount); 
	                	 funRoundAmt(cr1,"txtcrtotal");
	                 } 
	         	   }
	         		//var totalnet=$('#jqxCreditNote').jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
	         		//totalbase1=parseFloat(totalnet.sum.replace(',','')).toFixed(2);
	         		//alert(totalbase1);
	         		//funRoundAmt(totalbase1,"txtdrtotal");
          		 }
         	
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
         		if(datafield=="type"){
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "tax" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "taxamount" ,'');
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "nettotal" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         		setTotal();
        });
         	  
          	 $("#jqxCreditNote").on('cellvaluechanged', function (event) {
           	   var rowindexestemp = event.args.rowindex;
           	   $('#rowindex').val(rowindexestemp);
           	
        		var value = $('#jqxCreditNote').jqxGrid('getcellvalue', rowindexestemp, "type");
       			$('#type').val(value);
              });
            
           $('#jqxCreditNote').on('celldoubleclick', function (event) {
        	  if(event.args.columnindex == 3)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
        		    var value = $('#jqxCreditNote').jqxGrid('getcellvalue', rowindextemp, "type");
        		    CreditSearchContent('creditNoteSearch.jsp?atype='+value);
                  } 
        	  
        	  if(event.args.columnindex == 8)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value = $('#jqxCreditNote').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value==4 || value==5){
		           $('#jqxCreditNote').jqxGrid('clearselection');
		           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxCreditNote");
		           }
	            } 
	    		  
	           if(event.args.columnindex == 10)
	            {
		           var rowindextemp = event.args.rowindex;
		           var value1 = $('#jqxCreditNote').jqxGrid('getcellvalue', rowindextemp, "grtype");
		           document.getElementById("rowindex").value = rowindextemp;
		           if(value1==4 || value1==5){
		           $('#jqxCreditNote').jqxGrid('clearselection');
		           var value = $('#jqxCreditNote').jqxGrid('getcellvalue', rowindextemp, "costtype");
		           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxCreditNote&costtype="+value);
		           }
                } 
	           
	           if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "dr" ,true);
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "baseamount1" ,'0.00');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   		    $('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "tax" ,'');
 	   	        $('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "taxamount" ,'0.00');
 	            $('#jqxCreditNote').jqxGrid('setcellvalue', rowindexestemp, "nettotal" ,'0.00');
               }
            }); 
			
		$("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
		var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
		$("#jqxCreditNote").on('contextmenu', function () {
           return false;
        });
		 
		$("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#jqxCreditNote").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#jqxCreditNote").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#jqxCreditNote").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#jqxCreditNote").jqxGrid('getrowid', rowindex);
               $("#jqxCreditNote").jqxGrid('deleterow', rowid);
           }
		   setTotal();
        });
		   
		   $("#jqxCreditNote").on('rowclick', function (event) {
				if (event.args.rightclick) {
					
					if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" || document.getElementById("mode").value=="EDIT"){
					
						$("#jqxCreditNote").jqxGrid('selectrow', event.args.rowindex);
						var scrollTop = $(window).scrollTop();
						var scrollLeft = $(window).scrollLeft();
						contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
						return false;
					}
				}
		   }); 
		
           
        });
		
        function setTotal(){
			
           var sum=0.0;
       	   var rows = $('#jqxCreditNote').jqxGrid('getrows');
       	   var rowlength= rows.length;
       		for( var j=0;j<=rowlength-1;j++)
       		{
       			var ckbx = $('#jqxCreditNote').jqxGrid('getcellvalue', j, "dr");
       			var total = parseFloat($('#jqxCreditNote').jqxGrid('getcellvalue', j, "nettotal"));
       			if(!isNaN(total) && ckbx==true){
       				sum+=total;
       			}
       		}
			
			funRoundAmt(sum,"txtdrtotal");
        	
        }
        
    </script>
	
 <div id="jqxCreditNote"></div>
    
 <input type="hidden" id="rowindex"/> 
 <input type="hidden" id="type"/> 
 
 <div id='jqxWidget'>
		<div id="popupWindow">
			<div id='Menu'>
				<ul>
					<li>Delete Selected Row</li>
				</ul>
			</div>
		</div>
</div>