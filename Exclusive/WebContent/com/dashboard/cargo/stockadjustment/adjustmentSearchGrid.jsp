
<%@page import="com.dashboard.procurment.stockadjustment.ClsstockAdjustment" %>
<%ClsstockAdjustment cfar=new ClsstockAdjustment(); %>
<%
String id=request.getParameter("check")==null?"0":request.getParameter("check");
%>


<script type="text/javascript">
var id='<%=id%>';
if(id=='1'){
	  var fleetdata='<%=cfar.assetdetails()%>';
  }
  	$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'psrno', type: 'string'  },
                            {name : 'productid', type: 'string'  },
                            {name : 'name', type: 'string'  }
                           ],
                            localdata: fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#assignmentSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                          	  { text: 'Srno', datafield: 'psrno', width: '20%'},
                              { text: 'ProductId', datafield: 'productid', width: '20%'},
                              { text: 'Name', datafield: 'name', width: '60%' },
						]
            });
            
          $('#assignmentSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtasset").value=$('#assignmentSearch').jqxGrid('getcellvalue', rowindex2, "name");
                
              $('#adjustmentDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="assignmentSearch"></div>