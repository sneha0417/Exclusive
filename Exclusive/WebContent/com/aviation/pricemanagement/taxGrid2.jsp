<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO"%>
<%
ClsPriceManagementDAO DAO = new ClsPriceManagementDAO(); 
String price = request.getParameter("price")==null?"0":request.getParameter("price").trim();
String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
String mode = request.getParameter("mode")==null?"0":request.getParameter("mode").trim();
String dat = request.getParameter("dat")==null?"0":request.getParameter("dat").trim();
String tax = request.getParameter("tax")==null?"0":request.getParameter("tax").trim();
%>
<script type="text/javascript">
var reqdata2=[];
var num;
var rdocno='<%=rdocno%>';
var price='<%=price%>';

var list =['CARGO','EXPRESS'];
$(document).ready(function () {
	if(rdocno!="0"){
       reqdata2='<%=DAO.taxDataLoad(price,rdocno,dat) %>';
	}
	$("#netamount").val('<%=tax%>');
       var rendererstring=function (aggregates){
    	   
		var value=aggregates['sum'];
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
	var source =
	{
			datatype: "json",
			datafields: [
					 {name : 'taxid', type: 'int'},
		             {name : 'tax', type: 'string'},
		             {name : 'taxname', type: 'string'},
		             {name : 'curr', type: 'string'},
		             {name : 'percentage', type: 'number'},
		             {name : 'amount', type: 'number'},
		             {name : 'rdocno', type: 'string'},
		             {name : 'doc_no', type: 'string'},
                 ],
                 localdata: reqdata2,
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
            
            $("#jqxCalcData2").jqxGrid(
            {
                width: '100%',
                height: 290,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                theme: 'energyblue',
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 21,
                columns: [
						{ text: 'SL#', sortable: false, filterable: false, editable: false,
						    groupable: false, draggable: false, resizable: false,cellsalign: 'center',
						    datafield: 'sl', columntype: 'number', width: '5%',
						    cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    }
						  },
						  { text: 'taxdoc', datafield: 'taxid', width: '5%', hidden: true},
                          { text: 'Tax ID', datafield: 'tax', width: '25%',editable: false},	
      					  { text: 'Tax Name', datafield: 'taxname', width: '25%',editable: false},	
      					  { text: 'Curr', datafield: 'curr', width: '10%',editable: false},
      					  { text: 'Percentage', datafield: 'percentage', width: '15%',cellsformat : 'd2'},
						  { text: 'Amount', datafield: 'amount', width: '20%',aggregates: ['sum'], aggregatesrenderer:rendererstring, cellsformat : 'd2',align: 'right', cellsalign: 'right'},	
      					  { text: 'rdocno', datafield: 'rdocno', width: '5%', hidden: true},
       					  { text: 'doc_no', datafield: 'doc_no', width: '5%', hidden: true},
			              ]
               
            });
           
        $("#jqxCalcData2").jqxGrid('addrow', null, {});
            
            $("#jqxCalcData2").on('celldoubleclick', function (event){
            	var datafield=event.args.datafield;
            	var rowindextemp = event.args.rowindex;
	      	    document.getElementById("rowindex3").value = rowindextemp; 
            	if(datafield == "tax"){ 
            		taxTypeSearchContent("taxSearch.jsp?id=2");
            	}
            });
            
            $("#jqxCalcData2").on('cellvaluechanged', function (event){
            	var datafield = event.args.datafield;
            	var rowBoundIndex = event.args.rowindex;
            	if(datafield=="tax"){
            		num=0;
            		$("#jqxCalcData2").jqxGrid('setcellvalue', rowBoundIndex, "curr", "usc");
            	}
            	if(datafield=="percentage"){
            		var perc= $('#jqxCalcData2').jqxGrid('getcellvalue', rowBoundIndex, "percentage");
            		var amount=parseFloat(price)*parseFloat(perc)/100;
            		$("#jqxCalcData2").jqxGrid('setcellvalue', rowBoundIndex, "amount", amount);
            	}
            	else if(datafield=="amount"){
            		var amount= parseFloat($('#jqxCalcData2').jqxGrid('getcellvalue', rowBoundIndex, "amount"));
            		var perc=(parseFloat(amount)/parseFloat(price))*100;
            		$("#jqxCalcData2").jqxGrid('setcellvalue', rowBoundIndex, "percentage", perc);
            		
            		var tax= $("#jqxCalcData2").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
            		$("#netamount").val(tax.sum);
            		
            		if(num==0){
            			$("#jqxCalcData2").jqxGrid('addrow', null, {});
            		}
            		num=num+1;
            	}
            });
});

 function funSaveData(rowindex){
 	var rows = $("#jqxCalcData2").jqxGrid('getrows');
  	var length=rows.length;
  	var tax=$('#jqxCalcData2').jqxGrid('getcellvalue', 0, "tax");
 	if(typeof(tax)==""||typeof(tax)=="undefined"){
 		document.getElementById("errormsg1").innerText="No data !!";
	}
 	else{
		$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
     		if (r){
     			var tax= $("#jqxCalcData2").jqxGrid('getcolumnaggregateddata', 'amount', ['sum'],true);
     			var gridarray=new Array();
		  	    for(var i = 0; i < rows.length; i++){
		  	        gridarray[i]=(rows[i].taxid+"::"+rows[i].curr+"::"+$('#jqxCalcData2').jqxGrid('getcelltext', i, "percentage")+"::"+rows[i].amount+"::");
		  	    }
     			getData(tax.sum,gridarray);
     		}
		});
 	}
}

