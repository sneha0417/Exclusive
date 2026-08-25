<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
       <script type="text/javascript">
  
			 var yomdata='<%=DAO.searchyom()%>';   
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'yom', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: yomdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#yomgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'YOM', datafield: 'yom', width: '100%' },
                           
						
						
	             
						]
            });
            
          $('#yomgrid').on('rowdoubleclick', function (event) {
            
            
                var rowindex2 = event.args.rowindex;
                document.getElementById("yom").value =$('#yomgrid').jqxGrid('getcellvalue', rowindex2, "yom");
                document.getElementById("yomid").value =$('#yomgrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
        
                document.getElementById("errormsg").innerText="";
              $('#yomsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="yomgrid"></div> 