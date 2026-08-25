<%@page import="com.fixedassets.assetposting.fixedassetposting.ClsFixedAssetDepreciationPostingDAO" %>
<%ClsFixedAssetDepreciationPostingDAO fdp=new ClsFixedAssetDepreciationPostingDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String day = request.getParameter("day")==null?"0":request.getParameter("day");
   String deprDate = request.getParameter("deprdate")==null?"0":request.getParameter("deprdate").trim();
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");%>
<script type="text/javascript">
		var data1;
		
        $(document).ready(function () { 
            
        	var temp='<%=check%>';
        	var temp1='<%=trNo%>';
        	
        	if(temp=='2'){
        		data1='<%= fdp.accountDetailsGridLoading(branch,day,deprDate)%>';    
        	}else if(temp1>0){
          	    data1='<%=fdp.accountDetailsGridReloading(trNo)%>';
            } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'acno', type: 'int' },
							{name : 'accountno', type: 'int' },
     						{name : 'codeno', type: 'string' }, 
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   }
                        ],
                           localdata: data1,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxVehicleAccounts").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Account No', datafield: 'acno', hidden: true, width: '10%' },
							{ text: 'Account No', datafield: 'accountno',  width: '15%' },
							{ text: 'Account Head',   datafield: 'codeno',  width: '55%' },
							{ text: 'Debit', datafield: 'debit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Credit', datafield: 'credit', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
						]
            });
            
            if(temp1>0){
            	$("#jqxVehicleAccounts").jqxGrid('disabled', true);
            }
            
            $("#jqxVehicleAccounts").on('cellvaluechanged', function (event){
                
             var datafield = event.args.datafield;
         		
	         if(datafield=="debit" || datafield=="credit"){
	        	 
	            var debit=$('#jqxVehicleAccounts').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
	            var debit1=debit.sum;
	       	    if(!(isNaN(debit1))){
	       		  $('#txtdrtotal').val(debit1);
	      	    }else if(isNaN(debit1)){
	      		  $('#txtdrtotal').val(0.00);
	      	    }
	       	    
	       	    var credit=$('#jqxVehicleAccounts').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
	            var credit1=credit.sum;
	            if(!(isNaN(credit1))){
	    		  $('#txtcrtotal').val(credit1);
	   	        }else if(isNaN(credit1)){
	   		      $('#txtcrtotal').val(0.00);
	   	        } 
         	 }
            });
            
            var debit=$('#jqxVehicleAccounts').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            var debit1=debit.sum;
       	    if(!(isNaN(debit1))){
       		  $('#txtdrtotal').val(debit1);
      	    }else if(isNaN(debit1)){
      		  $('#txtdrtotal').val(0.00);
      	    }
       	    
       	 var credit=$('#jqxVehicleAccounts').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
         var credit1=credit.sum;
         if(!(isNaN(credit1))){
 		  $('#txtcrtotal').val(credit1);
	        }else if(isNaN(credit1)){
		      $('#txtcrtotal').val(0.00);
	        } 
            
        });
    </script>
    <div id="jqxVehicleAccounts"></div>
    <input type="hidden" id="rowindex"/> 