<%@page import="com.controlcentre.settings.yearclose.ClsYearcloseDAO" %>
<%ClsYearcloseDAO cyd=new ClsYearcloseDAO(); %>

<%String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();%>
<script type="text/javascript">
    var data= '<%=cyd.getSearchDetails(branch)%>';
 
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     					
                          	{name : 'date', type: 'date'  },
                          	{name : 'dateupto', type: 'date'  },
                          	{name : 'mclosedate', type: 'date'  },
                           	{name : 'clstat' , type: 'string' }
                          	
                          	
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
            $("#mcloseSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                //pageable: true,
                showfilterrow: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
               // sortable: true,
                //Add row method
                columns: [
				
					{ text: 'Doc No',filtertype:'number',datafield: 'doc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Date Upto', datafield: 'dateupto', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Month Close Date', datafield: 'mclosedate', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'cl_stat', datafield: 'clstat', width: '30%' ,hidden:true  }
	              ]
            });

            $('#mcloseSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#mcloseSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                
		                $("#date").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "date")); 
		                $("#dateupto").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "dateupto")); 
		                $("#yclosedate").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "mclosedate")); 
		                
		                var status=$("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "clstat");
		                if(status=="no")
		                	{
		                	 
		                	 $("#btnEdit").attr('disabled', true );
						 $("#btnDelete").attr('disabled', true );
		                	}
		                else
		                	{
		                	
		                	 $("#btnEdit").attr('disabled', false );
							 $("#btnDelete").attr('disabled', false );
		                	
		                	}
		                
		                
		            	$('#window').jqxWindow('close');
            		 }); 
        
        });
    </script>
    <div id="mcloseSearch"></div>
