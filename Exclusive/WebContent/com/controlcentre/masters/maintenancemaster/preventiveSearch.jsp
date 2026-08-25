<%@page import="com.controlcentre.masters.maintenancemaster.preventive.ClsPreventiveDAO" %>
<%ClsPreventiveDAO cpd=new ClsPreventiveDAO(); %>

    <script type="text/javascript">
    var data= '<%=cpd.getPreventive()%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'id', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'String'},
                          	{name : 'l_chg', type:'number'}
                 ],
                 localdata: data,
                
                
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
            $("#jqxPreventiveSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method

                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Id', datafield: 'id', width: '50%' },
					{text: 'Type',filtertype: 'input',columntype: 'textbox',datafield:'name',width:'50%'},
					{ text: 'Date',filtertype: 'input',columntype: 'textbox', datafield: 'date', width: '20%' },
					{ text: 'Charge',filtertype: 'input',columntype: 'textbox', datafield: 'l_chg', width: '20%' }
					]
            });
           $("#jqxPreventiveSearch").jqxGrid('hidecolumn', 'id'); 
         // $("#jqxPreventiveSearch").jqxGrid('hidecolumn', 'l_chg'); 

            $('#jqxPreventiveSearch').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxPreventiveSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("maintenanceid").value=$('#jqxPreventiveSearch').jqxGrid('getcellvalue', rowindex1, "id");
                document.getElementById("maintenancetype").value=$('#jqxPreventiveSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("lbrchg").value=$('#jqxPreventiveSearch').jqxGrid('getcellvalue', rowindex1, "l_chg");
                $("#prevdate").jqxDateTimeInput('val',$("#jqxPreventiveSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                
                document.close();
            }); 
            $('#jqxPreventiveSearch').on('rowdoubleclick', function (event) 
            		{ 
                $('#window').jqxWindow('hide');
            		 }); 
           
        });
    </script>
    <div id="jqxPreventiveSearch"></div>
