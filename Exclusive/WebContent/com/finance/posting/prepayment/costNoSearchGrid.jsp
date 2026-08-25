<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<script type="text/javascript">
 
     var costtype= '<%=DAO.costTypeSearch() %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'costtype', type: 'string'  },
                              {name : 'costgroup', type: 'string'  }
                            ],
                       localdata: costtype,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costtypeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Cost Type', datafield: 'costtype', hidden:true, width: '20%'},
                              { text: 'Cost Group', datafield: 'costgroup', width: '100%' },
						]
            });
            
             
          $('#costtypeSearch').on('celldoubleclick', function (event) {
                var rowindex1= event.args.rowindex;
                document.getElementById("txtcosttype").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex1, "costtype");
                document.getElementById("txtcostgroup").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex1, "costgroup");
                
              $('#costTypeSearchGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="costtypeSearch"></div> 