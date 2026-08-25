<%@page import="com.finance.posting.vehicledepreciationposting.ClsVehicleDepreciationPostingDAO"%>
<% ClsVehicleDepreciationPostingDAO DAO= new ClsVehicleDepreciationPostingDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");
String day = request.getParameter("day")==null?"0":request.getParameter("day");
String deprDate = request.getParameter("deprdate")==null?"0":request.getParameter("deprdate").trim();
String trNo = request.getParameter("trno")==null?"0":request.getParameter("trno");
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");
String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");%>

<script type="text/javascript">
	     var data;   
        $(document).ready(function () { 
            
             var temp='<%=check%>';
             var temp1='<%=trNo%>';
             
             /*$("#btnExcel").click(function() {
            	 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
     		});*/
            
             if(temp=='1'){  
            	  data='<%=DAO.vehicleDetailsProcessing(branch,deprDate)%>';    
             }else if(temp=='2'){  
           	      data='<%=DAO.vehicleDetailsCalculating(branch,day,deprDate)%>';
             }else if(temp1>0){
            	  data='<%=DAO.vehicleDetailsReloading(docNo,trNo)%>';
             } 
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no', type: 'int' },
     						{name : 'flname', type: 'string' }, 
     						{name : 'reg_no', type: 'string'   },
     						{name : 'prch_dte', type: 'date'  },
     						{name : 'prch_cost', type: 'number'   },
     						{name : 'bookvalue', type: 'number'   },
     						{name : 'depr', type: 'number' },
     						{name : 'depr_amt', type: 'number'   },
     						{name : 'frmdate', type: 'string'  }
                        ],
                            localdata: data,    
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxvehicleDetails").jqxGrid(
            {
                width: '99%',
                height: 200,
                source: dataAdapter,
                editable: false,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Fleet No', datafield: 'fleet_no',  width: '8%' },
							{ text: 'Fleet Name',   datafield: 'flname',  width: '20%' },
							{ text: 'Reg No.', datafield: 'reg_no', editable: false, width: '7%' },	
							{ text: 'Purchase Date', datafield: 'prch_dte', cellsformat: 'dd.MM.yyyy', editable: false, width: '10%' },	
							{ text: 'Purchase Price', datafield: 'prch_cost', width: '13%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Book Value', datafield: 'bookvalue', width: '14%', cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'Depr%', datafield: 'depr', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Depriciation', datafield: 'depr_amt', editable: false, width: '18%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'From Date', datafield: 'frmdate', hidden: true, editable: false, width: '10%' },
						],
            });
            
            if(temp1>0){
            	$("#jqxvehicleDetails").jqxGrid('disabled', true);
            }
            
           var depramt=$('#jqxvehicleDetails').jqxGrid('getcolumnaggregateddata', 'depr_amt', ['sum'], true);
           var depramt1=depramt.sum;
           
           var balanceamt=$('#jqxvehicleDetails').jqxGrid('getcolumnaggregateddata', 'bookvalue', ['sum'], true);
           var balanceamt1=balanceamt.sum;
           
           if(depramt1<0){
        	   if(!isNaN(balanceamt1)){
    	           document.getElementById("txtdeprtotal").value=balanceamt1;
    	           document.getElementById("txtdrtotal").value=balanceamt1;
    	           document.getElementById("txtcrtotal").value=balanceamt1;
    	           
    	           $('#jqxVehicleAccounts').jqxGrid('setcellvalue', 0, "credit" ,balanceamt1);
    	           $('#jqxVehicleAccounts').jqxGrid('setcellvalue', 1, "debit" ,balanceamt1);
               }
           }else{
	           if(!isNaN(depramt1)){
		           document.getElementById("txtdeprtotal").value=depramt1;
		           document.getElementById("txtdrtotal").value=depramt1;
		           document.getElementById("txtcrtotal").value=depramt1;
		           
		           $('#jqxVehicleAccounts').jqxGrid('setcellvalue', 0, "credit" ,depramt1);
		           $('#jqxVehicleAccounts').jqxGrid('setcellvalue', 1, "debit" ,depramt1);
	           }
           }
           
           $("#overlay, #PleaseWait").hide();
           
        });
    </script>
    <div id="jqxvehicleDetails"></div>
    <input type="hidden" id="rowindex"/> 