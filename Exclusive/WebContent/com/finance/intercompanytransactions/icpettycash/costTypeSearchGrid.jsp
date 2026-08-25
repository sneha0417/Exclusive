<%@page import="com.finance.intercompanytransactions.icpettycash.ClsIcPettyCashDAO"%>
<% ClsIcPettyCashDAO DAO= new ClsIcPettyCashDAO(); %>
<% String dbname = request.getParameter("dbname")==null?"0":request.getParameter("dbname"); %>
<script type="text/javascript">
  
     	var costtype= '<%=DAO.costTypeSearch(dbname) %>';
		
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
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindex1, "costtype" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype"));
                $('#icPettyCashGridID').jqxGrid('setcellvalue', rowindex1, "costgroup" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup"));
                
                $('#costTypeSearchGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="costtypeSearch"></div> 