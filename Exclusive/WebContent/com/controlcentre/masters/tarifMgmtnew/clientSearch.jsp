<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%ClsTarifDAO ctd=new ClsTarifDAO(); %>

<%String tariftype=request.getParameter("tariftype"); %>
<script type="text/javascript">
/* $('#frmTariffManagement select').attr('disabled', false);  */
      var dataclient= '<%=ctd.getClient(tariftype)%>';
  
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'refname', type: 'String'  },
     					
                 ],
                localdata: dataclient,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#clientSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
							{ text: 'Client Name', datafield: 'refname', width: '80%' },
						
	              ]
            });
           
            $('#clientSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("hidtxtclient").value= $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtclient").value= $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                 $('#clienttarifwindow').jqxWindow('close');
                
            });  
        });
    </script>
    <div id="clientSearch"></div>
