
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%-- <%@page import="com.sales.marketing.salesenquiry.ClsSalesEnquiryDAO"%>
<%
	ClsSalesEnquiryDAO DAO = new ClsSalesEnquiryDAO();
%> --%>

<%
	String docno = request.getParameter("docno") == null
			? "0"
			: request.getParameter("docno").trim();
%>
<script type="text/javascript">

function getproductdetails(psrno,rowno){ 
	
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.split('####');
	           var productname=items[0];
	           var unit=items[1];
	           var munit=items[2];
	           $('#prodetGrid').jqxGrid('setcellvalue', rowno, "productname",productname);
	           $('#prodetGrid').jqxGrid('setcellvalue', rowno, "unit",unit);
	           $('#prodetGrid').jqxGrid('setcellvalue', rowno, "unitdocno",munit);
	           $('#prodetGrid').jqxGrid('setcellvalue', rowno, "psrno",psrno);
	        
	    }
	       }
	   x.open("GET","getProductDet.jsp?psrno="+psrno,true);
		x.send();
	        
	      
	        }



var descdata1;
var prodata;

 
	<%--  descdata1='<%=DAO.prdGridLoad(session,docno)%>'; --%>

	

	$(document)
			.ready(
					function() {
					
			             $('#gridtext').keyup(function(){
			              	

			 			      $("#prosearch").jqxGrid('clearfilters');
			       		  
			             
			                 $('#part_no').val($(this).val());
			                 var dataField = "part_no";
			          applyFilter(dataField,$(this).val());  
			                 
			                 
			                 
			             });
			             
			         
			             $('#gridtext1').keyup(function(){
			             	

			 			      $("#prosearch").jqxGrid('clearfilters');
			     		  
			           
			               $('#productname').val($(this).val());
			               var dataField = "productname";
			    		   applyFilter(dataField,$(this).val());  
			               
			               
			               
			           });            
			           	 var cellclassname =  function (row, column, value, data) {


			            	  var ss= $('#prodetGrid').jqxGrid('getcellvalue', row, "qty");
			            		          if(parseInt(ss)<=0)
			            		  		{
			            		  		
			            		  		return "yellowClass";
			            		  	
			            		  		}
			            	    
			            	    	/* return "greyClass";
			            	    	
			            		        var element = $(defaultHtml);
			            		        element.css({ 'background-color': '#F3F297', 'width': '100%', 'height': '100%', 'margin': '0px' });
			            		        return element[0].outerHTML;
			            	*/

			            		}
						
						// prepare the data
						var source = {
							datatype : "json",
							datafields : [

							{
								name : 'productid',
								type : 'string'
							},
							{
								name : 'productname',
								type : 'string'
							}, {
								name : 'unit',
								type : 'String'
							}, {
								name : 'size',
								type : 'String'
							}, {
								name : 'qty',
								type : 'int'
							}, {name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
							{
								name : 'part_no',
								type : 'string'
							},

							],

							localdata : descdata1,

							pager : function(pagenum, pagesize, oldpagenum) {
								// callback called when a page or page size is changed.
							}

						};

						var prodSource = {
							datatype : "json",
							datafields : [ {
								name : 'part_no',
								type : 'string'
							}, {
								name : 'doc_no',
								type : 'string'
							}, {
								name : 'productname',
								type : 'string'
							} ],
							localdata : prodata
						};
						var prodAdapter = new $.jqx.dataAdapter(prodSource, {
							autoBind : true
						});

						var dataAdapter = new $.jqx.dataAdapter(source, {
							loadError : function(xhr, status, error) {
								alert(error);
							}

						});

						var list = prodata.split(",");
						/* var autoDropDownHeight = (list.length>9? false:true); */
			
						$("#prodetGrid")
								.jqxGrid(
										{
											width : '99.5%',
											height : 297,
											source: dataAdapter,
							                showaggregates:true,
							                showstatusbar:true,
							                editable: true,
							                disabled:true,
							                statusbarheight: 21,
							                selectionmode: 'singlecell',
							                pagermode: 'default',
							                handlekeyboardnavigation: function (event) {
							                	
							                	
							                	
							                	

							                    var cell4 = $('#prodetGrid').jqxGrid('getselectedcell');
							                   
							                    
							                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
							                    
							                   {	 
							                   	 
							                   	 
							                   	 
							  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
							  	                 
							  	                  if (key == 9) {    
							  	                	   
							  	                	  
							  	             	   
								   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
							  	                	  
							  	                	  
							  	                   var prodocs=rows[0].doc_no;
							  	                
							  	                /* if(parseInt(rows[0].method)==0)
							  	              	  { */
							  	              	  
							  	            		var rows1 = $("#prodetGrid").jqxGrid('getrows');
							  	          	    var aa=0;
							  	          	    
							  	          	
							  	          	    
							  	          	    for(var i=0;i<rows1.length;i++){
							  	          	 
							  	          	    
							  	          	    	 
							  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
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
							  	          	   
							  	            	  
							  	            	/*   } */
							  	                	  
							  	                	  
							  	                	  
							  	     
							  	                	  
							  	                	   
							  	               	 var rows = $("#prosearch").jqxGrid('getrows');
							  	  		    
							  	                	
							  	                	   $('#prodetGrid').jqxGrid('render');
							  	              	  var rowindex1 =$('#rowindex').val();
							  	               $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
							  	            
							  	            $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
							  	               
							  	            
							  	               
							  	 
							  	                $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
							  	                $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
							  	                 $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
							  	                $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
							  	                $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
							  	                $('#prodetGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
							  	            
							  	           $("#prodetGrid").jqxGrid('selectcell',rowindex1, "qty");
							  	         
							  	        //  $("#prodetGrid").jqxGrid('begincelledit', rowindex1, 'qty');
							  	             $('#searchwndow').jqxWindow('close'); 
							  	                	   
							  	          var rows = $('#prodetGrid').jqxGrid('getrows');
							               var rowlength= rows.length;
							               if(rowindex1 == rowlength - 1)
							               	{  
							               $("#prodetGrid").jqxGrid('addrow', null, {});
							               	} 
							  	        	            } 
							  	                   
							                    
							                    
							                    
							                    
							            if (cell4 != undefined && cell4.datafield == 'productid') {
							       
							       		 
							       		   document.getElementById("gridtext").focus();
							       		 
							            }
							            if (cell4 != undefined && cell4.datafield == 'productname') {
							    	        
							       		 
							       		   document.getElementById("gridtext1").focus();
							       		 
							          }
							              
							            
							                   } 
							       		 
							            
							                    },
							                

											columns : [

													{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},

							                        { text: 'Description', datafield: 'description', width: '25%' },
													{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '20%',cellclassname: cellclassname,
							                          	  
						  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						  							     
						  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
						  							   
						  							        
						  							    },  
						  							 
													},
						  							 
						{ text: 'Product Name', datafield: 'productname', width: '39%'  ,cellclassname: cellclassname ,columntype: 'custom',
														

						  								
						  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
						  							       
						  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
						  							     
						  							        
						  							    },  
													
													},

													{
														text : 'Unit',
														datafield : 'unit',
														width : '10%',
														editable:false
													},
													{
														text : 'Size',
														datafield : 'size',
														width : '13%',
														cellsalign : 'left',
														align : 'left'
													},
													{
														text : 'Quantity',
														datafield : 'qty',
														width : '13%',
														cellsalign : 'right',
														align : 'right',
														align : 'right',
														cellsformat : 'd2'
													},
													{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
						  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true},
						  							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
													{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
													{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },

											]
										});
						if (temp == 0) {
							$("#prodetGrid").jqxGrid('addrow', null, {});

						}

						if (($('#mode').val() == 'A')
								|| ($('#mode').val() == 'E')) {
							$("#prodetGrid").jqxGrid({
								disabled : false
							});
						}

			            $('#prodetGrid').on('cellclick', function (event) {
			                
			            	var columnindex1=event.args.columnindex;

			            	  if(columnindex1 == 1)
			            		  { 
			                	 productSearchContent('productSearch.jsp');
			            	 var rowindextemp = event.args.rowindex;
			            	    document.getElementById("rowindex").value = rowindextemp;  
			            	    
			           var temp= $('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
			           


			           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
			           { 
			          	 $('#gridtext').val("");  
			          	 $('#part_no').val("");  
			           }
			           else
			          	 {
			          	 
			          	   
			               $('#part_no').val($('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
			               
			               
			               $('#gridtext').val($('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
			               
			               
			               
			              
			               $('#prodetGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));

			               
			          	 }
			            
			               
			            		  } 
			            	  
			            	  
			            	if(columnindex1 == 2)
			        		  { 
			          	 productSearchContent('productSearch.jsp');
			        	 var rowindextemp = event.args.rowindex;
			        	    document.getElementById("rowindex").value = rowindextemp;  
			        	    
			        	      var temp= $('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
			                
			        	      
			                // alert(temp);
			                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
			        		   { 
			              	   $('#gridtext1').val(""); 
			              	   $('#productname').val("");  
			        		   }
			                 else
			                	 {
			        	    

			              	   $('#productname').val($('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
			              	   
			              	   $('#gridtext1').val($('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
			              	   
			                     
			                     $('#prodetGrid').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#prodetGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));

			                     
			                	 }
			                  

			         
			        		  } 
			              
			                
			                
			                
			                
			                
			                
			                
			                
			                
			                   
			                   });
			            
			            
			            var applyFilter = function (datafield,value) {
			                
			                var filtertype = 'stringfilter';
			              
			              
			                if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
			                var filtergroup = new $.jqx.filter();
			         
			                    var filter_or_operator = 1;

			                    var filtervalue = value;
			    	            var filtercondition = 'starts_with';
			                    
			                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
			                    filtergroup.addfilter(filter_or_operator, filter);
			               
			                
			                if (datafield == 'part_no') 
			                	{
			               
			                $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
			                document.getElementById("part_no").focus();
			                	}
			                else  if (datafield == 'productname') 
			            	         {
			                    
			                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
			                    document.getElementById("productname").focus();
			                    	}
			                
			                
			           
			                $("#prosearch").jqxGrid('applyfilters');
			                
			                
			                
			        
			            }

					});
</script>
<div id="prodetGrid"></div>
<input type="hidden" id="rowindex">
