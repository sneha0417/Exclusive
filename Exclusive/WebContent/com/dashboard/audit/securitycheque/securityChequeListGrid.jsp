<%@page import="com.dashboard.audit.securitychequelist.ClsSecurityChequeList"%>
<%ClsSecurityChequeList DAO= new ClsSecurityChequeList(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
%>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data='<%=DAO.securityChequeListGridLoading(branchval, upToDate)%>';  
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
				    {name : 'date' , type: 'date' },
				    {name : 'doc_no' , type: 'int' },
				    {name : 'bank' , type: 'string' },
				    {name : 'cheque_no', type: 'string'  },
				    {name : 'cheque_date', type: 'date'  },
				    {name : 'paidto', type: 'string'  },
				    {name : 'amount', type: 'number'  },
				    {name : 'remarks', type: 'string'  },
					{name : 'branchid', type: 'int'  },
					{name : 'info', type: 'string'  }
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
		            }		
            );
            $("#securityChequeList").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Doc No.', datafield: 'doc_no', width: '6%' },
						{ text: 'Bank', datafield: 'bank', width: '17%' },
						{ text: 'Cheque No', datafield: 'cheque_no', width: '17%' },
						{ text: 'Cheque Date', datafield: 'cheque_date', cellsformat: 'dd.MM.yyyy' , width: '7%' },
						{ text: 'Paid To', datafield: 'paidto', width: '17%' },
						{ text: 'Amount', datafield: 'amount',width: '9%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
						{ text: 'Remarks', datafield: 'remarks', width: '20%' },
						{ text: 'Branch Id', datafield: 'branchid', hidden: true, width: '10%' },
						{ text: 'Info', datafield: 'info', hidden: true, width: '10%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#securityChequeList").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#securityChequeList').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtdocno").value = $('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtbrhid").value = $('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "branchid");
            	document.getElementById("txtchequeno").value = $('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "cheque_no");
            	$('#date').val($('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "date")) ; 
            	$('#chequeDate').val($('#securityChequeList').jqxGrid('getcellvalue', rowindex1, "cheque_date")) ; 
            	
            	 var values= $('#securityChequeList').jqxGrid('getcellvalue',rowindex1, "info");
                 
                 var sum2 = values.toString().replace(/\*/g, '\n');
              
                 document.getElementById("txtinfo").value=sum2;
                 
            	$('#txtremarks').attr('readonly', false);$('#btnupdate').attr("disabled",false);
            });  

        });

</script>
<div id="securityChequeList"></div>
