<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.marketing.salesquotation.ClsSalesQuotationDAO"%>
<%ClsSalesQuotationDAO DAO= new ClsSalesQuotationDAO();%>
 
<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();


String refdtype=request.getParameter("refdtype")==null?"0":request.getParameter("refdtype").trim();

String enqdocs=request.getParameter("enqdocs")==null?"0":request.getParameter("enqdocs").trim();


String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
      
  .advanceClass
  {
      
     background-color: #ffdead;     
      	
  }
 /*  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        } */
 
    
              
</style>
<script type="text/javascript">
var qotgriddata;
$(document).ready(function () {
	chkfoc();
	chkbrand();
	chktax();
var temp2='<%=enqdoc%>';
var cond='<%=cond%>';
var temp='<%=qotdoc%>';
var enqdocs='<%=enqdocs%>';
if(enqdocs>0)
	{
	qotgriddata='<%=DAO.enqgridreload(session,enqdocs)%>';  
	}
else if(cond=="1")
{
	  
	qotgriddata='<%=DAO.enqgridreload(session,enqdoc,reftype,clientcaid,dates,cmbbilltype)%>';  
 
}

<%--  else if(temp>0)
 {
  
 	qotgriddata='<%=DAO.prdGridReload(session,qotdoc)%>';  

 } --%>
else if(temp>0 && cond=="2")
{
 
	 qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,refdtype)%>';  
 
}
 
else
 
{   
	qotgriddata;

 } 
             
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }    
 
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
	
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
 
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


            	  var ss= $('#jqxQuotation').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		return "redClass";
            		  	
            		  		}
            	   
            	 if ($("#mode").val() == "E") {    
            	   var clstatus= $('#jqxQuotation').jqxGrid('getcellvalue', row, "clstatus");
            		   if(parseInt(clstatus)==1)
            		   		 {
            		   		  return "advanceClass";
            		   		   }  
            		   		                    
            		      	} 
            		}
           	 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'size', type: 'number'   },
     						{name : 'totqty', type: 'number'   },
     						{name : 'qty', type: 'number'   },
     						{name : 'outqty', type: 'number'   },
     						{name : 'oldqty', type: 'number'   },
     						{name : 'balqty', type: 'number'   },
     						{name : 'foc', type: 'int' },
     						{name : 'refqty', type: 'int'  },
							{name : 'totwtkg', type: 'number' },
							{name : 'kgprice', type: 'number'  },
     						{name : 'unitprice', type: 'number' },
     						{name : 'total', type: 'number' },       
     						{name : 'discper', type: 'number' },
     						{name : 'dis', type: 'number' },
     						{name : 'netotal', type: 'number' },
     						{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
                    		{name : 'specid', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'chksearchset', type: 'number'    },
     						
     						{name : 'unitprice1', type: 'string'  },   
     						
     						{name : 'disper1', type: 'string'  },
     						
     						{name : 'brandname', type: 'string'},
     						
     					  {name : 'allowdiscount', type: 'number'  },
     						
     					 {name : 'taxper', type: 'number'  },  
     					 {name : 'taxamount', type: 'number'  },
     					{name : 'taxperamt', type: 'number'  }, 
     					
     					
     					{name : 'discountset', type: 'number'  }, 
     					{name : 'pqty', type: 'number'  }, 
     					  {name : 'taxdocno', type: 'string'    },
     					
     					
     					  
                        ],
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#jqxQuotation").on("bindingcomplete", function (event) { 
    			
    			
                if($('#mode').val()=="A"){
       
              if($('#cmbreftype').val()=='CEQ'){
            	
             	
                               
							            	 var rows1 = $("#jqxQuotation").jqxGrid('getrows');   
							              	  if(parseInt($('#jqxQuotation').jqxGrid('getcellvalue', 0, "discountset"))>0)
							        		  {
							            	 
							            	  for(var i=0;i<rows1.length;i++){
							            		  
							            		  
							                      
							                
							                		
							                		   var dscper=document.getElementById("dscper").value;
							                		   
							                		     
							                		   
							                		 	if(dscper>0)
							        		      		{
							                		 
							                		 	var allowdiscount=$('#jqxQuotation').jqxGrid('getcellvalue', i, "allowdiscount");
							        		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
							  
							        		            $('#jqxQuotation').jqxGrid('setcellvalue', i, "disper1" ,discallowper);
							        	        		  $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper" ,discallowper);
							        	        			if(discallowper>0)
						                           			{
							        	        		  
							        	        		 var total=$('#jqxQuotation').jqxGrid('getcellvalue', i, "total");
							        	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
							        	        		 var  netotal=parseFloat(total)-parseFloat(discount);
							        	        		     
							        	        		     $('#jqxQuotation').jqxGrid('setcellvalue', i, "dis" ,discount);
							        	        		     $('#jqxQuotation').jqxGrid('setcellvalue', i, "netotal" ,netotal);
						                           			}
							        	        		  
							        		      		}
							                		 	else
							                		 		{
							                		 		 
							                		 		 
							                		 
							                		 		  $('#jqxQuotation').jqxGrid('setcellvalue', i, "disper1" ,$('#jqxQuotation').jqxGrid('getcellvalue', i, "allowdiscount"));
							                        		  $('#jqxQuotation').jqxGrid('setcellvalue', i, "discper" ,$('#jqxQuotation').jqxGrid('getcellvalue', i, "allowdiscount"));
							                        		 	var allowdiscount=$('#jqxQuotation').jqxGrid('getcellvalue', i, "allowdiscount");
							                        	 
							                        		 	if(allowdiscount>0)  
							                           			{
							                        	 
							                        		 	 var total=$('#jqxQuotation').jqxGrid('getcellvalue', i, "total");
							                        	 
							                   
									        	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount)/100));
									        	        		 
									        	        		 
									        	        		 var  netotal=parseFloat(total)-parseFloat(discount);
									        	        		 
									        	        		     $('#jqxQuotation').jqxGrid('setcellvalue', i, "dis" ,discount);
									        	        		     $('#jqxQuotation').jqxGrid('setcellvalue', i, "netotal" ,netotal);
							                           			}
							                		 		
							                		 		}
							                		  
							                		  
							                	 
							            		  
							            		  
							            	  }
							              
							        		  } // 0chk
              
							              	  
							              	  
							              	  
							              	  
							              	 var rows = $("#jqxQuotation").jqxGrid('getrows');   
							              	 
							             	  for(var i=0;i<rows.length;i++){
							             	   		var netotal=$('#jqxQuotation').jqxGrid('getcellvalue', i, "netotal"); 
							                		
							                		  var taxper= $('#jqxQuotation').jqxGrid('getcellvalue', i, "taxper"); 
							                		  
							                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
							                		  
							                		  
							                		  $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxperamt",taxempamount);
							                		  
							                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
							                		  
							                		  $('#jqxQuotation').jqxGrid('setcellvalue', i, "taxamount",taxtotalamount);
							              	 
							                		 
							             	                         }			              	  
              
              
              } //if
              
                               } //mode
         
     
    			
    			
    		}); 
            
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxQuotation").jqxGrid(
            {
                width: '99.5%',
                height: 180,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	
 	 if(document.getElementById("cmbreftype").value=="DIR")
             		{
                       
            			 var cell1 = $('#jqxQuotation').jqxGrid('getselectedcell');
            		
            			 
                    	 if (cell1 != undefined && cell1.datafield == 'unit') {  
                    		 
                		 
                    		 if((parseInt(document.getElementById("multimethod").value)==1))
             				{	
                    			 
                    		 
                            var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                            if (key == 114) {  
                           	 
                   			 
                              var rowindextemp=cell1.rowindex;
                         	    document.getElementById("rowindex").value = cell1.rowindex;   
                             	  $('#jqxQuotation').jqxGrid('clearselection');
                             	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "psrno")+
                             			"&mode="+document.getElementById("mode").value);
                             	
                            	 
                            }
                            
             				}
                            
                            
                            }
            			 
                   }

                    var cell4 = $('#jqxQuotation').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) { 
  	                	
  	                	  
  	                	  
  	                	  if(cell4.datafield == 'productid')
	                		  {
	                		var aa= $('#part_no').val();
	                		  }
	                	  else if(cell4.datafield == 'productname')
	                		  {
	                		var aa= $('#productname').val();  
	                		  }
	                		  
	                	  
	           
	                	
	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                     
                    	return 0;
                    	}
                       
  	                	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	             	   
  	                	
  	                	
  		             	 if(document.getElementById("cmbreftype").value=="RFQ")
 	                	{
 	            
 	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
 	                	  
 	   	     
 	   	              
 	   	              
 	                    var unitprice=rows[0].unitprice;
 	   	              
 	   	                var prdid=rows[0].doc_no;
 	   	                var disper=rows[0].discper;
 	   	   
 	   	          
 	              	  
 		  	            		var rows1 = $("#jqxQuotation").jqxGrid('getrows');
 		  	          	    var aa=0;
 		  	          	    for(var i=0;i<rows1.length;i++){
 		  	          	 
 		  	          	    	
 		  	          	    	
 		  	          	    	 
 		  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prdid))
 		  	          			   {
 		  	          			  
 		  	           		   if(parseFloat(rows1[i].unitprice)==parseFloat(unitprice))
 		  	           			  {
 		  	           		 
 		  	           
 		  	           
 		  	           		   if(parseFloat(rows1[i].discper)==parseFloat(disper))
 		  	           			  {
 		  	           	 
 		  	           			   
 		  	           		   var munit=rows[0].unitdocno;
			      				 if((parseInt(document.getElementById("multimethod").value)==1))
			          				{	
			      					   
			  	        			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
			  	        			   {
			  	        				   
			  	        				   aa=1;
			  	            			   break;
			  	        			   }
			          				}
			      				 else
			      					 {
 		  	           			   
 		  	           			   aa=1;
 		  	          			   break;
			      					 }
 		  	           			   
 		  	           			  }
 		  	          			   }
 		  	          			   
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
  		             	 else
  		             		 {
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	              
  	            		var rows1 = $("#jqxQuotation").jqxGrid('getrows');
  	          	    var aa=0;
  	          	    for(var i=0;i<rows1.length;i++){
  	          	 
  	          	    	
  	          	     
  	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
  	          			   {
  	          		   var munit=rows[0].unitdocno;
	      				 if((parseInt(document.getElementById("multimethod").value)==1))
	          				{	
	      					   
	  	        			   if(parseInt(rows1[i].unitdocno)==parseInt(munit))
	  	        			   {
	  	        				   
	  	        				   aa=1;
	  	            			   break;
	  	        			   }
	          				}
	      				 else
	      					 {
  	          			   aa=1;
  	          			   break;
	      					 }
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
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxQuotation').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
	  	          $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	               
	  	        $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,rows[0].allowdiscount);
	  	        
	  	      $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
	  	        
	  	        
	  	    $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,rows[0].taxdocno);
	  	        
  	 
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitdocno"  ,rows[0].unitdocno);
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	            
  	           $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
  	  	        $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
  	  	  	   $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,rows[0].netotal);
  	  	  	   
  	  	  	   
  	  	  	   
  	  	  	   
  	  	     
  		  	    document.getElementById("datas2").value="0";
  	 
  	      	  if(parseInt(rows[0].discountset)>0)
  	      		  {
  	      		
  	      		   var dscper=document.getElementById("dscper").value;
  	      		 	if(dscper>0)
  			      		{
  	      	 
  	      		 	   var allowdiscount=rows[0].allowdiscount;
  			      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
  			      	 
  			      	 
  			      		
  			          document.getElementById("datas2").value="1";
  			  
  			          
  			            $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
  		        		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
  		        		  
  		        	    if(document.getElementById("cmbreftype").value=="CEQ")
  		          	    {
  		        		  
  		        	    	if(discallowper>0)
                   			{
     	        		 var total=$('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "total");
     	        		 
     	        		 
     	        	
     	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
     	        		 
     	        	 
     	        		 var  netotal=parseFloat(total)-parseFloat(discount);
     	        		     
     	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
     	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
                   			}
     	        		     
     	        		     
     	        		     
  		            	}
  		        		  
  			      		}
  	      		 	else
  	      		 		{
  	      		 		
  	      		 	 
  	      		 		  document.getElementById("datas2").value="1";
  	      		 		  
  	      		 		  
  	      		 	 
  	      		 		  
  	      		 		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].allowdiscount);
  	      		 		  
  	      		 		  
  	              		  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].allowdiscount);
  	              	  
    		        	    if(document.getElementById("cmbreftype").value=="CEQ")
    		          	    {
    		        		  
  	              		var allowdiscount=rows[0].allowdiscount;
  	              		
  	              		
  	              	if(allowdiscount>0)
            			{
             	 
	              		 var total=$('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "total");
   	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount.toFixed(2))/100));
   	        		 var  netotal=parseFloat(total)-parseFloat(discount);
   	        		     
   	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
   	        		     $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
            			}
  	              		
  	              		
  	              		 
    		          	    }
     	        		     
  	      		 		}
  	      		  
  	     
  	      

  			      
  			     	      
  	      		  }
  			     	 
  	      	  document.getElementById("datas2").value="0";
  		          
  	  	  	   
  	                
  	          //    $("#jqxQuotation").jqxGrid('selectcell',rowindex1, "qty" );
  	        //  $("#jqxQuotation").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	        
  	               if(document.getElementById("cmbreftype").value=="RFQ")
        	{
  	            	 if(document.getElementById("mode").value=="E")
  	            		 {
  	            	var	qty1= $('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "qty");	
  	              
  	              	var outqty1= $('#jqxQuotation').jqxGrid('getcellvalue', rowindex1, "outqty"); 
  	            		 var totout=parseFloat(qty1)+parseFloat(outqty1);
  	            		$('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "outqty",totout);
  	            		 }
  	            	   
  	                 $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
  	        $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
  	      $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].discper);
  	    $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "dis" ,rows[0].dis);
  	   $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "netotal" ,rows[0].netotal);
  	   
  	   
 	//  unitprice1 disper1
 	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,rows[0].unitprice);
 	  $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].discper);
  	   
  	 $('#jqxQuotation').jqxGrid('setcellvalue', rowindex1, "chksearchset" ,1);
  	   
  	 
  	   
        	}
  	          
  	        
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxQuotation').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxQuotation").jqxGrid('addrow', null, {});
               	} 
           //    alert(rowlength);
               $("#jqxQuotation").jqxGrid('ensurerowvisible', rowlength);
                
               
  	        	            } 
  	                   
  	                if (key != 13) {          
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
  	                }
            
                   } 
       		 
            
                    },
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,
	                   	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
                       { text: 'Product Name', datafield: 'productname',  cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							
							
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false  ,  cellclassname: cellclassname},
							{ text: 'Unit', datafield: 'unit', width: '6%',editable:false,  cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '5%' ,  cellclassname: cellclassname, cellsformat: 'd2'},
							{ text: 'oldqty', datafield: 'oldqty', width: '7%' ,hidden:true  },
							{ text: 'P Qty', datafield: 'pqty', width: '7%'    ,hidden:true },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%'  ,hidden:true },
							{ text: 'FOC', datafield: 'foc', width: '7%',editable:false },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%'  ,hidden:true },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%'  ,hidden:true },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right'},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',  cellclassname: cellclassname,
								
								cellbeginedit: function (row) {
									 
							         if (document.getElementById("cmbreftype").value=="RFQ")
		                             {
		                                  return false;
		                             } 
								   
								  },
							
							
							},
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,editable:false,cellbeginedit: function (row) {
								 
						         if (document.getElementById("cmbreftype").value=="RFQ")
	                             {
	                                  return false;
	                             } 
							   
							  }, },
							  { text: 'allowdiscount', datafield: 'allowdiscount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname  ,hidden:true   },
							
							  
							  
							  { text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,cellclassname: cellclassname,
								cellbeginedit: function (row) {
									 
							         if (document.getElementById("cmbreftype").value=="RFQ")
		                             {
		                                  return false;
		                             } 
								   
								  },},
							{ text: 'Discount', datafield: 'dis', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,
									  cellbeginedit: function (row) {
											 
									         if (document.getElementById("cmbreftype").value=="RFQ")
				                             {
				                                  return false;
				                             } 
										   
										  },},
							{ text: 'Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname,editable:false,
											  
							
											  cellbeginedit: function (row) {
													 
											         if (document.getElementById("cmbreftype").value=="RFQ")
						                             {
						                                  return false;
						                             } 
												   
												  },
							},
							{text: 'pid', datafield: 'proid', width: '10%',hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true},
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							{text: 'specid', datafield: 'specid', width: '10%',hidden:true },
							{text: 'chksearchset', datafield: 'chksearchset', width: '10%' ,hidden:true },
							
							{text: 'unitprice1', datafield: 'unitprice1', width: '10%',hidden:true },
							{text: 'disper1', datafield: 'disper1', width: '10%' ,hidden:true },
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{text: 'discountset', datafield: 'discountset', width: '10%'  ,hidden:true  },
	     		
							   {text: 'taxdocno', datafield: 'taxdocno', width: '10%'   ,hidden:true },
							
							//  unitprice1 disper1
						]
            });
            
       	 $('#jqxQuotation').on('cellclick', function (event) {
			 
			 document.getElementById("errormsg").innerText="";	 
			 
			 	 if(document.getElementById("cmbreftype").value=="DIR")
     		{
							var df=event.args.datafield;
			
							  
			             	  if(df == "unit")
			             		  { 
			             		 
						 if(parseInt(document.getElementById("multimethod").value)==1)
							{	 
						 
						 var rowindextemp = event.args.rowindex;
			       	    document.getElementById("rowindex").value = rowindextemp;   
			       	  $('#jqxQuotation').jqxGrid('clearselection');
			      	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "psrno")+
			      			"&mode="+document.getElementById("mode").value);
							}
						 
						 
						 
			             		  }
			       	
     		}
		 });
            
            $('#jqxQuotation').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var enqmasterdocno=$("#enqmasterdocno").val();
             	
             	var df=event.args.datafield;
             	 $('#datas').val(0);
              
             	  if(df == "productid")
             		  { 
            		 
             		  
             		  
             		 var clientcaid=document.getElementById("clientcaid").value; 
               		 var dates=document.getElementById("date").value; 
               		 
               		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
               		 
               		
             		  
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+enqmasterdocno+'&reftypes='+document.getElementById("cmbreftype").value+'&mode='+document.getElementById("mode").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxQuotation').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
                  if(df == "productname")
          		  { 
            	  if(document.getElementById("errormsg").innerText!="")
         		 {
            		   
         		 return 0;
         		 }
            	  
            	  
            	  var clientcaid=document.getElementById("clientcaid").value; 
            		 var dates=document.getElementById("date").value; 
            		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
            		productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+enqmasterdocno+'&reftypes='+document.getElementById("cmbreftype").value+'&mode='+document.getElementById("mode").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxQuotation').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxQuotation').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
                	 }
                  

         
        		  } 
            	 
                   
                   });
            
            
            
            function valchange(rowBoundIndex,datafield)
            {
            	var qty=0;
            	var oldqty=0;
            	var totqty=0;
            	var tmpqty=0;
            	var tmpqty1=0;
            	var outqty=0;
            	var balqty=0;
            	var unitprice=0;
            	var totwtkg=0;
            	var kgprice=0;
            	var unitprice=0;
            	var total=0;
            	var discper=0;
            	var discount=0;
            	var netotal=0;
            	var warning;
            	var searchtype=document.getElementById("prodsearchtype").value;
            	 qty= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	 	if(document.getElementById("cmbreftype").value=="CEQ" || document.getElementById("cmbreftype").value=="RFQ" )
            		{
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty-oldqty;
                	 tmpqty1=oldqty+balqty;
                	  $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
                	  var chksearchset=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "chksearchset");	
                	/* 	if($('#mode').val()=="E" && parseInt(chksearchset)==1){
                			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "outqty",qty);	
                		}
                		else
                			{ */
                			
                			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                			/* } */
                		
                	  
             		
                 	
            	 
            	 
          /*   	   if(searchtype!="0"){   */
            	 
                 	if($('#mode').val()=="A"){
                 		
                 		 if(qty>balqty){
                      		
                        	// $("#jqxQuotation").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
                        	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
                        	 document.getElementById("errormsg").innerText= "Quantity should not be greater than available  quantity "+balqty;
                        	 qty=balqty;
                        	  }  
                        	 
                        	 else{
                        		// $("#jqxQuotation").jqxGrid('hidevalidationpopups');
                        		 document.getElementById("errormsg").innerText="";
                        	 }	
                 		
                 		
                 	}
          
             	if($('#mode').val()=="E"){
             		
             		
             		 if(qty>totqty){
                 		
                    	// $("#jqxQuotation").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
                    	 //$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                    	 $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "qty",totqty);
             			 document.getElementById("errormsg").innerText= "Quantity should not be greater than available  quantity "+totqty;
             			 qty=totqty;
                    	 
                    	  }  
                    	 
                    	 else{
                    		// $("#jqxQuotation").jqxGrid('hidevalidationpopups');
                    		 document.getElementById("errormsg").innerText="";
                    	 }
             		
             	}
          
          
            	/*  } */
            	   
            		}  
            		}
            	   
            	 /* if(searchtype!="0"){
                
            	 if(datafield=='qty'){
            	 if(qty>balqty){
            		 
            		 warning="quantity should not be greater than requested quantity";
            		 document.getElementById("errormsg").innerText=warning;
            		 $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
            	 }
            	 else if(qty<=balqty){
            		 document.getElementById("errormsg").innerText="";
            	 }
            	 }
            	 } */
            	  
            	 if(datafield=='totwtkg' || datafield=='kgprice'){
            		 unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
                 	}
            	 
            	total=parseFloat(qty)*parseFloat(unitprice);
            	
  	             
            	
            	
            	
            	if(datafield=='dis'){
            		
            		 
            	discper=(100/parseFloat(total))*parseFloat(discount);
            	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	}
            	
            	
            	
            	 if(datafield=='discper'){
            	 
            		 
            		 
            		 
            		 
            		 
            		 
            		   var dscper=document.getElementById("dscper").value;
             	      
                  	 var  allowdiscount=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");
                  	
                  	 
                  	
                   	 
             	      
                   	if(dscper=="" || dscper==null)
                   		{
                   		 var discallowper=parseFloat(allowdiscount);
                   		 
                   		}
                   	else{
                   		 var discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);
                   		}
              
                   	
                   	if(parseFloat(discper)>0)
                   		{
                   		 
                   		}
                   	else
                   		{
                   		 
                   		discper=0.00;
                   		}    
                   	if(parseFloat(discallowper)>0)
                   		{
                   		 
                   		}
                   	else
                   		{
                   		 
                   		discallowper=0.00;
                   		}
            
            
                  	 if(parseFloat(discper.toFixed(2))<=parseFloat(discallowper.toFixed(2)))
                  		 {
                  		 
                  		 discper=discper;
                  	    
                  		 }
                  	    else
                  	    	{
                  	    	
                  	    	
                	    	if(parseFloat(discper)>0)
                	    		{
                	    		
                	    		if(isNaN(discallowper))
                	    			{
                	    			discallowper=0;
                	    			}
                	    		
                	    		document.getElementById("errormsg").innerText="Maximum Allowed Discount Is "+discallowper.toFixed(2);
                	    		}
                	    	discper=0;
                  	    
                  	    	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
                  	    	
                  	    	
                  	    	}
                  	    
                  	  
            		 
            		 
            		 if(discper>=0)
            			 {
            		 
            		 
            	discount=(parseFloat(total)*parseFloat(discper.toFixed(2)))/100;
            	
            			 }
            	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	}
            	
            	
            	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
     		   {
            		discount=0.0;
     		   }
            	 
            	
      
            	netotal=parseFloat(total)-parseFloat(discount);
            	
          
            	
           // $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             
    
            	if(parseFloat(discount)>0 || parseFloat(discount)<0)
            		{
            	
            	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            	else
            		{
            		$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
            		}
            	 
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
             
      			if(datafield=='qty'){
              		
              		if(parseFloat(discper)>0)
              			{
 
              			discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
              			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
              			}
        		  }
             
            		var summaryData1= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
            
          var ordervalue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
           
      	  funRoundAmt(ordervalue,"orderValue");
       	var summaryData10= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
      	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
     	/*   
    	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
    	  */
    	 funRoundAmt4(aa1,"st");
    	 funRoundAmt4(aa1,"taxtotal");
          
            	   }
            
            
            
            $("#jqxQuotation").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;  
         
            		    
	    if(datafield=='discper')
            		    	
            		    {
            		    	  if(parseInt($('#datas2').val())==1)
                    		  {
                    	   return 0;
                    		  }
            		    }
            		    
            		    
            		    
            		            	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            	   
            
            	   if(datafield=="productid")
            		   {
            	   
            	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            			if(parseInt($('#datas1').val())==0)
                   			
           				{
           				return 0;
           				}
            		if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice'){	 
           			valchange(rowBoundIndex,datafield);
            			}
               	 if(datafield=='unitprice')
                	 
        		 {
        		 
   	  		  var discount1=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "discper");
      		 
      		  
      		  if(parseFloat(discount1)==0)
  			  {
  		 
  			  }
      		  else
      			  {
      			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "discper",0);
      			$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "discper",discount1);
      			  }
  		  
      		  
        		 
        		 }
            	  	  if(datafield=="netotal")
            		  {
            	  		  
            	  		  var discount1=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "dis");
                  		  var total=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "total");
                  		 
                  		  if(parseFloat(discount1)==0)
                  			  {
                  		$('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
                  			  }
                  		  
            	  		  
            	  		  
            		var netotal=$('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "netotal"); 
            		
            		  var taxper= $('#jqxQuotation').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
            		  
            		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
            		  
            		  
            		  $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
            		  
            		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
            		  
            		  $('#jqxQuotation').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
            		  
            		 
            		  }
            		
            		  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice'){	   
                    	  
                		  funcalutax();
                  	  }
                 		
                    		});
            
            
            var applyFilter = function (datafield,value) {
                
                var filtertype = 'stringfilter';
              
              
                if (datafield == 'part_no' || datafield == 'productname') filtertype = 'stringfilter';
                var filtergroup = new $.jqx.filter();
         
                    var filter_or_operator = 1;

                    var filtervalue = value;
    	            var filtercondition = 'contains';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
               
                
                if (datafield == 'part_no') 
                	{
               
                $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
              //  document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'productname') 
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                //    document.getElementById("productname").focus();
                    	}
                
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
                
                
        
            }
            
            if($('#mode').val()!="view"){
            	$("#jqxQuotation").jqxGrid('disabled', false);
            } 
            
          if($('#cmbreftype').val()=='RFQ' || enqdocs>0 ||  $('#cmbreftype').val()=='CEQ'){
            	
            	if($('#mode').val()=="A"){	
            	
            var summaryData1= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
    		var summaryData2= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
			
        document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
        
        
          
  	   	var summaryData10= $("#jqxQuotation").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
  	   	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
/*   	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
  	   	 */
  	 
  	funRoundAmt4(aa1,"st");
	 funRoundAmt4(aa1,"taxtotal");
	 funcalutax();
            }
            }
          /*   $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxQuotation").on('contextmenu', function () {
                   return false;
               }); */
               
               /*  $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxQuotation").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxQuotation").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxQuotation").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxQuotation").jqxGrid('getrowid', rowindex);
                       $("#jqxQuotation").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#jqxQuotation").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#jqxQuotation").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               }); */
            
          
        });
