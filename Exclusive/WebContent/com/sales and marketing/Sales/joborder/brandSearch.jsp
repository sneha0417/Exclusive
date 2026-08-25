<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>


<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
<script type="text/javascript">

		 
			 var bookbarnddata='<%=DAO.searchbranch()%>';  
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'brand', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: bookbarnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brandsearch").jqxGrid(
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
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'BRAND', datafield: 'brand', width: '25%' },
                              { text: 'BRAND NAME', datafield: 'brandname', width: '75%' }
						
						
	             
						]
            });
            
          $('#brandsearch').on('rowdoubleclick', function (event) {
          
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("brand").value =$('#brandsearch').jqxGrid('getcellvalue', rowindex2, "brandname");
                document.getElementById("brandid").value= $('#brandsearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
                document.getElementById("model").value="";
   			 document.getElementById("modelid").value="";
   			 
   			 document.getElementById("submodel").value="";
   			 document.getElementById("submodelid").value="";
   			 
   			 document.getElementById("esize").value="";
   			 document.getElementById("esizeid").value="";
   			 
   			 document.getElementById("bsize").value="";
   			 document.getElementById("bsizeid").value="";
   			 
   			 document.getElementById("csize").value="";
   			 document.getElementById("csizeid").value="";
   			 
   			 
   			document.getElementById("errormsg").innerText="";
           
                
              $('#brandsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="brandsearch"></div> 