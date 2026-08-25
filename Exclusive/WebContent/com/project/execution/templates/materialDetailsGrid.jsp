<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.project.execution.templates.ClsTemplateDAO"%>
<%ClsTemplateDAO DAO= new ClsTemplateDAO();%>
 
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

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
              
</style>

<script type="text/javascript">
var matdata;
$(document).ready(function () {

	matdata='<%=DAO.materialGridLoad(session,docno)%>'; 
 
 var rendererstring2=function (aggregates){
  	var value=aggregates['sum2'];
  	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
  }    



	  var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }
	  
	  var cellclassname = function (row, column, value, data) {
    		/* if (data.qty==0) {
    			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		} */
    		};
 
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
           	 /* var cellclassname =  function (row, column, value, data) {


            	  var ss= $('#jqxDeliveryNote').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		return "yellowClass";
            		  	
            		  		}
            	   

            		} */
           	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
     						{name : 'productid', type: 'string' }, 
     						{name : 'productname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'netotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
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
  	                	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	                if(parseInt(rows[0].method)==0)
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
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxInvoiceGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	               
  	 
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	              $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid ); 
  	              
  	        //  $("#jqxInvoiceGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxInvoiceGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxInvoiceGrid").jqxGrid('addrow', null, {});
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
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							
							{ text: 'Description', datafield: 'desc1', width: '18%',editable:true },
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '8%',cellclassname: cellclassname,
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
{ text: 'Product Name', datafield: 'productname', width: '24%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},
							
							{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },	
							{ text: 'Quantity', datafield: 'qty', width: '7%',cellclassname: cellclassname, cellsformat: 'd2' },
							{ text: 'Amount', datafield: 'amount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							{ text: 'Margin%', datafield: 'margin', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						]
            });
            
            $('#jqxInvoiceGrid').on('cellclick', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 
            	 
            	  if(columnindex1 == 2)
            		  { 
            		 
                	 productSearchContent('productSearch.jsp');
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
            	  
            	  
            	if(columnindex1 == 3)
        		  { 
            		productSearchContent('productSearch.jsp');
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
            		/* var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');  */
            	   }
            
            
            
            $("#jqxInvoiceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    var discount=0;
    		    var margin=0;  
    		    var total=0;
    		    var qty=0;
    		    var amount=0;
    		    var netotal=0;
    		    if(datafield=="qty" || datafield=="amount" || datafield=='margin' )
    		  {
    		    	
    		    	 qty= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	     amount= $('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               	    total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
     			    margin=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
     			 
     			   if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
   	       		   {
   	                		
   		    		 margin=0;
   	              	    
   	       		   }
    		    	
    		    	
 
    		    	if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN" || amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN"))
           		   {
    		    		total=parseFloat(qty)*parseFloat(amount);
    		    		netotal=total;
    		    		discount=(parseFloat(total)*parseFloat(margin))/100;
            			netotal=parseFloat(total)+parseFloat(discount);
            			 
             			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
           		   }
    		    	
    		    	
    		  
    		  }
    		    
    		    /* if(datafield=='margin' ){
    		    	
    		    	total=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
        			 margin=$('#jqxInvoiceGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
        			 
        			 if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
  	       		   {
  	                		
  		    		 margin=0;
  	              	    
  	       		   }
        			 
        			 discount=(parseFloat(total)*parseFloat(margin))/100;
        			 netotal=parseFloat(total)+parseFloat(discount);
        			 $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
        			//$('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
        			
        		} */
    		     
    		   // $('#jqxInvoiceGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
    		    
    		    var summaryData1= $("#jqxInvoiceGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
        		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
        		
        		
        		 var txtmatotal=document.getElementById("txtmatotal").value;
           		 var txtlabtotal=document.getElementById("txtlabtotal").value;
           		 var txteqptotal=document.getElementById("txteqptotal").value;
           		 var grtotal=(parseFloat(txtmatotal)+parseFloat(txtlabtotal)+parseFloat(txteqptotal));
           		 document.getElementById("txtnettotal").value=grtotal;
    		    
            	
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
            
            if($('#mode').val()!="view"){
            	$("#jqxInvoiceGrid").jqxGrid('disabled', false);
            }
            
            
         
        });
</script>
<div id="jqxInvoiceGrid"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
