<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); %> 

<script type="text/javascript">
        
       var data6= '<%=DAO.nonFinancialLoading(cldocno) %>';
     
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'comment', type: 'string' },
     						{name : 'date', type: 'date'   },
     						{name : 'user_name', type: 'string' },
     						{name : 'branchname', type: 'string' },
     						{name : 'doc_no', type: 'int' }
                          ],
                    localdata: data6,
                
                
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

            
            
            $("#nonFinancialCommentsGridID").jqxGrid(
            {
            	width: '100%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                sortable: true,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						       }  
							},
							{ text: 'Non Financial Comments', datafield: 'comment', width: '40%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },	
							{ text: 'User', datafield: 'user_name', width: '25%' },	
							{ text: 'Branch', datafield: 'branchname', width: '20%' },	
							{ text: 'Doc No', datafield: 'doc_no', hidden : true, width: '10%' },
						 ]
            });
            
            //Add empty row
     	   $("#nonFinancialCommentsGridID").jqxGrid('addrow', null, {}); 
            
     	  $('#nonFinancialCommentsGridID').on('rowdoubleclick', function (event) {
       			var rowindextemp = event.args.rowindex;
       			document.getElementById("rowindex").value = rowindextemp;
       			
       			document.getElementById("docno").value=$('#nonFinancialCommentsGridID').jqxGrid('getcellvalue', rowindextemp, "doc_no");
       		 	document.getElementById("txtnonfinancialcomment").value=$('#nonFinancialCommentsGridID').jqxGrid('getcellvalue', rowindextemp, "comment");
       	  		$('#jqxNonFinancialDate').val($('#nonFinancialCommentsGridID').jqxGrid('getcellvalue', rowindextemp, "date")) ;
       	  
       		    var value = $('#nonFinancialCommentsGridID').jqxGrid('getcellvalue', rowindextemp, "doc_no");
       		    nonFinancialCommentsContent('nonFinancialComments.jsp?docno='+value);
            }); 
        });
    </script>

<div id="nonFinancialCommentsGridID"></div>
 <input type="hidden" id="rowindex"/>