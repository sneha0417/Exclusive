<%@page import="com.dashboard.accounts.arprojectallocation.ClsARProjectAllocationDAO"%>
<%ClsARProjectAllocationDAO DAO= new ClsARProjectAllocationDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%> 
<script type="text/javascript">
  
	var costcode= '<%=DAO.costcodeSearchLoading(check) %>';

  	 $(document).ready(function () { 	
		
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearchGridId").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                columnsresize : true,
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Docno', datafield: 'doc_no', width: '20%', hidden: true},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Cost Description', datafield: 'name' },
						]
            });
            
           $('#costcodeSearchGridId').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                $('#arProjectAllocationGridId').jqxGrid('setcellvalue', rowindex1, "jobno" ,$('#costcodeSearchGridId').jqxGrid('getcellvalue', rowindex2, "code"));
                $('#arProjectAllocationGridId').jqxGrid('setcellvalue', rowindex1, "jobname" ,$('#costcodeSearchGridId').jqxGrid('getcellvalue', rowindex2, "name"));
                
                $('#costCodeSearchWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearchGridId"></div> 