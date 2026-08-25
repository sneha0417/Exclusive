<%@page import="com.cargo.estimation.ClsEstimationDAO"%>
<%

String rowindex = request.getParameter("rowindex")==null?"0":request.getParameter("rowindex").trim();
String enqddoc = request.getParameter("enqddoc")==null?"0":request.getParameter("enqddoc").trim();
String mode = request.getParameter("mode")==null?"0":request.getParameter("mode").trim();

ClsEstimationDAO DAO=new ClsEstimationDAO();
%>
<script type="text/javascript">
var reqdata2;
var rowindex='<%=rowindex%>';
var enqddoc='<%=enqddoc%>';
var mode='<%=mode%>';

var list =['CARGO','EXPRESS'];
$(document).ready(function () {
	if(enqddoc>0)
  	 {
       reqdata2='<%=DAO.volumeDataLoad(enqddoc) %>';
  	 } 
	var rendererstring=function (aggregates){
		var value=aggregates['sum'];
		return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
	}
	var source =
	{
			datatype: "json",
			datafields: [
		             {name : 'type', type: 'string'},
		             {name : 'length1', type: 'number'},
		             {name : 'width', type: 'number'},
		             {name : 'height', type: 'number'},
		             {name : 'qty1', type: 'number'},
		             {name : 'volweight', type: 'number'},
		             {name : 'actualweight', type: 'number'}
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
            
            $("#jqxCalcData").jqxGrid(
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
                          { text: 'Type', datafield: 'type', width: '14%', columntype:'dropdownlist',
							  createeditor: function (row, column, editor) {
	                                editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
								  }
                          },	
      					  { text: 'Length', datafield: 'length1', width: '12%'},	
      					  { text: 'Width', datafield: 'width', width: '12%'},
      					  { text: 'Height', datafield: 'height', width: '12%'},
						  { text: 'QTY', datafield: 'qty1', width: '10%'},	
						  { text: 'Volume Weight', datafield: 'volweight', width: '20%', editable: false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsformat : 'd2' },
						  { text: 'Actual Weight', datafield: 'actualweight', width: '20%',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsformat : 'd2' },	
			              ]
               
            });
           
            $("#jqxCalcData").jqxGrid('addrow', null, {});
            
            $("#jqxCalcData").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
            	var rowBoundIndex = event.args.rowindex;
            	if(datafield=="qty1"||datafield=="type"||datafield=="length1"||datafield=="width"||datafield=="height"){
            		var type= $('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "type");
            		var length= parseFloat($('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "length1"));
            		var width= parseFloat($('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "width"));
            		var height= parseFloat($('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "height"));
            		var qty= parseFloat($('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "qty1"));
            		var volweight;
            		if(mode==2){
            			if(type=="CARGO"){
            				 volweight=length*width*height*qty/6000;
            			}
            			else if(type=="EXPRESS"){
            				 volweight=length*width*height*qty/5000;
            			}
            		}
            		else if(mode==1){
            			if(type=="CARGO"){
            				volweight=(length/100)*(width/100)*(height/100)*qty;
            			}
            		}
            		
//             		var volweight=parseFloat(qty)*parseFloat(weight);
            		$("#jqxCalcData").jqxGrid('setcellvalue', rowBoundIndex, "volweight", volweight);            	
            			
            	}
            	if(datafield=="type"&&mode=="1"&&$('#jqxCalcData').jqxGrid('getcellvalue', rowBoundIndex, "type")=="EXPRESS"){
            		document.getElementById("errormsg1").innerText="Calculation not possible for Express in Sea mode !!";
            		$("#jqxCalcData").jqxGrid('setcellvalue', rowBoundIndex, 'type', "CARGO");
            	}
            	if(datafield=="type"){
            		$("#jqxCalcData").jqxGrid('addrow', null, {});
            	}
            });
});

function funSaveData(rowindex){
 	var rows = $("#jqxCalcData").jqxGrid('getrows');
  	var length=rows.length;
 	if($('#jqxCalcData').jqxGrid('getcellvalue', 0, "type")==""||$('#jqxCalcData').jqxGrid('getcellvalue', 0, "type")=="undefined"){
 		document.getElementById("errormsg1").innerText="No data !!";
	}
 	else{
		$.messager.confirm('Confirm', 'Do you want to Save Changes?', function(r){
     		if (r){ 
     			var volweight= $("#jqxCalcData").jqxGrid('getcolumnaggregateddata', 'volweight', ['sum'],true);
     			var actualweight= $("#jqxCalcData").jqxGrid('getcolumnaggregateddata', 'actualweight', ['sum'],true);
     			var weighttype= $('#cmbweighttype').val();
     			
     			var gridarray=new Array();
		  	    for(var i = 0; i < rows.length; i++)
		  	    {
		  	        gridarray[i]=($("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'type')+"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'length1')
		  	        +"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'width')+"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'height')+"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'qty1')
		  	        +"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'volweight')+"::"+$("#jqxCalcData").jqxGrid('getcellvalue',rows[i],'actualweight')+"::");
		  	    }
     			
     			if(weighttype=="vol"){
     				updateVol(volweight.sum,rowindex,gridarray);
     			}
     			else{
     				updateVol(actualweight.sum,rowindex,gridarray);
     			}
     		}
		});
 	}
}

function updateVol(weight,rowindex,gridarray){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
			var items=x.responseText.trim();
			if(parseInt(items)=="0")  
			{
				$.messager.alert('Message', '  Record Successfully Updated ','info');
				$("#jqxEnquiry").jqxGrid('setcellvalue', rowindex, 'volume', weight);
				
				$('#jqxCalcData').jqxGrid('clear');
				$('#calculatewindow').jqxWindow('close');
			}
			else
			{
				$.messager.alert('Message', '  Not Updated  ','warning');
			}
		}
	}
	x.open("GET","updateVol.jsp?weight="+weight+"&enqddoc="+'<%=enqddoc%>'+"&gridarray="+gridarray,true);    
	x.send();
}

</script>
<style>
#errormsg1 {
  -moz-animation-duration: 1s;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  
  -webkit-animation-duration: 2s;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  
  animation-duration: 1s;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}
</style>
    
    <table width="100%">
    <tr><td colspan="2"> <label id="errormsg1" name="errormsg1" style="color:red;font-weight:bold;"><s:property value="errormsg1"/></label></td></tr>
    <tr><td colspan="2"><div id="jqxCalcData"></div></td></tr>
    <tr><td align="right" width="50%">
   <select name="cmbweighttype" id="cmbweighttype" style="width:40%;" >
    <option value="vol">VOLUME WEIGHT</option><option value="act">ACTUAL WEIGHT</option></select></td>
    <td align="left"><input type="button" name="btnSaveData" id="btnSaveData" value="Save" class="myButtons" style="width: 40%" onclick="funSaveData(rowindex);">
   
    </td></tr></table>
