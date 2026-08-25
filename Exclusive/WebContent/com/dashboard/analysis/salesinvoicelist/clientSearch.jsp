<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%> 
<script type="text/javascript">

        $(document).ready(function () { 	
            var clientdata='';

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'client',type: 'String'}
     						
                 ],
                localdata: clientdata,
                //url: url,
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
            $("#clientSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
							{ text: 'Client', datafield: 'client',width:'80%'}
							
	              ]
            });
           
            $('#clientSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("client").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "client"); 
            	document.getElementById("hidclient").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              $('#clientwindow').jqxWindow('close');
            });  
        });
    </script>
    <div id="clientSearch"></div>
