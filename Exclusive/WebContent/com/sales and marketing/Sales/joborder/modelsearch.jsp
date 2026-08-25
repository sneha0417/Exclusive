<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
       <script type="text/javascript">

			<%
			String  brandval=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
			%>
			
			 
			 var bookmodeldata='<%=DAO.searchmodel(brandval)%>';   
		$(document).ready(function () { 	
        	/* var url=""; */
        	
          // alert(quotmodeldata);
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'modelname', type: 'string'  },
                           {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: bookmodeldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#modelSearch").jqxGrid(
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
                              { text: 'MODEL', datafield: 'modelname', width: '100%' }
                             
						
						
	             
						]
            });
            
          $('#modelSearch').on('rowdoubleclick', function (event) {
            
  
                var rowindex2 = event.args.rowindex;
              

                document.getElementById("model").value =$('#modelSearch').jqxGrid('getcellvalue', rowindex2, "modelname");
                document.getElementById("modelid").value= $('#modelSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
           
                
                
      			 document.getElementById("submodel").value="";
       			 document.getElementById("submodelid").value="";
       			 
       			 document.getElementById("esize").value="";
       			 document.getElementById("esizeid").value="";
       			 
       			 document.getElementById("bsize").value="";
       			 document.getElementById("bsizeid").value="";
       			 
       			 document.getElementById("csize").value="";
       			 document.getElementById("csizeid").value="";
       			document.getElementById("errormsg").innerText="";
                $('#modelsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="modelSearch"></div>