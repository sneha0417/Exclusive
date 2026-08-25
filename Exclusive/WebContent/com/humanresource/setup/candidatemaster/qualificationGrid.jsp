<%@page import="com.humanresource.setup.candidatemaster.ClsCandidateMasterDAO"%>
<%ClsCandidateMasterDAO DAO= new ClsCandidateMasterDAO(); %>
<script type="text/javascript">
        
        var data1= '<%=DAO.getQualificationData()%>'; 
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int' }, 
     						{name : 'desc1', type: 'string' }
                        ],
                		 localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#qualificationGridID").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'id', datafield: 'doc_no', hidden:true, width: '10%' },
							{ text: 'Qualification', datafield: 'desc1', width: '100%' }
						]
            });
            
            $('#qualificationGridID').on('rowdoubleclick', function (event) {
                    var rowindex1 = event.args.rowindex;
                    document.getElementById("hidqualificationid").value = $('#qualificationGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	            document.getElementById("txtqualification").value = $('#qualificationGridID').jqxGrid('getcellvalue', rowindex1, "desc1");
            	
               $('#qualificationWindow').jqxWindow('close');  
            });  
        });
    </script>
    <div id="qualificationGridID"></div>
 