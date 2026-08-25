<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
<%
ClsEstimationDAO DAO = new ClsEstimationDAO();
String modeid = request.getParameter("modeid")==null?"0":request.getParameter("modeid").trim();
String shipid = request.getParameter("shipid")==null?"0":request.getParameter("shipid").trim();
String smodeid = request.getParameter("smodeid")==null?"0":request.getParameter("smodeid").trim();
String enqdocno = request.getParameter("enqdocno")==null?"0":request.getParameter("enqdocno").trim();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>

<script type="text/javascript">
var reqdata1;
var list =['CASH','CARD','ONLINE'];
var list1 =['ACTUAL','QUOTED'];
var id='<%=id%>';

$(document).ready(function () {
	
	if(id==1){
// 		alert(docno+"-"+enqdocno+"-"+modeid+"-"+smodeid+"-"+shipid);
		reqdata1='<%=DAO.estmDataLoad(docno,enqdocno,id,modeid,smodeid,shipid)%>';
	}
	var source =
	{
			datatype: "json",
			datafields: [
			             {name : 'sertype', type: 'string'},
			             {name : 'srvdocno', type: 'int'},
			             {name : 'currency', type: 'string'},
			             {name : 'rate', type: 'number'},
			             {name : 'price', type: 'number'},
			             {name : 'qty', type: 'number'},
			             {name : 'uom', type: 'string'},
			             {name : 'basetotal', type: 'number'},
			             {name : 'total', type: 'number'},
			             {name : 'billing', type: 'string'},
			             {name : 'vendor', type: 'string'},
			             {name : 'unitid', type: 'string'},
			             {name : 'vndid', type: 'string'},
			             {name : 'curid', type: 'string'},
			             {name : 'status', type: 'string'}
                 ],
                 localdata: reqdata1,
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

            $("#jqxEstimation").on("bindingcomplete", function (event) {
            	var rows=$("#jqxEstimation").jqxGrid('getrows');
        		for(var i=0;i<rows.length;i++){
        			if($('#jqxEstimation').jqxGrid('getcellvalue', i, "status")==1){
        				$('#jqxEstimation').jqxGrid('selectrow', i);
        			}
        		}
        	});
            
            
            $("#jqxEstimation").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'checkbox',
                pagermode: 'default',
                theme: 'energyblue',
                columns: [
                          { text: 'Service Type', datafield: 'sertype', width: '10%', editable: false },	
      					  { text: 'Currency', datafield: 'currency', width: '8%', editable: false },	
      					  { text: 'Rate', datafield: 'rate', width: '8%', editable: false,cellsformat: 'd2', align: 'right', cellsalign: 'right' },
      					  { text: 'Price', datafield: 'price', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right' },
						  { text: 'QTY', datafield: 'qty', width: '8%',cellsformat: 'd2' },	
						  { text: 'UOM', datafield: 'uom', width: '10%', editable: false },
						  { text: 'Total', datafield: 'total', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right' , editable: false},	
						  { text: 'Base Total', datafield: 'basetotal', width: '10%',cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
						  { text: 'Billing', datafield: 'billing', width: '10%', columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list1 });
							  }
						  },	
						  { text: 'Vendor', datafield: 'vendor', width: '14%', editable: false},
						  { text: 'srvdocno', datafield: 'srvdocno', width: '12%',hidden: true },
						  { text: 'unitid', datafield: 'unitid', width: '12%',hidden: true },
						  { text: 'vndid', datafield: 'vndid', width: '12%',hidden: true },
						  { text: 'curid', datafield: 'curid', width: '12%',hidden: true },
						  { text: 'status', datafield: 'status', width: '12%',hidden: true },
			              ]
               
            });
           
            $("#jqxEstimation").jqxGrid('addrow', null, {});
        	
            $("#jqxEstimation").on("celldoubleclick", function (event){
            	var columnindex1=event.args.datafield;
            	$('#rowindex').val(event.args.rowindex);
            	if(columnindex1 == "currency")
            	{ 
            		currencySearchContent("currencySearch.jsp");
            	}
            	if(columnindex1 == "uom")
            	{ 
            		unitSearchContent("unitSearch.jsp");
            	}
            	if(columnindex1 == "vendor")
            	{ 
            		vendorSearchContent("vendorSearch.jsp");
            	}
            	
            });
            $("#jqxEstimation").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
            	var rowBoundIndex = event.args.rowindex;   
            	if(datafield=="qty" || datafield=="price"){
            		var price= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "price");
            		var qty= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            		var total=parseFloat(price)*parseFloat(qty);
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "total", total);
            	}
            	if(datafield=="total" || datafield=="rate"){
            		var rate= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "rate");
            		var total= $('#jqxEstimation').jqxGrid('getcellvalue', rowBoundIndex, "total");
            		var basetotal=parseFloat(rate)*parseFloat(total);
            		$("#jqxEstimation").jqxGrid('setcellvalue', rowBoundIndex, "basetotal", basetotal);
            	}
            }); 
            
         		  
}); 
function currencySearchContent(url) {
	$.get(url).done(function (data) {
		$('#currencysearchwindow').jqxWindow('open');
		$('#currencysearchwindow').jqxWindow('setContent', data);
	});
}
function unitSearchContent(url) {
	$.get(url).done(function (data) {
		$('#unitsearchwindow').jqxWindow('open');
		$('#unitsearchwindow').jqxWindow('setContent', data);
	});
}
function vendorSearchContent(url) {
	$.get(url).done(function (data) {
		$('#vendorsearchwindow').jqxWindow('open');
		$('#vendorsearchwindow').jqxWindow('setContent', data);
	});
}
    </script>
    <div id="jqxEstimation"></div>
  <input type="hidden" id="rowindex"/> 