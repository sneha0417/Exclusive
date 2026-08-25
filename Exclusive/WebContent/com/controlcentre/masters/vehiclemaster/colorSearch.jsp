<%@page import="com.controlcentre.masters.vehiclemaster.color.ClsColorAction" %>
<%ClsColorAction coa=new ClsColorAction(); %>


<script type="text/javascript">
    var data= '<%=coa.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'color', type: 'String'  }
                          	
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
            $("#jqxColorSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'Color', datafield: 'color',columntype: 'textbox', filtertype: 'input', width: '60%' }
	              ]
            });
          
            $('#jqxColorSearch').on('rowdoubleclick', function (event) 
            		{ 
            			var rowindex1=event.args.rowindex;
              		 	 document.getElementById("docno").value= $('#jqxColorSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
               			 document.getElementById("color").value = $("#jqxColorSearch").jqxGrid('getcellvalue', rowindex1, "color");                
            	 		 $('#window').jqxWindow('hide');
            		 }); 
          
        });
    </script>
    <div id="jqxColorSearch"></div>
