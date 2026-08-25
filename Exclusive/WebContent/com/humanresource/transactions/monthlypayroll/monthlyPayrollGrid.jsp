<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.monthlypayroll.ClsMonthlyPayrollDAO"%>
<%ClsMonthlyPayrollDAO DAO= new ClsMonthlyPayrollDAO(); %> 
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");
   String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String date = request.getParameter("date")==null?"0":request.getParameter("date");
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
        .lightyellowClass 
        {
        	background-color: /* #F2D9E6 */#d9f2e6;
        }
        .lightorangeClass
        {
        	background-color: #FFE6CC;
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
		var tempDocNo='<%=docNo%>';
		
		var data;
		
        $(document).ready(function () { 
        	//alert(temp);
        	if(temp=='1') { 
        		data='<%=DAO.monthlyPayrollGridLoading(date,category,empId,docNo,mode)%>';
        		console.log(data);
        	} else if(tempDocNo>0){   
        		data='<%=DAO.monthlyPayrollGridReloading(session,date)%>';     
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
     						{name : 'earnbasic', type: 'number' },
     						{name : 'earnallowance1', type: 'number'   },
     						{name : 'earnallowance2', type: 'number'  },
     						{name : 'earnallowance3', type: 'number'   },
     						{name : 'earnallowance4', type: 'number'   },
     						{name : 'earnallowance5', type: 'number' },
     						{name : 'earnallowance6', type: 'number'  },
							{name : 'earnallowance7', type: 'number' },
							{name : 'earnallowance8', type: 'number'  },
     						{name : 'earnallowance9', type: 'number' },
     						{name : 'earnallowance10', type: 'number' },
     						{name : 'totalearnedsalary', type: 'number' },
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
     						{name : 'payrollprocessed', type: 'int' },
     						{name : 'rowno', type: 'int' }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#monthlyPayrollGridID").on("bindingcomplete", function (event) {
            	var tempLeaveTypeCount = $('#txtleavetypecount').val();
            	var tempAllowanceTypeCount = $('#txtallowancetypecount').val();
            	
				 if(tempLeaveTypeCount=='1'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave2');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='2'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='3'){
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='4'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='5'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='6'){
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='7'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='8'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else if(tempLeaveTypeCount=='9'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'leave10');
				 } else{
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'leave2');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'leave3');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'leave4');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'leave5');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'leave6');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'leave7');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'leave8');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'leave9');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'leave10');
				 }
				 
				 if(tempAllowanceTypeCount=='1'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance2');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
		    			$('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance2');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='2'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance3');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='3'){
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='4'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance5');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='5'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='6'){
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
						$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='7'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='8'){
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
					    $('#monthlyPayrollGridID').jqxGrid('hidecolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else if(tempAllowanceTypeCount=='9'){
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'allowance10');
		    			$("#monthlyPayrollGridID").jqxGrid('hidecolumn', 'earnallowance10');
				 } else{
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'allowance2');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'allowance3');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'allowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'allowance5');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'allowance6');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'allowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'allowance8');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'allowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'allowance10');
		    			$('#monthlyPayrollGridID').jqxGrid('showcolumn', 'earnallowance2');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'earnallowance3');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'earnallowance4');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'earnallowance5');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'earnallowance6');
						$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'earnallowance7');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'earnallowance8');
					    $('#monthlyPayrollGridID').jqxGrid('showcolumn', 'earnallowance9');
		    			$("#monthlyPayrollGridID").jqxGrid('showcolumn', 'earnallowance10');
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

            
            $("#monthlyPayrollGridID").jqxGrid(
            {
            	width: '100%',
                height: 440,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
                              cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Emp. ID', pinned: true, datafield: 'employeeid', editable: false, cellclassname: cellclassname, width: '7%' },
							{ text: 'Emp. Name', pinned: true, datafield: 'employeename', editable: false, cellclassname: cellclassname, width: '17%' },
							{ text: 'Date', pinned: true, datafield: 'dates', cellsformat: 'dd.MM.yyyy', editable: false, cellclassname: cellclassname, width: '6%' },
							{ text: 'Total Days', pinned: true, datafield: 'totaldays', cellsformat: 'd2', width: '6%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype1").value, pinned: true, datafield: 'leave1', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },	
							{ text: ' '+document.getElementById("txtleavetype2").value, pinned: true, datafield: 'leave2', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype3").value, pinned: true, datafield: 'leave3', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype4").value, pinned: true, datafield: 'leave4', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype5").value, pinned: true, datafield: 'leave5', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype6").value, pinned: true, datafield: 'leave6', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype7").value, pinned: true, datafield: 'leave7', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype8").value, pinned: true, datafield: 'leave8', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype9").value, pinned: true, datafield: 'leave9', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: ' '+document.getElementById("txtleavetype10").value, pinned: true, datafield: 'leave10', width: '3%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center' },
							{ text: 'Basic', datafield: 'basic', cellsformat: 'd2', width: '7%', editable: false, cellclassname: 'lightorangeClass', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype1").value, datafield: 'allowance1', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },	
							{ text: ' '+document.getElementById("txtallowancetype2").value, datafield: 'allowance2', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype3").value, datafield: 'allowance3', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype4").value, datafield: 'allowance4', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype5").value, datafield: 'allowance5', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype6").value, datafield: 'allowance6', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype7").value, datafield: 'allowance7', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype8").value, datafield: 'allowance8', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype9").value, datafield: 'allowance9', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: ' '+document.getElementById("txtallowancetype10").value, datafield: 'allowance10', cellsformat: 'd2', editable: false, cellclassname: 'lightorangeClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Total Salary', datafield: 'totalsalary', cellsformat: 'd2', editable: false, width: '8%', cellsalign: 'right', align: 'right', cellclassname: 'darkRedClass' },
							{ text: 'Earned Basic', datafield: 'earnbasic', cellsformat: 'd2', width: '7%', editable: false, cellclassname: 'lightyellowClass', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype1").value, datafield: 'earnallowance1', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },	
							{ text: 'Earned '+document.getElementById("txtallowancetype2").value, datafield: 'earnallowance2', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype3").value, datafield: 'earnallowance3', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype4").value, datafield: 'earnallowance4', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype5").value, datafield: 'earnallowance5', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype6").value, datafield: 'earnallowance6', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype7").value, datafield: 'earnallowance7', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype8").value, datafield: 'earnallowance8', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype9").value, datafield: 'earnallowance9', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Earned '+document.getElementById("txtallowancetype10").value, datafield: 'earnallowance10', cellsformat: 'd2', editable: false, cellclassname: 'lightyellowClass', width: '7%', cellsalign: 'right', align: 'right' },
							{ text: 'Total Earned Salary', datafield: 'totalearnedsalary', cellsformat: 'd2', editable: false, width: '10%', cellsalign: 'right', align: 'right', cellclassname: 'darkRedClass' },
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
							{ text: 'rowno', datafield: 'rowno', editable: false, aggregates: ['sum'], aggregatesrenderer:rendererstring, width: '7%'},
						],
            });
	         	
	        $("#overlay, #PleaseWait").hide();
		     
		    var payrollprocessed1="";
	        var payrollprocessed=$('#monthlyPayrollGridID').jqxGrid('getcolumnaggregateddata', 'payrollprocessed', ['sum'], true);
	        payrollprocessed1=payrollprocessed.sum;
	        if(!isNaN(payrollprocessed1)){
      		    funRoundAmt(payrollprocessed1,"txtpayrollalreadyprocessed");
      		  }
      		 else{
		    	 funRoundAmt(0.00,"txtpayrollalreadyprocessed");
		     }
	        
        });
    </script>
    <div id="monthlyPayrollGridID"></div>
 