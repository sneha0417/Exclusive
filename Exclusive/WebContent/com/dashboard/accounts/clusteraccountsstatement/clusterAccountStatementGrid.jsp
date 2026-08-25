<%@page import="com.dashboard.accounts.clusteraccountstatement.ClsClusterAccountStatement"%>
<%ClsClusterAccountStatement DAO= new ClsClusterAccountStatement(); %>
<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
   String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate");
   String branch = request.getParameter("branchval")==null?"NA":request.getParameter("branchval");
   String cluster = request.getParameter("clusterdocno")==null?"0":request.getParameter("clusterdocno");
   String clusteraccount = request.getParameter("clusteraccount")==null?"0":request.getParameter("clusteraccount").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
   %>
	 
<style type="text/css">
       
        .headClass
        {
            background-color: #CEECF5;
            font-weight: bold;
        }
        .netBalanceClass
        {
            background-color: #FFEBEB/* #FFFFD1 */;
             font-style: oblique;
        }
         .detailClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        
</style>

 <script type="text/javascript">
 
 		var data1;
 		var temp='<%=branch%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';
 		
 		if(temp!='NA'){
	    	data1 = '<%=DAO.clusterDetailedAccountStatementGrid(branch, fromDate, toDate, cluster, clusteraccount,check)%>'; 
 		} 
 	
        $(document).ready(function () {
      	
        	/*$("#btnExcel").click(function() {
    			$("#detailedAccountsStatementGrid").jqxGrid('exportdata', 'xls', 'ClusterAccountStatement');
    		});*/
        	
	      	var source =
            {
                datatype: "json",
                datafields: [
							{ name: "id", type: "number" },
					  	    { name: 'trdate', type: 'date' },
                      		{ name: 'transtype', type: 'string' },
                      		{ name: 'transno', type: 'int' },
                      		{ name: 'description', type: 'string' },
                      		{ name: 'branchname', type: 'string' },
                      		{ name: 'ref_detail', type: 'string' },
                      		{ name: 'debit', type: 'string' },
                      		{ name: 'credit', type: 'string' },
                      		{ name: 'netamount', type: 'string' },
                      		{ name: "parentid", type: "number" },
                      		{ name: "accountno", type: "number" },
                      		{ name: 'accountname', type: 'string' }
	                      ],
                          localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function () {
                }
            });
            
            var cellclassname = function (row, column, value, data) {
                 
            	if (data.accountno == '0'){
                	 return "netBalanceClass";
                }else if (data.parentid == null) {
                     return "headClass";
                 }else if (data.parentid != null) {
                     return "detailClass";
                 }else {
                	 return "whiteClass";
                 };
            };
            
            $("#detailedAccountsStatementGrid").jqxGrid(
            {
                source: dataAdapter,
                width: '99.5%',
                height: 510,
                
                columns: [
						  { text: 'Id',  hidden: true, datafield: 'id', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Parent Id',  hidden: true, datafield: 'parentid', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Account',  hidden: true, datafield: 'accountname', cellclassname: cellclassname, width: '20%'  },
						  { text: 'Description',  datafield: 'description', cellclassname: cellclassname, width: '24%' },
						  { text: 'Date', datafield: 'trdate', cellsformat: 'dd.MM.yyyy', cellclassname: cellclassname, width: '7%' },
						  { text: 'Type',  datafield: 'transtype', cellclassname: cellclassname, width: '8%'  },
		                  { text: 'Doc No',  datafield: 'transno', cellclassname: cellclassname, width: '5%' },
		                  { text: 'Branch',  datafield: 'branchname', cellclassname: cellclassname, width: '12%'  },
		                  { text: 'Reference',  datafield: 'ref_detail', cellclassname: cellclassname, width: '8%' },
		                  { text: 'Debit',datafield: 'debit', cellclassname: cellclassname, cellsAlign: "right", align: "right", width: '12%' },
		                  { text: 'Credit',datafield: 'credit', cellclassname: cellclassname, cellsAlign: "right", align: "right", width: '12%' },
		                  { text: 'Net Balance',datafield: 'netamount', cellclassname: cellclassname, cellsAlign: "right", align: "right", width: '12%' },
		                  { text: 'Account No',  hidden: true, datafield: 'accountno', cellclassname: cellclassname, width: '10%'  },
                       ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>

<div id="detailedAccountsStatementGrid"></div>
