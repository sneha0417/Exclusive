  <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<% ClsgoodsreceiptnoteDAO searchDAO = new ClsgoodsreceiptnoteDAO(); %> 
 

<%
String purdoc=request.getParameter("purdoc")==null?"0":request.getParameter("purdoc").trim();



String reqdoc=request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String refmasterdoc_no=request.getParameter("refmasterdoc_no")==null?"0":request.getParameter("refmasterdoc_no").trim();

 


%>
  <style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        
        }
</style>


<script type="text/javascript">
var descdata1;
var temp2='<%=chk%>';
var temp='<%=purdoc%>';
if(temp2!='NA')
{

<%--  descdata1='<%=searchDAO.reqgridreload(reqdoc,from)%>';   --%>
 
}


else if(temp>0)
{
 
	<%-- descdata1='<%=searchDAO.maingridreload(purdoc,reftype,refmasterdoc_no)%>';   --%>

}

else
 
{   
	descdata1;

 } 


        $(document).ready(function () { 	
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


         	  var ss= $('#serviecGrid').jqxGrid('getcellvalue', row, "qty");
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
            var source =
            {
                datatype: "json",
                datafields: [  
     						
                      		{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },  
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     					
     						{name : 'nettotal', type: 'number'    },
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
     						{name : 'qutval', type: 'number'    },
     						{name : 'saveqty', type: 'number'    },
     						
     						{name : 'checktype', type: 'number'    },
     						{name : 'pqty', type: 'number'    },
     						
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
                    		 {name : 'specid', type: 'string'  },
                 ],
              
                 localdata: descdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );

            
            
            $("#serviecGrid").jqxGrid(
            {
                width: '99.5%',
                height: 297,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
         //Add row method
                handlekeyboardnavigation: function (event) {
                	
                	
                	
                	

                    var cell4 = $('#serviecGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) {    
  	                	   
  	                	  
  	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	                if(parseInt(rows[0].method)==0)
  	              	  {
  	              	  
  	            		var rows1 = $("#serviecGrid").jqxGrid('getrows');
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
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#serviecGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	               
  	 
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
  	                $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
  	                
  	                
  	                
  	              $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
	                
	                if(document.getElementById("reftype").value=="PO")
	                	{
	            	  $('#datas1').val(0);
	              	$('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty);
	                	
	                  $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "qutval" ,rows[0].qutval);
	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "pqty" ,rows[0].pqty);
	                 $('#serviecGrid').jqxGrid('setcellvalue', rowindex1, "saveqty" ,rows[0].saveqty);
	                 
	                 
	                 
	                 
	         	  $('#datas1').val(1);
	          
	                	
	                	
	                	}
  	                
  	            
  	           $("#serviecGrid").jqxGrid('selectcell',rowindex1, "qty");
  	         
  	        //  $("#serviecGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#serviecGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#serviecGrid").jqxGrid('addrow', null, {});
               	} 
  	        	            } 
  	                   
                    
                    
                    
                    
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
              
            
                   } 
       		 
                	
                	
                	
              /*    var rows = $('#serviecGrid').jqxGrid('getrows');
                  var rowlength= rows.length;
                    var cell = $('#serviecGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'unitprice' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key ==9) {                                                        
                            var commit = $("#serviecGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    } */
                    },
                
                
                columns: [
                
							   { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				
                        	{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '10%',cellclassname: cellclassname,
                          	  
                            	cellbeginedit: function (row) {
                                    if (document.getElementById("reftype").value=="PR")
                             {
                                  return false;
                             }},
                            	
                            	
                            	
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
                           
  							 
							}, 
							{ text: 'Product Name', datafield: 'productname', width: '26%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							}, 
							{ text: 'Unit', datafield: 'unit', width: '10%',cellclassname: cellclassname },
							
						
							{ text: 'Quantity', datafield: 'qty', width: '10%' ,cellsalign: 'left', align:'left',cellclassname: cellclassname,cellsformat:'d2'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '10%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '10%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2' ,cellclassname: cellclassname},
		    				{ text: 'Discount', datafield: 'discount', width: '10%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
							{ text: 'Net Amount', datafield: 'nettotal', width: '10%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'prodoc', datafield: 'prodoc', width: '10%' ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
							{text: 'qutval', datafield: 'qutval', width: '10%' ,cellsformat:'d2' },
							{ text: 'pqty', datafield: 'pqty', width: '9%',cellsformat:'d2'  },
							{text: 'saveqty', datafield: 'saveqty', width: '10%' ,cellsformat:'d2'  },
						 
							{text: 'pid', datafield: 'proid', width: '10%' ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%'  ,hidden:true}, 
							
							 
							{text: 'checktype', datafield: 'checktype', width: '10%'  ,hidden:true},    
							{text: 'specid', datafield: 'specid', width: '10%'  ,hidden:true },
							
				 
						
							
	              ]
            });
           if(temp==0)
        	   {
            $("#serviecGrid").jqxGrid('addrow', null, {});
         
 
         
        	   }
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E'))
   		       {
   		  $("#serviecGrid").jqxGrid({ disabled: false}); 
   		        }
           
           
           var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
  		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
  		  
              document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
         document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
   
  	  
	 var summaryData4= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
  	   document.getElementById("prddiscount").value=summaryData4.sum.replace(/,/g,'');

           $('#serviecGrid').on('cellclick', function (event) {
       	document.getElementById("errormsg").innerText="";
       	
        var rowindex2 = event.args.rowindex;
        var qtyvalidate=$('#serviecGrid').jqxGrid('getcellvalue', rowindex2, "qty");
        
        if(parseInt(qtyvalidate)<=0)
        	{

    		document.getElementById("errormsg").innerText="Quantity Is Zero ";
    		//$('#serviecGrid').jqxGrid({ editable: false}); 
    		return 0;
        	
        	}
        else
        	{
        	document.getElementById("errormsg").innerText="";
        	
        	//$('#serviecGrid').jqxGrid({ editable: true}); 
        	
        	}
       	
        $('#datas').val(0);
    	var columnindex1=event.args.columnindex;

    	
    	  if(columnindex1 == 1)
    		  { 
    		  
      	   /*  	if(document.getElementById("reftype").value=="PO")
        		{
    	    		
    	    		 var rowindextemp = event.args.rowindex;
			    	    document.getElementById("rowindex").value = rowindextemp;  
    	    	 
			    	    var refmasterdoc_no = document.getElementById("refmasterdoc_no").value;  
			    		 reqproductSearchContent('refproductSearch.jsp?refmasterdoc_no='+refmasterdoc_no);
        		}
    	    	else
    	    		{   */
    		  
    	    		 var refmasterdoc_no = document.getElementById("refmasterdoc_no").value;  
    	    	  	 productSearchContent('productSearch.jsp?refmasterdoc_no='+refmasterdoc_no+'&dtype='+document.getElementById("reftype").value);
						    		  
						    		  
						        	  
						    	 var rowindextemp = event.args.rowindex;
						    	    document.getElementById("rowindex").value = rowindextemp;  
						    	    
						   var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
						   
						
						
						   if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
						   { 
						  	 $('#gridtext').val("");  
						  	 $('#part_no').val("");  
						   }
						   else
						  	 {
						  	 
						  	   
						       $('#part_no').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
						       
						       
						       $('#gridtext').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
						       
						       
						       
						      
						       $('#serviecGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
						
						       
						  	 }
    	    		}	    
       
    		   /*  }    */
    	  
    	  
    	if(columnindex1 == 2)
		  { 
    		
/*     	if(document.getElementById("reftype").value=="PO")
    		{
	    		
	    		 var rowindextemp = event.args.rowindex;
		    	    document.getElementById("rowindex").value = rowindextemp;  
		    	    var refmasterdoc_no = document.getElementById("refmasterdoc_no").value;  
	    		 reqproductSearchContent('refproductSearch.jsp?refmasterdoc_no='+refmasterdoc_no);
    		}
	    	else
	    		{  */
 	    		 var refmasterdoc_no = document.getElementById("refmasterdoc_no").value;  
	    	  	 productSearchContent('productSearch.jsp?refmasterdoc_no='+refmasterdoc_no+'&dtype='+document.getElementById("reftype").value);
    		
						  //	 productSearchContent('productSearch.jsp');
							 var rowindextemp = event.args.rowindex;
							    document.getElementById("rowindex").value = rowindextemp;  
							    
							      var temp= $('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
						        
							      
						        // alert(temp);
						         if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
								   { 
						      	   $('#gridtext1').val(""); 
						      	   $('#productname').val("");  
								   }
						         else
						        	 {
							    
						
						      	   $('#productname').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
						      	   
						      	   $('#gridtext1').val($('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
						      	   
						             
						             $('#serviecGrid').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#serviecGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
						
						             
						        	 }
          
	    		}
 
		   /*  }    */
      
        
        
        
        
        
        
        
        
        
           
           });

          /*  $('#serviecGrid').on('celldoubleclick', function (event) {
           	var columnindex1=event.args.columnindex;
           	
           	
           	
            var rowindex2 = event.args.rowindex;
            var qtyvalidate=$('#serviecGrid').jqxGrid('getcellvalue', rowindex2, "qty");
            
            if(parseInt(qtyvalidate)<=0)
            	{

        		document.getElementById("errormsg").innerText="Quantity Is Zero ";

            	$('#serviecGrid').jqxGrid({ editable: false}); 
            	
        		return 0;
            	
            	}
            else
            	{
            	document.getElementById("errormsg").innerText="";
            	$('#serviecGrid').jqxGrid({ editable: true}); 
            	}
           	
           	

             	  if(columnindex1 == 1)
             		  { 
                      
             	 var rowindextemp = event.args.rowindex;
             	    document.getElementById("rowindex").value = rowindextemp;  
             	  $('#serviecGrid').jqxGrid('clearselection');
             	 productSearchContent('productSearch.jsp');
             	
             		  } 
             	  
             	 
             	
             	  
                 });
            */
           function valchange(rowBoundIndex)
           { 
           	
           	var qty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
           	var unitprice=	$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
           	var total=parseFloat(qty)*parseFloat(unitprice);
          		
   		    $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
   		    
   		   var gtotal= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
   	   		var discount=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
   	        		    
   	        		
   	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
   	   		if(discount==""||discount==null||discount=="undefiend")
   	   			{
   	   		  $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
   	   			}
   	   		else{
   	   			$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
   	   		}
   	                    var summaryData1= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
   	        		    var summaryData= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
   	        		  
   	                    document.getElementById("productTotal").value=summaryData1.sum.replace(/,/g,'');
   	               document.getElementById("netTotaldown").value=summaryData.sum.replace(/,/g,'');
   	         
   	        
   	               
	         	  
	         	  
	         	 var summaryData4= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
  	         	   document.getElementById("prddiscount").value=summaryData4.sum.replace(/,/g,'');
	         	   
   	         	/*   if(document.getElementById('chkdiscount').checked) {
   	         		 var summaryData3= $("#serviecGrid").jqxGrid('getcolumnaggregateddata', 'discount', ['sum'],true);
   	         	   document.getElementById("descountVal").value=summaryData3.sum.replace(/,/g,'');
   	         	  } */
   	               
   	          /*      if(document.getElementById("nettotal").value!="" ||document.getElementById("nettotal").value==null || document.getElementById("nettotal").value=="undefiend") 
   	            	   {
   	               
   	            var aa=parseFloat(document.getElementById("netTotaldown").value)+parseFloat(document.getElementById("nettotal").value);
   	            	   }
   	               else
   	            	   { */
   	            //	  var aa=document.getElementById("netTotaldown").value;
   	            	   /* } */
        
                
            	//funRoundAmt(aa,"orderValue");
   	               
   	               
   	            var nettotalval=  $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
          var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                      $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
           }

           $("#serviecGrid").on('cellvaluechanged', function (event) 
           {
        	   
        	
           	var datafield = event.args.datafield;
       		
   		    var rowBoundIndex = event.args.rowindex;
   		    
   		    
   		    

   	   
   	  if(parseInt($('#datas').val())!=1)
   		  {
   	   
   
   	   if(datafield=="productid")
   		   {
   	   
   	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
       $('#sidesearchwndow').jqxWindow('close');
   		   }
   	   
   	   if(datafield=="productname")
   		   {
   		   	$('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
               $('#sidesearchwndow').jqxWindow('close');
   		   
   		   }
   	   
   		  }
   		    
   		   
           		if(datafield=="qty")
           		    {
           			 
           		 	if(parseInt($('#datas1').val())==0) // this for prd search in request not imported case qty not set
           			
           				{
           				return 0;
           				} 
           			
                	if(document.getElementById("reftype").value=="PO")
                		{
                	
            
           			
           			
                		var qutval=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qutval");	
               	        
                      	 
                        var quty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
                     
                        
                        
                        
                        	if(quty>qutval)
                        		{
                        		document.getElementById("errormsg").innerText=" Qty value not more than Actual Qty ";
                        		
                        		
                        		qty=qutval;
                        	   $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",qutval);
                        	  
                        		}
                        	
                        	
                        	
                        	else
                        		{
                        		
                        		qty=$('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");		
                        		}
                 		 
                	
                         	if(($('#mode').val()=='E'))
                    		{ 
                    	
                        	
                   	var rqqty= qty;	
                     	var remqty= $('#serviecGrid').jqxGrid('getcellvalue', rowBoundIndex, "pqty");	
                      	 
                      	 
                     	var blance=parseFloat(rqqty)+parseFloat(remqty); 
                     	
                     	 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",blance);
                    		}
                         	
                         	
                         	else
                         		{  
                         		 $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "saveqty",qty);
                         		  }  
                      
                     	 
                 		
                 		}  
           			
           			
           			
           			
           			
           			
           			
           			valchange(rowBoundIndex);
           		    }  
           		if(datafield=="unitprice")
       		    {
           	  	  /* if(document.getElementById('chkdiscount').checked) {
                		 
             			 
             		 
           	  	  } */
           		if(parseInt($('#datas1').val())==0)
           			
   				{
   				return 0;
   				}
   			
           	  	  
           			valchange(rowBoundIndex);
     
           			
           			
       		    }
           	 /*  if(document.getElementById('chkdiscount').checked) {
           		funcalcu();
           		
           	  }else{ */
		           		if(datafield=="discount")
		       		    {
		           			if(parseInt($('#datas1').val())==0)
		               			
		       				{
		       				return 0;
		       				}
		       			
		           			
		           			valchange(rowBoundIndex);
		  				
		       		    }
           		/* } */
           		 
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
<div id="serviecGrid"></div>
<input type="hidden" id="rowindex">
   <input type="text" id="datas1"/>    <!--  this for prd search in request not imported case qty not set -->

   <input type="text" id="datas"/>     <!--   FOR DOUBLE CLICK   productset cell value block    -->
