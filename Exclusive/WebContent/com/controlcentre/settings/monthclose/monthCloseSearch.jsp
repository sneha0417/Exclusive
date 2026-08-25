<%@page import="com.controlcentre.settings.monthclose.ClsMonthCloseDAO" %>
<%ClsMonthCloseDAO cmd=new ClsMonthCloseDAO(); %>

<%String branch=request.getParameter("branch")==null?"0":request.getParameter("branch").toString();%>
<script type="text/javascript">
    var data= '<%=cmd.getSearchDetails(branch)%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'voc_no', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'dateupto', type: 'date'  },
                          	{name : 'mclosedate', type: 'date'  }
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
                height: 358,
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
					{ text: 'Original Doc No',filtertype:'number', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Doc No',filtertype:'number',datafield: 'voc_no', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Date Upto', datafield: 'dateupto', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' },
					{ text: 'Month Close Date', datafield: 'mclosedate', width: '30%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' }
	              ]
            });

            $('#mcloseSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#mcloseSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("vocno").value= $('#mcloseSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
		                $("#date").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "date")); 
		                $("#dateupto").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "dateupto")); 
		                $("#mclosedate").jqxDateTimeInput('val', $("#mcloseSearch").jqxGrid('getcellvalue', rowindex1, "mclosedate")); 
		            	$('#window').jqxWindow('close');
            		 }); 
        
        });
    </script>
    <div id="mcloseSearch"></div>
