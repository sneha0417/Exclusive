<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO" %>
<%
    ClsServiceSaleDAO DAO=new ClsServiceSaleDAO();
	String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
	String owner = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
	String ptype = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");
 	String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 	String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 	String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 	String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
%>
<script type="text/javascript"> 

var datamain1= '<%=DAO.pmaterearch(session,docnoss,owner,ptype,datess,aa,descriptions,refnoss) %>'; 
$(document).ready(function () {  
	var source =
    {
    	datatype: "json",
        datafields: [
        	{name : 'doc_no', type: 'int'   },                            
            {name : 'voc_no', type: 'int'   },                         
            {name : 'date', type: 'date'   },     					 
     		{name : 'owner', type: 'string'   },
     		{name : 'desc1', type: 'string'   },     					 
     		{name : 'name', type: 'string'   },     						
     		{name : 'type', type: 'string'   },     						     						
     		{name : 'adate', type: 'date'   },
		    {name : 'mngperc', type: 'string'   },
		    {name : 'propertyid',type:'string'},
		    {name : 'unitno',type:'string'},
		    {name : 'optid',type:'string'},
		    {name : 'chktenancychequeowner',type:'string'},
		    {name : 'mgmtfeevalue',type:'string'},
		    {name : 'mgmtfeepercent',type:'string'},
		    {name : 'ownertel',type:'string'},
		    {name : 'ownermobile',type:'string'},
		    {name : 'owneremail',type:'string'},
		    {name : 'strmanage',type:'string'},
		],
        localdata: datamain1, 
        pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
        }
	};
            
    var dataAdapter = new $.jqx.dataAdapter(source);
    $("#searshgrid").jqxGrid(
    {
    	width: '100%',
        height: 283,
        source: dataAdapter,           
        selectionmode: 'singlerow',                
        columns: [ 
        	{ text: 'Doc No', datafield: 'voc_no', width: '6%',hidden:true },
            { text: 'Property ID', datafield: 'propertyid', width: '10%'},
			{ text: 'Unit No', datafield: 'unitno', width: '10%'},
			{ text: 'Optional ID', datafield: 'optid', width: '10%'},
			{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },							
			{ text: 'Property Name', datafield: 'name', width: '20%'  },
			{ text: 'Owner ', datafield: 'owner', width: '30%'  },
			{ text: 'Status ', datafield: 'type', width: '10%'  },
			{ text: 'Available Date ', datafield: 'adate', width: '12%' ,cellsformat:'dd.MM.yyyy' },
			{ text: 'Description', datafield: 'desc1', width: '20%' },		
			{ text: 'mng perc', datafield: 'mngperc', width: '20%' ,hidden:true},
			{ text: 'Cheque Owner Name', datafield: 'chktenancychequeowner', width: '20%' ,hidden:true},
			{ text: 'Mgmt Fee Percent', datafield: 'mgmtfeepercent', width: '20%' ,hidden:true},
			{ text: 'Mgmt Fee Value', datafield: 'mgmtfeevalue', width: '20%' ,hidden:true},
			{ text: 'Owner Tel', datafield: 'ownertel', width: '20%' ,hidden:true},
			{ text: 'Owner Mobile', datafield: 'ownermobile', width: '20%' ,hidden:true},
			{ text: 'Owner Email', datafield: 'owneremail', width: '20%' ,hidden:true},
			{ text: 'Manage', datafield: 'strmanage', width: '20%' ,hidden:true},
		]
	});
            
    $('#searshgrid').on('rowdoubleclick', function (event) {     
    	var rowindex1 = event.args.rowindex;
    	var rowindex2 = $('#rowindex').val();
    	$('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex2, "remarks" ,$('#searshgrid').jqxGrid('getcellvalue', rowindex1, "name"));
    	$('#propertysearchwndow').jqxWindow('close');   
    }); 
             
});
</script>
<div id="searshgrid"></div>