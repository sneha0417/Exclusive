<%@page import="com.finance.transactions.budget.ClsBudgetDAO"%>
<% ClsBudgetDAO DAO= new ClsBudgetDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String assessmentYear = request.getParameter("assessmentyear")==null?"0":request.getParameter("assessmentyear");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>
   
<style type="text/css">
        .headClass
        {
            background-color: #CEFFCE;
        }
        
</style>
     
<script type="text/javascript">
        
       	var data;
       	var dataExcelExport;
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
            var temp1='<%=check%>';
             
            if(temp>0 && temp1=='2'){     
           	 data='<%=DAO.incomeGridReloading(session,docNo,assessmentYear,check)%>';
           	 dataExcelExport='<%=DAO.incomeGridExcelExportLoading(session,docNo,assessmentYear,check)%>';
            }
            else if(temp>0 && temp1=='3'){     
           	 data='<%=DAO.incomeGridEditReloading(session,docNo,assessmentYear,check)%>';
          	 } else  if(temp1=='1') {
           		 data='<%=DAO.incomeGridLoading(assessmentYear,check)%>';  
             }else {  
           		 data = '[{"columns":[{"text":"Doc No","datafield":"acno","cellsAlign":"center","align":"center","hidden":"true"},{"text":"Account","datafield":"account","cellsAlign":"left","align":"left","width":"6%"},{"text":"Account Name","datafield":"accountname","cellsAlign":"left","align":"left","width":"22%"},{"text":"","datafield":"monthamt1","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt2","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt3","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt4","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt5","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt6","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt7","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt8","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt9","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt10","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt11","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt12","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"Net Income","datafield":"netincome","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"10%","hidden":"true"},{"text":"Group Type","datafield":"grtype","cellsAlign":"center","align":"center","hidden":"true"}]},{"rows":[{"acno":"","account":"","accountname":"","monthamt1":"","monthamt2":"","monthamt3":"","monthamt4":"","monthamt5":"","monthamt6":"","monthamt7":"","monthamt8":"","monthamt9":"","monthamt10":"","monthamt11":"","monthamt12":"","netincome":"0.00","grtype":"4"}]}]';
           	 }
                       
             var obj = $.parseJSON(data);
             var columns = obj[0].columns;
             var rows = obj[1].rows; 
             
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
                		   localdata: rows, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#budgetIncomeGridID").jqxGrid({
                     width: '99.5%',
                     height: 180,
                     source: dataAdapter,
                     columns: columns,
                     columnsresize: true,
                     showaggregates: true,
                     editable: true,
                     selectionmode: 'singlecell',
                     localization: {thousandsSeparator: ""},
                       
            });
            
            if(temp>0 && temp1=='2'){
            	$("#budgetIncomeGridID").jqxGrid('disabled', true);
            }
            
            var netincomes1="";
            $("#budgetIncomeGridID").on('cellvaluechanged', function (event) {
            	   $('#budgetIncomeGridID11').jqxGrid('render');
             	  var rowindex1 =$('#rowindex').val();
            	var rowindex = event.args.rowindex;
            	 
           		 var monthamt1 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt1");
           		 var monthamt2 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt2");
           		 var monthamt3 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt3");
           		 var monthamt4 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt4");
           		 var monthamt5 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt5");
           		 var monthamt6 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt6");
           		 var monthamt7 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt7");
           	     var monthamt8 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt8");
           		 var monthamt9 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt9");
           		 var monthamt10 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt10");
           		 var monthamt11 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt11");
           		 var monthamt12 = $('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt12");
           			
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
           	 $('#budgetIncomeGridID11').jqxGrid('setcellvalue', rowindex1, "monthamt1" ,$('#budgetIncomeGridID').jqxGrid('getcellvalue', rowindex, "monthamt1"));
           		
           		var netincome = parseFloat(monthamt1)+parseFloat(monthamt2)+parseFloat(monthamt3)+parseFloat(monthamt4)+parseFloat(monthamt5)+parseFloat(monthamt6)+
           						 parseFloat(monthamt7)+parseFloat(monthamt8)+parseFloat(monthamt9)+parseFloat(monthamt10)+parseFloat(monthamt11)+parseFloat(monthamt12);
           			
           		 if(isNaN(netincome)) {
                 	   $('#budgetIncomeGridID').jqxGrid('setcellvalue', rowindex, "netincome" ,"0.00");
                 }
                       
                 if(!isNaN(netincome)){
                 	   $('#budgetIncomeGridID').jqxGrid('setcellvalue', rowindex, "netincome" ,netincome);
                 	  var netincomes=$('#budgetIncomeGridID').jqxGrid('getcolumnaggregateddata', 'netincome', ['sum'], true);
                      netincomes1=netincomes.sum;
                      if(!isNaN(netincomes1)) {
                		    funRoundAmt(netincomes1,"txttotalincome");
                		 } else {
                			funRoundAmt(0.00,"txttotalincome");
          		    }
                 }
           		   
            });
         	  
            $("#overlay, #PleaseWait").hide();
            
            var netincomes=$('#budgetIncomeGridID').jqxGrid('getcolumnaggregateddata', 'netincome', ['sum'], true);
            netincomes1=netincomes.sum;
            if(!isNaN(netincomes1)) {
      		    funRoundAmt(netincomes1,"txttotalincome");
      		 } else {
      			funRoundAmt(0.00,"txttotalincome");
		    }
           
        });
</script>
<div id="budgetIncomeGridID"></div>
