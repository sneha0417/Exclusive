<%@page import="com.controlcentre.settings.companysettings.province.ClsProvinceDAO"%>
<% ClsProvinceDAO objpro=new ClsProvinceDAO();%>
    <script type="text/javascript">
    var data= '<%=objpro.provincelist()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'code', type: 'number'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'date'}
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
            $("#jqxProvinceSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Province Code', datafield: 'code', width: '20%' },
					{text: 'Province Name',datafield:'name',width:'35%'},
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy'}
					
					]
            });
           
            $('#jqxProvinceSearch').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
            	$('#date_province').jqxDateTimeInput({ disabled: false}); 
                document.getElementById("docno").value= $('#jqxProvinceSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtprovincecode").value=$('#jqxProvinceSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtprovincename").value=$('#jqxProvinceSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $('#date_province').val($('#jqxProvinceSearch').jqxGrid('getcellvalue', rowindex1, "date"));
                $('#date_province').jqxDateTimeInput({ disabled: true}); 
                
                
                
                
               /* document.getElementById("txttel1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "tel");
                document.getElementById("txtfax1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "fax");
                document.getElementById("txtemail1").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txttel2").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "tel2");
                document.getElementById("txtfax2").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "fax2");
                document.getElementById("txtwebsite").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "web");
                document.getElementById("txtpbno").value=$('#jqxLocationSearch').jqxGrid('getcellvalue', rowindex1, "pbno");
                $('#cmbbranchname').val($("#jqxLocationSearch").jqxGrid('getcellvalue', rowindex1, "brhid")) ;*/
                
            	$('#window').jqxWindow('hide');
            		 }); 
          
      
        });
    </script>
    <div id="jqxProvinceSearch"></div>
