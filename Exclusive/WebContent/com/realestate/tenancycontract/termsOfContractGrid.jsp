
  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 
 String load = request.getParameter("load")==null?"0":request.getParameter("load"); 
  String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
  
<script type="text/javascript">
		 var data111;  
        $(document).ready(function () {  
            var load='<%=load%>';
            var docno='<%=docno%>';
             
             if(load>0){   
            	  data111='<%=DAO.termsloading()%>';  
           	 }
             else if(docno>0)
            	 {
            	 data111='<%=DAO.termsloading(docno)%>';  
            	 }
             var rendererstring=function (aggregates){
            	   	var value=aggregates['sum'];
            	   	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
            		   {
            			value=0.0;
            		   }
            		
            	   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            	   }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'description', type: 'string'   },
     						{name : 'amount', type: 'number' },
     						{name : 'account', type: 'string'   },
     						{name : 'docno', type: 'string'   },
     						{name : 'tax',type:'bool'},
     						{name : 'taxtype',type:'String'},
     						{name : 'taxvalue',type:'number'},
     						{name : 'nettotal',type:'number'}
     						 
                        ],
                         localdata: data111,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list=['Inclusive','Exclusive'];
            $("#termsOfContractGridId").jqxGrid(
            {
                width: '99.5%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                disabled:true,
                editable:true,
              
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc', datafield: 'docno',  editable: false , width: '25%',hidden:true },	
							{ text: 'Description', datafield: 'description',  editable: false  },	
							{ text: 'Value', datafield: 'amount', cellsformat: 'd2', width: '14%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Tax',datafield:'tax',editable:false,width:'5%',columntype:'checkbox'},
							{ text: 'VAT Type',datafield:'taxtype',width:'10%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                	editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                	editor.on('change', function (event) {
                                		var rowindex=$('#termsOfContractGridrow').val();
                                		var amount=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowindex,'amount');
                                		if(parseFloat(amount)==0.0){
                    			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',0.0);
                    			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',amount);
                    			    	}
                                		var chktax=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowindex,'tax');
                                		var propertytype=$('#cmbtenancytype').val();//1-Residence,2-Commercial
                                		console.log("Property:"+propertytype+"Row:"+rowindex);
			    						if(chktax){
			    							if(propertytype!=1 || (propertytype==1 && rowindex!=0)){
			    								if(event.args.item.value=="Inclusive"){
	                                				var value=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowindex,'amount');
	                                				if(value!="" && value!=null && value!="undefined" && typeof(value)!="undefined"){
				    									value=parseFloat(value);
				    									var inclusiveamt=(value/105)*100;
				    									var taxamount=value-inclusiveamt;
				    									taxamount=parseFloat(taxamount).toFixed(2);
														value=parseFloat(value).toFixed(2);
				    									$('#termsOfContractGridId').jqxGrid('setcellvalue',rowindex,'taxvalue',taxamount);
				    									$('#termsOfContractGridId').jqxGrid('setcellvalue',rowindex,'nettotal',value);
				    									if(rowindex==0){
				    										setMgmtFee();	
				    									}
				    									
				    								}
	                                			}
	                                			else if(event.args.item.value=="Exclusive"){
	                                				var value=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowindex,'amount');
	                                				if(value!="" && value!=null && value!="undefined" && typeof(value)!="undefined"){
									    				value=parseFloat(value);
									    				var taxamount=value*(5/100);
														taxamount=parseFloat(taxamount);
														var finalamount=0.0;
														finalamount=parseFloat(value)+parseFloat(taxamount);
														finalamount=finalamount.toFixed(2);
														taxamount=taxamount.toFixed(2);
														$('#termsOfContractGridId').jqxGrid('setcellvalue',rowindex,'taxvalue',taxamount);
									    				$('#termsOfContractGridId').jqxGrid('setcellvalue',rowindex,'nettotal',finalamount);
									    				if(rowindex==0){
				    										setMgmtFee();	
				    									}
									    			}
	                                			}
			    							}
			    						}
			    						setMgmtFee();
			    			        	funSetMgmtVATType();
			    			        	LoadManagementfeeGrid();
			    			        	if($('#txtnumofcheque').val()!=''){
			    			        		fillgrid();
			    			        	}
                            		});
                                }
                            },
                            { text: 'VAT Value',datafield:'taxvalue',editable:false,width:'10%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Net Total', datafield: 'nettotal', cellsformat: 'd2', width: '14%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Account', datafield: 'account', editable: false, width: '20%',hidden:true },
							 
						]
            });
            
            $("#termsOfContractGridId").on("cellclick", function (event) 
			{
			    
			    var rowBoundIndex = event.args.rowindex;
			    // row's visible index.
			    var rowVisibleIndex = event.args.visibleindex;
			    // right click.
			    var rightclick = event.args.rightclick; 
			    // original event.
			    var ev = event.args.originalEvent;
			    // column index.
			    var columnindex = event.args.columnindex;
			    // column data field.
			    var dataField = event.args.datafield;
			    // cell value
			    var value = event.args.value;    
			    
			    $('#termsOfContractGridrow').val(rowBoundIndex);
			}); 
			
			
			
			$("#termsOfContractGridId").on('cellvaluechanged', function (event) {
			    var datafield = event.args.datafield;
			    // row's bound index.
			    var rowBoundIndex = event.args.rowindex;
			    // new cell value.
			    var value = event.args.newvalue;
			    // old cell value.
			    var oldvalue = event.args.oldvalue;
			    $('#termsOfContractGridrow').val(rowBoundIndex);
			    
			    if(datafield=="amount" || datafield=="taxtype"){
			    	//alert(value);
			    	var amount=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowBoundIndex,'amount');
			    	if(parseFloat(amount)==0.0){
			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',0.0);
			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',amount);
			    	}
			    	var chktax=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowBoundIndex,'tax');
			    	//alert("Tax Type:"+$('#termsOfContractGridId').jqxGrid('getcellvalue',rowBoundIndex,'taxtype'));
			    	if(chktax){
			    		var taxtype=$('#termsOfContractGridId').jqxGrid('getcellvalue',rowBoundIndex,'taxtype');
			    		if(taxtype=='Inclusive'){
			    			if(amount!="" && amount!=null && amount!="undefined" && typeof(amount)!="undefined"){
			    				amount=parseFloat(amount);
			    				amount=amount.toFixed(2);
			    				var inclusiveamt=(amount/105)*100;
			    				inclusiveamt=Math.round(inclusiveamt).toFixed(2);
			    				var taxamount=amount-inclusiveamt;
			    				taxamount=taxamount.toFixed(2);
			    				$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',taxamount);
			    				$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',amount);
			    			}
			    		}
			    		else if(taxtype=='Exclusive'){
			    			if(amount!="" && amount!=null && amount!="undefined" && typeof(amount)!="undefined"){
			    				//alert(value);
			    				amount=parseFloat(amount);
			    				amount=amount.toFixed(2);
			    				var taxamount=amount*(5/100);
			    				taxamount=parseFloat(taxamount);
								taxamount=Math.round(taxamount).toFixed(2);
								var finalamount=parseFloat(amount)+parseFloat(taxamount);
								finalamount=parseFloat(finalamount);
								finalamount=finalamount.toFixed(2);
								console.log(finalamount+"::"+taxamount+"::"+amount);
								$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',taxamount);
			    				$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',finalamount);
			    			}
			    		}
			    		else{
			    			$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',0.0);
			    			$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',amount);
			    		}
			    	}
			    	else{
			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'taxvalue',0.0);
			    		$('#termsOfContractGridId').jqxGrid('setcellvalue',rowBoundIndex,'nettotal',amount);
			    	}
			    }
				// Calculate & Set Management Fee Value
				
				var rent= $("#termsOfContractGridId").jqxGrid('getcellvalue',0, 'nettotal');
				$('#hidrent').val(rent);	
				var mngperc=$('#txtmanagementperc').val();
				
				var mngval=parseFloat(rent*mngperc/100).toFixed(2);
					
				$('#txtmanagementval').val(mngval);
				if($('#txtcommisionval').val()!="" && $('#txtcommisionval').val()!=null && $('#txtcommisionval').val()!="undefined" && typeof($('#txtcommisionval').val())!="undefined"){
	        		calcCommissionPercent();
	        	}
				
				
				
				var nettotal = $("#termsOfContractGridId").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'], true);
	            var tot = nettotal.sum.replace(/,/g, '');
	        	var commissionvalue=$('#txtcommisionval').val();
	        	var commissiontax=$('#commvatamount').val();
	        	var grandtotal=0.0;
	        	grandtotal+=parseFloat(tot);
	        	if(commissionvalue!="" && commissionvalue!=null && commissionvalue!="undefined" && typeof(commissionvalue)!="undefined"){
	        		grandtotal+=parseFloat(commissionvalue);
	        	}
	        	if(commissiontax!="" && commissiontax!=null && commissiontax!="undefined" && typeof(commissiontax)!="undefined"){
	        		grandtotal+=parseFloat(commissiontax);
	        	}
	        	$('#txtnettotal,#hidnettotal').val(grandtotal.toFixed(2));
	        	setMgmtFee();
	        	funSetMgmtVATType();
	        	LoadManagementfeeGrid();
	        	if($('#txtnumofcheque').val()!=''){
	        		fillgrid();
	        	}
			});
			$("#termsOfContractGridId").on('cellbeginedit', function (event) {
				var datafield = event.args.datafield;
				if(datafield=="nettotal"){
					return false;
				}
			});
            if ($("#mode").val() == "A" || $("#mode").val() == "E") {
            	
          	  $("#termsOfContractGridId").jqxGrid({ disabled: false});
          	
			
          	
          }
            
            
        });

</script>
<div id="termsOfContractGridId"></div>
<input type="hidden" name="termsOfContractGridrow" id="termsOfContractGridrow">
    