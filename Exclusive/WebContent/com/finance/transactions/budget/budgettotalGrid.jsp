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
        $(document).ready(function () { 
            
            var temp='<%=docNo%>';
            var temp1='<%=check%>';   
            if(temp>0 && (temp1=='2' || temp1=='3')){     
              	 data='<%=DAO.incomeGridReloading11(session,docNo,assessmentYear,check)%>';
               }else if(temp1=='1') {
           		 data='<%=DAO.incomeGridLoading11(assessmentYear,check)%>';  
             }else {  
           		 data = '[{"columns":[{"text":"","datafield":"accountname","cellsAlign":"left","align":"left","width":"28%"},{"text":"","datafield":"monthamt1","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt2","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt3","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt4","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt5","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt6","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt7","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt8","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt9","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt10","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt11","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"},{"text":"","datafield":"monthamt12","cellsAlign":"right","align":"right","cellsFormat":"d2","width":"6%"}]},{"rows":[{"accountname":"","monthamt1":"","monthamt2":"","monthamt3":"","monthamt4":"","monthamt5":"","monthamt6":"","monthamt7":"","monthamt8":"","monthamt9":"","monthamt10":"","monthamt11":"","monthamt12":""}]}]';
           	 }
              //alert("data"+data);
              
             var obj = $.parseJSON(data);     
             var columns = obj[0].columns;   
             var rows = obj[1].rows;
             
            // prepare the data
            var source =
            {     
                datatype: "json",   
                datafields: [
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
                        ],
                		   localdata: rows, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#budgetIncomeGridID11").jqxGrid({
                     width: '99.5%',
                     height: 100,  
                     source: dataAdapter,
                     columns: columns,
                     columnsresize: true,  
                     showaggregates: true,
                     editable: false,
                     selectionmode: 'singlecell',
                     localization: {thousandsSeparator: ""},
                       
            });
            if(temp>0 && (temp1=='2' || temp1=='3' || temp1=='1')){
            	$("#budgetIncomeGridID11").jqxGrid('disabled', true);
            }
            $("#overlay, #PleaseWait").hide();
        });
</script>
<div id="budgetIncomeGridID11"></div>
