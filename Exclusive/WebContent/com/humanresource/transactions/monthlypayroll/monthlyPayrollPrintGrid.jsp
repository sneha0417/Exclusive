<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.monthlypayroll.ClsMonthlyPayrollDAO"%>
<%ClsMonthlyPayrollDAO DAO= new ClsMonthlyPayrollDAO(); %> 
<% String date = request.getParameter("date")==null?"0":request.getParameter("date");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 
<style type="text/css">
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
	     .toBeProcessedClass
        {
           background-color: #F7F6F6;
           color: #000000;
           font-weight: bold;
        }
	    .whiteClass
        {
           background-color: #FFF;
        }
	  
</style>
<script type="text/javascript">
		var temp='<%=check%>';
		
		var data3;
		
        $(document).ready(function () { 	
        	
        	if(temp=='1') { 
        		data3='<%=DAO.monthlyPayrollPrintGridLoading(date,category,empId,check)%>';     
          	}
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' },
     						{name : 'dates', type: 'date' },
     						{name : 'totaldays', type: 'number' },
     						{name : 'leave1', type: 'string'   },
     						{name : 'leave2', type: 'string'  },
     						{name : 'leave3', type: 'string'   },
     						{name : 'leave4', type: 'string'   },
     						{name : 'leave5', type: 'string' },
     						{name : 'leave6', type: 'string'  },
							{name : 'leave7', type: 'string' },
							{name : 'leave8', type: 'string'  },
     						{name : 'leave9', type: 'string' },
     						{name : 'leave10', type: 'string' },
     						{name : 'basic', type: 'number' },
     						{name : 'allowance1', type: 'number'   },
     						{name : 'allowance2', type: 'number'  },
     						{name : 'allowance3', type: 'number'   },
     						{name : 'allowance4', type: 'number'   },
     						{name : 'allowance5', type: 'number' },
     						{name : 'allowance6', type: 'number'  },
							{name : 'allowance7', type: 'number' },
							{name : 'allowance8', type: 'number'  },
     						{name : 'allowance9', type: 'number' },
     						{name : 'allowance10', type: 'number' },
     						{name : 'totalsalary', type: 'number' },
     						{name : 'ot', type: 'string' },
     						{name : 'hot', type: 'string' },
     						{name : 'overtime', type: 'number' },
     						{name : 'grosssalary', type: 'number' },
     						{name : 'additions', type: 'number' },
     						{name : 'deductions', type: 'number' },
     						{name : 'loan', type: 'number' },
     						{name : 'netsalary', type: 'number' },
     						{name : 'remarks', type: 'string' },
     						{name : 'employeedocno', type: 'int' },
     						{name : 'payrollprocessed', type: 'int' }
                        ],
                		 localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#monthlyPayrollPrintGridID").on("bindingcomplete", function (event) {
            	var tempLeaveTypeCount = $('#txtleavetypecount').val();
            	var tempAllowanceTypeCount = $('#txtallowancetypecount').val();
            	
				 if(tempLeaveTypeCount=='1'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave2');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave3');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='2'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave3');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='3'){
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='4'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='5'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='6'){
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='7'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='8'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='9'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'leave10');
				 } else{
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'leave2');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'leave3');
						$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'leave4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'leave5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'leave6');
						$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'leave7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'leave8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'leave9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'leave10');
				 }
				 
				 if(tempAllowanceTypeCount=='1'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance2');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance3');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='2'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance3');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='3'){
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='4'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='5'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='6'){
						$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='7'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='8'){
					    $('#monthlyPayrollPrintGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else if(tempAllowanceTypeCount=='9'){
		    			$("#monthlyPayrollPrintGridID").jqxGrid('hidecolumn', 'allowance10');
				 } else{
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'allowance2');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'allowance3');
						$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'allowance4');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'allowance5');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'allowance6');
						$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'allowance7');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'allowance8');
					    $('#monthlyPayrollPrintGridID').jqxGrid('showcolumn', 'allowance9');
		    			$("#monthlyPayrollPrintGridID").jqxGrid('showcolumn', 'allowance10');
				 }					 
            });
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });
            
            var cellclassname = function (row, column, value, data) {
        		if (data.payrollprocessed == '0') {
        			if($('#mode').val()=='E') {
                    	return "toBeProcessedClass";
        			} else {
        				return "whiteClass";
        			}
                } else{
                	return "whiteClass";
                };
            };

            
            $("#monthlyPayrollPrintGridID").jqxGrid(
            {
            	width: '100%',
                height: 440,
                source: dataAdapter,
                editable: true,
                selectionmode: 'checkbox',
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Emp. ID', datafield: 'employeeid', editable: false, cellclassname: cellclassname, width: '7%' },
							{ text: 'Emp. Name', datafield: 'employeename', editable: false, cellclassname: cellclassname, width: '17%' },
							{ text: 'Date', datafield: 'dates', cellsformat: 'dd.MM.yyyy', editable: false, cellclassname: cellclassname, width: '6%' },
							{ text: 'Total Days', datafield: 'totaldays', cellsformat: 'd2', width: '5%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype1").value, datafield: 'leave1', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },	
							{ text: ' '+document.getElementById("txtleavetype2").value, datafield: 'leave2', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype3").value, datafield: 'leave3', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype4").value, datafield: 'leave4', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype5").value, datafield: 'leave5', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype6").value, datafield: 'leave6', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype7").value, datafield: 'leave7', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype8").value, datafield: 'leave8', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype9").value, datafield: 'leave9', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype10").value, datafield: 'leave10', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: 'Earned Basic', datafield: 'basic', cellsformat: 'd2', width: '7%', editable: false, cellclassname: cellclassname, cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype1").value, datafield: 'allowance1', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },	
							{ text: 'Earned '+document.getElementById("txtallowancetype2").value, datafield: 'allowance2', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype3").value, datafield: 'allowance3', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype4").value, datafield: 'allowance4', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype5").value, datafield: 'allowance5', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype6").value, datafield: 'allowance6', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype7").value, datafield: 'allowance7', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype8").value, datafield: 'allowance8', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype9").value, datafield: 'allowance9', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype10").value, datafield: 'allowance10', cellsformat: 'd2', editable: false, cellclassname: cellclassname, width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned Total Salary', datafield: 'totalsalary', cellsformat: 'd2', editable: false, width: '10%', cellsalign: 'right', align: 'right', cellclassname: 'redClass' },
							{ text: 'OT', datafield: 'ot', editable: false, width: '5%', cellsalign: 'center', align: 'center'  },
							{ text: 'HOT', datafield: 'hot', editable: false, width: '5%', cellsalign: 'center', align: 'center' },
							{ text: 'Overtime', datafield: 'overtime', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'redClass' },
							{ text: 'Gross Salary', datafield: 'grosssalary', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'blueClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Additions', datafield: 'additions', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'yellowClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Deductions', datafield: 'deductions', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Loan', datafield: 'loan', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Netsalary', datafield: 'netsalary', editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'darkRedClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
							{ text: 'Remarks', datafield: 'remarks', width: '25%', cellbeginedit: function (row) {if ($('#mode').val()=='view') {return false;}}},
							{ text: 'Emp. ID', datafield: 'employeedocno', editable: false, width: '7%', hidden: true },
							{ text: 'Payroll Processed', datafield: 'payrollprocessed', editable: false, aggregates: ['sum'], aggregatesrenderer:rendererstring, width: '7%', hidden: true },
						],
            });
	         	
	        $("#overlay, #PleaseWait").hide();
	        
        });
</script>
<div id="monthlyPayrollPrintGridID"></div>
 