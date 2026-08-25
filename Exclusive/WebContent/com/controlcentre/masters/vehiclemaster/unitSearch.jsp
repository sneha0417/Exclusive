 <%@page import="com.controlcentre.masters.vehiclemaster.unit.ClsUnitAction" %>
<% ClsUnitAction cua =new ClsUnitAction();%>

<script type="text/javascript">
    var data= '<%=cua.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'unit', type: 'String'  },
     						{name : 'unit_desc', type:  'String'}
                          	
                 ],
                 localdata: data,
                
                
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
            $("#jqxUnitSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'Unit',columntype: 'textbox', filtertype: 'input', datafield: 'unit', width: '30%' },
					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'unit_desc',width:'30%'}
	              ]
            });
          
            $('#jqxUnitSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxUnitSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("unit").value = $("#jqxUnitSearch").jqxGrid('getcellvalue', rowindex1, "unit");
		                document.getElementById("unitdesc").value = $("#jqxUnitSearch").jqxGrid('getcellvalue', rowindex1, "unit_desc");

		                $('#window').jqxWindow('hide');
            		 }); 
         
        });
    </script>
    <div id="jqxUnitSearch"></div>
