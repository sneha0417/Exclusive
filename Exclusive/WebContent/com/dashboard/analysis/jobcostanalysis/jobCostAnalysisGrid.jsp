<%@page import="com.dashboard.analysis.jobcostanalysis.ClsJobCostAnalysisDAO" %>
<% ClsJobCostAnalysisDAO DAO=new ClsJobCostAnalysisDAO(); %>  
<%  String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype").trim();
  	String contract = request.getParameter("contract")==null?"0":request.getParameter("contract").trim();
  	String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
  	String salesmandocno = request.getParameter("salesmandocno")==null?"0":request.getParameter("salesmandocno").trim();
  	String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
%> 
       
<style type="text/css">
  .variationClass
  {
      background-color: #DAF7A6;
  }
  .actualClass
  {
      background-color: #FFEBEB;
  }
  .incomeClass
  {
     background-color: #F5EEF8;
  }
  .estimationClass
  {
     background-color: #EBF5FB;
  }
</style>
 
<script type="text/javascript">
 	var temp4='<%=branch%>';
	var datas;

 	if(temp4!='NA') { 
	 	datas= '<%=DAO.jobCostAnalysisGridLoading(branch,fromdate,todate,contracttype,contract,cldocno,salesmandocno,check)%>';  
	} else { 
		datas;
	}  


 	$(document).ready(function () {
 		
 		var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
           }

	    var source =
	    {
	        datatype: "json",
	        datafields: [   
	                     {name :'jobnumber', type:'int' },
	                     {name :'doctype', type:'String' },
	                     {name :'client', type:'String' },
	                     {name :'startdate', type:'date' },
					     {name :'enddate', type: 'date'  },
						 {name :'status', type:'String' },
						 {name :'salesperson', type:'String'},
						 {name :'jobvalue', type:'number'},
						 {name :'estimatecost', type:'number'},
						 {name :'estimateprofit', type:'number' },
	                     {name :'incomeamount', type:'number' },
	                     {name :'actualmaterialamount', type:'String' },
					     {name :'actualmaterialexpenseamount', type: 'number'  },
						 {name :'labourhrstime', type:'String' },
						 {name :'labourvalue', type:'number'},
						 {name :'actualtotal', type:'number'},
						 {name :'actualprofit', type:'number'},
						 {name :'variationprofit', type:'number'},
						 {name :'variationprofitperc', type:'number'} 	
					    ],
					    localdata: datas,
	        
	        
	        pager: function (pagenum, pagesize, oldpagenum) {
	            // callback called when a page or page size is changed.
	        }
	    };
	  
	   
	    
	    var dataAdapter = new $.jqx.dataAdapter(source,
	    		 {
	        		loadError: function (xhr, status, error) {
	                alert(error);    
	                }
			            
		            }		
	    );
    
   $("#jobCostGridID").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        
        columns: [    
					{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,datafield: '',
					    columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }    
						},
                     { text: 'Job Number',datafield: 'jobnumber', width: '8%',columngroup:'contractdetails' },
                	 { text: 'Doc type', datafield: 'doctype', width: '6%',columngroup:'contractdetails' },
         			 { text: 'Client',datafield: 'client', width: '25%',columngroup:'contractdetails' },
         			 { text: 'Start',datafield: 'startdate', cellsformat: 'dd.MM.yyyy', width: '8%',columngroup:'contractdetails' },
         		     { text: 'End date', datafield: 'enddate', cellsformat: 'dd.MM.yyyy',  width: '8%',columngroup:'contractdetails' },
                     { text: 'Status', datafield: 'status',  width: '8%',columngroup:'contractdetails' },
           	         { text: 'Sales person', datafield: 'salesperson',  width: '20%',columngroup:'contractdetails' }, 
           	         { text: 'Job Value', datafield: 'jobvalue',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'contractdetails' },
           	         { text: 'Cost', datafield: 'estimatecost',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'estimationdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'estimationClass' },
           	         { text: 'Estimated Profit', datafield: 'estimateprofit',cellsformat: 'd2',cellsalign:'right',align:'right', width: '8%',columngroup:'estimationdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'estimationClass' },
      		     	 { text: 'Income',datafield: 'incomeamount', width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'incomeClass' },
      		    	 { text: 'Expeneses',datafield: 'actualmaterialamount', width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
      		         { text: 'Material', datafield: 'actualmaterialexpenseamount',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
                     { text: 'Labour HRS', datafield: 'labourhrstime',  width: '8%',columngroup:'actualdetails', cellclassname: 'actualClass' },
                     { text: 'Labour Amount',datafield: 'labourvalue', width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
        	         { text: 'Total', datafield: 'actualtotal',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' }, 
        	         { text: 'Profit', datafield: 'actualprofit',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'actualdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'actualClass' },
        	         { text: 'Value', datafield: 'variationprofit',  width: '10%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'variationdetails',aggregates: ['sum'],aggregatesrenderer:rendererstring, cellclassname: 'variationClass' },
        	         { text: 'Value %', datafield: 'variationprofitperc', width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'variationdetails', cellclassname: 'variationClass' },
        	     
           	       ], columngroups: 
	                     [
	                       { text: 'Contract', align: 'center', name: 'contractdetails',width: '20%' },
	                       { text: 'Estimate', align: 'center', name: 'estimationdetails',width: '10%' },
	                       { text: 'Actual', align: 'center', name: 'actualdetails',width: '10%' },
	                       { text: 'Variation', align: 'center', name: 'variationdetails',width: '10%' }
	                     ]
   
    });
   
    $("#overlay, #PleaseWait").hide();
   
});

</script>
<div id="jobCostGridID"></div>