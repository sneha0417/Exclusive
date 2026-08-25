<%@page import="com.humanresource.transactions.terminationbenefits.ClsTerminationBenefitsDAO"%>
<% ClsTerminationBenefitsDAO DAO= new ClsTerminationBenefitsDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
String day = request.getParameter("day")==null?"0":request.getParameter("day");
String deprDate = request.getParameter("deprdate")==null?"0":request.getParameter("deprdate").trim();
String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");%>

<style>
.currentamountClass {
       background-color: #FFFFD1;
}

.alreadypostedamountClass {
	  background-color: #E0F8F1;
}

.tobepostedamountClass {
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
            	  data='<%=DAO.terminationDetailsProcessing(branch,deprDate)%>';    
             } else if(temp=='2') {  
           	      data='<%=DAO.terminationDetailsCalculating(branch,deprDate)%>';
             } else if(temp1>0) {
            	  data='<%=DAO.terminationBenefitsReloading(docNo,trNo)%>';
            	  dataExcelExport='<%=DAO.terminationBenefitsExcelExport(docNo,trNo)%>';
             } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'employeedocno', type: 'string' },
							{name : 'employeeid', type: 'string' },
     						{name : 'employeename', type: 'string' }, 
     						{name : 'designation', type: 'string'   },
     						{name : 'category', type: 'string'   },
     						{name : 'joiningdate', type: 'date'  },
     						{name : 'salary', type: 'number'   },
     						{name : 'terminalbenefitsyears', type: 'string'   },
     						{name : 'terminalbenefitsdaystobeposted', type: 'string' },
     						{name : 'terminalbenefitscurrentprovision', type: 'number' },
     						{name : 'terminalbenefitsalreadyposted', type: 'number' },
     						{name : 'terminalbenefitstobeposted', type: 'number'   },
     						{name : 'leavesalary', type: 'number'   },
     						{name : 'leavesalarydaystobeposted', type: 'string' },
     						{name : 'leavesalarytotaldaysposted', type: 'number' },
     						{name : 'leavesalarycurrentprovision', type: 'number' },
     						{name : 'leavesalaryalreadyposted', type: 'number' },
     						{name : 'leavesalarytobeposted', type: 'number' },
     						{name : 'travelstotalperyear', type: 'string' },
     						{name : 'travelsdaystobeposted', type: 'string' },
     						{name : 'travelstotaldaysposted', type: 'string' },
     						{name : 'travelstotal', type: 'number' },
     						{name : 'travelsalreadyposted', type: 'number' },
     						{name : 'travelstobeposted', type: 'number' }
                        ],
                            localdata: data,    
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
    	        if(typeof(data.terminalbenefitscurrentprovision)=="undefined" || data.terminalbenefitscurrentprovision=="" ){
    	        	return "whiteClass"; 
    	        }
    	        else if(typeof(data.terminalbenefitscurrentprovision)!="undefined" && data.terminalbenefitscurrentprovision!="" ){
    	        	return "currentamountClass";
    	        };
    	      };
    	      
    	      var cellclassname1 = function (row, column, value, data) {
      	        
      	        if(typeof(data.terminalbenefitsalreadyposted)=="undefined" || data.terminalbenefitsalreadyposted=="" ){
      	        	return "whiteClass"; 
      	        }
      	        else if(typeof(data.terminalbenefitsalreadyposted)!="undefined" && data.terminalbenefitsalreadyposted!="" ){
      	        	return "alreadypostedamountClass";
      	        };
      	      };
      	      
			 var cellclassname2 = function (row, column, value, data) {
      	        
      	        if(typeof(data.terminalbenefitstobeposted)=="undefined" || data.terminalbenefitstobeposted=="" ){
      	        	return "whiteClass"; 
      	        }
      	        else if(typeof(data.terminalbenefitstobeposted)!="undefined" && data.terminalbenefitstobeposted!="" ){
      	        	return "tobepostedamountClass";
      	        };
      	      };
      	      
		     var cellclassname3 = function (row, column, value, data) {
      	        
      	        if(typeof(data.leavesalarytobeposted)=="undefined" || data.leavesalarytobeposted=="" ){
      	        	return "whiteClass"; 
      	        }
      	        else if(typeof(data.leavesalarytobeposted)!="undefined" && data.leavesalarytobeposted!="" ){
      	        	return "tobepostedamountClass";
      	        };
      	      };
      	      
		     var cellclassname4 = function (row, column, value, data) {
      	        
      	        if(typeof(data.travelstobeposted)=="undefined" || data.travelstobeposted=="" ){
      	        	return "whiteClass"; 
      	        }
      	        else if(typeof(data.travelstobeposted)!="undefined" && data.travelstobeposted!="" ){
      	        	return "tobepostedamountClass";
      	        };
      	      };
    	          
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#terminationBenefitsDetails").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                editable: false,
                columnsresize: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              columngroup:'employeeinfo',cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Emp. Doc No', datafield: 'employeedocno', hidden: true, width: '8%', columngroup:'employeeinfo' },
							{ text: 'Emp. ID', datafield: 'employeeid',  width: '5%', columngroup:'employeeinfo' },
							{ text: 'Emp. Name',   datafield: 'employeename',  width: '20%', columngroup:'employeeinfo' },
							{ text: 'Designation', datafield: 'designation', editable: false, width: '11%', columngroup:'employeeinfo' },
							{ text: 'Category', datafield: 'category', editable: false, width: '10%', columngroup:'employeeinfo' },
							{ text: 'Date of Joining', datafield: 'joiningdate', cellsformat: 'dd.MM.yyyy', editable: false, width: '6%', columngroup:'employeeinfo' },	
							
							{ text: 'Salary to be Calculated', datafield: 'salary', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'terminalbenefits' },
							{ text: 'Worked(Yrs)', datafield: 'terminalbenefitsyears', width: '5%', cellsalign: 'center', align: 'center', columngroup:'terminalbenefits' },
							{ text: 'Eligible Days', datafield: 'terminalbenefitsdaystobeposted', width: '5%', cellsalign: 'center', align: 'center', columngroup:'terminalbenefits' },
							{ text: 'Current Provision', datafield: 'terminalbenefitscurrentprovision', editable: false, width: '10%', cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'terminalbenefits' },
							{ text: 'Already Posted', datafield: 'terminalbenefitsalreadyposted', editable: false, width: '10%', cellclassname: cellclassname1, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'terminalbenefits' },
							{ text: 'To be Posted', datafield: 'terminalbenefitstobeposted', editable: false, width: '10%', cellclassname: cellclassname2, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'terminalbenefits' },
							
							{ text: 'Leave Salary to be Calculated', datafield: 'leavesalary', width: '12%', cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'leavesalary' },
							{ text: 'Current Eligible Days', datafield: 'leavesalarydaystobeposted', width: '5%', hidden: true, cellsalign: 'center', align: 'center', columngroup:'leavesalary' },
							{ text: 'Eligible Days', datafield: 'leavesalarytotaldaysposted', width: '5%', cellsalign: 'center', align: 'center', cellsformat: 'd2', columngroup:'leavesalary' },
							{ text: 'Current Provision', datafield: 'leavesalarycurrentprovision', editable: false, width: '10%', cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'leavesalary' },
							{ text: 'Already Posted', datafield: 'leavesalaryalreadyposted', editable: false, width: '10%', cellclassname: cellclassname1, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'leavesalary' },
							{ text: 'To be Posted', datafield: 'leavesalarytobeposted', editable: false, width: '10%', cellclassname: cellclassname3, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'leavesalary' },
							
							{ text: 'Total/Year', datafield: 'travelstotalperyear', width: '5%', cellsalign: 'center', align: 'center', columngroup:'travels' },
							{ text: 'Current Eligible Days', datafield: 'travelsdaystobeposted', width: '5%', hidden: true, cellsalign: 'center', align: 'center', columngroup:'travels' },
							{ text: 'Eligible Days', datafield: 'travelstotaldaysposted', width: '5%', cellsalign: 'center', align: 'center', columngroup:'travels' },
							{ text: 'Total', datafield: 'travelstotal', editable: false, width: '10%', cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'travels' },
							{ text: 'Already Posted', datafield: 'travelsalreadyposted', editable: false, width: '10%', cellclassname: cellclassname1, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'travels' },
							{ text: 'To be Posted', datafield: 'travelstobeposted', editable: false, width: '10%', cellclassname: cellclassname4, cellsformat: 'd2', cellsalign: 'right', align: 'right', columngroup:'travels' },
							
						], columngroups: 
		                     [
		                       { text: 'Employee Informations', align: 'center', name: 'employeeinfo',width: '20%' },
		                       { text: 'Terminal Benefits', align: 'center', name: 'terminalbenefits',width: '10%' },
		                       { text: 'Leave Salary', align: 'center', name: 'leavesalary',width: '8%' },
		                       { text: 'Travels', align: 'center', name: 'travels',width: '8%' }
		                     ] 
            });
            
            if(temp1>0){
            	$("#terminationBenefitsDetails").jqxGrid('disabled', true);
            }
            
           
            var terminalbenefitstobeposted=$('#terminationBenefitsDetails').jqxGrid('getcolumnaggregateddata', 'terminalbenefitstobeposted', ['sum'], true);
            var terminalbenefitstobeposted1=terminalbenefitstobeposted.sum;
            
            var leavesalarytobeposted=$('#terminationBenefitsDetails').jqxGrid('getcolumnaggregateddata', 'leavesalarytobeposted', ['sum'], true);
            var leavesalarytobeposted1=leavesalarytobeposted.sum; 
            
            var travelstobeposted=$('#terminationBenefitsDetails').jqxGrid('getcolumnaggregateddata', 'travelstobeposted', ['sum'], true);
            var travelstobeposted1=travelstobeposted.sum; 
           
	        if(!isNaN(terminalbenefitstobeposted1)){
		           document.getElementById("txtterminalbenefitstotal").value=terminalbenefitstobeposted1;
		           
		           if ($("#mode").val() == "A") {
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 0, "debit" ,terminalbenefitstobeposted1);
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 3, "credit" ,terminalbenefitstobeposted1);
		           }
	        }
	        
	        if(!isNaN(leavesalarytobeposted1)){
		           document.getElementById("txtleavesalarytotal").value=leavesalarytobeposted1;
		           
		           if ($("#mode").val() == "A") {
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 1, "debit" ,leavesalarytobeposted1);
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 4, "credit" ,leavesalarytobeposted1);
		           }
	        }
	        
	        if(!isNaN(travelstobeposted1)){
		           document.getElementById("txttravelstotal").value=travelstobeposted1;
		           
		           if ($("#mode").val() == "A") {
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 2, "debit" ,travelstobeposted1);
		           		$('#terminationBenefitsAccounts').jqxGrid('setcellvalue', 5, "credit" ,travelstobeposted1);
		           }
	        }
	           
	        funRoundAmt(parseFloat($('#txtterminalbenefitstotal').val())+parseFloat($('#txtleavesalarytotal').val())+parseFloat($('#txttravelstotal').val()),"txtdrtotal");
	        funRoundAmt(parseFloat($('#txtterminalbenefitstotal').val())+parseFloat($('#txtleavesalarytotal').val())+parseFloat($('#txttravelstotal').val()),"txtcrtotal");
	        
           $("#overlay, #PleaseWait").hide();
           
        });
    </script>
    <div id="terminationBenefitsDetails"></div>
    <input type="hidden" id="rowindex"/> 