<%@page import="com.controlcentre.masters.vehiclemaster.financier.ClsFinancierAction" %>
<%ClsFinancierAction cfa=new ClsFinancierAction(); %>


    <script type="text/javascript">
    var data1= '<%=cfa.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'fname', type: 'String'  },
     						{name : 'fid',type:'String'},
                          	{name : 'date', type: 'date'  },
                          	{name : 'acc_no',type:'String'},
                          	{name : 'description',type:'String'}
                          	
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
            $("#jqxFinancierSearch").jqxGrid(
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
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'DOC_NO', width: '10%',filtertype:'number' },
					{ text: 'Financier', datafield: 'fname', width: '70%',columntype: 'textbox', filtertype: 'input' },
					{ text: 'F ID',datafield:'fid',width:'10%',hidden:true,columntype: 'textbox', filtertype: 'input'},
					{ text: 'Date', datafield: 'date', width: '20%' ,columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy'},
					{text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true,columntype: 'textbox', filtertype: 'input'},
					{ text: 'Account',datafield:'description',width:'20%',hidden:true,columntype: 'textbox', filtertype: 'input'}

	              ]
            });
            
            $('#jqxFinancierSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxFinancierSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("finname").value = $("#jqxFinancierSearch").jqxGrid('getcellvalue', rowindex1, "fname");
		                document.getElementById("finid").value = $("#jqxFinancierSearch").jqxGrid('getcellvalue', rowindex1, "fid");
		                $("#findate").jqxDateTimeInput('val',$("#jqxFinancierSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                document.getElementById("txtaccno").value = $("#jqxFinancierSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
		                document.getElementById("txtaccname").value = $("#jqxFinancierSearch").jqxGrid('getcellvalue', rowindex1, "description");
		                $('#window').jqxWindow('hide');
            		 }); 
          
        });
    </script>
    <div id="jqxFinancierSearch"></div>
