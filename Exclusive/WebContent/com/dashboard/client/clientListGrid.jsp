<%@page import="com.dashboard.client.ClsClientDAO" %>
<%ClsClientDAO ccd=new ClsClientDAO(); %>

<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
 var temp='<%=check%>';
 
 var data;
 	if(temp=="load") {
	 	data = '<%=ccd.clientListGridLoading()%>';
     	var dataExcelExport='<%=ccd.clientListExcelExport()%>';
	}
 
        $(document).ready(function () { 
        	
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
                    { name: 'mail1', type: 'string' },
                    { name: 'crdprd', type: 'string' },
                    { name: 'crdlmt', type: 'string' },
                    { name: 'trnnumber', type: 'string' },
                    { name: 'date', type: 'date' },
                    { name: 'code', type: 'number' },
                    { name: 'acno', type: 'number' },
                    { name: 'accgroup', type: 'String' },
                    { name: 'crmaxdays', type: 'number' },
                    { name: 'tel', type: 'String' },
                    { name: 'area', type: 'String' },
                    { name: 'city', type: 'String' },
                    { name: 'country', type: 'String' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // initialize jqxGrid 
            $("#client").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                selectionmode: 'singlecell',
                groups: ['category','sal_name'],
                columns: [
				  { text: 'Date', groupable: true, datafield: 'date', width: '5%',cellsformat:'dd.mm.yyyy' },
				  { text: 'Code', groupable: true, datafield: 'code', width: '4%' },
				  { text: 'Name', groupable: true, datafield: 'refname', width: '17%' },
				  { text: 'A/c No', groupable: true, datafield: 'acno', width: '5%' },
                  { text: 'Category', groupable: true, datafield: 'category', width: '7%' },
                  { text: 'Acc. Group', groupable: true, datafield: 'accgroup', width: '8%' },
                  { text: 'Salesman', groupable: false, datafield: 'sal_name', width: '7%' },
                  { text: 'TRN No', groupable: false, datafield: 'trnnumber', width: '6%' },
                  { text: 'Credit Period Min', groupable: false, datafield: 'crdprd', width: '7%' },
                  { text: 'Credit Period Max', groupable: false, datafield: 'crmaxdays', width: '7%' },
                  { text: 'Credit Limit', groupable: false, datafield: 'crdlmt', width: '5%' },
                  { text: 'Address', groupable: false, datafield: 'address', width: '16%' },
                  { text: 'Telephone', groupable: false, datafield: 'tel', width: '7%' },
                  { text: 'Mobile', groupable: true, datafield: 'per_mob', width: '9%' },
                  { text: 'Email Id', groupable: false, datafield: 'mail1', width: '13%' },
                  { text: 'Area', groupable: true, datafield: 'area', width: '12%' },
                  { text: 'City', groupable: true, datafield: 'city', width: '7%' },
                  { text: 'Country', groupable: true, datafield: 'country', width: '7%' },
                  
				  
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
    
            $("#overlay, #PleaseWait").hide();
				           
        
}); 
				                              
</script>

<div id="client"></div>