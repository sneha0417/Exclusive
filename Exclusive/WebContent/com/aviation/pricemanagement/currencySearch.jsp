<%@page import="com.cargo.estimation.ClsEstimationDAO" %>
<%ClsEstimationDAO DAO=new ClsEstimationDAO(); 
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();%>
<script type="text/javascript">
  var colorddata=<%=DAO.currencySearch()%>;
  
  $(document).ready(function () { 	
	  var source =
	  {
		datatype: "json",
		datafields: [
			{name : 'currency', type: 'string'},
			{name : 'rate', type: 'string'},
			{name : 'curid', type: 'string'}
		],
        localdata: colorddata,
        pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
        }
	  };
	  var dataAdapter = new $.jqx.dataAdapter(source);
            $("#estcurrencySearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Currency', datafield: 'currency', width: '20%'},
                              { text: 'Rate', datafield: 'rate', width: '80%' },
                              { text: 'curid', datafield: 'curid', width: '3%', hidden: true },
                              ]
            });
            
          $('#estcurrencySearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                $('#txtcurrency').val($('#estcurrencySearch').jqxGrid('getcellvalue', rowindex2, "currency"));
                $('#currate').val($('#estcurrencySearch').jqxGrid('getcellvalue', rowindex2, "rate"));
                $('#currid').val($('#estcurrencySearch').jqxGrid('getcellvalue', rowindex2, "curid"));
                $('#currencysearchwndow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="estcurrencySearch"></div>