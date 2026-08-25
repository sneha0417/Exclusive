<%@page import="com.dashboard.accounts.prepaid.ClsPrepaid"%>
<% ClsPrepaid DAO= new ClsPrepaid(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String reporttype = request.getParameter("reporttype"); 
     String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
     String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
     
<style type="text/css">
  .amountClass
  {
      background-color: #FBEFF5;
  }
  .postedClass
  {
      background-color: #E0F8F1;
  }
  .balanceClass
  {
     color: #FF0000;
  }
  .toBePostedClass
  {
      background-color: #F5EEF8;
  }
  .postingClass
  {
      background-color: #FFF;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.prePaidGridLoading(branchval, chkfromdate, fromdate, upToDate, reporttype, accdocno,check)%>';
	  		   var dataExcelExport='<%=DAO.prePaidExcelExport(branchval, chkfromdate, fromdate, upToDate, reporttype, accdocno,check)%>'; 
	  	}
  	
        $(document).ready(function () {
        	
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
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							 {name : 'branch', type: 'string'},
     						 {name : 'transtype', type: 'string' },
     						 {name : 'transno', type: 'int' },
     						 {name : 'acno', type: 'int' },
     						 {name : 'account', type: 'int' },
     		     		     {name : 'accountname', type: 'string' },
     						 {name : 'postacno', type: 'int' },
     						 {name : 'paccount', type: 'int' },
     						 {name : 'paccountname', type: 'string' },
     						 {name : 'date', type: 'date' },
     						 {name : 'fromdate', type: 'date' },
     						 {name : 'todate', type: 'date' },
     						 {name : 'posteddate', type: 'date' },
     						 {name : 'postedtilldate', type: 'date' },
     						 {name : 'description', type: 'string' },
     						 {name : 'dramount', type: 'number' },
     						 {name : 'postamount', type: 'number' },
     						 {name : 'pendamount', type: 'number' },
     						 {name : 'tobeposted', type: 'int' }
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	$("#prepaidGridID").on("bindingcomplete", function (event) {
            	var temp=document.getElementById("cmbreporttype").value;
			   
            	if (temp !="detail"){
            		$('#prepaidGridID').jqxGrid('hidecolumn', 'posteddate');
            		$("#prepaidGridID").jqxGrid('setcolumnproperty', 'description', 'width', '15%');
			    } else {
			    	$('#prepaidGridID').jqxGrid('hidecolumn', 'postamount');
            		$('#prepaidGridID').jqxGrid('hidecolumn', 'pendamount');
            		$('#prepaidGridID').jqxGrid('hidecolumn', 'fromdate');
            		$('#prepaidGridID').jqxGrid('hidecolumn', 'todate');
            		$('#prepaidGridID').jqxGrid('hidecolumn', 'postedtilldate');
			    }
				
            });
        	
        	var cellclassname1 = function (row, column, value, data) {
        		if (data.tobeposted == '2') {
                    return "toBePostedClass";
                } else{
                	return "postingClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#prepaidGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'No.', sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,datafield: '',
						    	columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
						    	cellclassname: cellclassname1,cellsrenderer: function (row, column, value) {
						        	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }    
							},
							{ text: 'Branch', datafield: 'branch',  width: '8%', cellclassname: cellclassname1 },
							{ text: 'Dtype', datafield: 'transtype',  width: '4%', cellclassname: cellclassname1 },
							{ text: 'Doc No.', datafield: 'transno',  width: '5%', cellclassname: cellclassname1 },	
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%', cellclassname: cellclassname1 },
							{ text: 'A/C No.', datafield: 'account',  width: '5%', cellclassname: cellclassname1 },
							{ text: 'Account Name', datafield: 'accountname',  width: '15%', cellclassname: cellclassname1 },	
							{ text: 'Post A/C', hidden: true, datafield: 'postacno',  width: '5%', cellclassname: cellclassname1 },
							{ text: 'Post A/C No.', datafield: 'paccount',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'Post A/C Name' , datafield: 'paccountname',  width: '16%', cellclassname: cellclassname1 },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'From Date', datafield: 'fromdate', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'To Date', datafield: 'todate', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'Posted Date', datafield: 'posteddate', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'Posted Till', datafield: 'postedtilldate', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
							{ text: 'Description' , datafield: 'description', aggregates: ['sum1'],aggregatesrenderer:rendererstring1, cellclassname: cellclassname1 },
							{ text: 'Amount', datafield: 'dramount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'amountClass',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Posted', datafield: 'postamount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'postedClass',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Balance' , datafield: 'pendamount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'balanceClass',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'To Be Posted', hidden: true, datafield: 'tobeposted',  width: '5%' },
						 ]
            });
            
            if(temp=='NA'){
                $("#prepaidGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
           
        });

</script>
<div id="prepaidGridID"></div>