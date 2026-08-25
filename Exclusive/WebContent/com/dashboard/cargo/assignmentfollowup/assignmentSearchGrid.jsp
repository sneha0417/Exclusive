
<%@page import="com.dashboard.cargo.assignmentfolloup.ClsassignmentFolloup" %>
<%ClsassignmentFolloup cfar=new ClsassignmentFolloup(); %>



<script type="text/javascript">
  
	   var fleetdata='<%=cfar.assetdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
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
                              { text: 'Doc_No', datafield: 'doc_no', width: '20%',hidden: 'true'},
                              { text: 'Name', datafield: 'name', width: '100%' },
						]
            });
            
          $('#assignmentSearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                
                $("#txtstatus").val('');
                $("#txtstdocno").val('');
                document.getElementById("txtasset").value=$('#assignmentSearch').jqxGrid('getcellvalue', rowindex2, "name");
                document.getElementById("txtsdocno").value=$('#assignmentSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                
              $('#assignmentDetailsWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="assignmentSearch"></div>