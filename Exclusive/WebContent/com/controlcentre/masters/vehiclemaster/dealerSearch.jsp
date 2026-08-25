<%@page import="com.controlcentre.masters.vehiclemaster.dealer.ClsDealerAction" %>
<%ClsDealerAction cda=new ClsDealerAction(); %>


  <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
   <script type="text/javascript">
    var data1= '<%=cda.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'int' },
     						{name : 'name', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'date',type:'date'},
                          	{name : 'description',type:'string'}
                          	
                 ],
                 localdata: data1,
                
                
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
            $("#jqxDealerSearch").jqxGrid(
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
                //sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
					{text: 'Acc No',columntype: 'textbox', filtertype: 'input',datafield:'acc_no',width:'20%',hidden:true},
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%' ,cellsformat:'dd.MM.yyyy'},
					{ text: 'Account',columntype: 'textbox', filtertype: 'input',datafield:'description',width:'40%'}

					]
            });
           
            $('#jqxDealerSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxDealerSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("dealername").value = $("#jqxDealerSearch").jqxGrid('getcellvalue', rowindex1, "name");
		                $("#dealerdate").jqxDateTimeInput('val',$("#jqxDealerSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                document.getElementById("txtaccname").value = $("#jqxDealerSearch").jqxGrid('getcellvalue', rowindex1, "description");
		                document.getElementById("txtaccno").value = $("#jqxDealerSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
		            	$('#window').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxDealerSearch"></div>
