<%@page import="com.dashboard.audit.applieddelete.ClsAppliedDeleteDAO"%>
<%ClsAppliedDeleteDAO DAO= new ClsAppliedDeleteDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
     String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();%> 

<style type="text/css">
  .appliedClass
  {
     color: #0101DF;
  }
  .balanceClass
  {
	color: #FF0000;      
  }
  
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		     data='<%=DAO.appliedGridLoading(branchval, atype, accountno)%>'; 
	  	}
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'transno', type: 'int' },
     						{name : 'transtype', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'description', type: 'string'   },
     						{name : 'tramt', type: 'number' },
     		     		    {name : 'applied', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'out_amount', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'currency', type: 'string'   },
     						{name : 'tr_no', type: 'int'   },
     						{name : 'brhid', type: 'int'   },
     						{name : 'applyinfo', type: 'string'  }
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
            $("#appliedDelete").jqxGrid(
            {
                width: '98%',
                height: 350,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							 }    
							},
							{ text: 'Doc No.', datafield: 'transno',  width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype',  width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' ,  width: '7%' },	
							{ text: 'Remarks', datafield: 'description',  width: '44%' },	
							{ text: 'Amount', datafield: 'tramt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Applied', datafield: 'applied', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
							{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'balanceClass' },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  cellsformat: 'd2', width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' },
							{ text: 'Tran No' , hidden: true, datafield: 'tr_no',  width: '5%' },
							{ text: 'Branch' , hidden: true, datafield: 'brhid',  width: '5%' },
							{ text: 'Apply Info', datafield: 'applyinfo', hidden: true, width: '10%' },
						 ]
            });
            
            $("#overlay, #PleaseWait").hide();
            
            $('#appliedDelete').on('rowdoubleclick', function (event) { 
          	     var rowindex1=event.args.rowindex;
          	     $('#date').val(new Date());$('#txtreason').val('');
          	     $("#appliedDetailsGrid").jqxGrid({ disabled: false});
                 $('#date').jqxDateTimeInput({disabled: false});$('#txtreason').attr("readonly",false);$('#btndelete').attr("disabled",false);
          		 
                 document.getElementById("txttrno").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "tr_no");
                 document.getElementById("txtdtype").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "transtype");
                 document.getElementById("txtoutamount").value= $('#appliedDelete').jqxGrid('getcelltext',rowindex1, "out_amount");
                 document.getElementById("txtbranchid").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "brhid");
                 
                 var values= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "applyinfo");
                 var sum2 = values.toString().replace(/\*/g, '\n');
                 document.getElementById("applyinfo").value=sum2;
                 
                var indexVal =  $('#appliedDelete').jqxGrid('getcellvalue', rowindex1, "tr_no");
                var accountno = document.getElementById("txtdocno").value;
                
    			if(indexVal>0){
              		$("#detailDiv").load("appliedDetailGrid.jsp?trno="+indexVal+'&accountno='+accountno);
    			}
    			
             }); 

        });

</script>
<div id="appliedDelete"></div>
