<%@page import="com.controlcentre.settings.areamaster.area.ClsAreaDAO"%>
<%ClsAreaDAO DAO= new ClsAreaDAO();%>

    <script type="text/javascript">
  		var data= '<%=DAO.searchDetails() %>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
       						    {name : 'area', type: 'String'  },
                            	{name : 'date', type: 'String'  },
                            	{name : 'region',type:'String'},
                            	{name : 'reg_id',type:'String'},
                            	{name : 'country',type:'String'},
                            	{name : 'cou1_id',type:'String'},
                            	{name : 'city_name',type:'String'},
                            	{name : 'city_id', type: 'String'  }
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
            $("#jqxAreaSearch").jqxGrid(
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
          					{ text: 'Area',columntype: 'textbox', filtertype: 'input', datafield: 'area', width: '20%' },
          					{ text: 'Country id', datafield: 'cou1_id' } ,
          					{ text: 'Country',columntype: 'textbox', filtertype: 'input', datafield: 'country', width: '20%' },
          					{ text: 'Region id', datafield: 'reg_id' } ,
          					{ text: 'Region',columntype: 'textbox', filtertype: 'input', datafield: 'region', width: '20%' } ,
          					{ text: 'City id', datafield: 'city_id' } ,
         					{ text: 'City',columntype: 'textbox', filtertype: 'input', datafield: 'city_name', width: '20%' }
	              ]
            });
            $('#jqxAreaSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	     document.getElementById("docno").value= $('#jqxAreaSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	            	 document.getElementById("area").value = $("#jqxAreaSearch").jqxGrid('getcellvalue', rowindex1, "area");
	                 document.getElementById("city").value = $("#jqxAreaSearch").jqxGrid('getcellvalue', rowindex1, "city_id");
                     document.getElementById("country").value = $("#jqxAreaSearch").jqxGrid('getcellvalue', rowindex1, "cou1_id");
	                 document.getElementById("region").value = $("#jqxAreaSearch").jqxGrid('getcellvalue', rowindex1, "reg_id");
	                $("#date_area").jqxDateTimeInput('val',$("#jqxAreaSearch").jqxGrid('getcellvalue', rowindex1, "date"));
	                
	               
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
            $("#jqxAreaSearch").jqxGrid('hidecolumn', 'reg_id'); 
            $("#jqxAreaSearch").jqxGrid('hidecolumn', 'cou1_id'); 
            $("#jqxAreaSearch").jqxGrid('hidecolumn', 'city_id'); 
         
        });
    </script>
    <div id="jqxAreaSearch"></div>
