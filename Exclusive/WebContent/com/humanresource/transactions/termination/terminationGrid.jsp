<%@page import="com.humanresource.transactions.termination.ClsTerminationDAO"%>
<%ClsTerminationDAO DAO= new ClsTerminationDAO(); %>   
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
String day = request.getParameter("day")==null?"0":request.getParameter("day");
String deprDate = request.getParameter("deprdate")==null?"0":request.getParameter("deprdate").trim();
String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
String empid = request.getParameter("empid")==null?"0":request.getParameter("empid"); 
String type = request.getParameter("type")==null?"0":request.getParameter("type");
%>

<style>
.totalprovisionamountClass {
       background-color: #E0F8F1;
}

.netpayamountClass {
	   background-color: #FBEFF5;
}
        
.whiteClass{
           background-color: #fff;
}
</style>

<script type="text/javascript">
		var data;
		
        $(document).ready(function () { 	
        	
        	 var temp='<%=check%>';
             var temp1='<%=trNo%>';
            
             if(temp=='1') {  
            	  data='<%=DAO.terminationDetailsProcessing(branch,deprDate,empid,check,type)%>';    
             } else if(temp1>0) {
            	  data='<%=DAO.terminationDetailsReloading(empid,trNo,docNo)%>'; 
             }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'terminations', type: 'string' },
     						{name : 'gratuity', type: 'number'   },
     						{name : 'leavesalary', type: 'number' },
     						{name : 'travel', type: 'number' }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
        		if (data.terminations == 'Total Provision Till Date') {
                    return "totalprovisionamountClass";
                } else if (data.terminations == 'Net Pay') {
                    return "netpayamountClass";
                }
                else{
                	return "whiteClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#terminationGridID").jqxGrid(
            {
            	width: '99%',
                height: 205, 
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center', cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: '', datafield: 'terminations', cellclassname: cellclassname, editable: false, width: '50%' },
							{ text: 'Gratuity', datafield: 'gratuity', cellclassname: cellclassname, cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#terminationGridID').jqxGrid('getcellvalue', row, "terminations")!='Deduction')
							         {
							              return false;
							         }} 
							},
							{ text: 'Leave Salary', datafield: 'leavesalary', cellclassname: cellclassname, cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#terminationGridID').jqxGrid('getcellvalue', row, "terminations")!='Deduction')
							         {
							              return false;
							         }}
							},
							{ text: 'Travel', datafield: 'travel', cellclassname: cellclassname, cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right',
								cellbeginedit: function (row) {
							        if ($('#terminationGridID').jqxGrid('getcellvalue', row, "terminations")!='Deduction')
							         {
							              return false;
							         }}
							},
						]
            });
            
            $("#overlay, #PleaseWait").hide();
            
            if(temp1>0){
            	$("#terminationGridID").jqxGrid('disabled', true);
            }
            
             
         	 $("#terminationGridID").on('cellvaluechanged', function (event){
         		var dataField = event.args.datafield;
         		
         		if(dataField=="gratuity"){
                	var totalprovisiongratuity = $('#terminationGridID').jqxGrid('getcellvalue', 2, "gratuity");
                	var tobeprovidedgratuity = $('#terminationGridID').jqxGrid('getcellvalue', 4, "gratuity");
                	var dedeductiongratuity = $('#terminationGridID').jqxGrid('getcellvalue', 5, "gratuity");
                	$('#terminationGridID').jqxGrid('setcellvalue', 6, "gratuity", (parseFloat(totalprovisiongratuity)-parseFloat(dedeductiongratuity)));
                	
                	$('#terminationAccountsGridID').jqxGrid('setcellvalue', 0, "credit" ,(parseFloat(totalprovisiongratuity)-parseFloat(dedeductiongratuity)));
                	var gratuityexpense=(parseFloat(tobeprovidedgratuity)-parseFloat(dedeductiongratuity));
                	if(parseFloat(gratuityexpense)<0){
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "credit" ,parseFloat(gratuityexpense)*-1);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "debit" ,"");
                	} else {
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "debit" ,gratuityexpense);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "credit" ,"");
                	}
           			
                }
         		
         		if(dataField=="leavesalary"){
                	var totalprovisionleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 2, "leavesalary");
                	var tobeprovidedleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 4, "leavesalary");
                	var dedeductionleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 5, "leavesalary");
                	$('#terminationGridID').jqxGrid('setcellvalue', 6, "leavesalary", (parseFloat(totalprovisionleavesalary)-parseFloat(dedeductionleavesalary)));
                	
                	$('#terminationAccountsGridID').jqxGrid('setcellvalue', 3, "credit" ,(parseFloat(totalprovisionleavesalary)-parseFloat(dedeductionleavesalary)));
           			var leavesalaryexpense=(parseFloat(tobeprovidedleavesalary)-parseFloat(dedeductionleavesalary));
                	if(parseFloat(leavesalaryexpense)<0){
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "credit" ,parseFloat(leavesalaryexpense)*-1);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "debit" ,"");
                	} else {
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "debit" ,leavesalaryexpense);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "credit" ,"");
                	}
           			
                }
                
                if(dataField=="travel"){
                	var totalprovisiontravel = $('#terminationGridID').jqxGrid('getcellvalue', 2, "travel");
                	var tobeprovidedtravel = $('#terminationGridID').jqxGrid('getcellvalue', 4, "travel");
                	var dedeductiontravel = $('#terminationGridID').jqxGrid('getcellvalue', 5, "travel");
                	$('#terminationGridID').jqxGrid('setcellvalue', 6, "travel", (parseFloat(totalprovisiontravel)-parseFloat(dedeductiontravel)));
                	
                	$('#terminationAccountsGridID').jqxGrid('setcellvalue', 6, "credit" ,(parseFloat(totalprovisiontravel)-parseFloat(dedeductiontravel)));
           			var travelexpense=(parseFloat(tobeprovidedtravel)-parseFloat(dedeductiontravel));
                	if(parseFloat(travelexpense)<0){
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "credit" ,parseFloat(travelexpense)*-1);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "debit" ,"");
                	} else {
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "debit" ,travelexpense);
                		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "credit" ,"");
                	}
                }
                
                var debit=$('#terminationAccountsGridID').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
                var debit1=debit.sum;
                
                var credit=$('#terminationAccountsGridID').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
                var credit1=credit.sum;
                
                funRoundAmt(debit1,"txtdrtotal");
                funRoundAmt(credit1,"txtcrtotal");
                
             }); 
            
        });
</script>
<div id="terminationGridID"></div>
 