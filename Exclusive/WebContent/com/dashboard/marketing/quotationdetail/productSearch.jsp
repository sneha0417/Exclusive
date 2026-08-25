<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%>
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
<%
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String estdate=request.getParameter("estdate")==null?"0":request.getParameter("estdate").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id");
String productname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
String servicetype = request.getParameter("stypeid")==null?"0":request.getParameter("stypeid");
%>
 
<script type="text/javascript">
	    var scopeproduct="<%=scopeproduct%>";
	    
		var prodsearchdata= '<%=DAO.searchProduct(session,cldocno,estdate,brhid,productname,brandname,id,gridunit,gridprdname,scope,servicetype)%>';
		$(document).ready(function () { 	

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
                            {name : 'stdprice', type: 'String'},
							{name : 'lbrchg', type: 'number'},
							{name : 'scopefprice', type: 'number'},
							{name : 'scopestdcost', type: 'number'},
                        ],
         
                 		localdata: prodsearchdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#prosearchGrid").jqxGrid(
            {
            	width: 575,
                height: 560,
                source: dataAdapter,
                columnsresize: true,
                filterable: true, 
                selectionmode: 'singlerow',
                autorowheight: true,
                pageable: true,
            	pagesize: 50,
            	pagerheight: 1,
                       
                columns: [
							
                          { text: '', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                              datafield: 'sl', columntype: 'number', minwidth: 40,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
                       
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Product-Id', datafield: 'part_no', width: 120 },
                              { text: 'Product', datafield: 'productname', width: 250 },
                              { text: 'Brand', datafield: 'brandname', width: 120 },
                              { text: 'Unit', datafield: 'unit', width: 40 },
                              { text: 'Unit Price', datafield: 'unitprice', width: '15%',hidden:true },
                              { text: 'Method', datafield: 'method', width: '10%',hidden:true },
                              { text: 'Unitdoc', datafield: 'unitdocno', width: '10%' ,hidden:true},
                              { text: 'psrno', datafield: 'psrno', width: '10%' ,hidden:true},
                              { text: 'specid', datafield: 'specid', width: '10%' ,hidden:true},
                              { text: 'amount', datafield: 'amount', width: '10%' ,hidden:true},
                              { text: 'brandid', datafield: 'brandid', width: '10%' ,hidden:true},
                              { text: 'stdprice', datafield: 'stdprice', width: '10%' ,hidden: true},
		 					  { text: 'lbrchg', datafield: 'lbrchg', width: '10%' ,hidden: true},
		 					  { text: 'scopefprice', datafield: 'scopefprice', width: '10%' ,hidden: true},
		 					  { text: 'scopestdcost', datafield: 'scopestdcost', width: '10%' ,hidden: true},
						]
            })
             
            
        /*     $('#prosearchGrid').on('cellclick', function (event) {
            	
            	 var rowindex2 = event.args.rowindex;
            	 
            	 alert(rowindex2);
            	
            });  */
            
            
            $('#prosearchGrid').on('rowclick', function (event) {
             document.getElementById("datas").value="1";
                
                
               
            }); 
          $('#prosearchGrid').on('rowdoubleclick', function (event) {
        	
        	   $('#datas1').val("0");
        	   $('#qutDetSubGrid').jqxGrid('render');
        	  var rowindex1 =$('#rowindex').val();
            
                var rowindex2 = event.args.rowindex;
   
                
                
               
               
               var prodocs=$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
             
              if(parseInt($('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "method"))==0)
            	  {
            	  alert("inside");
          		var rows = $("#qutDetSubGrid").jqxGrid('getrows');
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
              
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "product" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "productname"));
	          $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brand" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandname"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "productname"));       
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "part_no"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandname"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "unit"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "unitdocno"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "psrno"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "specid"));
              if(parseInt(scopeproduct)==1){
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "amount"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "stdprice"));
              } else {
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,0);
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "stdprice" ,0);
              }
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brandid" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "brandid"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "lbrchg"));
	  		  $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "scopeamount" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopefprice"));
	  		  $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "scopestdcost" ,$('#prosearchGrid').jqxGrid('getcellvalue', rowindex2, "scopestdcost"));
              $('#datas1').val("1");
              var rows = $('#qutDetSubGrid').jqxGrid('getrows');
             
                var rowlength= rows.length;
                if(rowindex1 == rowlength - 1)
                	{  
                $("#qutDetSubGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
                	} 
                	  
                $("#qutDetSubGrid").jqxGrid('ensurerowvisible', rowlength);
              $('#sidesearchwndow').jqxWindow('close'); 
            }); 
           
            
       
        });
		
    </script>
    <div id="prosearchGrid"></div>
    
    