<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO"%>
<%ClsEmployeeMasterDAO DAO= new ClsEmployeeMasterDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<style type="text/css">
  .statutoryDeductionClass
  {
      background-color: #FDF9EF;
  }
</style>
<script type="text/javascript">
		var tempMode='<%=mode%>';
		var tempDocNo='<%=docNo%>';
		var temp='0';
		
		var data1;
		
        $(document).ready(function () { 	
        	
        	if(tempMode=='A') {
        		
        		data1='<%=DAO.allowanceLoading()%>';
        		
         	 } else if(tempDocNo>0 && tempMode=='E') {
         		 
         		data1='<%=DAO.allowanceEditReloading(docNo)%>';
         		
         	 } else if(tempDocNo>0) {
         		 
          		data1='<%=DAO.allowanceReloading(docNo)%>';
          		
          	 } else {
         		 
         		 temp='1';
         	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'allowanceid', type: 'string' },
     						{name : 'allowance', type: 'string' },
     						{name : 'addition', type: 'number'   },
     						{name : 'deduction', type: 'number' },
     						{name : 'statutorydeduction', type: 'number' },
     						{name : 'actualsalary',type:'int'},
     						{name : 'remarks', type: 'string' },
     						{name : 'refdtype', type: 'string' },
     						{name : 'chktype', type: 'string' },
     						{name : 'appraisal', type: 'int' }
     						
                        ],
                		 localdata: data1, 
                
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
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Allowance ID', datafield: 'allowanceid', hidden: true,  width: '10%' },
							{ text: 'Allowance', datafield: 'allowance',  width: '20%',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "appraisal")>0)
							         {
							              return false;
							         }
								}
							},			
							{ text: 'Addition', datafield: 'addition', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "appraisal")>0)
							         {
							              return false;
							         }
							    	
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }
								}		
							},
							{ text: 'Deduction', datafield: 'deduction', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
									if ($('#compensationGridID').jqxGrid('getcellvalue', row, "appraisal")>0)
							         {
							              return false;
							         }
									
									if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")=="STD")
							         {
							              return false;
							         }
								}		
							},
							{ text: 'Statutory Deduction', datafield: 'statutorydeduction', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right', cellclassname: 'statutoryDeductionClass',
								cellbeginedit: function (row) {
									if ($('#compensationGridID').jqxGrid('getcellvalue', row, "appraisal")>0)
							         {
							              return false;
							         }							        
									if ($('#compensationGridID').jqxGrid('getcellvalue', row, "refdtype")!="STD")
							         {
							              return false;
							         }
								}	
							},
							
							{text:'Actual Salary',datafield:'actualsalary',width:'10%'},
							{ text: 'Remarks', datafield: 'remarks', width: '20%',
								cellbeginedit: function (row) {
							        if ($('#compensationGridID').jqxGrid('getcellvalue', row, "appraisal")>0)
							         {
							              return false;
							         }
								}	
							},
							{ text: 'Ref. Dtype', datafield: 'refdtype', hidden: true, width: '10%' },	
							{ text: 'Check Type', datafield: 'chktype', hidden: true, width: '10%' },
							{ text: 'Appraisal', datafield: 'appraisal', hidden: true, width: '5%' },
							
						]
            });

            //Add empty row
            if(temp=='1'){
           	   $("#compensationGridID").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo>0 && tempMode=='view'){
            	$("#compensationGridID").jqxGrid('disabled', true);
            }
            
            $("#compensationGridID").on('cellendedit', function (event) {
            	var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;
                var value = $('#compensationGridID').jqxGrid('getcellvalue', rowIndex, "chktype");
          		if(dataField=="statutorydeduction"){
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
 