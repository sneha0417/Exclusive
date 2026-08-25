<%@page import="com.humanresource.transactions.appraisal.ClsAppraisalDAO" %>
<% ClsAppraisalDAO DAO=new ClsAppraisalDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno"); 
   String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>

<style type="text/css">
  .statutoryDeductionClass
  {
      background-color: #FDF9EF;
  }
</style>

<script type="text/javascript">
		var tempMode='<%=mode%>';
		var tempDocNo='<%=empdocno%>';
		var temp='0';
		var docnos='<%=docno%>';
		
		var saldata;
		
        $(document).ready(function () { 	
        	
        	if(tempMode=='A') {
        		saldata;
         	} else if(docnos>0 && tempMode=='E' ) {
         		saldata= '<%=DAO.grideeditsearch(docno)%>';   
         	}else if(docnos>0) {
         		saldata= '<%=DAO.relodesearch(docno)%>';  
         	} else if(tempDocNo>0) {
         	    saldata= '<%=DAO.basicsalaryfristsearch(empdocno)%>';  
          	} else {
         		 temp='1';
         	}
        	
            // prepare the data allowanceid
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'allowanceid', type: 'string' },
     						{name : 'allowance', type: 'string' },
     						{name : 'addition', type: 'number'   },
     						{name : 'deduction', type: 'number' },
     						{name : 'statutorydeduction', type: 'number' }, 
     						{name : 'revadd', type: 'number'   },
     						{name : 'revded', type: 'number' },
     						{name : 'revstatded', type: 'number' },
     						{name : 'remarks', type: 'string' },
     						{name : 'refdtype', type: 'string' },
     						{name : 'chktype', type: 'string' }
                        ],
                		 localdata: saldata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#compensationGridID").jqxGrid(
            {
            	width: '100%',
                height: 251,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                disabled:true,
               
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Allowance ID', datafield: 'allowanceid', hidden: true,  width: '10%' },
							{ text: 'Allowance', datafield: 'allowance',  width: '20%' ,editable: false},			
							{ text: 'Addition', datafield: 'addition', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }}		
							},
							{ text: 'Deduction', datafield: 'deduction', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }}		
							},
							{ text: 'Statutory Deduction', datafield: 'statutorydeduction', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', cellclassname: 'statutoryDeductionClass',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")!="STD")
							         {
							              return false;
							         }}	
							},
							{ text: 'Revised Addition', datafield: 'revadd', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }}
							},
							{ text: 'Revised Deduction', datafield: 'revded', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }}
							},
							{ text: 'Revised Statutory Deduction', datafield: 'revstatded', cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right', cellclassname: 'statutoryDeductionClass',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")!="STD")
							         {
							              return false;
							         }}	
							},
							{ text: 'Remarks', datafield: 'remarks', width: '23%' },
							{ text: 'Ref. Dtype', datafield: 'refdtype', hidden: true, width: '10%' },	
							{ text: 'Check Type', datafield: 'chktype', hidden: true, width: '10%' }	
						]
            });

            //Add empty row
            if(temp=='1'){
           	   $("#compensationGridID").jqxGrid('addrow', null, {});
             }
            
          
           if ($("#mode").val() == "A" ||$("#mode").val() == "E" ) {
         	     $("#compensationGridID").jqxGrid({ disabled: false});
           }
             
            $("#compensationGridID").on('cellendedit', function (event) {
            	var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;
                var value = $('#compensationGridID').jqxGrid('getcellvalue', rowIndex, "chktype");
          		if(dataField=="statutorydeduction"){
          			var value1 = event.args.value;
          			if(value=='1'){ 
          			if(parseFloat(value1)>100){ 
          		        $("#compensationGridID").jqxGrid('showvalidationpopup', (rowIndex-1), "revadd", "Limit Already Reached,Invalid Amount.");
          		        $('#txtvalidation').val(1);
          		         return true;  
          		        }
          		    else if(parseFloat(value1)<=100){
          		        $("#compensationGridID").jqxGrid('hidevalidationpopups');
          		        $('#txtvalidation').val(0);
          		        return false;  
          		        }
          			}
          		}  
          		
          		if(dataField=="revstatded"){
          			var value1 = event.args.value;
          			if(value=='1'){ 
          			if(parseFloat(value1)>100){ 
          		        $("#compensationGridID").jqxGrid('showvalidationpopup', (rowIndex-1), "remarks", "Limit Already Reached,Invalid Amount.");
          		        $('#txtvalidation').val(1);
          		         return true;  
          		        }
          		    else if(parseFloat(value1)<=100){
          		        $("#compensationGridID").jqxGrid('hidevalidationpopups');
          		        $('#txtvalidation').val(0);
          		        return false;  
          		        }
          			}
          		}
             });
            
        });

</script>
<div id="compensationGridID"></div>
 