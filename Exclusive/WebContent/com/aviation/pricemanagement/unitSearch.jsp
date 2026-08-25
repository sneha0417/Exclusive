<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO" %>
<%ClsPriceManagementDAO DAO=new ClsPriceManagementDAO(); %>
<script type="text/javascript">
  var colorddata=<%=DAO.unitSearch()%>;
  
  $(document).ready(function () { 	
	  var source =
	  {
		datatype: "json",
		datafields: [
			{name : 'unit', type: 'string'  },
			{name : 'doc_no', type: 'int'  }
		],
        localdata: colorddata,
        pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
        }
	  };
	  var dataAdapter = new $.jqx.dataAdapter(source);
            $("#estunitSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                          { text: 'Unit', datafield: 'unit', width: '98%'},
                          { text: 'doc_no', datafield: 'doc_no', width: '2%',hidden: true },
                ]
            });
            
          $('#estunitSearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                var rowindex1 = $('#rowindex').val();
                $("#jqxPriceMngt").jqxGrid('setcellvalue', rowindex1, "unit", $('#estunitSearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                $("#jqxPriceMngt").jqxGrid('setcellvalue', rowindex1, "unitid", $('#estunitSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#unitsearchwindow').jqxWindow('close');
          }); 
        });
    </script>
    <div id="estunitSearch"></div>