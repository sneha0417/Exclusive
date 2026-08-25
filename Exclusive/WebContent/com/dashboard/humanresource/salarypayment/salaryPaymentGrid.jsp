<%@page import="com.dashboard.humanresource.salarypayment.ClsSalaryPaymentDAO"%>
<%ClsSalaryPaymentDAO DAO= new ClsSalaryPaymentDAO(); %> 
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String year = request.getParameter("year")==null?"0":request.getParameter("year").trim();
	 String month = request.getParameter("month")==null?"0":request.getParameter("month").trim();
	 String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	 String agent = request.getParameter("agent")==null?"0":request.getParameter("agent").trim();
	 String statusID = request.getParameter("statusID")==null?"0":request.getParameter("statusID").trim();
	 String establishmentCode = request.getParameter("establishmentCode")==null?"0":request.getParameter("establishmentCode").trim();
	 String bankName = request.getParameter("bankName")==null?"0":request.getParameter("bankName").trim();
	 String bankAccount = request.getParameter("bankAccount")==null?"0":request.getParameter("bankAccount").trim();
	 String paymentDate = request.getParameter("paymentdate")==null?"0":request.getParameter("paymentdate").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>

<style>     
.previousLeaveClass { background-color: #CEECF5; }
.leaveClass { background-color: #F1F8E0; }
.eligibleClass { background-color: #FFEBC2; }       
.balanceClass { background-color: #FFD6E7; }
</style>
        
<script type="text/javascript">
      var data1;
      var dataSIF;
      var statusid='<%=statusID%>';
      var temp1='<%=branchval%>';
      var tempheight=0;
      
	    if(statusid=="1"){
	    	  tempheight=280;
	    	  $('#salaryPaymentDetailsGridID').jqxGrid({ selectionmode: 'checkbox'});
	    	  $('#date').jqxDateTimeInput({disabled: false});
	    } else{
	    	  tempheight=532;
	    	  $('#date').val(new Date());
	    	  $('#date').jqxDateTimeInput({disabled: true});
	    }
      
	  	if(temp1!='NA'){ 
	  		    data1='<%=DAO.salaryPaymentGridLoading(branchval, year, month, category, agent, statusID, establishmentCode, check)%>';  
	  		  
	  		    dataexcel='<%=DAO.salaryPaymentGridLoadingexcel(branchval, year, month, category, agent, statusID, establishmentCode, check)%>';
	  		    
	  		    if(statusid=="1"){
	  		    	dataSIF='<%=DAO.salaryPaymentGridSifExport(branchval, year, month, category, agent, statusID, establishmentCode, bankName, bankAccount, paymentDate, check)%>';
	  		    }
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{name : 'netsalary', type: 'number' },
	                {name : 'agent', type: 'string' },
				    {name : 'bankempid' , type: 'String' },
				    {name : 'bankaccount' , type: 'String' },
				    {name : 'bankbranch', type: 'String'  },
				    {name : 'bankifsc', type: 'String'  },
				    {name : 'empdocno', type: 'String'  }
	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	 $("#salaryPaymentDetailsGridID").on("bindingcomplete", function (event) {
        		 if(statusid=="1"){
        		 	$('#btnSifSalaryPayment').attr('disabled', false );
        		 }
        	 });
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#salaryPaymentDetailsGridID").jqxGrid(
            {
                width: '98%',
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                height:tempheight,
                rowsheight:25,
                columnsresize: true,
                editable: false,
                
                columns: [
						{ text: 'Emp. ID', datafield: 'empid', width: '7%' },
						{ text: 'Employee', datafield: 'empname' },
						{ text: 'Net Salary', datafield: 'netsalary', cellsformat: 'd2', cellsalign:'right', align:'right', width: '8%' },
						{ text: 'Agent ID', datafield: 'agent', width: '15%' },
						{ text: 'Employee ID', datafield: 'bankempid', width: '8%' },
						{ text: 'Bank Account No.', datafield: 'bankaccount',  width: '14%' },
						{ text: 'Branch Name', datafield: 'bankbranch', width: '15%' },
						{ text: 'IFSC Code', datafield: 'bankifsc', width: '8%' },
						{ text: 'Emp. Docno', datafield: 'empdocno', hidden: true, width: '8%' },
					 ]
            });
            
            if(temp1=='NA'){
                $("#salaryPaymentDetailsGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
  });
                       
</script>
<div id="salaryPaymentDetailsGridID"></div>