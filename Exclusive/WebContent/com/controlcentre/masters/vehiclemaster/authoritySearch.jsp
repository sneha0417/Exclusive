<%@page import="com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityAction" %>
<%ClsAuthorityAction ca=new ClsAuthorityAction(); %>

<script type="text/javascript">
    var data= '<%=ca.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'authname', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'authid',type:'String'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
            $("#jqxAuthoritySearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                //pageable: true,
                showfilterrow: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Authority', columntype: 'textbox', filtertype: 'input',datafield: 'authname', width: '50%' },
					{ text: 'Date', datafield: 'date', width: '40%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' }
	              ]
            });
            $("#jqxAuthoritySearch").jqxGrid('hidecolumn', 'authid'); 

            $('#jqxAuthoritySearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxAuthoritySearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("authname").value = $("#jqxAuthoritySearch").jqxGrid('getcellvalue', rowindex1, "authname");
		                $("#authdate").jqxDateTimeInput('val', $("#jqxAuthoritySearch").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("auth").value= $("#jqxAuthoritySearch").jqxGrid('getcellvalue', rowindex1, "authid");
		            	$('#window').jqxWindow('hide');
            		 }); 
        
        });
    </script>
    <div id="jqxAuthoritySearch"></div>
