<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.finance.nipurchase.suppliers.ClsVendorDetailsDAO" %>
<%  ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<head>
<style type="text/css">
	.icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
	}
        
</style>
<script type="text/javascript">
		
   $(document).ready(function () {
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	   $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../icons/31load.gif'/></div>");
          
		});
   
   function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
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
   
   function funExportsBtn(){
	   
	    JSONToCSVConvertor(exceldata, 'VendorLists', true);
	} 
            // prepare the data
           <%--  var data = '<%=DAO.vendorList()%>';

            var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'category', type: 'string' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' }
                    
                    
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#vendor").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                selectionmode: 'singlecell',
                groups: ['category','sal_name'],
                columns: [
          
                  { text: 'Category', groupable: true, datafield: 'category', width: '15%' },
                  { text: 'Name', groupable: true, datafield: 'refname', width: '20%' },
                  { text: 'Mobile', groupable: true, datafield: 'per_mob', width: '10%' },
                  { text: 'Salesman', groupable: false, datafield: 'sal_name', width: '15%' },
                  { text: 'Address', groupable: false, datafield: 'address', width: '25%' },
                  { text: 'Email Id', groupable: false, datafield: 'mail1', width: '15%' }
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
			
        }); --%>
  
    </script>
</head>
<body class='default'>
<button type="button" class="icon" id="excelExport" onclick="funExportsBtn();" title="Export current Document to Excel">
	<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%-- <button type="button" class="icon" id="btnSubmit" title="Load" onclick="funLoadData();">
							<img alt="Load" src="<%=contextP ath%>/icons/submit_new.png">
						</button>&nbsp;&nbsp;&nbsp;&nbsp;--%>
						<table width="100%">
		<tr>
			 <td><div id="vendorListDiv"><jsp:include page="vendorListGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
    
    
	</body>
</html>
 