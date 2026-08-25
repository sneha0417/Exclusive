<%@page import="com.controlcentre.masters.vehiclemaster.modelnew.*" %>
<%ClsModelNewDAO dao=new ClsModelNewDAO(); %>

<script type="text/javascript">
    var data= '<%=dao.list()%>';
    $(document).ready(function () { 	
    var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'doc_no' , type: 'int' },
	       			{name : 'vtype', type: 'String'  },
	                {name : 'date', type: 'date'  },
	                {name : 'brand_name',type:'String'},
	                {name : 'brandid',type:'String'},
	                {name : 'vehtype',type:'string'},
	                {name : 'seat',type:'number'},
	                {name : 'door',type:'number'},
	                {name : 'luggage',type:'number'},
	                {name : 'passengers',type:'number'},
	                {name : 'ac',type:'number'},
	                {name : 'vehtypedocno',type:'number'},
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
            $("#jqxModelSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                showfilterrow:true,
                filterable:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
          		{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%',hidden:true },
          		{ text: 'Model',columntype: 'textbox', filtertype: 'input', datafield: 'vtype', width: '30%' },
          		{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '10%',cellsformat:'dd.MM.yyyy'},
          		{ text: 'Brand',columntype: 'textbox', filtertype: 'input', datafield: 'brand_name', width: '30%' },
				{ text: 'Vehicle Type',columntype: 'textbox', filtertype: 'input', datafield: 'vehtype', width: '20%' },
				{ text: 'Vehicle Type Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'vehtypedocno', width: '20%',hidden:true },
				{ text: 'Seats',columntype: 'textbox', filtertype: 'input', datafield: 'seat', width: '20%',hidden:true },
				{ text: 'Doors',columntype: 'textbox', filtertype: 'input', datafield: 'door', width: '20%',hidden:true },
				{ text: 'Luggages',columntype: 'textbox', filtertype: 'input', datafield: 'luggage', width: '20%',hidden:true },
				{ text: 'Passengers',columntype: 'textbox', filtertype: 'input', datafield: 'passengers', width: '20%',hidden:true },
				{ text: 'AC',columntype: 'textbox', filtertype: 'input', datafield: 'ac', width: '20%',hidden:true }
					]
            });
            $('#jqxModelSearch').on('rowdoubleclick', function (event) 
            		{
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxModelSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("model").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "vtype");
		                $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                $("#brand").removeAttr('disabled');
		                $('#brand').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
		                $('#cmbvehtype').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "vehtypedocno")) ;
		                $('#hidcmbvehtype').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "vehtypedocno"))
		                document.getElementById("cmbseat").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "seat");
						document.getElementById("cmbdoor").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "door");
						document.getElementById("cmbluggage").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "luggage");
						document.getElementById("cmbpassengers").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "passengers");
						document.getElementById("cmbac").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "ac");
		            	$('#window').jqxWindow('close');
            		 }); 


        
            //$("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
            //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

        });
    </script>
    <div id="jqxModelSearch"></div>
