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
	  
	   $("#excelExport").click(function() {
			$("#vendor").jqxGrid('exportdata', 'xls', 'VendorList');
		});
		
            // prepare the data
            var data = '<%=DAO.vendorList()%>';

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
			
        });
    </script>
</head>
<body class='default'>
<button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
	<img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
    <div id='jqxWidget'>
        <div id="vendor"></div>
    </div>
    
	</body>
</html>
 