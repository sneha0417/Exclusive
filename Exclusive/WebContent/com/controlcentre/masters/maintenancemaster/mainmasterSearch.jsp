<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>

    <script type="text/javascript">
    var datasss= '<%=cmd.mainserch()%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                           	{name : 'docno' , type: 'number' },
      						{name : 'mtype', type: 'String'  },
                           	{name : 'name', type: 'String'  },
                           	{name : 'date',type:'date'}
           
                  ],
                 localdata: datasss,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  ///  alert(error);    
	                    }
		            }		
            );
            $("#mastersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
             //  filterable:true,
               // showfilterrow:true,
                altRows: true,
               // sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
               // sortable: true,
                //Add row method

                 columns: [
					{ text: 'Doc No', datafield: 'docno', width: '15%' },
					{ text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
					{text: 'Description',datafield:'name',width:'50%'},
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true },
				
					]
            });
       
  $('#mastersearchgrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("maintenancetype").value=$('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "mtype");
                document.getElementById("desc").value=$('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "name");
                $("#miandate").jqxDateTimeInput('val',$("#mastersearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="mastersearchgrid"></div>
