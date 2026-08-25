<%@page import="com.aviation.pricemanagement.ClsPriceManagementDAO" %>
<%ClsPriceManagementDAO DAO=new ClsPriceManagementDAO();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>
<script type="text/javascript">
var id='<%=id%>';
var colorddata=<%=DAO.taxSearch()%>;
  
  $(document).ready(function () { 	
	  var source =
	  {
		datatype: "json",
		datafields: [
			{name : 'doc_no', type: 'string'  },
			{name : 'tax', type: 'string'  },
			{name : 'desc1', type: 'string'  }
		],
        localdata: colorddata,
        pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
        }
	  };
	  var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxtaxSearch").jqxGrid(
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
						  { text: 'doc_no', datafield: 'doc_no', width: '5%', hidden : true},
                          { text: 'TAX', datafield: 'tax', width: '45%'},
                          { text: 'DESCRIPTION', datafield: 'desc1', width: '55%'},
                ]
            });
            
          $('#jqxtaxSearch').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
                var rowindex1 = $('#rowindex3').val();
                if('<%=id%>'=="1"){
	                $("#jqxCalcData").jqxGrid('setcellvalue', rowindex1, "taxid", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	                $("#jqxCalcData").jqxGrid('setcellvalue', rowindex1, "tax", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
	                $("#jqxCalcData").jqxGrid('setcellvalue', rowindex1, "taxname", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "desc1"));
                }
                else{
                	$("#jqxCalcData2").jqxGrid('setcellvalue', rowindex1, "taxid", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
 	                $("#jqxCalcData2").jqxGrid('setcellvalue', rowindex1, "tax", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "tax"));
 	                $("#jqxCalcData2").jqxGrid('setcellvalue', rowindex1, "taxname", $('#jqxtaxSearch').jqxGrid('getcellvalue', rowindex2, "desc1"));
                }
                $('#taxtypesearchwindow').jqxWindow('close');
          }); 
        });
    </script>
    <div id="jqxtaxSearch"></div>