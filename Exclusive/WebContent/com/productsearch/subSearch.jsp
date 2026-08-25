<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.productsearch.ClsProductSearchDAO"%>

 <%
 ClsProductSearchDAO DAO= new ClsProductSearchDAO(); 
String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String code = request.getParameter("pcode")==null?"0":request.getParameter("pcode");
 String cat = request.getParameter("cat")==null?"0":request.getParameter("cat");
 String subcat = request.getParameter("subcat")==null?"0":request.getParameter("subcat");
 String brand = request.getParameter("brand")==null?"0":request.getParameter("brand");
 String docnos = request.getParameter("docnos")==null?"0":request.getParameter("docnos");
 String load = request.getParameter("load")==null?"0":request.getParameter("load");
 String frm = request.getParameter("frm")==null?"0":request.getParameter("frm");
 
 System.out.println("=====name jsp=="+name);
 
%> 
 <script type="text/javascript">
 
  var  searchdata='<%=DAO.mainSrearch(session,name,code,brand,cat,subcat,docnos,load)%>'; 
 
        $(document).ready(function () { 
         
        	var frm='<%=frm%>';
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
			 
     						{name : 'brand', type: 'String'  },
     						{name : 'category', type: 'String'  },
     						{name : 'subcategory', type: 'String'  }, 
      						{name : 'productcode', type: 'String'  },
      						{name : 'productname', type: 'string'  },
      						{name : 'docno', type: 'String'  }
      						
                          	],
                          	localdata: searchdata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 345,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Doc No', datafield: 'docno', width: '8%' },
					{ text: 'Product Code', datafield: 'productcode', width: '15%' },
					{ text: 'Product Name', datafield: 'productname', width: '35%' },
					{ text: 'Brand', datafield: 'brand', width: '15%' }, 
					{ text: 'Category', datafield: 'category', width: '14%' },
					{ text: 'Sub Category', datafield: 'subcategory', width: '13%'},
					
					
					
					]
            });
    
     
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	     var rowindex1=event.args.rowindex;
				        	     
				        	          if(frm=='DSE')
				        	    	   {
				        	    	    document.getElementById("hidproductid").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "docno");
						         		document.getElementById("txtpartno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "productcode");
						        		document.getElementById("txtproductname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "productname");    
				        	    	   }
				        	     	  else if(frm=='STL')
			        	    	       {        
				        	    	    document.getElementById("name").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "productcode");
					                    document.getElementById("searchdetails1").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "productname");
					                    document.getElementById("psrno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "docno");
			        	    	       }
			        	    	 
				        		
				        		$('#productDetailsWindow').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
