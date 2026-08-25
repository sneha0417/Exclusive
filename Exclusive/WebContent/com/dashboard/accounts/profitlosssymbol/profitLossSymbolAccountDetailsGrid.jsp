<%@page import="com.dashboard.accounts.profitlosssymbol.ClsProfitLossSymbol" %>
<% ClsProfitLossSymbol DAO=new ClsProfitLossSymbol(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
     
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
</style>

<script type="text/javascript">

	var data3;
      
      var temp='<%=check%>'; 
      var name='<%=name%>';
	  	
        $(document).ready(function () {
        	$("#accountDetailsDetailedGridID").jqxGrid({ disabled: true});
        	
        	if(temp=='1'){ 
 	  		   data3='<%=DAO.accountStatementDetail(branchval, fromDate, toDate, accdocno,check)%>'; 
 	  	    } else {
 	  	    	data3;
 	  	    }
        	
        	$("#excelExport").click(function() {
        		if(parseInt(window.parent.chkexportdata.value)=="1") {
        			JSONToCSVCon(data3, "ProfitAndLoss", true);
    			 } else {
    				$("#accountDetailsGridID").jqxGrid('exportdata', 'xls', name);
    			 }
    		});
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
     						{name : 'tr_no', type: 'string'   }
	            ],
                localdata: data3,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
        	var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);

            $("#accountDetailsGridID").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '7%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
						{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '6%',columngroup:'cashcontrolaccount' },
						{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
						{ text: 'Description', datafield:'description', cellclassname: cellclassname, width:'32.59%',columngroup:'cashcontrolaccount'},
						{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '6%'  ,columngroup:'transactedin'},
						{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '6%',cellsformat: 'd2',columngroup:'transactedin'},
						{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
						{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin' },
						{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency' },
						{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '9.09%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency' },
						{ text: 'Tr No', hidden: true, datafield: 'tr_no',  width: '10%' },
						], columngroups: 
							[
								{ text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
								{ text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
								{ text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
							]
            });
            
            
            $("#overlay, #PleaseWait").hide();
            
            $('#accountDetailsGridID').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  var check=1;
            	  $("#overlay, #PleaseWait").show();
            	  $("#accountDetailsDetailedGridID").jqxGrid({ disabled: false});
         		  $("#accountDetailsDetailedDiv").load("profitLossSymbolDetailedAccountDetailsGrid.jsp?trno="+$('#accountDetailsGridID').jqxGrid('getcellvalue', rowindex1, "tr_no")+'&check='+check);
         		 
               }); 

        });

        function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
            
           // alert("arrData");
            var CSV = '';    
            //Set Report title in first row or line
            
            CSV += ReportTitle + '\r\n\n';

            //This condition will generate the Label/Header
            if (ShowLabel) {
                var row = "";
                
                //This loop will extract the label from 1st index of on array
                for (var index in arrData[0]) {
                    
                    //Now convert each value to string and comma-seprated
                    row += index + ',';
                }

                row = row.slice(0, -1);
                
                //append Label row with line break
                CSV += row + '\r\n';
            }
            
            //1st loop is to extract each row
            for (var i = 0; i < arrData.length; i++) {
                var row = "";
                
                //2nd loop will extract each column and convert it in string comma-seprated
                for (var index in arrData[i]) {
                    row += '"' + arrData[i][index] + '",';
                }

                row.slice(0, row.length - 1);
                
                //add a line break after each row
                CSV += row + '\r\n';
            }

            if (CSV == '') {        
                alert("Invalid data");
                return;
            }   
            
            //Generate a file name
            var fileName = "";
            //this will remove the blank-spaces from the title and replace it with an underscore
            fileName += ReportTitle.replace(/ /g,"_");   
            
            //Initialize file format you want csv or xls
            var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
            
            // Now the little tricky part.
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            
            //this trick will generate a temp <a /> tag
            var link = document.createElement("a");    
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            link.download = fileName + ".csv";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
</script>

<div id="accountDetailsGridID"></div>