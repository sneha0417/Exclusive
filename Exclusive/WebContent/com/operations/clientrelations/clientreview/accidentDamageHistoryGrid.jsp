<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); %> 
<script type="text/javascript">
        
	    var data4= '<%=DAO.accidentDamageLoading(cldocno) %>';
        
		$(document).ready(function () { 	
      
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'rfleet', type: 'int' },
     						{name : 'flname', type: 'string' },
     						{name : 'acdate', type: 'date'   },
     						{name : 'place', type: 'string'  },
     						{name : 'type', type: 'string'   },
     						{name : 'amount', type: 'number'  }
     					     						  											
                 ],
                 localdata: data4, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#accidentDamageGridID").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                sortable: true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Fleet No.', datafield: 'rfleet', width: '10%' },	
							{ text: 'Fleet Name', datafield: 'flname', width: '25%' },			
							{ text: 'Acc. Date', datafield: 'acdate', cellsformat: 'dd.MM.yyyy', width: '10%' },	
							{ text: 'Acc. Place', datafield: 'place', width: '30%' },	
							{ text: 'Acc. Type', datafield: 'type', width: '10%' },	
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2',cellsalign:'right',align:'right', width: '15%' },	
						 ]
            });
            
        });
		
</script>
<div id="accidentDamageGridID"></div>
 