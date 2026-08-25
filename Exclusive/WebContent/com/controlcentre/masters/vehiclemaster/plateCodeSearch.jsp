<%@page import="com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeAction" %>
<%ClsPlateCodeAction cpa=new ClsPlateCodeAction(); %>

<script type="text/javascript">
     var data= '<%=cpa.searchDetails() %>'; 
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no' , type: 'number' },
                          	{name : 'code_no' , type: 'String' },
     						{name : 'code_name', type: 'String'  },
                          	{name : 'authname', type: 'String'  },
                          	{name : 'authId', type: 'String'  },
                          	{name : 'plateDate', type: 'date'  }
                          	
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
           
            $("#jqxPlateCodeSearch").jqxGrid(
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
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',filtertype:'number' },
					{ text: 'Plate Code',columntype: 'textbox', filtertype: 'input', datafield: 'code_no', width: '30%' },
					{ text: 'Plate Name',columntype: 'textbox', filtertype: 'input', datafield: 'code_name', width: '30%' },
					{ text: 'Authority Name',columntype: 'textbox', filtertype: 'input', datafield: 'authname', width: '30%' },
					{ text: 'Authority Id',columntype: 'textbox', filtertype: 'input', datafield: 'authId', width: '30%' ,hidden:true},
					{ text: 'Date', columntype: 'textbox', filtertype: 'input',datafield: 'plateDate', width: '30%' ,hidden:true,cellsformat:'dd.MM.yyyy'}
	              ]
            });
       
            $('#jqxPlateCodeSearch').on('rowdoubleclick', function (event) 
            		{
		            	var rowindex1=event.args.rowindex;
		            	document.getElementById("docno").value= $('#jqxPlateCodeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                document.getElementById("plateCode").value= $('#jqxPlateCodeSearch').jqxGrid('getcellvalue', rowindex1, "code_no"); 
		                document.getElementById("platename").value = $("#jqxPlateCodeSearch").jqxGrid('getcellvalue', rowindex1, "code_name");
		                $('#authName').val($("#jqxPlateCodeSearch").jqxGrid('getcellvalue', rowindex1, "authId")) ;
		                $("#date_plateCode").jqxDateTimeInput('val', $("#jqxPlateCodeSearch").jqxGrid('getcellvalue', rowindex1, "plateDate")); 
		                $('#window').jqxWindow('close');
            		 }); 
        
        });
    </script>
    <div id="jqxPlateCodeSearch"></div>
