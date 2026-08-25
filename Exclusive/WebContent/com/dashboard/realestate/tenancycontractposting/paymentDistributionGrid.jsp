<%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%
ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<style>
.greenClass
{
	background-color: #ACF6CB;
}
</style>
<script type="text/javascript">
		 var paymentdata=[];  
        $(document).ready(function () { 
           
            var temp='<%=docno%>';
            var id='<%=id%>';
             if(id=="1"){   
            	 paymentdata='<%=DAO.paymentloading(docno)%>';  
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
                         localdata: paymentdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
			var cellclassname = function (row, column, value, data) {
        		if($('#searshgrid1').jqxGrid('getcellvalue',$('#maingridrowindex').val(),'recieptstatus')=="1"){
            		return "greenClass";
            	}
        	};
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['Bank', 'Cash','On Account'];
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
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							}, 
							{ text: 'docno', datafield: 'doc_no', width: '15%',hidden:true,cellclassname: cellclassname  },	
							{ text: 'Description', datafield: 'description', width: '15%' ,cellclassname: cellclassname },	
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '8%',cellclassname: cellclassname},	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname  },
							{ text: 'Notes', datafield: 'notes', width: '15%',cellclassname: cellclassname}, 
							{ text: 'Cheque No', datafield: 'chqno' ,cellclassname: cellclassname},
							
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%',columntype:'dropdownlist',cellclassname: cellclassname,
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                                      
	                                }
	                        },
	                        { text: 'Paid To', datafield: 'paidto', width: '13%' ,columntype:'dropdownlist',cellclassname: cellclassname,
                                createeditor: function (row, column, editor) {
                                    editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
						              }
						     },
				           /*  { text: 'Paid To', datafield: 'paidto', width: '15%',cellclassname: cellclassname   },
							{ text: 'Payment', datafield: 'paymentmethod', width: '7%' ,cellclassname: cellclassname  }, */
							{ text: 'Bank', datafield: 'bankaccount', width: '13%',cellclassname: cellclassname}, 
							{ text: 'Reciept No', datafield: 'recieptno', width: '10%',cellclassname: cellclassname},   
							{ text: 'rdocno', datafield: 'rdocno', width: '15%',hidden:true,cellclassname: cellclassname  },	
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
    