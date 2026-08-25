<%@page import="com.dashboard.marketing.estimationanalysis.ClsEstimationAnalysisDAO" %>
<% ClsEstimationAnalysisDAO DAO=new ClsEstimationAnalysisDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String clientdocno = request.getParameter("clientdocno")==null?"0":request.getParameter("clientdocno").trim();
     String estimationtrno = request.getParameter("estimationtrno")==null?"0":request.getParameter("estimationtrno").trim();
     String reftype = request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();
     String referencedocno = request.getParameter("referencedocno")==null?"0":request.getParameter("referencedocno").trim();
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
        .greyClass
        {
           background-color: #D8D8D8;
        }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.estimationAnalysisGridLoading(branchval, fromDate, toDate, clientdocno,estimationtrno, reftype, referencedocno, check)%>';
	  		   var dataExcelExport='<%=DAO.estimationAnalysisExcelExport(branchval, fromDate, toDate, clientdocno,estimationtrno, reftype, referencedocno, check)%>';
	  	}
	  	
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'string'    },
							{name : 'reference', type: 'string'    },
							{name : 'site', type: 'string'    },
							{name : 'sertype', type: 'string'    },
							{name : 'desc1', type: 'string'  },
							{name : 'scope', type: 'string'},
							{name : 'product', type: 'string' },
							{name : 'brandname', type: 'string'},
							{name : 'unit', type: 'string'  },
							{name : 'qty', type: 'number'  },
							{name : 'scopestdcost', type: 'number'},
							{name : 'scopeamount', type: 'number'  },
							{name : 'scopetotal', type: 'number'},
							{name : 'scopeprofitamt', type: 'number'}, 
							{name : 'scopeprofitperc', type: 'number'},
							{name : 'stdprice', type: 'number'    },
							{name : 'amount', type: 'number'  },
							{name : 'producttotal', type: 'number' },
							{name : 'profitproductamount', type: 'number'}, 
							{name : 'productprofitperc', type: 'number'},
							{name : 'marginper', type: 'number'    },
							{name : 'margin', type: 'number'  },
							{name : 'totalcost', type: 'number'  },
							{name : 'totalestimated', type: 'number'  },
							{name : 'totalprofitamt', type: 'number'}, 
							{name : 'totalprofitperc', type: 'number'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#estimationAnalysisGridId").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
								{ text: 'Sl#', datafield: 'slno', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
								},
								{ text: 'Doc No', datafield: 'doc_no', width: '5%',columngroup:'otherinformations' },
								{ text: 'Reference', datafield: 'reference', width: '6%',columngroup:'otherinformations' },
								{ text: 'Site', datafield: 'site', width: '8%',columngroup:'otherinformations' },
								{ text: 'Service Type', datafield: 'sertype', width: '10%',columngroup:'otherinformations' },
								{ text: 'Description', datafield: 'desc1', width: '12%',columngroup:'otherinformations' },
								{ text: 'Scope', datafield: 'scope', width: '4%',columngroup:'otherinformations' },
								{ text: 'Product', datafield: 'product', width: '10%',columngroup:'otherinformations' },
								{ text: 'Brand', datafield: 'brandname', width: '8%',columngroup:'otherinformations' },
								{ text: 'Unit', datafield: 'unit', width: '3%',columngroup:'otherinformations' },	
								{ text: 'Quantity', datafield: 'qty', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',columngroup:'otherinformations' },
								{ text: 'Cost', datafield: 'scopestdcost', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',columngroup:'scopeinfo' },
								{ text: 'Estimated', datafield: 'scopeamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'scopeinfo' },
								{ text: 'Total', datafield: 'scopetotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'scopeinfo' },
								{ text: 'Profit', datafield: 'scopeprofitamt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'scopeinfo' },
								{ text: 'Profit %', datafield: 'scopeprofitperc', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'scopeinfo' },
								{ text: 'Cost', datafield: 'stdprice', width: '12%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'productinfo' },
								{ text: 'Estimated', datafield: 'amount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'productinfo' },
								{ text: 'Total', datafield: 'producttotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',columngroup:'productinfo' },
								{ text: 'Profit', datafield: 'profitproductamount', width: '12%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'productinfo' },
								{ text: 'Profit % ', datafield: 'productprofitperc', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'productinfo' },
								{ text: 'Margin %', datafield: 'marginper', width: '6%' , cellsformat: 'd2', cellsalign: 'right' , align: 'right',columngroup:'margininfo'},
								{ text: 'Margin', datafield: 'margin', width: '6%' , cellsformat: 'd2', cellsalign: 'right', align: 'right',columngroup:'margininfo' },
								{ text: 'Cost', datafield: 'totalcost', width: '12%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'netinfo' },
								{ text: 'Estimated', datafield: 'totalestimated', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'netinfo' },
								{ text: 'Profit', datafield: 'totalprofitamt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'netinfo' },
								{ text: 'Profit %', datafield: 'totalprofitperc', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,columngroup:'netinfo' },
								], columngroups: 
				                     [
				                       { text: '', align: 'center', name: 'otherinformations',width: '20%' },
				                       { text: 'Scope', align: 'center', name: 'scopeinfo',width: '10%' },
				                       { text: 'Product', align: 'center', name: 'productinfo',width: '10%' },
				                       { text: 'Margin', align: 'center', name: 'margininfo',width: '10%' },
				                       { text: 'NET', align: 'center', name: 'netinfo',width: '10%' }
				                     ]
            });
            
            if(temp=='NA'){
                $("#estimationAnalysisGridId").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
});

</script>
<div id="estimationAnalysisGridId"></div>
