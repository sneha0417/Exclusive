<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.projectexecution.procurementstatus.ClsProcurementStatusDAO"%>
<%
ClsProcurementStatusDAO DAO=new ClsProcurementStatusDAO();
%>
<%


String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
%>
 
       <script type="text/javascript">
  
			 var prodsearchdata= '<%=DAO.searchBrand(session,productname,brandname,id,gridunit,gridprdname)%>';
		$(document).ready(function () { 	
        	/* var url=""; */

            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'unitdocno', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'specid', type: 'string'  },
                            {name : 'method', type: 'string'  },
                            {name : 'amount', type: 'number'  },
                            {name : 'brandid', type: 'number'  }, 
                            {name : 'productname', type: 'string'  },
                        ],
         
                		//  url: url1,
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brandsearchGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                filterable: true, 
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              
                              { text: 'Product-Id', datafield: 'part_no', width: '15%' },
                              { text: 'Product', datafield: 'productname' , width: '40%' },
                              { text: 'Brand', datafield: 'brandname', width: '30%' },
                              { text: 'Unit', datafield: 'unit', width: '10%' },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'amount', datafield: 'amount', width: '10%' ,hidden:true},
                              { text: 'brandid', datafield: 'brandid', width: '10%' ,hidden:true},
						]
            })
     
          $('#brandsearchGrid').on('rowdoubleclick', function (event) {
        	            
                var rowindex2 = event.args.rowindex;
   

              document.getElementById("txtbrandid").value= $('#brandsearchGrid').jqxGrid('getcellvalue', rowindex2, "brandid");
              document.getElementById("txtbrand").value=$('#brandsearchGrid').jqxGrid('getcellvalue', rowindex2, "brandname");
            
              $("#procurementSubGrid").jqxGrid('clear'); 
              
              $('#brandsearch').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="brandsearchGrid"></div>
    
    