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
		
        // prepare the data
            var data = '<%=DAO.vendorList()%>';
     		exceldata='<%=DAO.vendorExcelExport()%>';
            
     		var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'category', type: 'string' },
                    { name: 'doc_no', type: 'int' },
                    { name: 'codeno', type: 'string' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'type', type: 'string' },
					{ name: 'trnnumber', type: 'string' },
					{ name: 'account', type: 'string' },
					{ name: 'accountgroup', type: 'string' },
					{ name: 'creditperiodmin', type: 'string' },
					{ name: 'creditperiodmax', type: 'string' },
					{ name: 'creditlimit', type: 'string' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#vendorgrid").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                columnsresize: true,
                groupable: true,
                selectionmode: 'singlecell',
                groups: ['category','sal_name'],
                columns: [
          
                  { text: 'Category', groupable: true, datafield: 'category', width: '14%' },
                  { text: 'Doc No', groupable: false, datafield: 'doc_no', width: '8%' },
                  { text: 'Code', groupable: false, datafield: 'codeno', width: '8%' },
                  { text: 'Name', groupable: true, datafield: 'refname', width: '19%' },
                  { text: 'Mobile', groupable: true, datafield: 'per_mob', width: '9%' },
                  { text: 'Salesman', groupable: false, datafield: 'sal_name', width: '14%' },
                  { text: 'Address', groupable: false, datafield: 'address', width: '24%' },
                  { text: 'Email Id', groupable: false, datafield: 'mail1', width: '14%' },
                  { text: 'Type', groupable: false, datafield: 'type', width: '8%' },
				  { text: 'TRN No', groupable: false, datafield: 'trnnumber', width: '8%' },
				  { text: 'Account', groupable: false, datafield: 'account', width: '8%' },
				  { text: 'Account Group', groupable: false, datafield: 'accountgroup', width: '15%' },
				  { text: 'Credit Period(Min)', groupable: false, datafield: 'creditperiodmin', width: '8%' },
				  { text: 'Credit Period(Max)', groupable: false, datafield: 'creditperiodmax', width: '8%' },
				  { text: 'Credit Limit', groupable: false, datafield: 'creditlimit', width: '8%' },
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
			
        });
    </script>
</head>
<body class='default'>
    <div id='jqxWidget'>
        <div id="vendorgrid"></div>
    </div>
    
	</body>
</html>
 