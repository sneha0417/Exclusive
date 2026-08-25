<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
<%String yomfrm=request.getParameter("yomfrm");%>
<%String yomto=request.getParameter("yomto");%>
<script type="text/javascript">
var uomrow='<%=request.getParameter("rowno") %>';
$(document).ready(function () {
  
   var suitdata;
  
	    suitdata='<%=DAO.suitSearch(session,yomfrm,yomto) %>'; 
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

	{name : 'doc_no', type: 'string'  },          
	{name : 'model', type: 'string'  },
	{name : 'modelid', type: 'int'   },
	{name : 'submodel', type: 'string'  },
	{name : 'submodelid', type: 'int'   },
	{name : 'brand', type: 'string'   },
	{name : 'brandid', type: 'int'   },
	{name : 'yomfrm', type: 'string'   },
	{name : 'yomto', type: 'string'   },
	{name : 'yomfrmid', type: 'int'   },
	{name : 'yomtoid', type: 'int'   },
	{name : 'esize', type: 'string'   },
	{name : 'esizeid', type: 'int'   },
	{name : 'bsize1', type: 'string'   },
	{name : 'bsize1id', type: 'int'   },
	{name : 'bsize2', type: 'string'   },
	{name : 'bsize2id', type: 'int'   },
	{name : 'bsize3', type: 'string'   },
	{name : 'bsize3id', type: 'int'   },
	{name : 'csize1', type: 'string'   },
	{name : 'csize1id', type: 'int'   },
	{name : 'csize2', type: 'string'   },
	{name : 'csize2id', type: 'int'   },
	{name : 'csize3', type: 'string'   },
	{name : 'csize3id', type: 'int'   },
	
                  		
                  		
                  		],
				    localdata: suitdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
   
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#suitSearch").jqxGrid(
    {
        width: '98%',
        height: 120,
        source: dataAdapter,
        showaggregates:true,
        showfilterrow: true, 
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%', cellsrenderer: function (row, column, value) {
    return "<div style='margin:4px;'>" + (value + 1) + "</div>";
}   },
{ text: 'doc_no', datafield: 'doc_no', hidden: true, width: '10%',cellsalign: 'center', align: 'center' },
{ text: 'Yom(From)', datafield: 'yomfrm', editable: false, width: '5%',cellsalign: 'center', align: 'center' },
{ text: 'Yomfrmid', datafield: 'yomfrmid', hidden:true, width: '15%',cellsalign: 'center', align: 'center' },
{ text: 'Yom(To)', datafield: 'yomto', editable: false, width: '5%',cellsalign: 'center', align: 'center' },
{ text: 'Yomtoid', datafield: 'yomtoid', hidden:true, width: '15%',cellsalign: 'center', align: 'center' },
{ text: 'typeid', datafield: 'typeid', width: '5%',hidden:true },
{ text: 'modelid', datafield: 'modelid', width: '5%',hidden:true },
{ text: 'brandid', datafield: 'brandid', width: '5%',hidden:true },
{ text: 'submodelid', datafield: 'submodelid', width: '5%',hidden:true },
{ text: 'Type', datafield: 'ptype', editable: false, width: '15%',cellsalign: 'center', align: 'center',hidden:true },
{ text: 'Brand', datafield: 'brand', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
{ text: 'Model', datafield: 'model', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
{ text: 'Sub Model', datafield: 'submodel', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
{ text: 'EngineSize', datafield: 'esize', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
{ text: 'spec2id', datafield: 'esizeid', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'BedSize1', datafield: 'bsize1', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
{ text: 'BedSize2', datafield: 'bsize2', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
{ text: 'BedSize3', datafield: 'bsize3', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
{ text: 'bsize1id', datafield: 'bsize1id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'bsize2id', datafield: 'bsize2id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'bsize3id', datafield: 'bsize3id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'CabinSize1', datafield: 'csize1', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'csize1id', datafield: 'csize1id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },
{ text: 'CabinSize2', datafield: 'csize2', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'csize2id', datafield: 'csize2id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },
{ text: 'CabinSize3', datafield: 'csize3', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
{ text: 'csize3id', datafield: 'csize3id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },


					]

    });
    
    $( "#btnsuit" ).click(function() {
    	
    	funUpdate();
    	
    	
    	$('#suitsearchwindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#suitsearchwindow').jqxWindow('close');
    	});
});

function funUpdate(){
    var rows = $("#suitSearch").jqxGrid('selectedrowindexes');
  //alert(rows.length);
    var selectedRecords = new Array();
    for(var i=0;i<rows.length;i++){
		var docno=$('#suitSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
		
		if(i==0){
			document.getElementById("hidvehsuitid").value=docno;
		}
		else{
			document.getElementById("hidvehsuitid").value+=","+docno;
		}
	}
    $("#partSearchdiv").load("partSearchGrid.jsp?type=2&suitid="+document.getElementById("hidvehsuitid").value);
}
  	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnsuit" name="btnok" class="myButton">Search</button>&nbsp;&nbsp;</div>

<!-- <button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button> -->
<div id="suitSearch"></div>