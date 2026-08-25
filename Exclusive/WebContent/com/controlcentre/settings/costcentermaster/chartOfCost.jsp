<%@page import="com.controlcentre.settings.costcentermaster.ClsCostCenterDAO" %>
<% ClsCostCenterDAO ccd=new ClsCostCenterDAO();%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<head>
<style type="text/css">
        .redClass
        {
            
            background-color: #FFEBEB;
        }
        
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .icon {
   width: 2.5em;
   height: 3em;
   border: none;
   background-color: #E0ECF8;
  }
        </style>
<script type="text/javascript">
		
   $(document).ready(function () {
	   var theme = getDemoTheme();
	   
            // prepare the data
            var data = '<%=ccd.getChartOfCost()%>';

            $("#excelExport").click(function() {
	   		     if(parseInt(window.parent.chkexportdata.value)=="1") {
	      				JSONToCSVCon(data, "ChartOfCosts", true);
	   			 } else {
	   				$("#ChartOfCosts").jqxGrid('exportdata', 'xls', 'ChartOfCosts');
	   			 }
   		   });
            var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'gp_desc', type: 'string' },
                    { name: 'costgroup', type: 'string' },
                    { name: 'costcode', type: 'string' },
                    { name: 'description', type: 'string' },
                    { name: 'group_name', type: 'string' }
                    
                    
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            var redRow;
            var yellowRow;
            var cellclassname = function (row, column, value, data) {
                if (data.md == 'D') {
                    return "redClass";
                } else if (data.md == 'M') {
                	  return "yellowClass";
                }; 
                
            }; 
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#ChartOfCosts").jqxGrid(
            {
                width: '100%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                //groupsrenderer: false,
                selectionmode: 'singlecell',
                groups: ['costgroup','group_name'],
                columns: [
          
                 /*  { text: 'Group Name', groupable: true, datafield: 'gp_desc', width: '20%' ,cellclassname: cellclassname }, */
                  { text: 'Group Head', groupable: true, datafield: 'costgroup', width: '25%',cellclassname: cellclassname  },
                  { text: 'Main Head', groupable: true, datafield: 'group_name', width: '28%' ,cellclassname: cellclassname },
                  { text: 'Cost Code', groupable: false, datafield: 'costcode', width: '9%',cellclassname: cellclassname  },
                  { text: 'Description', groupable: false, datafield: 'description', width: '37%',cellclassname: cellclassname  }
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
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
</head>
<body class='default'>
<button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
    <div id='jqxWidget'>
        <div id="ChartOfCosts"></div>
    </div>
	
	
	</body>
</html>
 