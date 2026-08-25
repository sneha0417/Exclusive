<%@page import=" com.dashboard.realestate.ejaripayment.ClsEjariPaymentDAO" %>
  
<%	
ClsEjariPaymentDAO DAO=new ClsEjariPaymentDAO(); 
 	String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
%>
<script type="text/javascript">
 
var datamain11= '<%=DAO.listsearch(barchval,fromdate,todate,aa) %>'; 
 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },                            
                            {name : 'voc_no', type: 'int'   },                         
                            {name : 'date', type: 'date'   },                            
                            {name : 'period_from', type: 'date'   },
                            {name : 'period_to', type: 'date'   },     					 
     						{name : 'refname', type: 'string'   },   
     						{name : 'protype', type: 'string'   },
     						{name : 'period', type: 'string'   },
     						{name : 'period_no', type: 'string'   },
     						{name : 'pname', type: 'string'   },
     						{name : 'not_period', type: 'string'   },
     						{name : 'totalamount', type: 'string'   },
     						{name : 'ejamt', type: 'number'   },
     						{name : 'pymt', type: 'number'   },
     					  
                        ],
                		localdata: datamain11, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid1").jqxGrid(
            {
                width: '100%',
                height: 480,
                source: dataAdapter,
                columnsresize:true,
                filtermode:'excel',
                showfilterrow:true,
                enabletooltips:true,
                filterable: true,
                selectionmode: 'checkbox',
                
                columns: [ 
                          
						{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                        { text: 'Contract No', datafield: 'voc_no', width: '6%' },
						{ text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },							 
						{ text: 'Tenant ', datafield: 'refname', width: '28%'   },
						{ text: 'Type', datafield: 'protype', width: '7%',hidden:true },
						{ text: 'Property', datafield: 'pname', },
						{ text: 'Ejari Amount', datafield: 'ejamt', width: '10%',cellsformat:'d2',align:'right',cellsalign:'right'},
						{ text: 'Payment', datafield: 'pymt', width: '10%',cellsformat:'d2',align:'right',cellsalign:'right'},
						
						 
						]
            });
            
             $('#searshgrid1').on('rowselect', function (event) {    
                var rowindex1 = event.args.rowindex;
                //alert("cell click invoked");
           	    $("#Update").attr('disabled', false );
            	/* var nettotal=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "totalamount");
            	$('#txtmainnettotal').val(nettotal); */
            	
            	var docno=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	 //alert("cell click invoked===="+docno);
            	document.getElementById("brhid").value=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "brhid");;
            	
        	    document.getElementById("masterdocno").value=docno;
        	     
         	    /* $("#listdiv1").load("termsOfContractGrid.jsp?docno="+docno);
         		$("#listdiv2").load("paymentDistributionGrid.jsp?docno="+docno);
         		$("#agentdiv").load("agentGrid.jsp?docno="+docno); */
         		  $('#prdocno').val(docno);
                 
            }); 
             $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="searshgrid1"></div>