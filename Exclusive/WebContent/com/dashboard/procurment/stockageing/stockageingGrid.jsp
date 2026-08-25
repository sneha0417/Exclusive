<%@page import="com.dashboard.procurment.stockageing.ClsStockageingDAO"%>
<%ClsStockageingDAO DAO= new ClsStockageingDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String level1From = request.getParameter("level1from")==null?"0":request.getParameter("level1from").trim();
     String level1To = request.getParameter("level1to")==null?"0":request.getParameter("level1to").trim();
     String level2From = request.getParameter("level2from")==null?"0":request.getParameter("level2from").trim();
     String level2To = request.getParameter("level2to")==null?"0":request.getParameter("level2to").trim();
     String level3From = request.getParameter("level3from")==null?"0":request.getParameter("level3from").trim();
     
     String level3To = request.getParameter("level3to")==null?"0":request.getParameter("level3to").trim();
     
     String level4From = request.getParameter("level4from")==null?"0":request.getParameter("level4from").trim();
     
     String level4To = request.getParameter("level4to")==null?"0":request.getParameter("level4to").trim();
     
     String level5From = request.getParameter("level5from")==null?"0":request.getParameter("level5from").trim();
     
     
  	String hidbrandid = request.getParameter("hidbrandid")==null?"0":request.getParameter("hidbrandid").trim();
  	String hidtypeid = request.getParameter("hidtypeid")==null?"0":request.getParameter("hidtypeid").trim();
  	String hideptid = request.getParameter("hideptid")==null?"0":request.getParameter("hideptid").trim();
  	String hidcatid = request.getParameter("hidcatid")==null?"0":request.getParameter("hidcatid").trim();
  	String hidsubcatid = request.getParameter("hidsubcatid")==null?"0":request.getParameter("hidsubcatid").trim();
   	    
  	String hidproductid = request.getParameter("hidproductid")==null?"0":request.getParameter("hidproductid").trim();
     
     String check = request.getParameter("check")==null?"0":request.getParameter("check");%> 
     
<style type="text/css">
  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var l1=''+$('#txtlevel1from').val()+' - '+$('#txtlevel1to').val()+'';
      var l2=''+$('#txtlevel2from').val()+' - '+$('#txtlevel2to').val()+'';
     
      var l3=''+$('#txtlevel3from').val()+' - '+$('#txtlevel3to').val()+'';
      var l4=''+$('#txtlevel4from').val()+' - '+$('#txtlevel4to').val()+'';
      
      var l5='>='+$('#txtlevel5from').val()+'';
      
      
	  	if(temp!='NA'){ 
	  		  data='<%=DAO.stockageinggrid(branchval, upToDate,  level1From, level1To, level2From, level2To, level3From,
	  				  check, level3To, level4From, level4To, level5From,hidbrandid,hidtypeid,hideptid,hidcatid,hidsubcatid,hidproductid)%>';  
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
							    {name : 'productid', type: 'String'  },
		                        {name : 'productname', type: 'String'  },
		                      
		                        {name : 'brand', type: 'String'  },
									 
								{name : 'level_1qty' , type:'number'},
								{name : 'level_1amount' , type:'number'},
								{name : 'level_2qty' , type:'number'},
								{name : 'level_2amount' , type:'number'},
								{name : 'level_3qty' , type:'number'},
								{name : 'level_3amount' , type:'number'} ,
								{name : 'level_4qty' , type:'number'},
								{name : 'level_4amount' , type:'number'} ,
								{name : 'level_5qty' , type:'number'},
								{name : 'level_5amount' , type:'number'} 
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
            
            $("#stockageinggrid").jqxGrid(
            {
                width: '98%',
                height: 520,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,  
                showstatusbar:true,
             	statusbarheight:25,
                
                columns: [     
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                  
							 { text: 'Product', datafield: 'productid',  width: '11%'  }, 
				           	 { text: 'Product Name', datafield: 'productname',  width: '23%'  }, 
				           	 { text: ' Brand', datafield: 'brand',  width: '14%'  }, 
				           	 { text:'Qty ['+l1 +' ]' ,  datafield: 'level_1qty',  width: '7%',cellsformat: 'd2' , aggregates: ['sum'], aggregatesrenderer:rendererstring1,cellclassname:'advanceClass'},
				       		 { text: 'Amount ['+l1 +' ]'  ,  datafield: 'level_1amount',  width: '9%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:'balanceClass'},
   				    		 { text: 'Qty ['+l2 +' ]' ,  datafield: 'level_2qty',  width: '7%',cellsformat: 'd2',cellclassname:'advanceClass' },
				       		 { text: 'Amount ['+l2 +' ]'  ,  datafield: 'level_2amount',  width: '9%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:'balanceClass'},
	  			    		 { text: 'Qty ['+l3 +' ]' ,  datafield: 'level_3qty',  width: '7%',cellsformat: 'd2' ,cellclassname:'advanceClass' },
					       	 { text:' Amount [' +l3 +' ]' ,  datafield: 'level_3amount',  width: '9%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:'balanceClass'},
					    	 { text: 'Qty ['+l4 +' ]' ,  datafield: 'level_4qty',  width: '7%',cellsformat: 'd2' ,cellclassname:'advanceClass' },
					       	 { text:' Amount [' +l4 +' ]' ,  datafield: 'level_4amount',  width: '9%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:'balanceClass'},
					    	 { text: 'Qty ['+l5 +' ]' ,  datafield: 'level_5qty',  width: '7%',cellsformat: 'd2' ,cellclassname:'advanceClass' },
					       	 { text:' Amount [' +l5 +' ]' ,  datafield: 'level_5amount',  width: '9%',cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring,cellclassname:'balanceClass'},
		 
							 
							 
						 ]
            });
            
            if(temp=='NA'){
                $("#stockageinggrid").jqxGrid("addrow", null, {});
            }
            
          /*   var advance1="";var balance1="";var netbalance="";
              var rows = $("#stockageinggrid").jqxGrid('getrows');
            if(rows.length>0){
            	var advance=$('#stockageinggrid').jqxGrid('getcolumnaggregateddata', 'advance', ['sum'], true);
            	advance1=advance.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
            	var balance=$('#stockageinggrid').jqxGrid('getcolumnaggregateddata', 'balance', ['sum'], true);
            	balance1=balance.sum.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
            }
            if(!isNaN(advance1 || balance1)){
            	netbalance= parseFloat(balance1) - parseFloat(advance1);
      		    funRoundAmt(netbalance,"txtnetbalance");
      		  }
      		 else{
		    	 funRoundAmt(0.00,"txtnetbalance");
		     }
             */
            $("#overlay, #PleaseWait").hide();
            
         /*    $('#stockageinggrid').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  document.getElementById("txtacountno").value=$('#stockageinggrid').jqxGrid('getcellvalue', rowindex1, "account");
            	  document.getElementById("txtbranch").value=$('#stockageinggrid').jqxGrid('getcellvalue', rowindex1, "branch_id");
               }); 
 */
        });

</script>
<div id="stockageinggrid"></div>
