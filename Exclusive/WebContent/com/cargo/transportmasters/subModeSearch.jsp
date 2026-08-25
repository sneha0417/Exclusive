<%@page import="com.cargo.transportmasters.submode.ClsSubModeAction"%>
<%ClsSubModeAction csa=new ClsSubModeAction();  %>
<script type="text/javascript">
  		
  		var subsearchdata= '<%=csa.searchDetails() %>';
        
  		
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'date', type: 'date'  },
                          	{name : 'modename', type: 'String'  },
                          	{name : 'submode', type: 'String'  },
                          	{name : 'modeid', type: 'int'  }
                          	
                          	],
               localdata: subsearchdata,
        
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
            $("#jqxSubModeSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Date', datafield: 'date', width: '20%' ,cellsformat: 'dd.MM.yyyy'},
					{ text: 'Mode', datafield: 'modename', width: '30%' },
					{ text: 'Submode', datafield: 'submode', width: '30%' },
					{ text: 'Mode id', datafield: 'modeid', width: '40%' , hidden : false }
					

					]
            });
            $('#jqxSubModeSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                $('#cmbmode').attr('disabled', false);
                getMode();
                
                document.getElementById("docno").value= $('#jqxSubModeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#submodedate").jqxDateTimeInput('val', $("#jqxSubModeSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("submodeid").value = $("#jqxSubModeSearch").jqxGrid('getcellvalue', rowindex1, "submode");
                document.getElementById("cmbmodeid").value = $("#jqxSubModeSearch").jqxGrid('getcellvalue', rowindex1, "modeid");
                
                //$('#cmbmode').attr('disabled', true);
                $('#window').jqxWindow('close');
            }); 
         
        });
</script>
<div id="jqxSubModeSearch"></div>
