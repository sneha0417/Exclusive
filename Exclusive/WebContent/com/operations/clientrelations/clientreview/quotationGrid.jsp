<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); %> 

<script type="text/javascript">

	    var data5= '<%=DAO.quotationLoading(cldocno) %>';

        $(document).ready(function () { 	

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'ref_type', type: 'string' },
     						{name : 'doc_no', type: 'int' },
     						{name : 'brand_name', type: 'string'   },
     						{name : 'model', type: 'string'  },
     						{name : 'spec', type: 'string'   },
     						{name : 'color', type: 'string'  },
     						{ name: 'unit', type: 'string' },
     						{name : 'frmdate', type: 'date' },
     						{name : 'todate', type: 'date' },
     						{name : 'rtype', type: 'string' },
     						{name : 'nettotal', type: 'number' }
     					     					     						  											
                 ],
                 localdata: data5,
                
                
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

            
            
            $("#quotationGridID").jqxGrid(
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
							{ text: 'Type', datafield: 'ref_type', width: '5%' },	
							{ text: 'Doc No.', datafield: 'doc_no', width: '6%' },			
							{ text: 'Brand', datafield: 'brand_name', width: '8%' },	
							{ text: 'Model', datafield: 'model', width: '8%' },	
							{ text: 'Specification', datafield: 'spec', width: '27%' },	
							{ text: 'Color', datafield: 'color', width: '8%' },	
							{ text: 'Unit', datafield: 'unit', width: '6%' },	
							{ text: 'Contract From', datafield: 'frmdate', cellsformat: 'dd.MM.yyyy' ,width: '8%' },
							{ text: 'Contract To', datafield: 'todate', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Rent Type', datafield: 'rtype', width: '8%' },
							{ text: 'Total', datafield: 'nettotal', cellsformat: 'd2',cellsalign:'right',align:'right', width: '8%' },
						 ],
            });
            
           
        });

</script>
<div id="quotationGridID"></div>
 