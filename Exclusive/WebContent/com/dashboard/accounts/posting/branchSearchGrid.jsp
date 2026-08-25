<%@page import="com.dashboard.accounts.posting.ClsPostingDAO" %>
<%ClsPostingDAO cpd=new ClsPostingDAO();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();%>


<script type="text/javascript">
        
        var brchdata= '<%= cpd.branchlist(session,check) %>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'int' },
     						{name : 'branchname', type: 'String' },
                        ],
                		 localdata: brchdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxBranchSearch").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Branch Id', hidden: true, datafield: 'doc_no', width: '10%' },
							{ text: 'Branch', datafield: 'branchname', width: '100%' }
						]
            });
            
            $('#jqxBranchSearch').on('celldoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtibbranchid").value = $('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	document.getElementById("txtibbranch").value = $('#jqxBranchSearch').jqxGrid('getcellvalue', rowindex1, "branchname");
            	
               $('#branchSearchWindow').jqxWindow('close'); 
			   
			   if($('#hidchckibbranch').val()==1){
     			  if($('#txtibbranchid').val()!='' && $('#txtibbranchid').val()!=null){
     				funIBDateInPeriod($('#fromdate').val(),$('#txtibbranchid').val());
     			  }
     		   }
			   
            }); 
        });
    </script>
    <div id="jqxBranchSearch"></div>
 