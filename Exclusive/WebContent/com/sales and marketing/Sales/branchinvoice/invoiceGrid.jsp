<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.Sales.branchInvoice.ClsBranchInvoiceDAO"%>
<%ClsBranchInvoiceDAO DAO= new ClsBranchInvoiceDAO();%>

<% 

String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();

String cmbreftype=request.getParameter("cmbreftype")==null?"NA":request.getParameter("cmbreftype").trim();
String locationid=request.getParameter("locationid")==null?"NA":request.getParameter("locationid").trim();

String date=request.getParameter("date")==null?"NA":request.getParameter("date").trim();

String catid=request.getParameter("catid")==null?"NA":request.getParameter("catid").trim();


String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();



 
%>

<style type="text/css">
 .redClass
    {
        background-color: #ffe4e1;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }       
</style>

<script type="text/javascript">
var qotgriddata;
$(document).ready(function () {
chkfoc();
chkbrand();
chkaccount();
chktax();

var temp2='<%=enqdoc%>';
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

<%--  if(temp2>0 && cond=="0")
{

	qotgriddata='<%=DAO.qotgridreload(enqdoc,reftype)%>';  
 
}

  else --%> if(cond=="1")
 {
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,reftype,date,catid,cmbbilltype)%>';  

 }
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqmasterdocno,cmbreftype,locationid,catid,cmbbilltype)%>';  

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
	  
	  var cellclassname = function (row, column, value, data) {
  		if (data.chkqty==1) {
  			// document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
              return "redClass";
          }
  		else{
  			//document.getElementById("errormsg").innetText="";
  		}
  		
  		 var ss= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', row, "qty");
         if(parseInt(ss)<=0)
 		{
 		
 		return "redClass";
 	
 		}
      /*    var count= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', row, "count");
         if(parseInt(count)==2)
 		{
 		
        	 $.messager.alert('alert', ' Products contains different locations');
 	cc
 		} */
         
         

  		};
 
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
     						{name : 'stkid', type: 'number'    },
     						
     						{name : 'locid', type: 'number'    },
     						
     					    {name : 'brandname', type: 'string'  },
     					    {name : 'count', type: 'string'  },
     					   {name : 'allowdiscount', type: 'number'  },
     					   
     					  {name : 'lbrchg', type: 'number'  },
     					  
     					  
     					    
     					 {name : 'taxper', type: 'number'  }, 

     					{name : 'taxperamt', type: 'number'  }, 
     					 
     					 {name : 'taxamount', type: 'number'  }, 
     					 
     					{name : 'discountset', type: 'number'  }, 
     					  
     					   
     					   
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            		
            		
         		
            $("#jqxInvoiceGrid").on("bindingcomplete", function (event) { 
    			
    			
            	
            	   if($('#mode').val()=="A"){
            	       
                       if($('#cmbreftype').val()=='DEL' || $('#cmbreftype').val()=='JOR'){
                     	
                      	
                                        
         							            	 var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');   
         							              	  if(parseInt($('#jqxInvoiceGrid').jqxGrid('getcellvalue', 0, "discountset"))>0)
         							        		  {
         							            	 
         							            	  for(var i=0;i<rows1.length;i++){
         							            		  
         							            		  
         							                      
         							                
         							                		
         							                		   var dscper=document.getElementById("dscper").value;
         							                		   
         							                		     
         							                		   
         							                		 	if(dscper>0)
         							        		      		{
         							                		 
         							                		 	var allowdiscount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "allowdiscount");
         							        		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
         							  
         							        		         //   $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "disper1" ,discallowper);
         							        	        		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper" ,discallowper);
         							        	        			if(discallowper>0)
         						                           			{
         							        	        		  
         							        	        		 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "total");
         							        	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
         							        	        		 var  netotal=parseFloat(total)-parseFloat(discount);
         							        	        		     
         							        	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis" ,discount);
         							        	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal" ,netotal);
         						                           			}
         							        	        		  
         							        		      		}
         							                		 	else
         							                		 		{
         							                		 		 
         							                		 		 
         							                		 
         							                		 		//  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "disper1" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "allowdiscount"));
         							                        		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "discper" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "allowdiscount"));
         							                        		 	var allowdiscount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "allowdiscount");
         							                        	 
         							                        		 	if(allowdiscount>0)  
         							                           			{
         							                        	 
         							                        		 	 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "total");
         							                        	 
         							                   
         									        	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount)/100));
         									        	        		 
         									        	        		 
         									        	        		 var  netotal=parseFloat(total)-parseFloat(discount);
         									        	        		 
         									        	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "dis" ,discount);
         									        	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "netotal" ,netotal);
         							                           			}
         							                		 		
         							                		 		}
         							                		  
         							                		  
         							                	 
         							            		  
         							            		  
         							            	  }
         							              
         							        		  } // 0chk
                       }}
            	
            	
                if($('#mode').val()=="A"){
       
              if($('#cmbreftype').val()=='SOR' || $('#cmbreftype').val()=='DEL' || $('#cmbreftype').val()=='JOR'){
            	
             	 var rows = $("#jqxInvoiceGrid").jqxGrid('getrows');   
 
	             	  for(var i=0;i<rows.length;i++){
	             	   		var netotal=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "netotal"); 
	                		
	                		  var taxper= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', i, "taxper"); 
	                		  
	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
	                		  
	                		  
	                		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxperamt",taxempamount);
	                		  
	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
	                		  
	                		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', i, "taxamount",taxtotalamount);
	              	 
	                		 
	             	                         }
                                    }
                               } 
         	         
     
    			
    			
    		}); 
            
            	 
            		
            		
            		
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInvoiceGrid").jqxGrid(
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
                	

                    var cell4 = $('#jqxInvoiceGrid').jqxGrid('getselectedcell');
                   
                    
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
  	                	  
  	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	               /*  if(parseInt(rows[0].method)==0)
  	              	  { */
  	           
  	            if(document.getElementById("cmbreftype").value=='DIR' || document.getElementById("cmbreftype").value=='SOR'|| document.getElementById("cmbreftype").value=='JOR')
            		   {
  	            	   
  	            		var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
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
  	          	   
  	            	  
  	            	   }  
  	                	  
  	            else  if(document.getElementById("cmbreftype").value=='DEL')
         		   {
  	            	 var prodocs1=rows[0].doc_no;
  	            	 var locid=rows[0].locid;
  	                	
  	            	 
	            		var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
 	          	         var aa=0;
 	          	       for(var i=0;i<rows1.length;i++){
			  	          	  
			  	          	    	   if(parseInt(rows1[i].prodoc)==parseInt(prodocs1))
			  	          			   {
			  	          	    		   
			  	          	    		  if(parseInt(rows1[i].locid)==parseInt(locid))
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
  	  		    
  	                	
  	                	   $('#jqxInvoiceGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,rows[0].allowdiscount);
  	              
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "lbrchg" ,rows[0].lbrchg);
  	          $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
  	              
  	            
  	          
  	                
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "eidtprice" ,rows[0].eidtprice);
  	 
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	                
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno); 
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid);
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty);
  	          $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice );
  	          
  	        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "locid" ,rows[0].locid );
  	          
  	  	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,rows[0].dis);
    	  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].discper);
    	  document.getElementById("datas2").value="0";
    	  if(document.getElementById("cmbreftype").value=="DIR" || document.getElementById("cmbreftype").value=="DEL"|| document.getElementById("cmbreftype").value=="JOR")
    		  
    		  
    		  {  
    	  if(parseInt(rows[0].discountset)>0)
    		  {
    		
    		   var dscper=document.getElementById("dscper").value;
    		 	if(dscper>0)
	      		{
    		  
    		 	var allowdiscount=rows[0].allowdiscount;
	      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
	      	 
	          document.getElementById("datas2").value="1";
	          //  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
        		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
        		  
        		  
        		  
        		  
        		  if(document.getElementById("cmbreftype").value=="DEL"|| document.getElementById("cmbreftype").value=="JOR")
	          	    {
	        		  
	        	    	if(discallowper>0)
             			{
	        		 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "total");
	        		 
	        		 
	        	
	        		 var discount=(parseFloat(total)*(parseFloat(discallowper.toFixed(2))/100));
	        		 
	        	 
	        		 var  netotal=parseFloat(total)-parseFloat(discount);
	        		     
	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
             			}
	        		     
	        		     
	        		     
	            	}
        		  
        		  
        		  
        		  
	      		}
    		 	else
    		 		{
    		 		  document.getElementById("datas2").value="1";
    		 		//  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].allowdiscount);
            		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].allowdiscount);
            		  
            		  
            		  
            		  
            	  	    if(document.getElementById("cmbreftype").value=="DEL" || document.getElementById("cmbreftype").value=="JOR")
		          	    {
		        		  
	              		var allowdiscount=rows[0].allowdiscount;
	              		
	              		
	              	if(allowdiscount>0)
        			{
         	 
              		 var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindex1, "total");
	        		 var discount=(parseFloat(total)*(parseFloat(allowdiscount.toFixed(2))/100));
	        		 var  netotal=parseFloat(total)-parseFloat(discount);
	        		     
	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "dis" ,discount);
	        		     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "netotal" ,netotal);
        			}
	              		
	              		
	              		 
		          	    }
            		  
            		  
    		 		}
    		  
    		  
    		  }
    

	      
	     	      
    		  }
	     	 
    	  document.getElementById("datas2").value="0";
	           
  	                
  	         //     $("#jqxInvoiceGrid").jqxGrid('selectcell',rowindex1, "qty" );
  	        //  $("#jqxInvoiceGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	 
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
               	} 
               
               $("#jqxInvoiceGrid").jqxGrid('ensurerowvisible', rowlength);
               
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
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
						{ text: 'Product Name', datafield: 'productname'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname  },
							
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '4%',cellclassname: cellclassname ,cellsformat: 'd2'},
							
							
							
							{ text: 'lbrchg', datafield: 'lbrchg', width: '10%', cellsformat: 'd2',hidden:true, cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
							
							
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname   ,hidden:true  },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname  ,hidden:true    },
							{ text: 'FOC', datafield: 'foc', width: '7%',cellclassname: cellclassname },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true   },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true   },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname 	,
								cellbeginedit: function (row) {
								 
						         if (document.getElementById("cmbreftype").value=="SOR")
	                             {
	                                  return false;
	                             } 
							   
							  },},
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							{ text: 'allowdiscount', datafield: 'allowdiscount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname   ,hidden:true   },
							
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,
								cellbeginedit: function (row) {
									 
							         if (document.getElementById("cmbreftype").value=="SOR")
		                             {
		                                  return false;
		                             } 
								   
								  },},
							{ text: 'Discount', datafield: 'dis', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,
									  cellbeginedit: function (row) {
											 
									         if (document.getElementById("cmbreftype").value=="SOR")
				                             {
				                                  return false;
				                             } 
										   
										  },},
							{ text: 'Net Total', datafield: 'netotal', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'eidtprice', datafield: 'eidtprice', width: '10%' ,hidden:true },
							
							
							{text: 'locid', datafield: 'locid', width: '10%'    ,hidden:true },
							
							{text: 'chkqty', datafield: 'chkqty', width: '10%' ,hidden:true  },
							{text: 'count', datafield: 'count', width: '10%'    ,hidden:true }, 
							
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax %amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true},
							{ text: 'Tax Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{text: 'discountset', datafield: 'discountset', width: '10%' ,hidden:true   },
							
							
							
						]
            });
            
            
            
            
             if($('#mode').val()=="A"){   
            
            if(document.getElementById("cmbreftype").value=='DEL' && cond=="1")
  		   {
           	  
           	 var locid1=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', 0, "locid");
               	
           	 
         		var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
        	         var aa=0;
        	       for(var i=0;i<rows1.length;i++){
        	    	   
        	    	   
        	    	 
		  	          	    		  if(parseInt(rows1[i].locid)!=parseInt(locid1))
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
        		   
        		  
        		   $.messager.alert('alert', ' Products contains different locations');
        		   }
        	 
  		   }
            
            }
           
          	 $('#jqxInvoiceGrid').on('cellclick', function (event) {
    			 
    			 document.getElementById("errormsg").innerText="";	 
    			 
    		 }); 
            $('#jqxInvoiceGrid').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var refmasterdocno=$("#refmasterdocno").val();
            	 var reftype=$("#cmbreftype").val();
            		var df=event.args.datafield;

                    
               	  if(df == "productid")
               		  { 
               		  
              		var clientid=document.getElementById("clientid").value;
              		if(clientid==""){
            			document.getElementById("errormsg").innerText="Select a Customer";
            			
            			return 0;
            		}
              		
            		 if(document.getElementById("locationid").value=="")
              		  {

              		   document.getElementById("errormsg").innerText="Search Location";  
              		   document.getElementById("txtlocation").focus();
              		     
              		      return 0;
              		  }
                 		  
                 		
              		
              		var cmbprice=document.getElementById("cmbprice").value;
              		var cmbreftype=document.getElementById("cmbreftype").value;
               		 var clientcaid=document.getElementById("clientcaid").value; 
               		 var dates=document.getElementById("date").value;
               		 
               		 
               		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
               		 
               		
               		 
               		 
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&reftype='+reftype+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
              	 if(df == "productname")
        		  { 
          	  if(document.getElementById("errormsg").innerText!="")
       		 {
          		   
       		 return 0;
       		 } 
            		
          	var clientid=document.getElementById("clientid").value;
          	
        	var clientid=document.getElementById("clientid").value;
      		if(clientid==""){
    			document.getElementById("errormsg").innerText="Select a Customer";
    			
    			return 0;
    		}
      		
      		
      		 if(document.getElementById("locationid").value=="")
   		  {

   		   document.getElementById("errormsg").innerText="Search Location";  
   		   document.getElementById("txtlocation").focus();
   		     
   		      return 0;
   		  }
      		  
      		
          	
      		var cmbprice=document.getElementById("cmbprice").value;
    		var cmbreftype=document.getElementById("cmbreftype").value;
    		 var clientcaid=document.getElementById("clientcaid").value; 
    		 var dates=document.getElementById("date").value;
    		 
    		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
       		 
    		 
    		 
          	  productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&cmbreftype='+cmbreftype+'&location='+document.getElementById("locationid").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
        	    
          	 var rowindextemp = event.args.rowindex;
          	  document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
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
            	 qty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
       
             	if($('#mode').val()=="E"){
             		totqty=totqty+oldqty;
             		if(document.getElementById("cmbreftype").value!="SOR")
         			{
             		
             		
            	 if(qty>totqty){
            		 document.getElementById("errormsg").innerText="Quantity should not be greater than available quantity "+totqty;
            	// $("#jqxInvoiceGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
            	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 }
            	 
            	 else{
            		// $("#jqxInvoiceGrid").jqxGrid('hidevalidationpopups');
            		 document.getElementById("errormsg").innerText="";
            		 
            	 }
            	 
         			}
             		
             		else
             			{
             			 var tempqty=0;
                 		 
                 		 if(balqty>totqty)
                 			 {
                 			 
                 			tempqty=totqty;
                 			 }
                 		 else if(balqty<=totqty)
                 			 {
                 			 
                 			tempqty=balqty;
                 			 }
                 		 
                 	
                 		 
                  
             			 if(qty>tempqty){
                     		
             				document.getElementById("errormsg").innerText="Quantity should not be greater than available quantity "+tempqty;
                        	// $("#jqxInvoiceGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+tempqty);
                        	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                        	 }
                        	 
                        	 else{
                        		
                        		 document.getElementById("errormsg").innerText="";
                        		 // $("#jqxInvoiceGrid").jqxGrid('hidevalidationpopups');
                        		 $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
                        	 }		
             			
             			
             			
             			}
             		
            	 
            	 
             		 }
             	else if($('#mode').val()=="A"){
             		
             		if(document.getElementById("cmbreftype").value!="SOR")
             			{
             		
             		if(qty>balqty){
             			document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
                   // $("#jqxInvoiceGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
                   	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 }
                   	 
                   	 else{
                   		document.getElementById("errormsg").innerText="";
                   		 //$("#jqxInvoiceGrid").jqxGrid('hidevalidationpopups');
                   	 }
             		
             		
             			}
             		else
             			{
             			
             		 var tempqty=0;
             		 var temps=0;
             		 if(balqty>totqty)
             			 {
             			tempqty=totqty;
             			temps=1;
             			 }
             		 else if(balqty<=totqty)
             			 {
             			tempqty=balqty;
             			temps=1;
             			 }
             		 
             		 if(parseInt(temps)>0)
         			 {
         			 
         			 }
         		 else
         			 {
         			tempqty=qty;
         			 }
             		if(qty>tempqty){
             			document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+tempqty;
                   	// $("#jqxInvoiceGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+tempqty);
                   	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 }
                   	 
                   	 else{
                   		document.getElementById("errormsg").innerText="";
                   		 //$("#jqxInvoiceGrid").jqxGrid('hidevalidationpopups');
                   		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
                   	 }
             		
             		
             			 
             			
             			
             			
             			}
             		
             		
             		
             		
             		
             	}
            	 }
            	 /* } */
            	 /* if(searchtype!="0"){
                
            	 if(datafield=='qty'){
            	 if(qty>balqty){
            		 
            		 warning="quantity should not be greater than requested quantity";
            		 document.getElementById("errormsg").innerText=warning;
            		 $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
            	 }
            	 else if(qty<=balqty){
            		 document.getElementById("errormsg").innerText="";
            	 }
            	 }
            	 } */
            	  
            	 if(datafield=='totwtkg' || datafield=='kgprice'){
            		 if(!(totwtkg==""||typeof(totwtkg)=="undefined"|| typeof(totwtkg)=="NaN" || kgprice==""||typeof(kgprice)=="undefined"|| typeof(kgprice)=="NaN"))
           		   {
            			 unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
           		   }
            		
                 	}
            	 
            	total=parseFloat(qty)*parseFloat(unitprice);
            	
            	
            	  if(datafield=='qty'){
              		
              		if(parseFloat(discper)>0)
              			{
              		   
              			  
              			discount=(parseFloat(total)*parseFloat(discper.toFixed(2)))/100;
              		             			
              			}
              		
              	         }
            	if(datafield=='dis'){
            		
            	//	alert("1"); allowdiscount
            	
/*             	 var dscper=document.getElementById("dscper").value;
            	 var  allowdiscount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");
            	      
            	if(dscper=="" || dscper==null)
            		{
            		 var discallowper=parseFloat(allowdiscount);
            		
            	 
            		}
            	else{
            		 var discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);
            		}
            	
            	 
            	 
            	


            	 
            	 var tempdiscount=parseFloat(total)*(parseFloat(discallowper)/100);
            	 


            	
            	 if(parseFloat(discount)<=parseFloat(tempdiscount))
            		 {
            	  
            	    discount=discount;
            	    
            		 }
            	    else
            	    	{
            	    	discount=0;
            	    	}
            	 
            	 */
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
          		   
            		
            	}
            	
            	
            	
            	if(datafield=='discper'){
            		
           // 	alert("1");	
           
           
                var dscper=document.getElementById("dscper").value;
            	      
            	 var  allowdiscount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");
            	
              	 if($('#cmbreftype').val()=='SOR')
        		 {
        		 var  allowdiscount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper"); 
        		 }
            	
             	 
       	      
             	if(dscper=="" || dscper==null )
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
            	    //	document.getElementById("errormsg").innerText="Discount should not be greater than available Discount ";
            	    	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	    	
            	    
            	    	
            	    	}
            	    
            	  
            		
            	discount=(parseFloat(total)*parseFloat(discper.toFixed(2)))/100;
            	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	}
            	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
     		   {
            		discount=0.0;
     		   }
            	
            	
            	
   /*          	
            	if(document.getElementById("cmbreftype").value=="SOR")
            		
            		{
            		if($('#mode').val()=="A" || $('#mode').val()=="E")
            		{
            		if(datafield=='qty')
            			{
            			if(discper>0)
            				{
            		 
            		discount=(parseFloat(total)*parseFloat(discper))/100;
            				}
            			}
            		}
            		
            		} */
            		
            	netotal=parseFloat(total)-parseFloat(discount);
            	
            //	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            
            	if(parseFloat(discount)>0 || parseFloat(discount)<0)
        		{
            	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
        		}
            	else
            		{
            		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
            		}
            	
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
            	 
                if(datafield=='qty'){
              	  
            		if(parseFloat(discper)>0)
          			{
            			discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
            			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
          			}
            	  
              }	
            		var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
	        		
	        		if(document.getElementById("cmbreftype").value=="JOR")
	        			{
	        			 
	        			//$("#jqxserviceGrid").jqxGrid('addrow', null, {});
	        			
	        		var summaryData3= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'lbrchg', ['sum'],true);
	        		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "nettotal" ,summaryData3.sum.replace(/,/g,''));
	        			 
	        		 var aa="Fixing Charge";
	          		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "description" ,aa);
	          		 
	          		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "acno" ,document.getElementById("fixaccountdoc").value);
	          		 
	          		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "account" ,document.getElementById("fixaccount").value);
	          		 
	          	 
	          		 
	          		document.getElementById("nettotal").value=summaryData3.sum.replace(/,/g,'');
	          		 
	          		 
	          		 
	          		 
	        			}
	          		/*  $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "nettotal" ,aa);
	        		 
	        		  account acno qty price total nettotal */
	        		 
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          
          var vals=summaryData.sum.replace(/,/g,'');
          
          if(parseFloat(document.getElementById("nettotal").value)>0)
        	  {
          
           vals= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
        	  }
          
         // document.getElementById("orderValue").value=vals; 
          
          
          
          funRoundAmt(vals,"orderValue");
          
      	var summaryData10= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
          
      	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
   
   	 funRoundAmt4(aa1,"st");
	 funRoundAmt4(aa1,"taxtotal");
     	  
           
       /*    document.getElementById("st").value=summaryData10.sum.replace(/,/g,'');
          document.getElementById("taxtotal").value=summaryData10.sum.replace(/,/g,''); */
          
          
          
          
            	   }
            
            
            
            $("#jqxInvoiceGrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    

      		    	  if(parseInt($('#datas2').val())==1)
              		  {
              	   return 0;
              		  }          	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            	   
            
            	   if(datafield=="productid")
            		   {
            	   
            	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            	  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice' ){	   
            	  
           			valchange(rowBoundIndex,datafield);
            	  }
           		    
            	  
            	  
            	 if(datafield=='unitprice')
            	 
            		 {
            		 
       	  		  var discount1=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
          		 
          		  
          		  if(parseFloat(discount1)==0)
      			  {
      		 
      			  }
          		  else
          			  {
          			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",0);
          			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discount1);
          			  }
      		  
          		  
            		 
            		 }
            	  if(datafield=="netotal")
            		  
            		 
            		  {
            		  
            		  
         	  		  var discount1=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
              		  var total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
              		 
              		  if(parseFloat(discount1)==0)
              			  {
              		$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
              			  }
              		  
            		  
            		var netotal=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal"); 
            		
            		  var taxper= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
            		  
            		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
            		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
            		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
            		  
            		  $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
            		  
            		 
            		  }
            	  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice' ){	   
                	  
            		  funcalutax();
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
             //   document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'productname') 
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                 //   document.getElementById("productname").focus();
                    	}
                
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
                
                
        
            }
            
 
    
 
            
            
            if($('#mode').val()!="view"){
            	$("#jqxInvoiceGrid").jqxGrid('disabled', false);
          
            
            if($('#cmbreftype').val()=='JOR' || $('#cmbreftype').val()=='SOR' || $('#cmbreftype').val()=='DEL'){
            var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
    		var summaryData2= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
    		
    		
    		var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
    		var summaryData2= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
    		
    		if(document.getElementById("cmbreftype").value=="JOR")
    			{
    			 
    			//$("#jqxserviceGrid").jqxGrid('addrow', null, {});
    			
    		var summaryData3= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'lbrchg', ['sum'],true);
    		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "nettotal" ,summaryData3.sum.replace(/,/g,''));
    			 
    		 var aa="Fixing Charge";
      		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "description" ,aa);
      		 
      		 
      		 
      		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "acno" ,document.getElementById("fixaccountdoc").value);
      		 
      		 $('#jqxserviceGrid').jqxGrid('setcellvalue', 0, "account" ,document.getElementById("fixaccountname").value);
      		 
      		 
      		 
      		
      		 
      		document.getElementById("nettotal").value=summaryData3.sum.replace(/,/g,'');
      		 
      		 
      		 
      		 
    			}
			
   			document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
  			document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
  			document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
  			 var vals=summaryData.sum.replace(/,/g,'');
  	          
  	          if(parseFloat(document.getElementById("nettotal").value)>0)
  	        	  {
  	          
  	           vals= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
  	        	  }
  	          
  	         // document.getElementById("orderValue").value=vals; 
  	          
  	        funRoundAmt(vals,"orderValue");
  	          
  	   	var summaryData10= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
  	   	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
  	/*  var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value); */
  	   	
  
	 
	  	funRoundAmt4(aa1,"st");
		 funRoundAmt4(aa1,"taxtotal");
		 funcalutax();
            }  
            }
            
            
      		
        	  var count=$('#jqxInvoiceGrid').jqxGrid('getcellvalue',0, "count");
       	         
       	   
       	   
       	   if(parseInt(count)==2)
       		   {
       		   
       		  
       		   $.messager.alert('alert', ' Invoice Not Generated');
       		   
       		  $("#jqxInvoiceGrid").jqxGrid('disabled', true);
       		   }

  			 
            
        });
        
        
