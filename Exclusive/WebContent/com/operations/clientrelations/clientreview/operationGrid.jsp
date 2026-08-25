<%@page import="com.operations.clientrelations.clientreview.ClsClientReviewDAO" %>
<% ClsClientReviewDAO DAO=new ClsClientReviewDAO(); %>
<% String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
   String detailed = request.getParameter("detailed")==null?"0":request.getParameter("detailed"); %>  

<style type="text/css">
        .blueClass
        {
            background-color: #E0ECF8;
        }
        .whiteClass
        {
           background-color: #fff;
        }
</style>

<script type="text/javascript">

	    var data1= '<%=DAO.operationLoading(cldocno,detailed) %>';
	    
        $(document).ready(function () { 
        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'doc_no', type: 'int' },
     						{name : 'flname', type: 'string'   },
     						{name : 'clstatus', type: 'string'  },
     						{name : 'rentaltype', type: 'string'  },
     						{ name: 'rate', type: 'string' },
     						{ name: 'cdw', type: 'string' },
     						{name : 'brout', type: 'string' },
     						{name : 'odate', type: 'date' },
     						{name : 'otime', type: 'string' },
     						{name : 'okm', type: 'string' },
     						{name : 'ofuel', type: 'string' },
     						{name : 'brin', type: 'string' },
     						{name : 'indate', type: 'date' },
     						{name : 'intime', type: 'string' },
     						{name : 'infuel', type: 'string' },
     						{name : 'inkm', type: 'string' },
     						{name : 'status', type: 'number' }
     					     						  											
                 ],
                 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            var cellclassname = function (row, column, value, data) {
        		if (data.status == 0) {
                    return "blueClass";
                } else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#operationGridID").jqxGrid(
            {
            	width: '100%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
						  { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No.', datafield: 'doc_no', cellclassname: cellclassname, width: '5%' },	
							{ text: 'Fleet', datafield: 'flname', cellclassname: cellclassname, width: '10%' },	
							{ text: 'Status', datafield: 'clstatus', cellclassname: cellclassname, width: '4%' },	
							{ text: 'Rent Type', datafield: 'rentaltype', cellclassname: cellclassname, width: '6%' },	
							{ text: 'Rent', datafield: 'rate', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: cellclassname, width: '6%' },	
							{ text: 'CDW', datafield: 'cdw', cellsformat: 'd2',cellsalign:'right',align:'right', cellclassname: cellclassname, width: '6%' },
							{ text: 'Branch Out', datafield: 'brout', cellclassname: cellclassname, width: '9%' },
							{ text: 'Date Out', datafield: 'odate', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy' , width: '6%' },
							{ text: 'Time Out', datafield: 'otime', cellclassname: cellclassname, width: '4%' },
							{ text: 'KM Out', datafield: 'okm', cellclassname: cellclassname, width: '6%' },
							{ text: 'Fuel Out', datafield: 'ofuel', cellclassname: cellclassname, width: '5%' },
							{ text: 'Branch In', datafield: 'brin', cellclassname: cellclassname, width: '9%' },
							{ text: 'Date In', datafield: 'indate', cellclassname: cellclassname, cellsformat: 'dd.MM.yyyy' , width: '6%' },
							{ text: 'Time In', datafield: 'intime', cellclassname: cellclassname, width: '4%' },
							{ text: 'Fuel In', datafield: 'infuel', cellclassname: cellclassname, width: '4%' },
							{ text: 'KM In', datafield: 'inkm', cellclassname: cellclassname, width: '5%' },
							{ text: 'Status', datafield: 'status', cellclassname: cellclassname, hidden: true, width: '5%' },
						 ]
            });
            
            
        });

</script>

<div id="operationGridID"></div>

 