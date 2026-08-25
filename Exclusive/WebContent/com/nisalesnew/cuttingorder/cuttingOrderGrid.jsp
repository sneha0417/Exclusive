 <%@page import="com.nisalesnew.cuttingorder.ClsCuttingOrderDAO"%>
<% ClsCuttingOrderDAO  ClsCuttingOrderDAO = new ClsCuttingOrderDAO();

String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");

 

%>
       <script type="text/javascript">
  
			 var data1= '<%=ClsCuttingOrderDAO.reload(docno)%>';

$(document).ready(function () {
	var list1 =['YES','NO'];
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
     
	
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'productid', type: 'String'  },
						{name : 'productname', type: 'string'  },
						{name : 'floor', type: 'String'  },
						{name : 'flatids',type:'number'},
						
						{name : 'width',type:'number'},
						{name : 'height',type:'number'},
						
						{name : 'quantity', type: 'number'  },
						{name : 'sqm', type: 'String'  },
						{name : 'totsize', type: 'number'  },
						{name : 'price', type: 'number'},
						{name : 'bevcode', type: 'String'},
						{name : 'bevrate', type: 'number'  },
					
						{name : 'bevvalue', type: 'number'  },
						{name : 'polcode', type: 'string'  },
						
	
						{name : 'polrate', type: 'number'},
						{name : 'polcharge', type: 'number'},
						{name : 'temp', type: 'String'},
						{name : 'amount', type: 'number'  },
						
						
						{name : 'psrno', type: 'string'  },
						{name : 'unit', type: 'string'  },
						{name : 'unitdocno', type: 'string'  },
						{name : 'specid', type: 'string'  },
						
						{name : 'proid', type: 'string'  },
						{name : 'proname', type: 'string'  },
						
						{name : 'bevcodename', type: 'string'  },
						{name : 'polcodename', type: 'string'  },
						
						
						  
						
						
						
					 
						
					
						
						],
				    localdata: data1,
        
        
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
    
    
   
   
    
    $("#cuttingOrderGridID").jqxGrid(
    {
        width: '100%',
        height: 300,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 21,
        selectionmode: 'singlecell',
        pagermode: 'default',
        disabled:true,
        editable:true ,
        columnsresize:true,
        
        handlekeyboardnavigation: function (event) {
     	   

        	 

          
     			 var cell1 = $('#cuttingOrderGridID').jqxGrid('getselectedcell');
     		
     			 
             	 if (cell1 != undefined && cell1.datafield == 'bevcodename') {  
             		 
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                  	    document.getElementById("rowindex").value = cell1.rowindex;   
                  	  $('#cuttingOrderGridID').jqxGrid('clearselection');
                    	codeinfoSearchContent('bsearchcode.jsp?name=1');
                      	
      				           }
                     
                     
                     }
     			 
	 if (cell1 != undefined && cell1.datafield == 'polcodename') {  
             		 
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                  	    document.getElementById("rowindex").value = cell1.rowindex;   
                      	  $('#cuttingOrderGridID').jqxGrid('clearselection');
                      	  
                       	codeinfoSearchContent('bsearchcode.jsp?name=2');
                      	
      				           }
                     
                     
                     }
     			  
       	
        	
     		  
                  var cell4 = $('#cuttingOrderGridID').jqxGrid('getselectedcell');
                 
                  
                  if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname'  )) 
                  
                 {	 
                 	 document.getElementById("errormsg").innerText="";	 
                 
                 	 
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
	                       
                 
	/*              	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	                	  
	                	  
	                   var prodocs=rows[0].doc_no;
	                
	                if(parseInt(rows[0].method)==0)
	              	  {
	              	  
	            		var rows1 = $("#cuttingOrderGridID").jqxGrid('getrows');
	          	    var aa=0;
	          	    for(var i=0;i<rows1.length;i++){
	  
	          	  
	   	          	  
	   	          		   if(parseInt(rows1[i].prodoc)==parseInt(prodocs))
	   	          			   {
	   	          			  
	   	         		   var munit=rows[0].munit;
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
	          		  $('#sidesearchwndow').jqxWindow('close'); 
	          		   return 0;
	          		  
	          		   
	          		   }
	          	   else
	          		   {
	          		   
	          		   document.getElementById("errormsg").innerText="";
	          		   }
	          	   
	            	  
	            	  }
	                	  
	                	   */
	                	  
	     
	                	  
	                	   
	               	 var rows = $("#prosearch").jqxGrid('getrows');
	  		    
	                	
	                	   $('#cuttingOrderGridID').jqxGrid('render');
	              	  var rowindex1 =$('#rowindex').val();
	               $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
	            
	               $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
	             
	 
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
	              
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
	                $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
	          
	             $('#sidesearchwndow').jqxWindow('close'); 
	                	   
	          var rows = $('#cuttingOrderGridID').jqxGrid('getrows');
             var rowlength= rows.length;
             if(rowindex1 == rowlength - 1)
             	{  
             $("#cuttingOrderGridID").jqxGrid('addrow', null, {});
             	} 
             
             
             $("#cuttingOrderGridID").jqxGrid('ensurerowvisible', rowlength);
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
                  
                
					
           	         { text: 'SL No', sortable: false, filterable: true, editable: false,
                              groupable: false, draggable: true, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							}, 
					 /* { text: 'Product ID', datafield: 'productid', width: '10%'},
					 { text: 'Product Name', datafield: 'productname', width: '15%'}, */
						{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '15%',
                   	  
						    createeditor: function (row, cellvalue, editor, cellText, width, height) {
						     
						         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
						   
						        
						    },  
						 
                    
						
						},
						{ text: 'Product Name', datafield: 'productname',columntype: 'custom',
							
							createeditor: function (row, cellvalue, editor, cellText, width, height) {
						       
						         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
						     
						        
						    },  
						},
					 { text: 'Psrno', datafield: 'psrno', width: '5%' ,hidden:true},
					 
					 { text: 'Unit', datafield: 'unit', width: '5%',hidden:true },
					 { text: 'unitdocno', datafield: 'unitdocno', width: '5%' ,hidden:true},
					 { text: 'specid', datafield: 'specid', width: '5%',hidden:true },
				 
					 { text: 'Floor', datafield: 'floor', width: '6%',hidden:true},
					 
					 { text: 'Flat', datafield: 'flatids', width: '6%',hidden:true},
					 {text: 'Width(mm)', datafield: 'width', width: '6%', cellsformat:'d4'},
					 
				     { text: 'Height(mm)',datafield: 'height', width: '6%', cellsformat:'d4' }, 
				    
				     
				     { text: 'Quantity',datafield: 'quantity', width: '6%' , cellsformat:'d2'},
					/*  { text: 'SQM', datafield: 'sqm', width: '6%',aggregates: ['sum'],aggregatesrenderer:rendererstring1  }, */
					 
					 
					 { text: 'SQM',  datafield: 'sqm',  width: '10%',hidden:true,cellsalign: 'center',aggregatesrenderer:rendererstring1 ,align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
	                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list1 });
	                        
						
						}

					
	                         },
					 
					 { text: 'Tot Size', datafield: 'totsize',hidden:true, width: '6%', cellsformat:'d4', cellsalign:'right', align:'right',editable:false  },
					 { text: 'Price', datafield: 'price', width: '7%', cellsformat:'d4', cellsalign:'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 { text: 'Bevelling Code',hidden:true, datafield: 'bevcodename', width: '6%',editable:false },
					 { text: '  Code2',hidden:true, datafield: 'bevcode', width: '6%',hidden:true },
					 { text: 'Bev. Rate',hidden:true, datafield: 'bevrate', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right'},
					 { text: 'Bev. Value',hidden:true, datafield: 'bevvalue', width: '5%' ,cellsformat:'d2', cellsalign:'right', align:'right',editable:false},
					 { text: 'Polishing Code',hidden:true, datafield: 'polcodename', width: '6%',editable:false },
					 { text: '  Code1,hidden:true', datafield: 'polcode', width: '6%',hidden:true},
					 { text: 'Pol Rate',hidden:true, datafield: 'polrate', width: '4%', cellsformat:'d2', cellsalign:'right', align:'right'},
					 { text: 'Pol Charge',hidden:true, datafield: 'polcharge', width: '5%', cellsformat:'d2', cellsalign:'right', align:'right',editable:false},
					 { text: 'Temp',hidden:true, datafield: 'temp', width: '5%'},
					 { text: 'Amount', datafield: 'amount',editable:false, width: '8%', cellsformat:'d4', cellsalign:'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 
					 {text: 'proid', datafield: 'proid', width: '5%',hidden:true },
					 { text: 'proname', datafield: 'proname', width: '5%' ,hidden:true},
					 
					 
 
					 
					]
   
    });
    
    if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    	
    	  $("#cuttingOrderGridID").jqxGrid({ disabled: false});
    	
    }
    
    
 
	
	 $('#cuttingOrderGridID').on('cellclick', function (event) {
		 
		 
			var df=event.args.datafield;

			  
      	  if(df == "bevcodename") 
      		  { 
      		 
		 	 
      		 var rowindextemp = event.args.rowindex;
      	    document.getElementById("rowindex").value = rowindextemp;   
      	  $('#cuttingOrderGridID').jqxGrid('clearselection');
      	codeinfoSearchContent('bsearchcode.jsp?name=1');
		
			}
      	  
      	  
      	  if(df=="polcodename")
      		  {
      		  
      		 var rowindextemp = event.args.rowindex;
     	    document.getElementById("rowindex").value = rowindextemp;   
     	  $('#cuttingOrderGridID').jqxGrid('clearselection');
     	codeinfoSearchContent('psearchcode.jsp?name=2');
      		  
      		  }
		 
		 
		 
      		  
	 });
	
    
    
    
    
    $('#cuttingOrderGridID').on('cellbeginedit', function (event) {
   	 
   	 
    	
    	var columnindex1=event.args.columnindex;
    	$('#datas').val(0);

    	
    	var df=event.args.datafield;

     
    	  if(df == "productid")
    		  { 
    		   
          	 productSearchContent('productSearch.jsp?id=search');
      	 var rowindextemp = event.args.rowindex;
      	    document.getElementById("rowindex").value = rowindextemp;  
      	    
     var temp= $('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "productid"); 
  
     if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
	   { 
    	 $('#gridtext').val("");  
    	 $('#part_no').val("");  
    	 
	   }
     else
    	 {
    	 
    	   
         $('#part_no').val($('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
         
         
         $('#gridtext').val($('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));
         
         
         
        
         $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proid"));

         
    	 }
      
         
      		  } 
      	  
      if(df == "productname")
  		  { 
    	  if(document.getElementById("errormsg").innerText!="")
 		 {
    		   
 		 return 0;
 		 }
    	  productSearchContent('productSearch.jsp?id=search');
	 var rowindextemp = event.args.rowindex;
	    document.getElementById("rowindex").value = rowindextemp;  
	    
	      var temp= $('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "productname"); 
          
	      
          // alert(temp);
           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
		   { 
        	   $('#gridtext1').val(""); 
        	   $('#productname').val("");  
		   }
           else
          	 {
	    

        	   $('#productname').val($('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
        	   
        	   $('#gridtext1').val($('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));
        	   
               
               $('#cuttingOrderGridID').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowindextemp, "proname"));

               
          	 }
            

   
		  } 
        
       
      	 
          });
    
    
    
    $("#cuttingOrderGridID").on('cellvaluechanged', function (event) {
    	
    	   var rowBoundIndex = event.args.rowindex;
    	   var datafield = event.args.datafield;
    	   
    	  if(parseInt($('#datas').val())!=1)
    		  {
    	   
     
    	   if(datafield=="productid")
    		   {
    	   
    	$('#cuttingOrderGridID').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
        $('#sidesearchwndow').jqxWindow('close');
    		   }
    	   
    	   if(datafield=="productname")
    		   {
    		   	$('#cuttingOrderGridID').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                $('#sidesearchwndow').jqxWindow('close');
    		   
    		   }
    		  
    	   
    		  }
 
    	  
    	  if(datafield=="quantity" ||  datafield=="price")
    		  {
    		  calculatedatagrid(rowBoundIndex);
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
   
    
    
     $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#cuttingOrderGridID").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#cuttingOrderGridID").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#cuttingOrderGridID").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#cuttingOrderGridID").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#cuttingOrderGridID").jqxGrid('getrowid', rowindex);
               $("#cuttingOrderGridID").jqxGrid('deleterow', rowid);
           }
       });
       
       $("#cuttingOrderGridID").on('rowclick', function (event) {
           if (event.args.rightclick) {
		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"  ){
               $("#cuttingOrderGridID").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
		   }
       });

 

    
   
    
  
});

/* function calculatedatagrid(rowBoundIndex)
{

		var width=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "width");
		var height=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "height");
		var quantity=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "quantity");
		if(width=="" || width==null || width==0 ||typeof(width)=="undefined"|| typeof(width)=="NaN")
		{
			width=0;
		}
		else 
			{
			width=width/1000;
			}
		if(height=="" || height==null || height==0 ||typeof(height)=="undefined"|| typeof(height)=="NaN")
		{
			height=0;
		}
		else
			{
			height=height/1000;
			}
		if(quantity=="" || quantity==null || quantity==0 ||typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
		{
			quantity=0;
		}
		
		if(quantity==0 )
			{
			price=0;
			}
		else
			{
			price=((width*height)*quantity);
			}
		$('#cuttingOrderGridID').jqxGrid('setcellvalue', rowBoundIndex, "price" ,price.toFixed(4));
}
 */
function calculatedatagrid(rowBoundIndex)
{
	var width=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "width");
	var height=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "height");
	var quantity=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "quantity");
	
	var price=$('#cuttingOrderGridID').jqxGrid('getcellvalue', rowBoundIndex, "price");
 
	if(width=="" || width==null || width==0 ||typeof(width)=="undefined"|| typeof(width)=="NaN")
	{
		width=0;
	}
	 
	if(height=="" || height==null || height==0 || typeof(height)=="undefined"|| typeof(height)=="NaN")
	{
		height=0;
	}
 
		 
	if(quantity=="" || quantity==null || quantity==0 || typeof(quantity)=="undefined"|| typeof(quantity)=="NaN")
	{
		quantity=0;
	}
	
 
	
 
	
	if(price=="" || price==null || price==0 || typeof(price)=="undefined"|| typeof(price)=="NaN")
	{
		price=0;
	}
	else
		{ 
		 
			
			$('#cuttingOrderGridID').jqxGrid('setcellvalue', rowBoundIndex, "amount",(parseFloat(price)*parseFloat(quantity)));
		 }
		 
		
		 
	 
	
	
	
	 
	 
}

</script>
 <div id='jqxWidget'>
    
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
   </div>
  <input type="hidden" id="datas"/> 
    <input type="hidden" id="rowindex"/> 
  
  
<div id="cuttingOrderGridID"></div>