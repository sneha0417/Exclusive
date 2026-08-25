<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.deductionschedule.ClsDeductionScheduleDAO"%>
<%ClsDeductionScheduleDAO DAO= new ClsDeductionScheduleDAO(); %>
<% 
String startdate1 = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
String instamt1 = request.getParameter("instamt")==null?"0":request.getParameter("instamt");
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
%>

<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
<script type="text/javascript">
        
        var data;  
        $(document).ready(function () { 
            var temp1='<%=instamt1%>';
            var temp2='<%=docNo%>';
            
            if(temp1!="0"){
            	data = '<%=DAO.deductionScheduleGrid(startdate1, amount1, instno1, instamt1) %>';
            }
            else if(temp2>0){
            	data = '<%=DAO.deductionScheduleGridReloading(docNo) %>';
            }

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'int'  },
     						{name : 'date', type: 'date'   },
     						{name : 'amount', type: 'number'  },
     						{name : 'posted', type: 'int'  },
     						{name : 'postedtrno', type: 'int'  },
     						{name : 'rowno', type: 'int'  }
                        ],
                		  localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellbeginedit = function (row, datafield, columntype, value) {
                var rowindexestemp = event.args.rowindex;
                var value = $('#deductionScheduleGridID').jqxGrid('getcellvalue', rowindexestemp, "posted");	
                if(value>0)
    				return false;
            }
            
            var cellclassname = function (row, column, value, data) {
                if (data.posted > 0) {
                    return "disableClass";
                };
            }; 

            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#deductionScheduleGridID").jqxGrid(
            {
                width: '57%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                columns: [
							{ text: 'Sr. No.', datafield: 'sr_no',  width: '10%', cellsalign: 'center', align: 'center', editable: false, cellclassname: cellclassname},
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '40%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'amount',  width: '50%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellbeginedit: cellbeginedit, cellclassname: cellclassname, aggregates: ['sum']  },
							{ text: 'Posted', datafield: 'posted',  hidden: true, width: '10%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Posted Tr No', datafield: 'postedtrno',  hidden: true, width: '10%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Row No', datafield: 'rowno',  hidden: true, width: '10%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
						]
            });
            
         /*  //Add empty row
          if(temp1 == "0" && temp2>0){
       	   $("#deductionScheduleGridID").jqxGrid('addrow', null, {});
          }  */
          
          if(temp2>0){
        	  $("#deductionScheduleGridID").jqxGrid('disabled', true);
          }
          
           var total1="0.00";
       	   $("#deductionScheduleGridID").on('cellvaluechanged', function (event){
       		 var amount = document.getElementById("txtamount").value;
             var total=$('#deductionScheduleGridID').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
             total1=(total.sum).replace(/,/g,'');
             document.getElementById("txtinstamttotal").value=total1;
             
       			if(parseFloat(total1)>parseFloat(amount) || parseFloat(total1)<parseFloat(amount)){ 
       				document.getElementById("errormsg").innerText="Invalid Transaction,Sum of Distribution is not Valid.";
       		        $('#txtvalidation').val(1);
       		         return 0;  
       			}
       			else{
       				document.getElementById("errormsg").innerText="";
       				$('#txtvalidation').val(0);
      		         return 1;
       			}
       			
           }); 

       	 var total=$('#deductionScheduleGridID').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
       	 if(typeof(total) == "undefined" || typeof(total) == "NaN" || total == ""){
         	document.getElementById("txtinstamttotal").value=0.00;
       	 } else {
       		document.getElementById("txtinstamttotal").value=total.sum;	 
       	 }
        
        });
    </script>
    <div id="deductionScheduleGridID"></div>
 