function getData(tax,gridarray){
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText.trim();
			if(parseInt(items)=="0")  
			{
				
				var rowindex1=$("#rowindex").val();
				$("#jqxPriceMngt").jqxGrid('setcellvalue', rowindex1, "itax", tax);
				$('#jqxCalcData2').jqxGrid('clear');
				$.messager.alert('Message', '  Tax Updated ','info');
				$('#taxsearchwindow').jqxWindow('close');
				$('#itaxsearchwindow').jqxWindow('close');
				$("#jqxPriceMngt").jqxGrid({ disabled: true});
			}
			else
			{
				$.messager.alert('Message', '  Not Updated  ','warning');
			}
		}
	}
	x.open("GET","saveTax.jsp?rdocno="+rdocno+"&gridarray="+gridarray+"&tax="+tax+"&mode="+'<%=mode%>'+"&type="+<%=dat%>+"",true);    
	x.send();
}
function taxTypeSearchContent(url) {
  	$.get(url).done(function (data) {
  		$('#taxtypesearchwindow').jqxWindow('open');
  		$('#taxtypesearchwindow').jqxWindow('bringToFront');
  		$('#taxtypesearchwindow').jqxWindow('setContent', data);
  	});
  }
</script>
<style>
.myButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #E0ECF8), color-stop(1, #81BEF7));
	background:-moz-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-webkit-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-o-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-ms-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:linear-gradient(to bottom, #E0ECF8 5%, #81BEF7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#E0ECF8', endColorstr='#81BEF7',GradientType=0);
	background-color: #E0ECF8;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	display:inline-block;
	cursor:pointer;
	font-size:8pt;
	
	padding:3px 22px;
	text-decoration:none;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #81BEF7), color-stop(1, #E0ECF8));
	background:-moz-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	background:-webkit-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	background:-o-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	background:-ms-linear-gradient(top, #81BEF7 5%, #E0ECF8 100%);
	background:linear-gradient(to bottom, #81BEF7 5%, #E0ECF8 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#81BEF7', endColorstr='#E0ECF8',GradientType=0);
	background-color:#81BEF7;
}
.myButton:active {
	position:relative;
	top:1px;
}

</style>

<table width="100%">
<tr><td style="text-align: center;">
<label style="font-size: 10px;">Total Amount in usc :</label>&nbsp;
<input type="text" id="netamount" name="netamount"/></td></tr>
<tr><td>
<div id="jqxCalcData2"></div>
</td></tr>
<tr><td style="text-align: center;">
<input type="button" class="myButton" name="btnSave" id="btnSave" value="Save" onclick="funSaveData()">
<input type="hidden" id="rowindex3"/>
</td></tr>
</table>