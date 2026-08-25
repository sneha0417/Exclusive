<%@page import="com.dashboard.humanresource.monthlypayrollposting.ClsMonthlyPayrollPostingDAO"%>
<% ClsMonthlyPayrollPostingDAO DAO= new ClsMonthlyPayrollPostingDAO(); %>
<% String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim(); 
   String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim(); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %> 
           	  
<style type="text/css">
     
     .lightBlueClass { background-color: #CEECF5; }
     
     .whiteClass { background-color: #fff; }
</style>

<script type="text/javascript">

	 var temp='<%=branchval%>';
	 var data;
	 
	if(temp!='NA') {
		data= '<%=DAO.monthlyPayrollcategoryTotalGridLoading(branchval,upToDate,check)%>';
	}
	
	$(document).ready(function () {
		
		var rendererstring=function (aggregates){
	     	var value=aggregates['sum'];
	     	if(typeof(value) == "undefined" || typeof(value) == "NAN"){
           		value=0.00;
           	}
	     	value=(parseFloat(value)/parseFloat(2)).toFixed(2);
	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
		}
     		var rendererstring1=function (aggregates){
     		var value1=aggregates['sum1'];
     		return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     	}
     		
	    // prepare the data
	    var source =
	    {
	        datatype: "json",
	        datafields: [
						{ name : 'category', type: 'string'  },
						{ name : 'amount', type: 'number'  },
						{ name : 'pay_catid', type: 'int'  }
					   ],
					   localdata: data,
        
        	pager: function (pagenum, pagesize, oldpagenum) {
           	 // callback called when a page or page size is changed.
        	}
    	};
	    
	    var cellclassname = function (row, column, value, data) {
    		if (data.category == 'ALL') {
                return "lightBlueClass";
            } 
        };
  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#monthlyPayrollTotalGridID").jqxGrid(
    {
        width: '98%',
        height: 195,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
        localization: {thousandsSeparator: ""},
        
        columns: [
						{ text: 'Category', datafield: 'category', width: '60%' , cellclassname: cellclassname, aggregates: ['sum1'], aggregatesrenderer:rendererstring1 },
						{ text: 'Amount', datafield: 'amount', width: '40%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Category ID', datafield: 'pay_catid', width: '10%',hidden:true },
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();
    		
	$('#monthlyPayrollTotalGridID').on('rowdoubleclick', function (event) {
		 var rowIndex = event.args.rowindex;
		 var caregoryID=$('#monthlyPayrollTotalGridID').jqxGrid('getcelltext',rowIndex, "pay_catid");
		 var checks = 1;
		 $("#overlay, #PleaseWait").show();
		 $("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});
		 $("#payrollPostingJVGridID").jqxGrid('clear');
		 $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: false});$("#payrollPostingJVGridID").jqxGrid({ disabled: true});
		 $('#postingDate').jqxDateTimeInput({ disabled: false});
		 $("#monthlyPayrollPostingDiv").load("monthlyPayrollPostingGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate=01.'+$('#uptodate').val()+'&category='+caregoryID+'&checks='+checks);
	});
    
});	
	
</script>
<div id="monthlyPayrollTotalGridID"></div>