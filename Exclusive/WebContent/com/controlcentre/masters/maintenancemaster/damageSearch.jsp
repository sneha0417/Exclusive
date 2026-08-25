<%@page import="com.controlcentre.masters.maintenancemaster.damage.ClsDamageDAO" %>
<%ClsDamageDAO cdd=new ClsDamageDAO(); %>

    <script type="text/javascript">
    var datass= '<%=cdd.getDamage() %>';
  
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'type', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'String'},
                          	{name : 'dmg_chg', type:'number'}
                 ],
                 localdata: datass,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  // alert(error);    
	                    }
		            }		
            );
            $("#jqxDamageSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
               // sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
              //  sortable: true,
                //Add row method

                columns: [
                          
                          
              			{ text: 'DOC NO', datafield: 'doc_no', width: '20%' },
              			{ text: 'Type', datafield: 'type', width: '40%' },
    					{ text: 'Name', datafield: 'name', width: '40%' },      
				
    					
					{ text: 'Date', datafield: 'date', width: '20%' ,hidden:true}
					
					]
            });
         
            

            $('#jqxDamageSearch').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#cmbtype').val($('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("name1").value=$('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "name");

                $("#damagedate").jqxDateTimeInput('val',$("#jqxDamageSearch").jqxGrid('getcellvalue', rowindex1, "date"));
            	$('#window').jqxWindow('close');

            }); 
         
        });
    </script>
    <div id="jqxDamageSearch"></div>
