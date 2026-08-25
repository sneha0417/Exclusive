   

  <%@page import=" com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO" %>
<%ClsTenancyContractPostingDAO DAO=new ClsTenancyContractPostingDAO();%>
 
 
 
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
		 var data21;  
        $(document).ready(function () { 
           var id='<%=id%>';
            var temp='<%=docno%>';
             
             if(id=="1"){   
            	 data21='<%=DAO.agentloading(docno)%>';  
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'agent', type: 'string'   },
     						{name : 'commperc', type: 'number' },
     						{name : 'commamount', type: 'number'   },
     						{name : 'salid', type: 'number'   }
                        ],
                         localdata: data21,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#agentGridId").jqxGrid(
            {
                width: '99.5%',
                height: 190,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                editable: false,
                columnsresize:true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
 
                    
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Agent', datafield: 'agent',  editable: false },	
							{ text: 'Agent', datafield: 'salid',  editable: false,width:'10%',hidden:true },	
							{ text: 'Commission %', datafield: 'commperc', cellsformat: 'd2', width: '25%', cellsalign: 'right', align: 'right'
								 
							},
							{ text: 'Commission Value', datafield: 'commamount', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' 
								 
							}
						]
            });
            
         
            
            
          
        });

</script>
<div id="agentGridId"></div>
    