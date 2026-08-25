<%@page import="com.dashboard.accounts.trialbalance.ClsTrialBalance"%>
<%ClsTrialBalance DAO= new ClsTrialBalance(); %>
<%   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype").trim();
     String includingZero = request.getParameter("includingzero")==null?"0":request.getParameter("includingzero").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 

<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .orangeClass
    {
        background-color: #FFEBC2;
    }
    
    .whiteClass
    {
        background-color: #FFF;
    }
    
</style>

<script type="text/javascript">
      var data,exceldata;
      var temp='<%=barchval%>';
      var temp1='<%=fromDate%>';
	  var temp2='<%=toDate%>';
  	 
	  	if(temp!='NA'){  
	  		 data='<%=DAO.trialBalance(barchval, fromDate, toDate, accType,includingZero,check)%>';
	  		exceldata='<%=DAO.trialBalanceExcel(barchval, fromDate, toDate, accType,includingZero,check)%>';
	  	}
  	
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	var nf = new Intl.NumberFormat();
                if(($('#cmbtype').val()).trim()==''){
                	value=value.toString().replace(/,/g, '');
					value=nf.format((parseFloat(value)/parseFloat(2)).toFixed(2));
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
							{name : 'account' , type: 'string' },
							{name : 'account_name' , type: 'string' },
						    {name : 'opening_dr' , type: 'number' },
							{name : 'opening_cr' , type:'number'},
							{name : 'transactions_dr' , type:'number'},
							{name : 'transactions_cr' , type:'number'},
							{name : 'netbalance_dr',type:'number'},
							{name : 'netbalance_cr' , type:'number'},
							{name : 'account_docno' , type: 'string' }
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
                if (parseInt(data.account_docno) == 1) {
                	return "redClass";
                } 
                /*if (parseInt(data.netbalance_dr)> 0) {
                    return "redClass";
                }
        		if (parseInt(data.netbalance_cr)>0) {
                    return "yellowClass";
                }*/ 
                else {
                	return "whiteClass";
        		};
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#trialBalance").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                rowsheight:25,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                showaggregates: true,
             	showstatusbar:true,
                editable: false,
                localization: {thousandsSeparator: ","},
				
                columns: [
							{ text: 'A/C No.', datafield: 'account', cellclassname: cellclassname, align: 'center', width: '6%'},
							{ text: 'Account', datafield: 'account_name', cellclassname: cellclassname, align: 'center', width: '28%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Dr',  datafield: 'opening_dr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'opening',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Cr',  datafield: 'opening_cr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'opening',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Dr',  datafield: 'transactions_dr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactions',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Cr',  datafield: 'transactions_cr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactions',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Dr',  datafield: 'netbalance_dr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'netbalance',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Cr',  datafield: 'netbalance_cr', cellclassname: cellclassname, width: '11%', cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'netbalance',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'A/C Doc No.', datafield: 'account_docno', hidden: true, align: 'center', width: '6%'},
						 ], columngroups: 
					                     [
					                       { text: 'Opening', align: 'center', name: 'opening',width: '20%' },
					                       { text: 'Transactions', align: 'center', name: 'transactions',width: '20%' },
					                       { text: 'Net Balance', align: 'center', name: 'netbalance',width: '20%' }
					                     ]
            });
            
            if(temp=='NA'){
                $("#trialBalance").jqxGrid("addrow", null, {});
            }

			$("#overlay, #PleaseWait").hide();
			$('#btnprint').attr("disabled",false);
            $('#trialBalance').on('rowdoubleclick', function (event) {
            	//var args = event.args;
            	var rowindex = event.args.rowindex;
                var desc= "Trial Balance"; 
                var accdocno= $('#trialBalance').jqxGrid('getcellvalue', rowindex, "account_docno");
          	    
				if( $('#cmbtype').val()=='GL'){
                	if($('#trialBalance').jqxGrid('getcellvalue', rowindex, "account")=='340'){
                		accdocno= $('#trialBalance').jqxGrid('getcellvalue', rowindex, "account");
                	} else if($('#trialBalance').jqxGrid('getcellvalue', rowindex, "account")=='301'){
                		accdocno= $('#trialBalance').jqxGrid('getcellvalue', rowindex, "account");
                	} if($('#trialBalance').jqxGrid('getcellvalue', rowindex, "account")=='255'){
                		accdocno= $('#trialBalance').jqxGrid('getcellvalue', rowindex, "account");
                	}
                }
				
         	    var url=document.URL;
				var reurl=url.split("com/");
				
				var detName=$('#trialBalance').jqxGrid('getcellvalue', rowindex, "account_name");
				var path="com/dashboard/accounts/trialbalance/accountDetails.jsp";
				top.addTab( detName,reurl[0]+""+path+"?name="+detName+"&main="+desc.replace(/ /g, "%20")+"&branchval="+temp+'&fromdate='+temp1+'&todate='+temp2+'&accdocno='+accdocno+'&atype='+$('#cmbtype').val());
          	    
              });
            
            var debit1="";var credit1="";var netamount="";
            var debit=$('#trialBalance').jqxGrid('getcolumnaggregateddata', 'netbalance_dr', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#trialBalance').jqxGrid('getcolumnaggregateddata', 'netbalance_cr', ['sum'], true);
            credit1=credit.sum;
            if(!isNaN(debit1 || credit1)){
            	netamount= parseFloat(debit1) - parseFloat(credit1);
            	if(netamount!="0.00"){
            		if(($('#cmbtype').val()).trim()==''){
      		    	funRoundAmt(netamount/2,"txtnetamount");
            		} else {
            			funRoundAmt(netamount,"txtnetamount");
            		}
      		    	$("#trialDiv").show();
            	}else if(netamount=="0.00"){
            		$("#trialDiv").hide();
            	}
      		  }
      		else{
      			funRoundAmt(0.00,"txtnetamount");
		    }
        });

</script>
<div id="trialBalance"></div>
