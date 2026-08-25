<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<% String form = request.getParameter("formname").toString();%>
<% String dtype1 = request.getParameter("costtype").toString();%> 
<script type="text/javascript">
  
var costcode= '<%=DAO.costCodeSearch(dtype1) %>';

  	 $(document).ready(function () { 	
  		var formname='<%=form%>';
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
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#'+formname).jqxGrid('setcellvalue', rowindex1, "costcode" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "code"));
				
				if(formname=="jqxFuelCardReimbursement"){
				    $('#'+formname).jqxGrid('setcellvalue', rowindex1, "reg_no" ,$('#costcodeSearch').jqxGrid('getcellvalue', rowindex2, "reg_no"));
	                var rows = $('#jqxFuelCardReimbursement').jqxGrid('getrows');
	                var rowlength= rows.length;
	                var rowindex2 = rowlength - 1;
	          	    var costtype=$("#jqxFuelCardReimbursement").jqxGrid('getcellvalue', rowindex2, "costtype");
	          	    if(typeof(costtype) != "undefined" && costtype != ""){
	          	    	$("#jqxFuelCardReimbursement").jqxGrid('addrow', null, {"costtype": "6","costgroup": "Fleet","costcode": "","amount1": "","baseamount1": "","description": ""});
	          	    }
                }
				
                $('#costCodeSearchWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 