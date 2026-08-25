<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO"%>
<%
ClsPriceManagementDAO DAO = new ClsPriceManagementDAO(); 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
%> 
<script type="text/javascript">
var docno='<%=docno%>';
var reqdata1;
if(parseInt(docno)>0){
	reqdata1='<%=DAO.maingridreload(docno)%>';
}
        $(document).ready(function () { 	
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'portid', type: 'int'  },
							{name : 'port', type: 'string'   },
     						{name : 'region', type: 'string'  },
     						{name : 'unitid', type: 'int'   },
     						{name : 'unit', type: 'string'  },
     						{name : 'price', type: 'number'   },
     						{name : 'tax', type: 'string'   },
     						{name : 'itax', type: 'string'   },
     						{name : 'doc_no', type: 'string'   }
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

            
            
            $("#jqxPriceMngt").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                disabled:true,
                editable: true,
                altRows: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                //Add row method
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center',
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            { text: 'doc_no', datafield: 'doc_no', width: '9%' , hidden: true },
                            { text: 'portid', datafield: 'portid', width: '9%' , hidden:true },	
                            { text: 'Port', datafield: 'port', width: '15%' , editable: false},	
                            { text: 'Region', datafield: 'region', width: '20%' , editable: false},	
                            { text: 'Unit', datafield: 'unit', width: '10%' , editable: false},
                            { text: 'Unit Id', datafield: 'unitid', width: '9%' , editable: false,hidden:true},	
                            { text: 'Price', datafield: 'price', width: '17%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right'},
                            { text: 'Tax(Per Rate)', datafield: 'tax', width: '17%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
                            { text: 'Tax(Per Invoice)', datafield: 'itax', width: '16%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
                            
			              ]
               
            });
           
            $("#jqxPriceMngt").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxPriceMngt").jqxGrid({ disabled: false}); 
    		}
            
            $("#jqxPriceMngt").on('celldoubleclick', function (event){
            	var datafield=event.args.datafield;
            	var dat=0;
            	var rowindextemp = event.args.rowindex;
            	$("#rowindex").val(rowindextemp);
            	if(datafield == "unit")
            	{ 
            		unitSearchContent("unitSearch.jsp");
            	}
            	if(datafield == "port")
      		 	{ 
	      	    	portSearchContent('portINgridsearch.jsp');
      		    }
            	if(datafield == "tax")
      		  	{ 
            		if($('#docno').val()=="")
	             	{
	            		$.messager.alert('Message'," Save the document",'warning');
	             	}
	            	else{
	            		var docno=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'doc_no');
						var price=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'price');
						var tax=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'tax');
	            		taxSearchContent1('taxGrid.jsp?price='+price+'&mode='+$("#mode").val()+'&rdocno='+docno+'&tax='+tax+'&dat=1');
	            	}
      		    } 
            	else if(datafield == "itax")
      		  	{
	            	if($('#docno').val()=="")
	             	{
	            		$.messager.alert('Message'," Save the document",'warning');
	             	}
	            	else{
	            		var docno=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'doc_no');
						var price=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'price');
						var tax=$("#jqxPriceMngt").jqxGrid('getcellvalue',rowindextemp,'itax');
						taxSearchContent2('taxGrid2.jsp?price='+price+'&mode='+$("#mode").val()+'&rdocno='+docno+'&tax='+tax+'&dat=2');
	            	}
    		  }
            });
       $("#jqxPriceMngt").on('cellvaluechanged', function (event){
	       var datafield = event.args.datafield;
	       if(datafield=="port")
	      	{
	    	 $("#jqxPriceMngt").jqxGrid('addrow', null, {});
	      	}
		});
 });
        
        function unitSearchContent(url) {
        	$.get(url).done(function (data) {
        		$('#unitsearchwindow').jqxWindow('open');
        		$('#unitsearchwindow').jqxWindow('setContent', data);
        	});
        }
  	  function taxSearchContent1(url) {
      	$.get(url).done(function (data) {
      		$('#taxsearchwindow').jqxWindow('open');
      		$('#taxsearchwindow').jqxWindow('setContent', data);
      	});
      }
  	function taxSearchContent2(url) {
      	$.get(url).done(function (data) {
      		$('#itaxsearchwindow').jqxWindow('open');
      		$('#itaxsearchwindow').jqxWindow('setContent', data);
      	});
      }
  	
    </script>
    <div id="jqxPriceMngt"></div>
  <input type="hidden" id="rowindex"/>
