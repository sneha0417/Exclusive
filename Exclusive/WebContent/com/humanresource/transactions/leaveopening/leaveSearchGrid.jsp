<%@page import="com.humanresource.transactions.leaveopening.ClsLeaveOpeningDAO"%>
<% ClsLeaveOpeningDAO DAO= new ClsLeaveOpeningDAO(); %>
<script type="text/javascript">
  
	var data2= '<%=DAO.leaveDetailsSearch() %>';

  	 $(document).ready(function () { 	
		
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'leaveid', type: 'string'  },
							{name : 'leavename', type: 'string'  }
                        ],
                      localdata: data2,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }                          
            };
			
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leaveSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Leave ID', datafield: 'leaveid', width: '20%', hidden: true},
							  { text: 'Leave', datafield: 'leavename', width: '100%'}
						]
            });
            
               $('#leaveSearchGridID').on('rowdoubleclick', function (event) {
        	      var rowindex1 =$('#rowindex').val();
	              var rowindex2 = event.args.rowindex;
	              $('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindex1, "leaveid" ,$('#leaveSearchGridID').jqxGrid('getcellvalue', rowindex2, "leaveid"));
	              $('#leaveOpeningGridID').jqxGrid('setcellvalue', rowindex1, "leave" ,$('#leaveSearchGridID').jqxGrid('getcellvalue', rowindex2, "leavename"));
	              
                  $('#leaveDetailsGridWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="leaveSearchGridID"></div> 