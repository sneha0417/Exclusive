<%@page import="com.controlcentre.settings.areamaster.region.ClsRegionAction"%>
<%ClsRegionAction DAO= new ClsRegionAction();%>    
    <script type="text/javascript">
  		var data= '<%=DAO.searchDetails()%>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'REG_NAME', type: 'String'  },
                          	{name : 'DATE', type: 'String'  }
                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxRegionSearch").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
					{ text: 'DOC NO',filtertype:'number', datafield: 'DOC_NO', width: '10%' },
					{ text: 'REGION',columntype: 'textbox', filtertype: 'input', datafield: 'REG_NAME', width: '50%' },
					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '40%' }
	              ]
            });
            $('#jqxRegionSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxRegionSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("region").value = $("#jqxRegionSearch").jqxGrid('getcellvalue', rowindex1, "REG_NAME");
                $("#date_reg").jqxDateTimeInput('val', $("#jqxRegionSearch").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxRegionSearch"></div>
