<%@page import="com.controlcentre.settings.approvalmaster.ClsApprovalMasterDAO" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%ClsApprovalMasterDAO camd=new ClsApprovalMasterDAO(); %>
    <script type="text/javascript">
    var data= '<%=camd.searchDetails(session) %>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'dtype', type: 'String'  },
     						{name : 'menu_name', type: 'String'  }
                          	],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxApproveSearch").jqxGrid(
            {
                width: '100%',
                height: 352,
                source: dataAdapter,
                columnsresize: true,
             
                showfilterrow: true,
                filterable: true,
             
                selectionmode: 'singlerow',
                pagermode: 'default',
               
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
					{ text: 'Doc Type', datafield: 'dtype', width: '30%' },
					{ text: 'Name', datafield: 'menu_name', width: '50%' }
					]
            });
    
           
     
            $('#jqxApproveSearch').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxApproveSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("doctype").value=$('#jqxApproveSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
                document.getElementById("doctypename").value=$('#jqxApproveSearch').jqxGrid('getcellvalue', rowindex1, "menu_name");
    			$('#frmApprovalMaster input').attr('readonly', false );
    			$("#main *").attr("disabled",false);
    			$("#lev1 *").attr("disabled",false);
    			$("#lev2 *").attr("disabled",false);
    			$("#lev3 *").attr("disabled",false);
    			 funSetlabel();
                frmApprovalMaster.submit();	
                $('#window').jqxWindow('close');
            		 }); 
      
        });
    </script>
    <div id="jqxApproveSearch"></div>
