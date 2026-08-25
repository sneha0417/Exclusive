<%@page import="com.cargo.transportmasters.mode.ClsModeAction"%>
<%@page import="com.controlcentre.masters.salesmanmaster.staff.ClsStaffAction" %>
<%ClsModeAction cma=new ClsModeAction();  %>
<script type="text/javascript">
  		
  		var data= '<%=cma.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'date', type: 'date'  },
                          	{name : 'modename', type: 'String'  },
                          	
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
            $("#jqxModeSearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
					{ text: 'Date', datafield: 'date', width: '30%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Mode', datafield: 'modename', width: '40%' },
					

					]
            });
            $('#jqxModeSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#jqxModeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#modedate").jqxDateTimeInput('val', $("#jqxModeSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("modeid").value = $("#jqxModeSearch").jqxGrid('getcellvalue', rowindex1, "modename");
         
                
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxModeSearch"></div>
