
<%@page import="com.procurement.purchase.purchaserequest.ClsPurchaserequestDAO"%>
<% ClsPurchaserequestDAO  PurchaserequestDAO = new ClsPurchaserequestDAO(); %> 
 <%
           	String reqdoc = request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();
 
 String prcharrays=request.getParameter("prcharray")==null?"0":request.getParameter("prcharray");
 String modebprfs=request.getParameter("modebprf")==null?"0":request.getParameter("modebprf");
   
 System.out.println("prcharraysGrid==="+prcharrays);
   %> 
<script type="text/javascript">


	
var prcharray='<%=prcharrays.replaceAll("a@b@c"," ")%>';
var modebprf='<%=modebprfs%>';

        	
var vahreqdata;
           	  
           	  
           	var temp1='<%=reqdoc%>';
            var hide;
            if(temp1>0) 
            
          	 {
            	 vahreqdata= '<%=PurchaserequestDAO.maingridreload(reqdoc)%>';
          	     hide=2; 
          	 } 
            else
          	 { 
            	 vahreqdata;
            	
          
          	 } 
   
        $(document).ready(function () { 	 
        	chkbrand();
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
                         	{name : 'productid', type: 'string'    },
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						
     						{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     				     	{name : 'proid', type: 'string'    },
                    		{name : 'proname', type: 'string'    },
     				 
                    		 {name : 'specid', type: 'string'},
                    		 
                    		 {name : 'brandname', type: 'string'},
                    		 
                    		 
                    		 
     											
                 ],
                 localdata: vahreqdata,
                
                
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

            
            

            
            $("#purchasedetails").jqxGrid(
            {
                width: '100%',
                height: 352,
                source: dataAdapter,
                disabled:true,
                editable:true ,
        
             //   editmode: 'click',
                
                selectionmode: 'singlecell',
                pagermode: 'default',
                
          
               handlekeyboardnavigation: function (event) {
            	   
    
	        		  
	                     var cell4 = $('#purchasedetails').jqxGrid('getselectedcell');
	                    
	                     
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
		                       
                        
	   	             	   
	 	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	   	                	  
	   	                	  
	   	                   var prodocs=rows[0].doc_no;
	   	                
	   	                if(parseInt(rows[0].method)==0)
	   	              	  {
	   	              	  
	   	            		var rows1 = $("#purchasedetails").jqxGrid('getrows');
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
	   	                	  
	   	                	  
	   	                	  
	   	     
	   	                	  
	   	                	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');
	   	  		    
	   	                	
	   	                	   $('#purchasedetails').jqxGrid('render');
	   	              	  var rowindex1 =$('#rowindex').val();
	   	               $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
	   	            
	   	            $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
	   	            
	   	             $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
	   	               
	   	            
	   	         
	   	 
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].munit);
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno );
	   	                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
	   	          // $("#purchasedetails").jqxGrid('selectcell',rowindex1, "unit");
	   	         
	   	        //  $("#purchasedetails").jqxGrid('begincelledit', rowindex1, 'qty');
	   	             $('#sidesearchwndow').jqxWindow('close'); 
	   	                	   
	   	          var rows = $('#purchasedetails').jqxGrid('getrows');
	                var rowlength= rows.length;
	                if(rowindex1 == rowlength - 1)
	                	{  
	                $("#purchasedetails").jqxGrid('addrow', null, {});
	                	} 
	                
	                
	                $("#purchasedetails").jqxGrid('ensurerowvisible', rowlength);
	   	        	            } 
	   	                   
	            
	                     
	   	               if (key != 13) {          
	   	            	
					                 if (cell4 != undefined && cell4.datafield == 'productid') 
					                 {
					                	 if(parseInt(document.getElementById("productchk").value)==0){					        
						        		   document.getElementById("gridtext").focus();
					                      }
					                 }
					                 if (cell4 != undefined && cell4.datafield == 'productname') {
					         	        
					                	 if(parseInt(document.getElementById("productchk").value)==0){
						        		   document.getElementById("gridtext1").focus();
					                	 }
						        		 
					               }
						               
	   	               }
	                         } 
	        		 
              
                    }, 
               
          
            		
                columns: [
							 	
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                                groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                                datafield: 'sl', columntype: 'number', width: '6%',
                                cellsrenderer: function (row, column, value) {
                                    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                                }  
                              },
  				
  							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '15%',
                            	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
                           
  							
  							},
  							{ text: 'Product Name', datafield: 'productname',columntype: 'custom' ,
  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
  							},
  							
  							{text: 'Brand Name', datafield: 'brandname', width: '15%' , editable:false  },
  							{ text: 'Unit', datafield: 'unit', width: '10%', editable:false	},
  							{ text: 'Quantity', datafield: 'qty', width: '24%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
  							
  							{text: 'pid', datafield: 'proid', width: '10%'  ,hidden:true  }, 
  							{text: 'pname', datafield: 'proname', width: '10%' ,hidden:true },  
  							
  							{text: 'prodoc', datafield: 'prodoc', width: '5%'   ,hidden:true}, 
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',hidden:true  },
							{text: 'psrno', datafield: 'psrno', width: '10%',hidden:true },
					 
							
							{text: 'specid', datafield: 'specid', width: '10%' ,hidden:true },
							
							
							 
			              ]
               
            });
         
            $("#purchasedetails").jqxGrid('addrow', null, {});

    		if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    			
    			$("#purchasedetails").jqxGrid({ disabled: false});
    			
    		}
                    

   		 $('#purchasedetails').on('celldoubleclick', function (event) {
   			 

         	 
         	$('#datas').val(0);

         	
         	var df=event.args.datafield;

          
         	  if(df == "productid")
         		  { 
         		 
         		  if(parseInt(document.getElementById("productchk").value)==1)
         			  {
         			 
         			 $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',false);
                	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',false);
               	 productSearchContent('productMasterSearch.jsp');
         			  }
         	
           	 var rowindextemp = event.args.rowindex;
           	    document.getElementById("rowindex").value = rowindextemp;  
           	    
          var temp= $('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "productid"); 
          

       
          if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
		   { 
         	 $('#gridtext').val("");  
         	 $('#part_no').val("");  
         	 
		   }
          else
         	 {
         	 
         	   
              $('#part_no').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
              
              
              $('#gridtext').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
              
              
              
             
              $('#purchasedetails').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
  
              
         	 }
           
              
           		  } 
           	  
           if(df == "productname")
       		  { 
         	  if(document.getElementById("errormsg").innerText!="")
      		 {
         		   
      		 return 0;
      		 }
         	  if(parseInt(document.getElementById("productchk").value)==1)
 			  {
         		 $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',false);
           	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',false);
       	 productSearchContent('productMasterSearch.jsp');
 			  }
 		  
     	 var rowindextemp = event.args.rowindex;
     	    document.getElementById("rowindex").value = rowindextemp;  
     	    
     	      var temp= $('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "productname"); 
               
     	      
               // alert(temp);
                if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
     		   { 
             	   $('#gridtext1').val(""); 
             	   $('#productname').val("");  
     		   }
                else
               	 {
     	    
   
             	   $('#productname').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
             	   
             	   $('#gridtext1').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
             	   
                    
                    $('#purchasedetails').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
    
                    
               	 }
                 
     
        
     		  } 
             
   			 
   		 });
    		
    		
    		 $('#purchasedetails').on('cellclick', function (event) {
    			 
    			 document.getElementById("errormsg").innerText="";	 
    				var df=event.args.datafield;

  				  
               	  if(df == "unit")
               		  { 
               		 
  			 if(parseInt(document.getElementById("multimethod").value)==1)
					{	 
  			 
  			 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;   
         	  $('#purchasedetails').jqxGrid('clearselection');
        	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "psrno")+
        			"&mode="+document.getElementById("mode").value);
					}
  			 
  			 
  			 
               		  }
    		 });
    		
            $('#purchasedetails').on('cellbeginedit', function (event) {
            	 
            	 
            	
            	var columnindex1=event.args.columnindex;
            	$('#datas').val(0);

            	
            	var df=event.args.datafield;

             
            	  if(df == "productid")
            		  { 
            		  if(parseInt(document.getElementById("productchk").value)==0)
            			  {
            			  $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',true);
                  	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',true);
            			  productSearchContent('productSearch.jsp');
            			  }
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	    
             var temp= $('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "productid"); 
             
   
          
             if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
  		   { 
            	 $('#gridtext').val("");  
            	 $('#part_no').val("");  
            	 
  		   }
             else
            	 {
            	 
            	   
                 $('#part_no').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
                 
                 
                 $('#gridtext').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
                 
                 
                 
                
                 $('#purchasedetails').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proid"));
     
                 
            	 }
              
                 
              		  } 
              	  
              if(df == "productname")
          		  { 
            	  if(document.getElementById("errormsg").innerText!="")
         		 {
            		   
         		 return 0;
         		 }
            	  if(parseInt(document.getElementById("productchk").value)==0)
    			  {
            		  $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',true);
              	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',true);
    			  productSearchContent('productSearch.jsp');
    			  }
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                  
        	      
                  // alert(temp);
                   if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
                	   $('#gridtext1').val(""); 
                	   $('#productname').val("");  
        		   }
                   else
                  	 {
        	    
      
                	   $('#productname').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
                	   
                	   $('#gridtext1').val($('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
                	   
                       
                       $('#purchasedetails').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#purchasedetails').jqxGrid('getcellvalue', rowindextemp, "proname"));
       
                       
                  	 }
                    
        
           
        		  } 
                
               	
               	
               	
               	
               	
               	
               	
               	
               	
               	
              	 
                  });
            
            
            
            $("#purchasedetails").on('cellvaluechanged', function (event) {
            	
            	   var rowBoundIndex = event.args.rowindex;
            	   var datafield = event.args.datafield;
            	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            	   
            		  if(modebprf!="a1"){
            	   if(datafield=="productid")
            		   {
            	   
            	$('#purchasedetails').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#purchasedetails').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
               // $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#purchasedetails').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#purchasedetails').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                      //  $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            		  }
            	   
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
           
            
            
         /*     $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#purchasedetails").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#purchasedetails").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#purchasedetails").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#purchasedetails").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#purchasedetails").jqxGrid('getrowid', rowindex);
                       $("#purchasedetails").jqxGrid('deleterow', rowid);
                   }
               });
               
               $("#purchasedetails").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#purchasedetails").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
        		   }
               });

 */

            
           
    
        
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
    	     
    	    	  
    	    	  $('#purchasedetails').jqxGrid('showcolumn', 'brandname');
    	    
    	    	  
    	    	  
    	        }
    	          else
    	      {
    	      
    	        	  $('#purchasedetails').jqxGrid('hidecolumn', 'brandname');
    	      
    	      }
    	      
    	       }}
    	   x.open("GET","checkbrand.jsp?",true);
    		x.send();
    	 
    	      
    	        
        	
        }
    	   
        	 
        if(modebprf=="a1")
    	{
        	
    	  var splt=prcharray.split(",");
    	 
    	 for(var i=0;i<splt.length;i++)
    	 {
    		 var data=splt[i].split("::");
    		 
    		 var rowno=data[0].trim()=="undefined" || data[0].trim()=="NaN" || data[0].trim()==""|| data[0]==null?"0":data[0].trim();
		
    		var productid=data[1].trim()=="undefined" || data[1].trim()=="NaN" || data[1].trim()==""|| data[1]==null?"0":data[1].trim();
    		
    		var productname=data[2].trim()=="undefined" || data[2].trim()=="NaN" || data[2].trim()==""|| data[2]==null?"0":data[2].trim();
				var prodoc=data[3].trim()=="undefined" || data[3].trim()=="NaN" || data[3].trim()==""|| data[3]==null?"0":data[3].trim();
				var brandname=data[4].trim()=="undefined" || data[4].trim()=="NaN" || data[4].trim()==""|| data[4]==null?"0":data[4].trim();
				var unit=data[5].trim()=="undefined" || data[5].trim()=="NaN" || data[5].trim()==""|| data[5]==null?"0":data[5].trim();
				var unitdocno=data[6].trim()=="undefined" || data[6].trim()=="NaN" || data[6].trim()==""|| data[6]==null?"0":data[6].trim();
				var psrno=data[7].trim()=="undefined" || data[7].trim()=="NaN" || data[7].trim()==""|| data[7]==null?"0":data[7].trim();
				var specid=data[8].trim()=="undefined" || data[8].trim()=="NaN" || data[8].trim()==""|| data[8]==null?"0":data[8].trim();
				var purqty=data[9].trim()=="undefined" || data[9].trim()=="NaN" || data[9].trim()==""|| data[9]==null?"0":data[9].trim();
				 $("#purchasedetails").jqxGrid('addrow', null, {});
          	   $('#purchasedetails').jqxGrid('setcellvalue', i, "productid" ,productid);
          	    $('#purchasedetails').jqxGrid('setcellvalue', i, "productname" ,productname);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "brandname" ,brandname);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "unit" ,unit);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "qty" ,purqty);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "prodoc" ,prodoc);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "unitdocno" ,unitdocno);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "psrno" ,psrno);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "proid" ,productid);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "proname" ,productname);
                $('#purchasedetails').jqxGrid('setcellvalue', i, "specid" ,specid);
    	 }
    	 
    	}
 	 
        function chkproductconfig()
        {
        	
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
             
              if(parseInt(items)>0)
               {
            	   document.getElementById("productchk").value=1;
            	 
            	     $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',false);
            	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',false);
            	   		
            	   } 
                
                  else
              {
                	   document.getElementById("productchk").value=0; 
                	   $('#purchasedetails').jqxGrid('setcolumnproperty','productid','editable',true);
               	   	$('#purchasedetails').jqxGrid('setcolumnproperty','productname','editable',true);
              }
              
               }}
           x.open("GET","checkproductconfig.jsp?",true);
        	x.send();

        	
        } 
    </script>
    <div id="purchasedetails"></div>
     <!-- <div id='jqxWidget'>
   <div id="purchasedetails"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div -->
  
 <!--    <div id="purchasedetails"></div> -->
  <input type="hidden" id="rowindex"/> 
   <input type="hidden" id="datas"/>     <!--   FOR DOUBLE CLICK -->
   
   
   
  