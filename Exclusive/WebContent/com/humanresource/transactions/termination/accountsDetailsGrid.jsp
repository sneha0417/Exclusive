<%@page import="com.humanresource.transactions.termination.ClsTerminationDAO"%>
<%ClsTerminationDAO DAO= new ClsTerminationDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%>
<script type="text/javascript">
        var temp='<%=check%>';
	    var temp1='<%=trNo%>';
		var data1;
		
        $(document).ready(function () { 
        	
        	if(temp=='2'){
        		data1='<%=DAO.accountDetailsGridLoading(empid,check)%>';     
        	}else if(temp1>0){
          	    data1='<%=DAO.accountDetailsReloading(empid,trNo,docNo)%>'; 
            } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'acno', type: 'int' },
							{name : 'account', type: 'int' },
     						{name : 'codeno', type: 'string' }, 
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   }
                        ],
                           localdata: data1,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#terminationAccountsGridID").on("bindingcomplete", function (event) {
            	
            	var alreadyprovidedgratuity="0",tobeprovidedgratuity="0",deductiongratuity="0",netpaygratuity="0",alreadyprovidedleavesalary="0",tobeprovidedleavesalary="0",deductionleavesalary="0",netpayleavesalary="0",alreadyprovidedtravel="0",tobeprovidedtravel="0",deductiontravel="0",netpaytravel="0";
            	
            	alreadyprovidedgratuity = $('#terminationGridID').jqxGrid('getcellvalue', 3, "gratuity");
       			tobeprovidedgratuity = $('#terminationGridID').jqxGrid('getcellvalue', 4, "gratuity");
       			deductiongratuity = $('#terminationGridID').jqxGrid('getcellvalue', 5, "gratuity");
       			netpaygratuity = $('#terminationGridID').jqxGrid('getcellvalue', 6, "gratuity");

       			alreadyprovidedleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 3, "leavesalary");
       			tobeprovidedleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 4, "leavesalary");
       			deductionleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 5, "leavesalary");
       			netpayleavesalary = $('#terminationGridID').jqxGrid('getcellvalue', 6, "leavesalary");
              
       			alreadyprovidedtravel = $('#terminationGridID').jqxGrid('getcellvalue', 3, "travel");
       			tobeprovidedtravel = $('#terminationGridID').jqxGrid('getcellvalue', 4, "travel");
       			deductiontravel = $('#terminationGridID').jqxGrid('getcellvalue', 5, "travel");
       			netpaytravel = $('#terminationGridID').jqxGrid('getcellvalue', 6, "travel"); 
       			
       			
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 0, "credit" ,netpaygratuity==null?0:netpaygratuity);
       			var gratuityexpense=(parseFloat(tobeprovidedgratuity)-parseFloat(deductiongratuity));
            	if(parseFloat(gratuityexpense)<0){
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "credit" ,parseFloat(gratuityexpense)*-1);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "debit" ,"");
            	} else {
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "debit" ,gratuityexpense);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 1, "credit" ,"");
            	}
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 2, "debit" ,alreadyprovidedgratuity);
       			
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 3, "credit" ,netpayleavesalary==null?0:netpayleavesalary);
       			var leavesalaryexpense=(parseFloat(tobeprovidedleavesalary)-parseFloat(deductionleavesalary));
            	if(parseFloat(leavesalaryexpense)<0){
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "credit" ,parseFloat(leavesalaryexpense)*-1);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "debit" ,"");
            	} else {
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "debit" ,leavesalaryexpense);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 4, "credit" ,"");
            	}
            	
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 5, "debit" ,alreadyprovidedleavesalary);
       			
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 6, "credit" ,netpaytravel==null?0:netpaytravel);
       			var travelexpense=(parseFloat(tobeprovidedtravel)-parseFloat(deductiontravel));
            	if(parseFloat(travelexpense)<0){
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "credit" ,parseFloat(travelexpense)*-1);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "debit" ,"");
            	} else {
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "debit" ,travelexpense);
            		$('#terminationAccountsGridID').jqxGrid('setcellvalue', 7, "credit" ,"");
            	}
       			$('#terminationAccountsGridID').jqxGrid('setcellvalue', 8, "debit" ,alreadyprovidedtravel);
       			
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#terminationAccountsGridID").jqxGrid(
            {
                width: '99%',
                height: 130, 
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Account Doc No', datafield: 'acno', hidden: true, width: '10%' },
							{ text: 'Account No', datafield: 'account',  width: '15%' },
							{ text: 'Account Name',   datafield: 'codeno',  width: '55%' },
							{ text: 'Debit', datafield: 'debit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Credit', datafield: 'credit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
						]
            });
            
            if(temp1>0){
            	$("#terminationAccountsGridID").jqxGrid('disabled', true);
            }
            
            var debit=$('#terminationAccountsGridID').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            var debit1=debit.sum;
            
            var credit=$('#terminationAccountsGridID').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            var credit1=credit.sum;
            
            funRoundAmt(debit1,"txtdrtotal");
            funRoundAmt(credit1,"txtcrtotal");
	        
            $("#overlay, #PleaseWait").hide();
            
        });
    </script>
    <div id="terminationAccountsGridID"></div>
    <input type="hidden" id="rowindex"/> 