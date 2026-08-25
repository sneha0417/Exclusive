<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<% String dtype1 = request.getParameter("costtype").toString();%> 
<script type="text/javascript">
  
var costcode= '<%=DAO.costCodeSearch(dtype1) %>';

  	 $(document).ready(function () { 	
			var costtype='<%=dtype1%>';
			
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
							{name : 'reg_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            $("#costcodeSearch").on("bindingcomplete", function (event) {
			    if (costtype !="6"){
            		$('#costcodeSearch').jqxGrid('hidecolumn', 'reg_no');
			    }
            });
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                            { text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true},
						    { text: 'Reg No.', datafield: 'reg_no', width: '20%'},
                            { text: 'Cost Code', datafield: 'code', width: '20%'},
                            { text: 'Cost Group', datafield: 'name' },
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcostno").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtcostcode").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "name");
                
                $('#costTypeSearchGridWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 