function chkbrand()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
     
    	  
    	  $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'brandname');
      
      }
      
       }}
   x.open("GET","checkbrand.jsp?",true);
	x.send();
}


function chktax()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      if(parseInt(items)>0)
       {
    	 
    	  
    	  $('#tax').show();
    	  $('#billname').show();
    	  $('#cmbbilltype').show();
    	  
    	  $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'taxper');
    	  $('#jqxInvoiceGrid').jqxGrid('showcolumn', 'taxamount');
    
    	  
    	  
        }
          else
      {
        	  $('#tax').hide();
        	  $('#billname').hide();
        	  $('#cmbbilltype').hide();
        	  $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'taxper');
        	  $('#jqxInvoiceGrid').jqxGrid('hidecolumn', 'taxamount');
      
      }
      
       }}
   x.open("GET","checktax.jsp?",true);
	x.send();
 
      
        
	
} 
function chkaccount()
{
 
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200)
    {
      var items= x.responseText.trim();
     
      var item = items.split('::');
      
  	/* response.getWriter().print(acno+"::"+account+"::"+description); */
			       
  	document.getElementById("fixaccountdoc").value= item[0];  
				 	
  	document.getElementById("fixaccount").value= item[1];
				
  	document.getElementById("fixaccountname").value= item[2];
       }}
   x.open("GET","getaccountfix.jsp?",true);
	x.send();
 
      
        
	
} 
        
       
</script>
<div id="jqxInvoiceGrid"></div>


<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">

<input type="hidden" id="datas2"><!--  discount set at a time cellvalue change not working; -->
