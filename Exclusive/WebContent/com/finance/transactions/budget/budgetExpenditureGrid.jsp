<%@page import="com.finance.transactions.budget.ClsBudgetDAO"%>
<% ClsBudgetDAO DAO= new ClsBudgetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String assessmentYear = request.getParameter("assessmentyear")==null?"0":request.getParameter("assessmentyear");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<style type="text/css">
        .headExpClass
        {
            background-color: #FFEBEB;
        }
        
</style>
     
<script type="text/javascript">
        
       	var data1; 
       	var dataExcelExport1;
        var rendererstring=function (aggregates){
          	var value=aggregates['sum'];
          	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
          }
        $(document).ready(function () {  
            
             var temp2='<%=docNo%>';
             var temp3='<%=check%>';
             
             if(temp2>0  && temp3=='2'){  
            	    data1='<%=DAO.expenditureGridReloading(session,docNo,assessmentYear,check)%>';
            	    dataExcelExport1='<%=DAO.expenditureGridExcelExportLoading(session,docNo,assessmentYear,check)%>';
           	 } else if(temp2>0  && temp3=='3'){  
            	    data1='<%=DAO.expenditureGridEditReloading(session,docNo,assessmentYear,check)%>';          
           	 } else if(temp3=='1') {
            		data1='<%=DAO.expenditureGridLoading(assessmentYear,check)%>'; 
             } else {
           			data1 = '[{"columns":[{"text":"Doc No","datafield":"acno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Account","datafield":"account","cellsAlign":"left","align":"left","width":"6%"},{"text":"Account Name","datafield":"accountname","cellsAlign":"left","align":"left","width":"22%"},{"text":"","datafield":"monthamt1","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt2","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt3","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt4","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt5","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt6","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt7","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt8","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt9","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt10","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt11","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt12","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"Net Expenditure","datafield":"netincome","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"10%","hidden":"true"},{"text":"Group Type","datafield":"grtype","cellsAlign":"center","align":"center","hidden":"true"}]},{"rows":[{"acno":"","account":"","accountname":"","monthamt1":"","monthamt2":"","monthamt3":"","monthamt4":"","monthamt5":"","monthamt6":"","monthamt7":"","monthamt8":"","monthamt9":"","monthamt10":"","monthamt11":"","monthamt12":"","netincome":"0.00","grtype":"5"}]}]';
           	 }   
                     
             var obj = $.parseJSON(data1);
             var columns1 = obj[0].columns;
             var rows1 = obj[1].rows;
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'acno', type: 'string' },
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'monthamt1', type: 'number'  },
     						{name : 'monthamt2', type: 'number' },
     						{name : 'monthamt3', type: 'number' },
     						{name : 'monthamt4', type: 'number' },
     						{name : 'monthamt5', type: 'number' },
     						{name : 'monthamt6', type: 'number' },
     						{name : 'monthamt7', type: 'number' },
     						{name : 'monthamt8', type: 'number' },
     						{name : 'monthamt9', type: 'number' },
     						{name : 'monthamt10', type: 'number' },
     						{name : 'monthamt11', type: 'number' },
     						{name : 'monthamt12', type: 'number' },
     						{name : 'grtype', type: 'string'  },
     						{name : 'netincome', type: 'number'  },
     						{name : 'total', type: 'number'  }
                        ],
                		   localdata: rows1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#budgetExpenditureGridID").jqxGrid({
                     width: '99.5%',
                     height: 180,
                     source: dataAdapter,
                     columns: columns1,
                     columnsresize: true,
                     editable: true,
                     showaggregates: true,
                     selectionmode: 'singlecell',
                     localization: {thousandsSeparator: ""},
                       
            });
           
            if(temp2>0 && temp3=='2'){
            	$("#budgetExpenditureGridID").jqxGrid('disabled', true);
            }
         	  
            var expenditure1="";
            $("#budgetExpenditureGridID").on('cellvaluechanged', function (event) {
            	 var rowindex = event.args.rowindex;
            	 
           		 var monthamt1 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt1");
           		 var monthamt2 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt2");
           		 var monthamt3 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt3");
           		 var monthamt4 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt4");
           		 var monthamt5 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt5");
           		 var monthamt6 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt6");
           		 var monthamt7 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt7");
           	     var monthamt8 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt8");
           		 var monthamt9 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt9");
           		 var monthamt10 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt10");
           		 var monthamt11 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt11");
           		 var monthamt12 = $('#budgetExpenditureGridID').jqxGrid('getcellvalue', rowindex, "monthamt12");
           			
           		if(isNaN(monthamt1) || monthamt1==null || monthamt1=="") { monthamt1="0.00"; }
           		
           		if(isNaN(monthamt2) || monthamt2==null || monthamt2=="") { monthamt2="0.00"; }
           		
           		if(isNaN(monthamt3) || monthamt3==null || monthamt3=="") { monthamt3="0.00"; }
           		
           		if(isNaN(monthamt4) || monthamt4==null || monthamt4=="") { monthamt4="0.00"; }
           		
           		if(isNaN(monthamt5) || monthamt5==null || monthamt5=="") { monthamt5="0.00"; }
           		
           		if(isNaN(monthamt6) || monthamt6==null || monthamt6=="") { monthamt6="0.00"; }
           		
           		if(isNaN(monthamt7) || monthamt7==null || monthamt7=="") { monthamt7="0.00"; }
           		
           		if(isNaN(monthamt8) || monthamt8==null || monthamt8=="") { monthamt8="0.00"; }
           		
           		if(isNaN(monthamt9) || monthamt9==null || monthamt9=="") { monthamt9="0.00"; }
           		
           		if(isNaN(monthamt10) || monthamt10==null || monthamt10=="") { monthamt10="0.00"; }
           		
           		if(isNaN(monthamt11) || monthamt11==null || monthamt11=="") { monthamt11="0.00"; }
           		
           		if(isNaN(monthamt12) || monthamt12==null || monthamt12=="") { monthamt12="0.00"; }
           		
           		var expenditure = parseFloat(monthamt1)+parseFloat(monthamt2)+parseFloat(monthamt3)+parseFloat(monthamt4)+parseFloat(monthamt5)+parseFloat(monthamt6)+
           						 parseFloat(monthamt7)+parseFloat(monthamt8)+parseFloat(monthamt9)+parseFloat(monthamt10)+parseFloat(monthamt11)+parseFloat(monthamt12);
           			
           		 if(isNaN(expenditure)) {
                 	   $('#budgetExpenditureGridID').jqxGrid('setcellvalue', rowindex, "netincome" ,"0.00");
                 }
                    
                 if(!isNaN(expenditure)){
                 	   $('#budgetExpenditureGridID').jqxGrid('setcellvalue', rowindex, "netincome" ,expenditure);
                 	  var expenditures=$('#budgetExpenditureGridID').jqxGrid('getcolumnaggregateddata', 'netincome', ['sum'], true);
                      expenditure1=expenditures.sum;
                      if(!isNaN(expenditure1)) {
                		    funRoundAmt(expenditure1,"txttotalexpenditure");
                		 } else {
                			funRoundAmt(0.00,"txttotalexpenditure");
          		    }
                 }
                 
                 
           		   
            });
         	  
            $("#overlay, #PleaseWait").hide();
            
            var expenditures=$('#budgetExpenditureGridID').jqxGrid('getcolumnaggregateddata', 'netincome', ['sum'], true);
            expenditure1=expenditures.sum;
            if(!isNaN(expenditure1)) {
      		    funRoundAmt(expenditure1,"txttotalexpenditure");
      		 } else {
      			funRoundAmt(0.00,"txttotalexpenditure");
		    }
           
        });
</script>
<div id="budgetExpenditureGridID"></div>
