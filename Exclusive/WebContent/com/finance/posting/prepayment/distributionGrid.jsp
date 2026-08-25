<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.posting.prePayment.ClsPrePaymentDAO"%>
<% ClsPrePaymentDAO DAO= new ClsPrePaymentDAO(); %> 
<% 
String startdate1 = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
String enddate1 = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
String cmbfrequency1 = request.getParameter("cmbfrequency")==null?"0":request.getParameter("cmbfrequency");
String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
String instamt1 = request.getParameter("instamt")==null?"0":request.getParameter("instamt");
String dueafter1 = request.getParameter("dueafter")==null?"0":request.getParameter("dueafter");
String tranId = request.getParameter("tranId")==null?"0":request.getParameter("tranId");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
<script type="text/javascript">
        
        var data3;  
        $(document).ready(function () { 
            var temp1='<%=instamt1%>';
            var temp2='<%=tranId%>';
            
            if(temp1!="0"){
            	data3 = '<%=DAO.distributionGrid(startdate1, enddate1, cmbfrequency1, amount1, instno1, instamt1, dueafter1, check) %>';
            }
            else if(parseInt(temp2)>0){
            	data3 = '<%=DAO.distributionGridReloading(session, tranId, check) %>';
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
     						{name : 'rowno', type: 'int'  }
                        ],
                		  localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellbeginedit = function (row, datafield, columntype, value) {
                var rowindexestemp = event.args.rowindex;
                var value = $('#jqxDistributionGrid').jqxGrid('getcellvalue', rowindexestemp, "posted");	
                if(value>0)
    				return false;
            }
            
            var cellclassname = function (row, column, value, data) {
                if (data.posted > 0) {
                    return "disableClass";
                };
            }; 

            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDistributionGrid").jqxGrid(
            {
                width: '95%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', datafield: 'sr_no',  width: '10%', cellsalign: 'center', align: 'center', editable: false, cellclassname: cellclassname},
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '40%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'amount',  width: '50%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellbeginedit: cellbeginedit, cellclassname: cellclassname, aggregates: ['sum']  },
							{ text: 'Posted', datafield: 'posted',  hidden: true, width: '10%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Row No', datafield: 'rowno',  hidden: true, width: '10%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
						]
            });
            
          //Add empty row
          if(temp1 == "0"){
       	   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
          } 
          
          if(temp2>0){
        	  $("#jqxDistributionGrid").jqxGrid('disabled', true);
          }
          
           var total1="";
       	   $("#jqxDistributionGrid").on('cellvaluechanged', function (event){
       		 var amount = document.getElementById("txtamount").value;
             var total=$('#jqxDistributionGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
             total1=total.sum;
             document.getElementById("txtinstamttotal").value=total1;
             
       			if((parseFloat(total1)>parseFloat(amount)) || (parseFloat(total1)<parseFloat(amount))){ 
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

       	 var total=$('#jqxDistributionGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
         document.getElementById("txtinstamttotal").value=total.sum;
        
         var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
         var value = $('#jqxDistributionGrid').jqxGrid('getcellvalue', (rows.length-1), "sr_no");
         document.getElementById("txtinstnos").value=value;
         
        });
    </script>
    <div id="jqxDistributionGrid"></div>
 