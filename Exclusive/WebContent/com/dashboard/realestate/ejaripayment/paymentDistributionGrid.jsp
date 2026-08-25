
<%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();
  
 %>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");%> 
<script type="text/javascript">
		 var data311;  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
             
             if(temp>0){   
            	 data311='<%=DAO.paymentloading(docno)%>';  
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
							{name : 'doc_no', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'amount', type: 'number'   },
     						{name : 'notes', type: 'string'   },
     						{name : 'chqno', type: 'string'   },
     						{name : 'paidto', type: 'string'   },
     						{name : 'paymentmethod', type: 'string'   },
     						{name : 'bankaccount', type: 'string'   },
     						{name : 'rdocno', type: 'string'   },
     						{name : 'recieptno',type:'string'}
                        ],
                         localdata: data311,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['Bank', 'Cash'];
            var list1 = ['Owner', 'Self'];
             
            $("#paymentDistributionGridId").jqxGrid(
            {
                width: '99.5%',
                height: 180,
                source: dataAdapter,
                editable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
               
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							}, 
							{ text: 'docno', datafield: 'doc_no', width: '15%',hidden:true  },	
							{ text: 'Description', datafield: 'description', width: '15%'  },	
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%'
								 },	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Notes', datafield: 'notes', width: '15%'}, 
							{ text: 'Cheque No', datafield: 'chqno' },
							
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                                      
	                                }
	                        },
	                        { text: 'Paid To', datafield: 'paidto', width: '13%' ,columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
						              }
						     },
				           /*  { text: 'Paid To', datafield: 'paidto', width: '15%'   },
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%'   }, */
							{ text: 'Bank', datafield: 'bankaccount', width: '13%'}, 
							{ text: 'Reciept No', datafield: 'recieptno', width: '10%'},   
							{ text: 'rdocno', datafield: 'rdocno', width: '15%',hidden:true  },	
						]
            });
            
            $('#paymentDistributionGridId').on('cellvaluechanged', function (event) 
            {   
       	            var rows = $('#paymentDistributionGridId').jqxGrid('getrows');
       	            var rowlength= rows.length;
       	            var rowindex1=event.args.rowindex;
       	            
       	            var nettotal= $("#paymentDistributionGridId").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);  
       				var tot=nettotal.sum.replace(/,/g,'');
       				
       				$('#txtnettotal').val(tot);
        	            
            }); 
          
              
        });

</script>
<div id="paymentDistributionGridId"></div>
    