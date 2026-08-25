<%@page import="com.dashboard.accounts.pdcpostingreverse.ClsPDCPostingReverseDAO"%>
<%ClsPDCPostingReverseDAO DAO= new ClsPDCPostingReverseDAO(); %> 
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String code = request.getParameter("code")==null?"FRO":request.getParameter("code").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.pdcPostingReverseGridLoading(branchval, code, accdocno, atype, fromDate, toDate, check)%>'; 
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'branchname', type: 'string' },
							{name : 'doc_no', type: 'int'  },
							{name : 'dtype', type: 'string'  },
							{name : 'bankacno', type: 'int'  },
							{name : 'bank', type: 'string' }, 
							{name : 'bankname', type: 'string' },
							{name : 'atype', type: 'string'   },
							{name : 'acno', type: 'int'  },
							{name : 'account', type: 'int'  },
							{name : 'accountname', type: 'int'   },
							{name : 'chqno', type: 'int'   },
							{name : 'chqdt', type: 'date' },
							{name : 'tr_dr', type: 'number'   },
							{name : 'lamount', type: 'number'   },
							{name : 'curr', type: 'int'  },
							{name : 'currtype', type: 'string' },
							{name : 'rate', type: 'int'  },
							{name : 'curid', type: 'int'  },
							{name : 'brhid', type: 'int'  },
							{name : 'tr_no', type: 'int'  },
							{name : 'rowno', type: 'int'  },
							{name : 'pdcposttrno', type: 'int'  }
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
            
            $("#pdcPostingReverseGridID").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                filterable: true,
                showfilterrow: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
             	columnsresize: true,
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Branch',  datafield: 'branchname',  width: '10%' },
							{ text: 'Doc No', datafield: 'doc_no', width: '7%' },
							{ text: 'Type', datafield: 'dtype', width: '5%' },
							{ text: 'Bank Doc No', hidden: true, datafield: 'bankacno', width: '10%' },	
							{ text: 'Bank No.',  datafield: 'bank',  width: '5%' },
							{ text: 'Bank Name',  datafield: 'bankname',  width: '12%' },
							{ text: 'A/C Type', datafield: 'atype', width: '5%' },	
							{ text: 'Account No', hidden: true, datafield: 'acno', width: '20%' },	
							{ text: 'Account No', datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'accountname', width: '15%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '9%' },
							{ text: 'Cheque Date', datafield: 'chqdt', cellsformat: 'dd.MM.yyyy', width: '7%' },
							{ text: 'Amount', datafield: 'tr_dr', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Base Amt',  hidden: true, datafield: 'lamount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Currency',  hidden: true, datafield: 'curr', width: '10%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', width: '10%' },
							{ text: 'Currency Id',  hidden: true, datafield: 'curid', width: '10%' },
							{ text: 'Currency Type',  hidden: true, datafield: 'currtype', width: '10%' },
							{ text: 'Branch Id',  hidden: true, datafield: 'brhid', width: '10%' },
							{ text: 'Tr No', hidden: true, datafield: 'tr_no', width: '10%' },
							{ text: 'Row No', hidden: true, datafield: 'rowno', width: '10%' },
							{ text: 'Post Tr No', hidden: true, datafield: 'pdcposttrno', width: '10%' },
						 ]
            });
            
            if(temp=='NA'){
                $("#pdcPostingReverseGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();

            $('#pdcPostingReverseGridID').on('rowdoubleclick', function (event) { 
            	var rowindex1=event.args.rowindex;
            	
            	$('#btnReverse').attr('disabled', false);
          	  	document.getElementById("txttrno").value=$('#pdcPostingReverseGridID').jqxGrid('getcellvalue', rowindex1, "tr_no");
          	  	document.getElementById("txtpostedtrno").value=$('#pdcPostingReverseGridID').jqxGrid('getcellvalue', rowindex1, "pdcposttrno");
             }); 
        });

</script>
<div id="pdcPostingReverseGridID"></div>
