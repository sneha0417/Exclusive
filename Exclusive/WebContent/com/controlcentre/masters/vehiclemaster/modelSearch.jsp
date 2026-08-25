<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>

<script type="text/javascript">
    var data= '<%=cma.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'int' },
     						{name : 'vtype', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'brand_name',type:'String'},
                          	{name : 'brandid',type:'String'}
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
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Model', columntype: 'textbox', filtertype: 'input',datafield: 'vtype', width: '30%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '30%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Brand',columntype: 'textbox', filtertype: 'input',datafield:  'brand_name',width:'30%'},
					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input',datafield:  'brandid',width:'5%',hidden:true}
					]
            });
            $('#jqxModelSearch').on('rowdoubleclick', function (event) 
            		{
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxModelSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("model").value = $("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "vtype");
		                $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		                $("#brand").removeAttr('disabled');
		                $('#brand').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
		                //$("#brand").attr('disabled',true);

		               // alert("Brand value"+$('#brand').val());
		                //alert("Brand2"+$("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid"));
		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
		            	$('#window').jqxWindow('close');
            		 }); 


        
            //$("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
            //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

        });
    </script>
    <div id="jqxModelSearch"></div>
