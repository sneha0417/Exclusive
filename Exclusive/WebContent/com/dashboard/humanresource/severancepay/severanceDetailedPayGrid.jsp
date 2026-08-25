<%@page import="com.dashboard.humanresource.severancepay.ClsSeverancePay" %>
<% ClsSeverancePay DAO=new ClsSeverancePay(); %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();%>

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
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
    
    .account {
		color: black;
		background-color: #E0ECF8;
		width: 100%;
		height: 28px;
		font-family: Myriad Pro;
		font-weight: bold;
	}
	.accname {
		color: black;
		background-color: #E0ECF8;
		width: 100%;
		font-family: comic sans ms;
	}
        
</style>

<script type="text/javascript">
    
       var data1='<%=DAO.severanceDetailedPayGridLoading(branchval, upToDate, empdocno)%>';
       var name='<%=name%>';
	  	
        $(document).ready(function (){ 
        	 
    		 $("#excelExport").click(function () {
    			 JSONToCSVConvertor(data1, 'SeverancePayDetailed', true);
             });

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
        	
            // prepare the data
        	 var source =
             {
             	datatype: "json",
                 dataFields: [
                      {name : 'employeedocno', type: 'int' },
                      {name : 'employeeid', type: 'string' },
                      {name : 'employeename', type: 'string' },
                      {name : 'date', type: 'date' },
      				  {name : 'terminalbenefitsdebit', type: 'number' },
      				  {name : 'terminalbenefitscredit', type: 'number' },
      				  {name : 'leavesalarydebit', type: 'number' },
      				  {name : 'leavesalarycredit', type: 'number' },
      				  {name : 'travelsdebit', type: 'number' },
      				  {name : 'travelscredit', type: 'number' },
      				  {name : 'description', type: 'string' }
                 ],
                 localdata: data1,  
             };
             
             var dataAdapter = new $.jqx.dataAdapter(source,
             		 {
                 		loadError: function (xhr, status, error) {
 	                    alert(error);    
 	                    }
 		            });
             
             $("#detailedSeverancePayGridID").jqxGrid(
             {
                 source: dataAdapter,
                 width: '80%',
                 height: 400,
                 rowsheight:25,
                 statusbarheight:25,
                 filtermode:'excel',
                 filterable: true,
                 sortable: true,
                 selectionmode: 'singlerow',
                 showaggregates: true,
              	 showstatusbar:true,
                 editable: false,
                 columnsresize: true,
                 
                 columns: [
				   { text: 'No.', sortable: false, filterable: false, editable: false,
						groupable: false, draggable: false, resizable: false,datafield: '',
						columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					  }    
				   },
                   { text: 'Emp. ID', hidden: true, cellsAlign: 'left', align: 'left', dataField: 'employeeid', width: '5%'},
                   { text: 'Emp. Name', hidden: true, cellsAlign: 'left', align: 'left', dataField: 'employeename', width: '5%'},
                   { text: 'Date', dataField: 'date', cellsformat:'dd.MM.yyyy', width: '7%' },
                   { text: 'Debit',  datafield: 'terminalbenefitsdebit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'terminalbenefits',aggregates: ['sum'],aggregatesrenderer:rendererstring },
				   { text: 'Credit',  datafield: 'terminalbenefitscredit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'terminalbenefits',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                   { text: 'Debit',  datafield: 'leavesalarydebit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'leavesalary',aggregates: ['sum'],aggregatesrenderer:rendererstring },
				   { text: 'Credit',  datafield: 'leavesalarycredit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'leavesalary',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                   { text: 'Debit',  datafield: 'travelsdebit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'travels',aggregates: ['sum'],aggregatesrenderer:rendererstring },
				   { text: 'Credit',  datafield: 'travelscredit', width: '12%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'travels',aggregates: ['sum'],aggregatesrenderer:rendererstring },
                   { text: 'Description', dataField: 'description', cellsAlign: 'left', align: 'left', width: '17%' },
                 ],
					columngroups: 
						  [
	                        { text: 'Terminal Benefits', align: 'center', name: 'terminalbenefits',width: '10%' },
	                        { text: 'Leave Salary', align: 'center', name: 'leavesalary',width: '10%' },
	                        { text: 'Travels', align: 'center', name: 'travels',width: '10%' }
						 
						  ]
             });
             
             var result=$("#detailedSeverancePayGridID").jqxGrid('getCellValue', 0, 'employeeid')+" - "+$("#detailedSeverancePayGridID").jqxGrid('getCellValue', 0, 'employeename');
             document.getElementById("lblemployeename").innerText=result;
            
         });

</script>
    
    </head>
<body class='default'>
<table width="100%">
  <tr>
    <td width="5%"><button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 				   <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png"></button></td>
    <td width="95%"><label class="account">Employee :&nbsp;&nbsp;&nbsp;</label><label class="accname" name="lblemployeename" id="lblemployeename"></label></td></tr>
</table>
 
        <div id="detailedSeverancePayGridID"></div>
</body>

<script type="text/javascript">
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
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
</html>
 