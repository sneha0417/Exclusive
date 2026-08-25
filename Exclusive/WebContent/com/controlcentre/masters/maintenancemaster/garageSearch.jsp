<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>
    <script type="text/javascript">
    var data= '<%=cgd.getGarage()%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number'},
     						{name : 'code', type: 'String'},
                          	{name : 'name', type: 'String'},
                          	{name : 'date',type:'date'},
                          	{name : 'type', type:'String'},
                          	{name : 'branch', type:'String'},
                          	{name : 'location', type:'String'},
                          	{name : 'acc_no', type:'String'},
                          	{name : 'description', type:'String'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#jqxGarageSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
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
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',filtertype:'number' },
					{ text: 'Code', datafield: 'code', width: '50%' },
					{text: 'Name',datafield:'name',width:'50%',filtertype: 'input',columntype: 'textbox'},
					{ text: 'Branch', datafield: 'branch', width: '20%' },
					{ text: 'Location', datafield: 'location', width: '20%' },
					{ text: 'Date', datafield: 'date', width: '20%' ,filtertype: 'input',columntype: 'textbox',cellsformat:'dd.MM.yyyy'},
					{ text: 'Acc No', datafield: 'acc_no', width: '20%' },
					{ text: 'Type', datafield: 'type', width: '20%',filtertype: 'input',columntype: 'textbox'},
					{ text: 'Description', datafield: 'description',width:'20%',filtertype: 'input',columntype: 'textbox'}
					]
            });
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'code');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'branch');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'location');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'acc_no');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'type');
            

            $('#jqxGarageSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("garagecode").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("garagename").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $('#location').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "location")) ;
                $('#type').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("txtaccname").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "acc_no");

               // $('#accno').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "acc_no")) ;
                $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "date"));
            	$('#window').jqxWindow('close');

            }); 
           
          
        });
    </script>
    <div id="jqxGarageSearch"></div>
