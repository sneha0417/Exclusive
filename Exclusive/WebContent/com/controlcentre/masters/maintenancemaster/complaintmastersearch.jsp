<%@page import="com.controlcentre.masters.maintenancemaster.complaint.ClsComplaintDAO" %>
<%ClsComplaintDAO ccd=new ClsComplaintDAO(); %>
   <script type="text/javascript">
    var commasterdata= '<%=ccd.mainserch() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                         	{name : 'doc_no' , type: 'number' },
     						{name : 'compname', type: 'String'  },
                        	{name : 'date', type: 'date'  }
           
                  ],
                 localdata: commasterdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  ///  alert(error);    
	                    }
		            }		
            );
            $("#compmastersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlerow',
                columnsresize: true,
              
                 columns: [
                       	{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
    					{ text: ' Name', datafield: 'compname', width: '80%' },
                    	{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
				
					]
            });
       
  $('#compmastersearchgrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("compliant").value=$('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "compname");
                $("#compdate").jqxDateTimeInput('val',$("#compmastersearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="compmastersearchgrid"></div>
