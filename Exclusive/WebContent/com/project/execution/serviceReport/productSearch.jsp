<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<% ClsServiceReportDAO DAO = new ClsServiceReportDAO(); %> 
<% String reqmasterdocno=request.getParameter("reqmasterdocno")==null?"0":request.getParameter("reqmasterdocno").trim();
String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
String accdocno=request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory"); %>
 
<script type="text/javascript">
  
	    var prodsearchdata= '<%=DAO.searchProduct(productname,gridprdname,gridunit,gridcategory,gridssubcategory,brandname,id)%>';   
			 
		$(document).ready(function () { 	

            var source =
            {
                datatype: "json",
                datafields: [ 
                            
                            {name : 'part_no', type: 'string'  },
                            {name : 'productname', type: 'string'  },
                            {name : 'brandname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'unit', type: 'string'  },
                            {name : 'unitdocno', type: 'string'  },
                            {name : 'psrno', type: 'string'  },
                            {name : 'specid', type: 'string'  },
                            {name : 'method', type: 'string'  },
                            {name : 'category', type: 'string'  },
                            {name : 'subcategory', type: 'string'  },
                            
                        ],
         
                 localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#prosearch").jqxGrid(
            {
                width: '100%',
                height: 560,
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
                       
                              { text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product', datafield: 'part_no', width: '28%' },
                              { text: 'Product Name', datafield: 'productname', width: '55%' },
                              { text: 'Category', datafield: 'category', width: '15%',hidden:true },
                              { text: 'Sub Category', datafield: 'subcategory', width: '15%',hidden:true },
                              { text: 'Brand Name', datafield: 'brandname', width: '12%',hidden:true },
                              { text: 'Unit', datafield: 'unit' },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden: true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden: true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden: true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden: true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden: true},
						]
            })
             
            $('#prosearch').on('rowclick', function (event) {
            	 document.getElementById("datas").value="1";
            });
            
            $('#prosearch').on('rowdoubleclick', function (event) {
        	
               $('#datas1').val(0);
        	   $('#materialDetailsGridID').jqxGrid('render');
        	    var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
               
                var prodocs=$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
               
                if(parseInt($('#prosearch').jqxGrid('getcellvalue', rowindex2, "method"))==0) {
            	  
          		var rows = $("#materialDetailsGridID").jqxGrid('getrows');
        	    var aa=0;
        	    for(var i=0;i<rows.length;i++){
        		   if(parseInt(rows[i].prodoc)==parseInt(prodocs))
        			   {
        			   aa=1;
        			   break;
        			   }
        		   else{
        			   aa=0;
        		       } 
        	       }
        	   
        	   
        	   
        	   if(parseInt(aa)==1)
        		   {
        		   
        			document.getElementById("errormsg").innerText="You have already select this product";
        		   
        		   return 0;
        		   
        		   }
        	   else
        		   {
        		   document.getElementById("errormsg").innerText="";
        		   }
        	   
          	  
          	  }
            	  
            	  
            	
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));       
              
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "productname"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#materialDetailsGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "specid"));
        	  
              $('#datas1').val(1);
              
              var rows = $('#materialDetailsGridID').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1) {  
                	$("#materialDetailsGridID").jqxGrid('addrow', null, {});
                } 
                	  
                $("#materialDetailsGridID").jqxGrid('ensurerowvisible', rowlength);
                $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
</script>
<div id="prosearch"></div>