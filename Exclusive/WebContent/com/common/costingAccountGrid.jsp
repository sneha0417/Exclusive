<%@page import="com.common.ClsCommonCosting"%>
<% ClsCommonCosting DAO= new ClsCommonCosting(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<% String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
   String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); %>  
<script type="text/javascript">
        
       	var costingaccountdata; 
        $(document).ready(function () { 
            
            var temp='<%=docno%>';
             
             if(temp>0){     
            	 costingaccountdata='<%=DAO.accountGridLoading(branch,dtype,docno)%>';      
           	 }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'docno', type: 'int' },
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'cr', type: 'bool' },
     						{name : 'amount', type: 'number'  },
     						{name : 'trno', type: 'int' },
     						{name : 'tranid', type: 'int' },
     						{name : 'id', type: 'int' }
                        ],
                		   localdata: costingaccountdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costingAccountGridID").jqxGrid(
            {
            	width: '99.5%',
                height: 100,
                source: dataAdapter,
                editable: false,
                showaggregates: true,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '8%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', datafield: 'docno',  hidden: true, width: '7%' },
							{ text: 'Account', datafield: 'account',  editable: false,  width: '18%' },	
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '50%' },	
							{ text: 'Cr', datafield: 'cr', columntype: 'checkbox', editable: true, checked: true, width: '9%',cellsalign: 'center', align: 'center' },
							{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '15%', cellsalign: 'right', align: 'right' },
							{ text: 'Trno', datafield: 'trno',  hidden: true, width: '7%' },
							{ text: 'Tranid', datafield: 'tranid',  hidden: true, width: '7%' },
							{ text: 'Id', datafield: 'id',  hidden: true, width: '7%' },
						]
            });
            
            $('#costingAccountGridID').on('rowdoubleclick', function (event) {
	       		 var rowIndex = event.args.rowindex;
	       		 var amount=$('#costingAccountGridID').jqxGrid('getcelltext',rowIndex, "amount");
	       		 var account=$('#costingAccountGridID').jqxGrid('getcelltext',rowIndex, "docno");
	       		 var trno=$('#costingAccountGridID').jqxGrid('getcelltext',rowIndex, "trno");
	       		 var tranid=$('#costingAccountGridID').jqxGrid('getcelltext',rowIndex, "tranid");
	       		 var id=$('#costingAccountGridID').jqxGrid('getcelltext',rowIndex, "id");
	       		 var checks = 1;
	       		 $('#txtaccountno').val(account);
	       		 $('#txtaccounttrno').val(trno);
	       		 $('#txtaccounttranid').val(tranid);
	       		 $('#txtaccountid').val(id);
	       		
		       	 if(!isNaN(amount)){
		       		 funCostingRoundAmt(amount,"txtaccounttotal");
		      	 }
		      	 else{
		      		funCostingRoundAmt(0.00,"txtaccounttotal");
				 }
	       		
	       		 $("#costingGridID").jqxGrid('clear');
	       		 $("#costingGridDiv").load("<%=contextPath%>/com/common/costingGrid.jsp?tranid="+tranid+'&checks='+checks);
       	});
           
});
</script>
<div id="costingAccountGridID"></div>
