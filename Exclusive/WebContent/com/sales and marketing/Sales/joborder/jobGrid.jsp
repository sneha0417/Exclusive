<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>

<% 

String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

 


 
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
 
var temp='<%=docno%>';
 

 if(temp>0)
{
	
	qotgriddata='<%=DAO.prdGridReload(session,docno)%>';  
	


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
     						{name : 'fixing', type: 'bool'  },
     					   
     					   
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            		
            		
         		
            		
/* 
            	  $("#jqxInvoiceGrid").on("bindingcomplete", function (event) { 
            			
            			
            			 
                        	
                       	 
                  		var rows1 = $("#jqxInvoiceGrid").jqxGrid('getrows');
                  		
                  	  var count=$('#jqxInvoiceGrid').jqxGrid('getcellvalue',0, "count");
                 	         
                 	   
                 	   
                 	   if(parseInt(count)==2)
                 		   {
                 		   
                 		  
                 		   $.messager.alert('alert', ' Products contains different locations');
                 		   
                 		  $("#jqxInvoiceGrid").jqxGrid('disabled', true);
                 		   }
            
            			
            			
            		});    
            		  */
            	 
            		
            		
            		
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInvoiceGrid").jqxGrid(
            {
                width: '99.5%',
                height: 350,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                
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
  	          	   
  	            	  
  	                	  
  	           
  	            	 
  	                	
         		  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxInvoiceGrid').jqxGrid('render'); 
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	             
  	                
  	             
  	 
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	                
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno); 
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,1 );
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid);
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty);
  	          $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice );
  	          
  	        $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "locid" ,rows[0].locid );
  	          
 
  	        
  	 
  	       
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
							
							{ text: 'Unit', datafield: 'unit', width: '6%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '10%',cellclassname: cellclassname },
							
							
							{ text: 'Fixing', datafield: 'fixing',columntype: 'checkbox', editable: true,  width: '10%',cellsalign: 'center', align: 'center'
							},
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname,hidden:true  },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'FOC', datafield: 'foc', width: '7%',cellclassname: cellclassname,hidden:true },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true  },
							{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true  },
							{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true  },
							{ text: 'allowdiscount', datafield: 'allowdiscount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true },
							
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true },
							{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true },
							{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true },
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
							
							
						]
            });
            
            
            
        	if ($("#mode").val() == "A") {
    			
    			
     
    			$("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
    		 
    			
    			
    			
    		}
            
            
            if(($("#mode").val()=='view'))
        	{
        	$("#jqxInvoiceGrid").jqxGrid({ disabled: true}); 
        	}
            else
            	{
            	$("#jqxInvoiceGrid").jqxGrid({ disabled: false}); 
            	}
      
          	 $('#jqxInvoiceGrid').on('cellclick', function (event) {
    			 
    			 document.getElementById("errormsg").innerText="";	 
    			 
    		 }); 
            $('#jqxInvoiceGrid').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 
            		var df=event.args.datafield;

                    
               	  if(df == "productid")
               		  { 
               		  
              		var clientid=document.getElementById("clientid").value;
              		if(clientid==""){
            			document.getElementById("errormsg").innerText="Select a Customer";
            			
            			return 0;
            		}
              		
 
               		 
                	 productSearchContent('productSearch.jsp?');
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
      		if(clientid==""){
    			document.getElementById("errormsg").innerText="Select a Customer";
    			
    			return 0;
    		}
      		
      		
   
          	  productSearchContent('productSearch.jsp?');
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
            	 
            	 qty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
 
            	
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
       
			             	if($('#mode').val()=="E"){
			             		totqty=totqty+oldqty;
			              
			             		
			             		
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
						             	else if($('#mode').val()=="A"){
			             		
			             	 
			             		
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
            	 }
  
            			
          		   
            		
            	}
            	
            	
            	
             
            	
            	
   
            
            
            
            $("#jqxInvoiceGrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		            	   
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
            	  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice'){	   
            	  
           			valchange(rowBoundIndex,datafield);
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
        
       
</script>
<div id="jqxInvoiceGrid"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
