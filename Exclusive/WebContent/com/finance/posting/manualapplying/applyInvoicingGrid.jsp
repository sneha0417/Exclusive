<%@page import="com.finance.posting.manualapplying.ClsManualApplyingDAO"%>
<%ClsManualApplyingDAO DAO= new ClsManualApplyingDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String accNo = request.getParameter("accNo")==null?"0":request.getParameter("accNo");
   String aType = request.getParameter("accType")==null?"0":request.getParameter("accType");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %>

<script type="text/javascript">
       var data2;
        $(document).ready(function () { 	
              
             var temp='<%=accNo%>';
             
             if(temp>0)
           	 { 
            	  data2='<%=DAO.applyInvoiceGridLoading(accNo,aType,check)%>';  
           	 } 

             // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'transno', type: 'int' },
     						{name : 'transtype', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'description', type: 'string'   },
     						{name : 'tramt', type: 'number' },
     		     		    {name : 'applying', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'out_amount', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'currency', type: 'string'   }
                        ],
                		  localdata: data2,  
                
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

            $("#jqxApplyInvoicing").jqxGrid(
            {
                width: '99%',
                height: 220,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                showfilterrow: true,
                filterable: true,
                 //Add row method
                /* handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxApplyInvoicing').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxApplyInvoicing').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'applying' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },  */
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype', editable: false, width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '7%' },	
							{ text: 'Remarks', datafield: 'description', editable: false, width: '44%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right' },
							{ text: 'Applying', datafield: 'applying', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Balance', datafield: 'balance', width: '10%',cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'] },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  width: '5%',cellsformat: 'd2' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' }
						]
            });   
            
            if(temp==0){
            //Add empty row
          	   $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
             }
          	
            $("#overlay, #PleaseWait").hide();
            
        	 var applied1="";
          	 $("#jqxApplyInvoicing").on('cellvaluechanged', function (event){
          		$("#jqxApplyInvoicing").jqxGrid('clearfilters');
                 var rowindex1=event.args.rowindex;
                 var value = $('#jqxApplyInvoicing').jqxGrid('getcellvalue', rowindex1, "tramt");
                 var value1=$("#jqxApplyInvoicing").jqxGrid('getcellvalue', rowindex1, "applying");
                 var balance= (parseFloat(value)-parseFloat(value1)).toFixed(2);
                 $('#jqxApplyInvoicing').jqxGrid('setcellvalue', rowindex1, "balance",balance);
                 
                var applied=$('#jqxApplyInvoicing').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
                applied1=applied.sum;
                document.getElementById("txtapplyinvoiceapply").value=applied1;
                
                var totamount = $('#txtapplyinvoiceamt').val();
      		    var totapply = $('#txtapplyinvoiceapply').val();
      		    if(!isNaN(totamount || totapply)){
      		    var totbalance= parseFloat(totamount) - parseFloat(totapply);
				funRoundAmt(totbalance,"txtapplyinvoicebalance");
      		  }
      		else{
		    	 funRoundAmt(0.00,"txtapplyinvoiceamt");
		    }
              }); 
             
          	 
          	$("#jqxApplyInvoicing").on('cellvaluechanged', function (event) {
          		var dataField = event.args.datafield;
                var rowIndex = event.args.rowindex;
                var value = $('#jqxApplyInvoicing').jqxGrid('getcellvalue', rowIndex, "tramt");
                var value1=$("#jqxApplyInvoicing").jqxGrid('getcellvalue', rowIndex, "applying");
          		var amount = document.getElementById("txtapplyinvoiceamt").value;
          		var applied=$('#jqxApplyInvoicing').jqxGrid('getcolumnaggregateddata', 'applying', ['sum'], true);
          		applied1=parseFloat(applied.sum); 
          		if(dataField=="applying"){
          			if(applied1>amount){ 
          		        $("#jqxApplyInvoicing").jqxGrid('showvalidationpopup', rowIndex, "applying", "Limit Already Reached,Invalid Amount.");
          		        $('#txtvalidation').val(1);
          		         return true;  
          		        }
          		    else if(value1>value){
          		    	$("#jqxApplyInvoicing").jqxGrid('showvalidationpopup', rowIndex, "applying", "Invalid Amount.");
          		    	$('#txtvalidation').val(1);
         		         return true; 
          		    }  
          		    else{  
          		        $("#jqxApplyInvoicing").jqxGrid('hidevalidationpopups');
          		         $('#txtvalidation').val(0);
          		        return false;  
          		        }
          		}      		
          	});
          	
          	$("#jqxApplyInvoicing").on("cellclick", function (event) {
          		var dataField = event.args.datafield;
          		var rowIndex = event.args.rowindex;        
          		
          		if(dataField=="tramt"){
          			var value = $('#jqxApplyInvoicing').jqxGrid('getcellvalue', rowIndex, "tramt");
          			$("#jqxApplyInvoicing").jqxGrid('setcellvalue', rowIndex, "applying",value);
          		}
          	});
        });
    </script>
    <div id="jqxApplyInvoicing"></div>
 