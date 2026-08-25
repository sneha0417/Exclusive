<%@page import="com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceAction" %>
<%ClsInsuranceAction cia=new ClsInsuranceAction(); %>

<script type="text/javascript">
    var data1= '<%=cia.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'inname', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'description',type:'String'},
                          	{name : 'acc_no',type:'String'}
                          	
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
            $("#jqxInsuranceSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method

                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Insurance',columntype: 'textbox', filtertype: 'input', datafield: 'inname', width: '50%' },
					{text: 'Date',columntype: 'textbox', filtertype: 'input',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},
					{text: 'Account',columntype: 'textbox', filtertype: 'input',datafield:'description',width:'20%'},
					{text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true}

					]
            });
            $('#jqxInsuranceSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                document.getElementById("insurcompany").value=$('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex1, "inname");
		                $("#insurdate").jqxDateTimeInput('val',$("#jqxInsuranceSearch").jqxGrid('getcellvalue', rowindex1, "date"));
						document.getElementById("txtaccname").value=$('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex1, "description");
						document.getElementById("txtaccno").value=$('#jqxInsuranceSearch').jqxGrid('getcellvalue', rowindex1, "acc_no");
		                $('#window').jqxWindow('hide');
            		 }); 
        
        
        });
    </script>
    <div id="jqxInsuranceSearch"></div>
