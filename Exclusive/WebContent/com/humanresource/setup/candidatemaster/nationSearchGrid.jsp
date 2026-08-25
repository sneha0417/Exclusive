<%@page import="com.humanresource.setup.candidatemaster.ClsCandidateMasterDAO"%>
<%ClsCandidateMasterDAO DAO= new ClsCandidateMasterDAO(); %>
<script type="text/javascript">
        
        var national= '<%=DAO.nationsSearch() %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' }, 
     						{name : 'nation', type: 'string' }
                        ],
                		 localdata: national, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#nationSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Nation ID', datafield: 'doc_no', hidden:true, width: '10%' },
							{ text: 'Nation', datafield: 'nation', width: '100%' }
						]
            });
            
            $('#nationSearch').on('rowdoubleclick', function (event) {
                    var rowindex1 = event.args.rowindex;
                    document.getElementById("hidnationid").value = $('#nationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	            document.getElementById("txtnationality").value = $('#nationSearch').jqxGrid('getcellvalue', rowindex1, "nation");
            	
               $('#nationalityWindow').jqxWindow('close');  
            });  
        });
    </script>
    <div id="nationSearch"></div>
 