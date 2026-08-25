<%@page import="com.dashboard.humanresource.monthlypayrollposting.ClsMonthlyPayrollPostingDAO"%>
<% ClsMonthlyPayrollPostingDAO DAO= new ClsMonthlyPayrollPostingDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String checks = request.getParameter("checks")==null?"0":request.getParameter("checks").trim();%>
<style>
 		 .redClass
        {
            background-color: #FFEBEB;
        }
        .blueClass
	    {
	        background-color: #E0F8F1;
	    }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
         .greenClass
        {
           background-color: #F1F8E0;
        }
	    .darkRedClass
	    {
	       background-color: #FFD3D5;
	    }
	    .whiteClass
        {
           background-color: #FFF;
        }
</style>
        
<script type="text/javascript">
      var data1;
      var temp1='<%=branchval%>';
      
	  	if(temp1!='NA'){ 
	  		    data1='<%=DAO.monthlyPayrollPostingGridLoading(branchval, upToDate,category,checks)%>';   
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined" || typeof(value) == "NAN"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{ name : 'employeeid', type: 'string' },
     						{ name : 'employeename', type: 'string' },
     						{ name : 'dates', type: 'string' },
     						{ name : 'daystopay', type: 'number' },
     						{ name : 'basicsalary', type: 'number' },
     						{ name : 'totalsalary', type: 'number' },
     						{ name : 'overtime', type: 'number' },
     						{ name : 'grosssalary', type: 'number' },
     						{ name : 'additions', type: 'number' },
     						{ name : 'deductions', type: 'number' },
     						{ name : 'loan', type: 'number' },
     						{ name : 'netsalary', type: 'number' },
     						{ name : 'remarks', type: 'string' },
     						{ name : 'employeedocno', type: 'int' },
     						{ name : 'empcatid', type: 'int' },
     						{ name : 'rdocno', type: 'int' }
	            			],
                			localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            var cellclassname = function (row, column, value, data) {
        		if (data.rdocno != '0') {
        				return "whiteClass";
                } else{
                	return "whiteClass";
                };
            };
            
            $("#monthlyPayrollPostingGridID").jqxGrid(
            {
            	width: '98%',
    	        height: 260,
    	        source: dataAdapter,
    	        showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
    	        filtermode:'excel',
    	        filterable: true,
    	        selectionmode: 'checkbox',
    	        pagermode: 'default',
    	        sortable:false,
                
                columns: [
						{ text: 'Emp. ID', pinned: true, datafield: 'employeeid', editable: false, cellclassname: cellclassname, width: '7%' },
						{ text: 'Emp. Name', pinned: true, datafield: 'employeename', editable: false, cellclassname: cellclassname, width: '17%' },
						{ text: 'Date', pinned: true, datafield: 'dates', editable: false, cellclassname: cellclassname, width: '6%' },
						{ text: 'Days To Pay', pinned: true, datafield: 'daystopay', cellsformat: 'd2', width: '6%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Earned Basic', datafield: 'basicsalary', cellsformat: 'd2', width: '8%', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Earned Allowances', datafield: 'totalsalary', cellsformat: 'd2', editable: false, width: '10%', cellsalign: 'right', align: 'right', cellclassname: 'redClass', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Overtime', datafield: 'overtime', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'redClass', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Gross Salary', datafield: 'grosssalary', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'blueClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Additions', datafield: 'additions', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'yellowClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Deductions', datafield: 'deductions', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Loan', datafield: 'loan', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Netsalary', datafield: 'netsalary', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'darkRedClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Remarks', datafield: 'remarks', editable: false, width: '25%'},
						{ text: 'Emp. ID', datafield: 'employeedocno', editable: false, width: '7%', hidden: true },
						{ text: 'Emp. CategoryID', datafield: 'empcatid', editable: false, width: '7%', hidden: true },
						{ text: 'Payroll Doc No', datafield: 'rdocno', editable: false, width: '7%', hidden: true },
					 ]
            });
            
            if(temp1=='NA'){
                $("#monthlyPayrollPostingGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
  });
                       
</script>
<div id="monthlyPayrollPostingGridID"></div>