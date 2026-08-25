<%@page import="com.dashboard.fixedasset.fixedassetregister.ClsFixedAssetRegister"%>
<%ClsFixedAssetRegister DAO= new ClsFixedAssetRegister(); %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String assetno = request.getParameter("assetno")==null?"0":request.getParameter("assetno").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String name = request.getParameter("name")==null?"0":request.getParameter("name").trim();
	String check=request.getParameter("check")==null?"0":request.getParameter("check").trim();%>
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
    
    .textbox {
	    border: 0;
	    height: 25px;
	    width: 20%;
	    border-radius: 5px;
	    -moz-border-radius: 5px;
	    -webkit-border-radius: 5px;
	    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
	    -webkit-background-clip: padding-box;
	    outline: 0;
    }
        
</style>

<script type="text/javascript">
    
       var data1='<%=DAO.fixedDetailedAsssetGridLoading(branchval, fromDate, toDate, assetno)%>';
       var name='<%=name%>';
	  	
        $(document).ready(function (){ 
        	 
    		 $("#excelExport").click(function () {
                 $("#detailedAsset").jqxDataTable('exportData', 'xls');
             });

        	
            // prepare the data
        	 var source =
             {
             	datatype: "json",
                 dataFields: [
                      {name : 'asset_no', type: 'int' },
                      {name : 'assetid', type: 'int' },
                      {name : 'assetname', type: 'string' },
      				  {name : 'acno', type: 'string' },
      				  {name : 'date', type: 'date' },
      				  {name : 'description', type: 'string' },
      				  {name : 'debit', type: 'number' },
      				  {name : 'credit', type: 'number' },
      				  {name : 'ttype', type: 'string' },
      				  {name : 'bookvalue', type: 'number' }
                 ],
                 localdata: data1,  
             };
             var dataAdapter = new $.jqx.dataAdapter(source, {
                 loadComplete: function () {
                     // data is loaded.
                 }
             });
             
             // create jqxDataTable.
             $("#detailedAsset").jqxDataTable(
             {
                 source: dataAdapter,
                 altRows: true,
                 sortable: true,
                 groups: ['asset_no'],
                 width: '99.5%',
                 height: 400,
                 groupsRenderer: function(value, rowData, level)
                 {
                     return "Asset No : " + value;
                 },
                 columns: [
                   { text: 'Asset No', hidden: true, cellsAlign: 'left', align: 'left', dataField: 'asset_no', width: '10%'},
                   { text: 'Asset Id', cellsAlign: 'left', align: 'left', dataField: 'assetid', width: '5%'},
                   { text: 'Asset Name', cellsAlign: 'left', align: 'left', dataField: 'assetname', width: '25%'},
                   { text: 'Account No', cellsAlign: 'left', align: 'left', dataField: 'acno', width: '5%' },
                   { text: 'Date', dataField: 'date', cellsformat:'dd.MM.yyyy', width: '15%' },
                   { text: 'Acc. Head', datafield: 'description', width: '25%' },
                   { text: 'Debit', dataField: 'debit', cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                   { text: 'Credit', dataField: 'credit', cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                   { text: 'TR. Type', dataField: 'ttype', cellsAlign: 'center', align: 'center', width: '5%' },
                   { text: 'Book Value', dataField: 'bookvalue', hidden: true, cellsformat: 'd2', cellsAlign: 'right', align: 'right', width: '10%' },
                 ]
             });
             
             var result=$("#detailedAsset").jqxDataTable('getCellValue', 0, 'bookvalue');
             document.getElementById("txtbookvalue").value=result;
         });

</script>
    
    </head>
<body class='default'>
 <button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button> 
        <div id="detailedAsset"></div>
        
        <table width="100%">
		<tr>
		<td width="92%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Book Value :&nbsp;</td>
        <td width="8%" align="left"><input type="text" class="textbox" id="txtbookvalue" name="txtbookvalue" style="width:80%;text-align: right;" value='<s:property value="txtbookvalue"/>'/></td>
		</tr>
		</table>
	
	</body>
</html>
 