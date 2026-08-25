<%@page import="com.dashboard.accounts.finance.ClsFinance"%>
<%ClsFinance DAO= new ClsFinance(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accType = request.getParameter("acctype")==null?"0":request.getParameter("acctype").trim();
     String accDocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String dType = request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
     String docRangeFrom = request.getParameter("docrangefrom")==null?"0":request.getParameter("docrangefrom").trim();
     String docRangeTo = request.getParameter("docrangeto")==null?"0":request.getParameter("docrangeto").trim();
     String amtRangeFrom = request.getParameter("amtrangefrom")==null?"0":request.getParameter("amtrangefrom").trim();
     String amtRangeTo = request.getParameter("amtrangeto")==null?"0":request.getParameter("amtrangeto").trim();
     String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
      var data6;
      var temp='<%=branchval%>';
      var temp1='<%=dType%>';
		
		if(temp1=='SEC'){
		  	if(temp!='NA'){ 
		  		   data6='<%=DAO.finance(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>';  
				   <%-- var dataExcelExport5='<%=DAO.financeExcelExport(branchval, fromDate, toDate, accType, accDocno, dType, docRangeFrom, docRangeTo, amtRangeFrom, amtRangeTo,chk)%>'; --%>
		  	}
		}
		
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'doc_no' , type: 'int' },
                    {name : 'date' , type: 'date' },
				    {name : 'bank' , type: 'string' },
				    {name : 'chqno', type: 'string'  },
				    {name : 'chqdt', type: 'date'  },
				    {name : 'description', type: 'string'  },
				    {name : 'remarks', type: 'string'  },
				    {name : 'amount', type: 'number'  }
	            ],
                localdata: data6,
               
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
            $("#securityChequeList").jqxGrid(
            {
            	width: '100%',
                height: 470,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
				columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                enabletooltips: true,
                
                columns: [
                          
						{ text: 'SL#', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,
						    datafield: 'sl', columntype: 'number', width: '4%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }  
						  },
						{ text: 'Doc No.', datafield: 'doc_no', width: '6%' },
                        { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Bank', datafield: 'bank', width: '17%' },
						{ text: 'Cheque No', datafield: 'chqno', width: '17%' },
						{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Paid To', datafield: 'description', width: '17%' },
						{ text: 'Remarks', datafield: 'remarks', width: '20%' },
						{ text: 'Amount', datafield: 'amount',width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						
					 ]
            });
            $('#securityChequeList').on('rowdoubleclick', function (event) {
              	 var rowindex1 = event.args.rowindex;
                var path1="",detName="";
              	 var url=document.URL;
       	 		 var reurl=url.split("com/");
       	 		 var mod="v";
       	 		if(temp1=="SEC"){
       	 		  detName= "Security Cheque";
       	 		window.parent.formName.value="Security Cheque";
       	 		window.parent.formCode.value="SEC";
       	 		 var doc=$('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "doc_no");
       	 		 
       	 		 path1='com/finance/transactions/securitycheque/saveSecurityCheque?mode=view&txtsecuritychequedocno='+doc; 
       	 		}
       	 		
       	 	 top.addTab( detName,reurl[0]+""+path1);
	    		
 	    	
            });
            if(temp=='NA'){
                $("#securityChequeList").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

        });

</script>
<div id="securityChequeList"></div>