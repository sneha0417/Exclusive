<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
   String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
   String detailed = request.getParameter("detailed")==null?"0":request.getParameter("detailed"); %> 

<script type="text/javascript">
        
     var data2= '<%=DAO.paymentFollowUpLoading(accountno,cldocno,detailed) %>'; 
        
     $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'remarks', type: 'string' },
     						{name : 'fdate', type: 'date' },
     						{name : 'date', type: 'date'   },
     						{name : 'user_name', type: 'string'  },
     						{name : 'branchname', type: 'string'   }
                          ],
                  localdata: data2, 
                
                
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

            
            
            $("#financialCommentsGridID").jqxGrid(
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
							{ text: 'Financial Comments', datafield: 'remarks', width: '40%' },	
							{ text: 'Followup Date', datafield: 'fdate', cellsformat: 'dd.MM.yyyy' , width: '10%' },			
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },	
							{ text: 'User', datafield: 'user_name', width: '25%' },	
							{ text: 'Branch', datafield: 'branchname', width: '15%' },	
						 ]
            });
        	   
        });
    </script>
    <div id="financialCommentsGridID"></div>
 