function chktax()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
    	 
    	  
    	  $('#taxsss').hide();

    	  $('#billname').show();
    	  $('#cmbbilltype').show();
    	  
    	 
    	  $('#jqxQuotation').jqxGrid('showcolumn', 'taxper');
    	  $('#jqxQuotation').jqxGrid('showcolumn', 'taxamount');
       	  $('#jqxQuotation').jqxGrid('showcolumn', 'taxperamt');
    
    	  
    	  
        }
          else
      {
        	  $('#taxsss').hide();
        	  $('#billname').hide();
        	  $('#cmbbilltype').hide();
        	  
        	  $('#jqxQuotation').jqxGrid('hidecolumn', 'taxper');
        	  $('#jqxQuotation').jqxGrid('hidecolumn', 'taxamount');
        	  $('#jqxQuotation').jqxGrid('hidecolumn', 'taxperamt');
      
      }
      
       }}
   x.open("GET","checktax.jsp?",true);
	x.send();
 
      
        
	
} 
function chkbrand()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
     
    	  
    	  $('#jqxQuotation').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxQuotation').jqxGrid('hidecolumn', 'brandname');
      
      }
      
       }}
   x.open("GET","checkbrand.jsp?",true);
	x.send();
 
      
        
	
}
        
        
</script>
<div id='jqxWidget'>
   <div id="jqxQuotation"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
           
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
<input type="hidden" id="datas2"><!--  discount set at a time cellvalue change not working; -->