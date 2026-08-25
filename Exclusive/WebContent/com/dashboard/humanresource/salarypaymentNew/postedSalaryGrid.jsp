<%@page import="com.dashboard.humanresource.salarypaymentNew.ClsSalaryPaymentDAO"%>
<%ClsSalaryPaymentDAO DAO= new ClsSalaryPaymentDAO(); %> 
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String year = request.getParameter("year")==null?"0":request.getParameter("year").trim();
	 String month = request.getParameter("month")==null?"0":request.getParameter("month").trim();
	 String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
	 String agent = request.getParameter("agent")==null?"0":request.getParameter("agent").trim();
	 String establishmentCode = request.getParameter("establishmentCode")==null?"0":request.getParameter("establishmentCode").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
           	  
<style type="text/css">
     
     .lightBlueClass { background-color: #CEECF5; }
     
     .whiteClass { background-color: #fff; }
</style>

<script type="text/javascript">

	 var temp='<%=branchval%>';
	 var data;
	 
	if(temp!='NA') {
		data= '<%=DAO.postedSalaryGridLoading(branchval, year, month, category, agent, establishmentCode, check)%>';
	}
	
	$(document).ready(function () {
		
		var rendererstring=function (aggregates){
	     	var value=aggregates['sum'];
	     	if(typeof(value) == "undefined" || typeof(value) == "NAN"){
           		value=0.00;
           	}
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
						{ name : 'status', type: 'string'  },
						{ name : 'total', type: 'number'  },
						{ name : 'statusid', type: 'int'  }
					   ],
					   localdata: data,
        
        	pager: function (pagenum, pagesize, oldpagenum) {
           	 // callback called when a page or page size is changed.
        	}
    	};
	    
	    var cellclassname = function (row, column, value, data) {
    		if (data.status == 'ALL') {
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
    
    
    $("#postedSalaryGridID").jqxGrid(
    {
        width: '98%',
        height: 107,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
        localization: {thousandsSeparator: ""},
        
        columns: [
						{ text: 'Status', datafield: 'status', width: '60%' , cellclassname: cellclassname, aggregates: ['sum1'], aggregatesrenderer:rendererstring1 },
						{ text: 'Total', datafield: 'total', width: '40%', cellsalign: 'right', align: 'right',cellclassname: cellclassname, aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Status ID', datafield: 'statusid', width: '10%', hidden: true },
					]
    
    });
    
    $("#overlay, #PleaseWait").hide();
    		
	$('#postedSalaryGridID').on('rowdoubleclick', function (event) {
		 var rowIndex = event.args.rowindex;
		 var statusID=$('#postedSalaryGridID').jqxGrid('getcelltext',rowIndex, "statusid");
		 var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var category = $('#cmbempcategory').val();
		 var agent = $('#cmbempagentid').val();
		 var establishmentcode = $('#txtestablishmentcode').val();
		 var bankaccount = $('#txtbankaccount').val();
		 var bankaccountname = $('#txtbankaccountname').val();
		 var date = $('#date').val();
		 
		 $("#overlay, #PleaseWait").show();
		 $("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
		 $("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: true});
		 $("#salaryPaymentDetailsGridID").jqxGrid({ disabled: false});$('#txtselectedemployees').val('');
		 
		 if(statusID=='1') {
			 $("#JVTDiv").prop("hidden", false);
		 } else {
			 $("#JVTDiv").prop("hidden", true);        
	     }		 
		 
		 $("#salaryPaymentDetailsDiv").load("salaryPaymentGrid.jsp?branchval="+branchval+'&year='+year+'&month='+month+'&category='+category+'&agent='+agent+'&statusID='+statusID+'&establishmentCode='+establishmentcode.replace(/ /g, "%20")+'&bankAccount='+bankaccount.replace(/ /g, "%20")+'&bankName='+bankaccountname.replace(/ /g, "%20")+'&paymentdate='+date+'&check=1');
		 
	});
    
});	
	
</script>
<div id="postedSalaryGridID"></div>