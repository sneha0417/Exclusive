<%@page import="com.controlcentre.settings.areamaster.country.ClsCountryDAO"%>
<%ClsCountryDAO DAO= new ClsCountryDAO();%>
    <script type="text/javascript">
  		var data= '<%=DAO.searchDetails() %>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                            	{name : 'country_name',type:'String'},
                            	{name : 'country_code',type:'String'},
       						    {name : 'date', type: 'String'  },
                            	{name : 'region', type: 'String'  },
                            	{name : 'reg_id' , type: 'String' }
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
            $("#jqxRegionSearch").jqxGrid(
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
					        { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '5%' },
          			 		{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '15%'},
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country_name', width: '35%' },
          					{ text: 'Country Code',columntype: 'textbox', filtertype: 'input', datafield: 'country_code', width: '10%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '35%' }
	              ]
            });
            $('#jqxRegionSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxCountrySearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("country").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_name");
	                document.getElementById("contry_code").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "country_code");
	                document.getElementById("region").value = $("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "reg_id");
	                $("#date_coun").jqxDateTimeInput('val',$("#jqxCountrySearch1").jqxGrid('getcellvalue', rowindex1, "date"));
	                
	                $("#jqxRegionSearch").jqxGrid('hidecolumn', 'reg_id'); 
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxRegionSearch"></div>
