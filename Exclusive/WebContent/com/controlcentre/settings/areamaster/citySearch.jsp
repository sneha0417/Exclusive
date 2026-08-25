<%@page import="com.controlcentre.settings.areamaster.city.ClsCityDAO"%>
<%ClsCityDAO DAO= new ClsCityDAO();%>

    <script type="text/javascript">
    var data= '<%=DAO.searchDetails() %>'; 
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	    {name : 'doc_no' , type: 'int' },
       						    {name : 'city_name', type: 'String'},
       						    {name : 'city_code', type: 'String'},
                            	{name : 'date', type: 'String'  },
                            	{name : 'region',type:'String'},
                            	{name : 'reg_id',type:'String'},
                            	{name : 'country',type:'String'},
                            	{name : 'cou1_id',type:'String'}
                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxCitySearch").jqxGrid(
            {
                width: '100%',
                height: 315,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
                            { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%'},
	                        { text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},         					
	                        { text: 'City',columntype: 'textbox', filtertype: 'input', datafield: 'city_name', width: '25%' },
	                        { text: 'City Code',columntype: 'textbox', filtertype: 'input', datafield: 'city_code', width: '25%' },
	                        { text: 'Country id', datafield: 'cou1_id' } ,
	                        { text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country', width: '20%' },
	                        { text: 'Region id', datafield: 'reg_id' } ,
	                        { text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '20%' } 
	               ]
            });
            $('#jqxCitySearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	    document.getElementById("docno").value= $('#jqxCitySearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("city").value = $("#jqxCitySearch").jqxGrid('getcellvalue', rowindex1, "city_name");
	                document.getElementById("city_code").value = $("#jqxCitySearch").jqxGrid('getcellvalue', rowindex1, "city_code");
                    document.getElementById("country").value = $("#jqxCitySearch").jqxGrid('getcellvalue', rowindex1, "cou1_id");
	                document.getElementById("region").value = $("#jqxCitySearch").jqxGrid('getcellvalue', rowindex1, "reg_id");
	                $("#date_city").jqxDateTimeInput('val',$("#jqxCitySearch").jqxGrid('getcellvalue', rowindex1, "date"));
	                
	               
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
            $("#jqxCitySearch").jqxGrid('hidecolumn', 'reg_id'); 
            $("#jqxCitySearch").jqxGrid('hidecolumn', 'cou1_id'); 
        });
    </script>
    <div id="jqxCitySearch"></div>
