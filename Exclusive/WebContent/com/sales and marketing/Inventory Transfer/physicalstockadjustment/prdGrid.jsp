<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.sales.InventoryTransfer.physicalstockadjustment.ClsphysicalStockadjustmentDAO"%>
<%ClsphysicalStockadjustmentDAO DAO= new ClsphysicalStockadjustmentDAO();%>
 
 
<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String locationid=request.getParameter("locationid")==null?"0":request.getParameter("locationid").trim();
 

//System.out.println("=================qotdoc============"+qotdoc);

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
var temp2='<%=enqdoc%>';
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

  if(cond=="1")
 {
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,locationid)%>';  

 } 
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,locationid,reftype)%>';  

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
    			//document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		}
    		
         	  var ss= $('#jqxstkAdjustment').jqxGrid('getcellvalue', row, "qty");
	          if(parseInt(ss)<=0)
	  		{
	  		
	  		return "redClass";
	  	
	  		}
    		
    		};
 
var rendererstring=function (aggregates){
	var value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
}
 
             $('#gridtext0').keyup(function(){
             	

 			      $("#prosearch").jqxGrid('clearfilters');
     		  
           
               $('#doc_no').val($(this).val());
               var dataField = "doc_no";
    		   applyFilter(dataField,$(this).val());  
               
               
               
           });            
             
 
 
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


            	  var ss= $('#jqxstkAdjustment').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		return "yellowClass";
            		  	
            		  		}
            	   

            		} */
           	 
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
                    		{name : 'prodoc', type: 'string'    },
                    		{name : 'specid', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'stkid', type: 'number'    },
     						{name : 'ordout_qty', type: 'number'    }, 
     						
     						{name : 'valorderqty', type: 'number'    }, 
     						
     						{name : 'totalorderqty', type: 'number'    }, 
     						
     						{name : 'brandname', type: 'string'    }, 
     						
     						
     						{name : 'phy_qty', type: 'number'    }, 
     						{name : 'adj_qty', type: 'number'    }, 
     						
     						{name : 'cost_price', type: 'number'    }, 
     						
     						{name : 'totcost_price', type: 'number'    }, 
     						{name : 'stk_qty', type: 'number'    }, 
     						
     						
     						
     						
     						 
     						
     						
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxstkAdjustment").jqxGrid(
            {
                width: '99.5%',
                height: 350,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	

                    var cell4 = $('#jqxstkAdjustment').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'productname' || cell4.datafield == 'prodoc' )) 
                    
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
	                	 else if(cell4.datafield == 'prodoc')
	                		  {
	                		var aa= $('#doc_no').val();  
	                		  }  
	                
	                		  
	                	  
	           
	                	
	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                     
                    	return 0;
                    	}
                       	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                 var rsv_qty=rows[0].rsv_qty;
  	                 
  	              
  	        		 if(parseFloat(rsv_qty)>0)
  	    			   {
  	        			document.getElementById("errormsg").innerText="Not able to process";
  	      		   
  	      		   return 0; 
  	    			   }
  	    		   
  	        	  else
  	 		   {
  	 		   document.getElementById("errormsg").innerText="";
  	 		   }
  	  
  	                 
  	                 
  	                /* if(parseInt(rows[0].method)==0)
  	              	  { */
  	              	  
  	            		var rows1 = $("#jqxstkAdjustment").jqxGrid('getrows');
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
  	          	   
  	            	  
  	            	  /* }
  	                	 */  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxstkAdjustment').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	               
  	 
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                
  	              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	              
  	                
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "stk_qty" ,rows[0].stk_qty );
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid );
  	            $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	          $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice );
  	                
  	 
  	          
  	       // $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "cost_price" ,rows[0].cost_price);
  	      $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindex1, "cost_price1" ,rows[0].cost_price);
  	          
   	          
  	        if($('#mode').val()=="E"){
         		
         		 
         		 
         		} 
  	          
  	      
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxstkAdjustment').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxstkAdjustment").jqxGrid('addrow', null, {});
               	} 
               
               $("#jqxstkAdjustment").jqxGrid('ensurerowvisible', rowlength);
               
  	        	            } 
  	                if (key != 13) {                  
                    
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
          
          if (cell4 != undefined && cell4.datafield == 'prodoc') {
    	        
       		 
       		   document.getElementById("gridtext0").focus();
       		 
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
							
							{text: 'Doc No', datafield: 'prodoc',columntype: 'custom', width: '5%',cellclassname: cellclassname,
							
							createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="doc_no" name="doc_no" style="width:100%;height:99%;"   />' );
							
							    },
							 
							 },
							
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '15%',cellclassname: cellclassname,
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
                                  { text: 'Product Name', datafield: 'productname' ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							
							{text: 'Brand Name', datafield: 'brandname', width: '11%' , editable:false,cellclassname: cellclassname  },
							{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },
							
							
							
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: ' Qty', datafield: 'qty',cellclassname: cellclassname ,cellsformat: 'd2', editable: false,hidden:true},   
							{ text: 'Stock Qty', datafield: 'stk_qty',cellclassname: cellclassname ,cellsformat: 'd2', editable: false, width: '6%'},   
							
							{ text: 'Physical Qty', datafield: 'phy_qty',cellclassname: cellclassname,cellsformat: 'd2', width: '6%' }, 
							
							
							{ text: 'Adjusted Qty', datafield: 'adj_qty',cellclassname: cellclassname, width: '6%', editable: false ,cellsformat: 'd2', cellsformat: 'd2',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
							
							{ text: 'Cost Price', datafield: 'cost_price',cellclassname: cellclassname, width: '7%',cellsformat: 'd2', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#jqxstkAdjustment').jqxGrid('getcellvalue', row, "adj_qty");
								     if (parseInt(temp)<=0)
								    	 {
								    			    	 
								       return false; 
								    	 }
								      
								   
								  }
							},
							
							
							{ text: 'sCost Price', datafield: 'cost_price1',cellclassname: cellclassname,cellsformat: 'd2', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname ,hidden:true},
							
							{ text: 'Total Cost Price', datafield: 'totcost_price',cellclassname: cellclassname,cellsformat: 'd2', width: '7%', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
							
						
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname  ,hidden:true    },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname ,hidden:true  },
							{ text: 'FOC', datafield: 'foc', width: '7%',cellclassname: cellclassname ,hidden:true},
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname  ,hidden:true   },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true},
							{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname ,hidden:true },
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,hidden:true },
							{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
							{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname ,hidden:true},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname  ,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname ,hidden:true},
  							//{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname ,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname,hidden:true },
							
							{text: 'chkqty', datafield: 'chkqty', width: '10%',cellclassname: cellclassname ,hidden:true  },  // save validation
							{text: 'ordout_qty', datafield: 'ordout_qty', width: '10%',cellclassname: cellclassname  ,hidden:true  }, //edit case total out
							
							{text: 'valorderqty', datafield: 'valorderqty', width: '10%',cellclassname: cellclassname ,hidden:true   }, //sor validate
							{text: 'totalorderqty', datafield: 'totalorderqty', width: '10%',cellclassname: cellclassname  ,hidden:true  }, // tottal qty order 
							
							
						]
            });
            
            
            if(temp==0)
     	   {
         $("#jqxstkAdjustment").jqxGrid('addrow', null, {});
      

      
     	   }
        
        
        if(($('#mode').val()=='A')||($('#mode').val()=='E'))
		       {
		  $("#jqxstkAdjustment").jqxGrid({ disabled: false}); 
		        }
        
        
        if(document.getElementById("docno").value>0)
     	   {
     	   
     	   $('#jqxstkAdjustment').jqxGrid('showcolumn', 'totcost_price');
     	   }
        else
     	   {
     	   $('#jqxstkAdjustment').jqxGrid('hidecolumn', 'totcost_price');
     	   }
        
        	 $('#jqxstkAdjustment').on('cellclick', function (event) {
    			 
    			 document.getElementById("errormsg").innerText="";	 
    			 
    		 }); 
            $('#jqxstkAdjustment').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	  
            	 
            		var df=event.args.datafield;

            		  $('#datas').val(0);
            		  
            		  
            if(df == "prodoc")
               		  { 
               		  /* if(document.getElementById("locationid").value=="")
            		  {

            		   document.getElementById("errormsg").innerText="Search Location";  
            		   document.getElementById("txtlocation").focus();
            		     
            		      return 0;
            		  }
               		   */
               		  
               		  
               		  
               		productSearchContent('productSearch.jsp?location='+document.getElementById("locationid").value+'&branch='+document.getElementById("brchNames1").value);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "prodoc"); 
           

 
           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext0').val("");  
          	 $('#part_no').val(""); 
          	 
           }
           else
          	 {
          	 
          	   
               $('#doc_no').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "prodoc"));
               
               
               $('#gridtext0').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "prodoc"));
               
               
               
              
               $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindextemp, "prodoc" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "prodoc"));

               
          	 }
            
               
            		  } 
               	  if(df == "productid")
               		  { 
               		  /* if(document.getElementById("locationid").value=="")
            		  {

            		   document.getElementById("errormsg").innerText="Search Location";  
            		   document.getElementById("txtlocation").focus();
            		     
            		      return 0;
            		  }
               		   */
               		  
               		  
               		  
               		productSearchContent('productSearch.jsp?location='+document.getElementById("locationid").value+'&branch='+document.getElementById("brchNames1").value);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           

 
           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val(""); 
          	 
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
                  if(df == "productname")
          		  { 
            	  if(document.getElementById("errormsg").innerText!="")
         		 {
            		   
         		 return 0;
         		 }
            	  
            	  
            	  
            	  
            		productSearchContent('productSearch.jsp?location='+document.getElementById("locationid").value+'&branch='+document.getElementById("brchNames1").value);
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
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
            	 qty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	var valorderqty=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "valorderqty");
            	var ordout_qty=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "ordout_qty");
            	 
            	var totalorderqty=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "totalorderqty");
            	 
            	 if(datafield=='qty'){
            		 
            		 
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
    
     
             	if($('#mode').val()=="E"){
             		 
             		if($('#cmbreftype').val()=="DIR")
             			{
             			 
             			totqty=(totqty-outqty)+oldqty;
             		 
            	 if(qty>totqty){
            		
            	// $("#jqxstkAdjustment").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
            	 //$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 
            	 
            	 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+totqty;
            	 
            	 }
            	 
            	 else{
            		// $("#jqxstkAdjustment").jqxGrid('hidevalidationpopups');
            		 document.getElementById("errormsg").innerText="";
            		 $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
            	 }
             		 }
             		
             		
             		
             		else
             			{
        				 
         				 
             			if(parseFloat(oldqty)<=0)
             				{
		             			if(qty>valorderqty){
		                    		
		             					             				
		                         	// $("#jqxstkAdjustment").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+valorderqty);
		                         	document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+valorderqty;
		                         	 }
		                         	 
		                         	 else{
		                         		// $("#jqxstkAdjustment").jqxGrid('hidevalidationpopups');
		                         		 
		                         		document.getElementById("errormsg").innerText="";
		                         	   $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
		                         	 }
		             			
             				}
             			
             			else
             				{
             				
             				var chkqty=	totalorderqty-ordout_qty+oldqty;
             				
             		 
             				if(balqty<chkqty)
             					{
             					chkqty=balqty+oldqty;
             					
             					}
             				 
             				
             			
             			//var chkqty=ordout_qty-oldqty;
             			
             			
             			
             			if(qty>chkqty){
             				document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+chkqty;	
                       //	 $("#jqxstkAdjustment").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+chkqty);
                       	 //$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                       	 }
                       	 
                       	 else{
                       	//	 $("#jqxstkAdjustment").jqxGrid('hidevalidationpopups');
                       	document.getElementById("errormsg").innerText="";
                       		 $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
                       	 }	
             			
             				}
             			
             			
             			}
             		
             	}
             	
             	else if($('#mode').val()=="A"){
             		
             		
             		if($('#cmbreftype').val()=="DIR")
             			{
             		
             		if(qty>balqty){
             			document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;	
                   //	 $("#jqxstkAdjustment").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
                   	 //$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 }
                   	 
                   	 else{
                   		// $("#jqxstkAdjustment").jqxGrid('hidevalidationpopups');
                   		 document.getElementById("errormsg").innerText="";
                   		 
                   	   $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0); // validation save
                   	 }
             		
             			}
             		
             		else
             			{
             			
             			if(balqty<valorderqty)
             				{
             				valorderqty=balqty; 
             				}
             			
             			
             			if(qty>valorderqty){
             				document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+valorderqty;
                         // 	 $("#jqxstkAdjustment").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+valorderqty);
                          	 //$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                          	 }
                          	 
                          	 else{
                          		// $("#jqxstkAdjustment").jqxGrid('hidevalidationpopups');
                          		 document.getElementById("errormsg").innerText="";
                          		 
                          	   $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "chkqty" ,0);
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
            		 $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
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
              		   
              			
              			discount=(parseFloat(total)*parseFloat(discper))/100;
              		             			
              			}
              		
              	         }
            	
            	if(datafield=='dis'){
            	discper=(100/parseFloat(total))*parseFloat(discount);
            	}
            	
            	
            	
            	if(datafield=='discper'){
            	discount=(parseFloat(total)*parseFloat(discper))/100;
            	}
            	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
     		   {
            		discount=0.0;
     		   }
            	netotal=parseFloat(total)-parseFloat(discount);
            	
            	
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            	
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
   
            		
/*             		var summaryData1= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');  */
            	   }
            
            
            
            $("#jqxstkAdjustment").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		            	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            
                  if(datafield=="prodoc")
            		   {
            	   
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "prodoc" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "prodoc"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }	   
            
            	   if(datafield=="productid")
            		   {
            	   
            	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            	  
            	  if(datafield=='phy_qty'){
           			//valchange(rowBoundIndex,datafield);phy_qty adj_qty
           			
            		 var phy_qty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "phy_qty");	
                 	var stkqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "stk_qty");
                 	
                	var balqty= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
                 	
                 	
                 	var adj_qty=parseFloat(phy_qty)-parseFloat(stkqty);
                 	
                 	
                 $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "adj_qty",adj_qty);
                 
                 if(parseFloat(adj_qty)<0)
                	 {
                	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "cost_price","");
                	 
                	  
                	 
                	 }
                 else
                	 {
                	 
                	  $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "cost_price",$('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "cost_price1"));
                	 }
                 
                 
                 
            /*   	var cost_price= $('#jqxstkAdjustment').jqxGrid('getcellvalue', rowBoundIndex, "cost_price");
                 
                  */
           /*      var totcost_price=parseFloat(cost_price)*parseFloat(adj_qty);
           			
                $('#jqxstkAdjustment').jqxGrid('setcellvalue', rowBoundIndex, "totcost_price",totcost_price);
           		 */	
           			
           			
            	  }
           		    	 
                    		});
            
            
            var applyFilter = function (datafield,value) {
                
                var filtertype = 'stringfilter';
              
              
                if (datafield == 'part_no' || datafield == 'productname' || datafield == 'doc_no') filtertype = 'stringfilter';
                var filtergroup = new $.jqx.filter();
         
                    var filter_or_operator = 1;

                    var filtervalue = value;
    	            var filtercondition = 'starts_with';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
               
                
                if (datafield == 'part_no') 
                	{
               
                $("#prosearch").jqxGrid('addfilter', 'part_no' , filtergroup);
               // document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'productname') 
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                   // document.getElementById("productname").focus();
                    	}
                else  if (datafield == 'doc_no')    
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'doc_no' , filtergroup);
                   // document.getElementById("prodoc").focus();
                    	}
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
                
                
        
            }
            
            if($('#mode').val()!="view"){
            	$("#jqxstkAdjustment").jqxGrid('disabled', false);
            }
            
           /*  if($('#cmbreftype').val()=='SOR'){
            var summaryData1= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
    		var summaryData2= $("#jqxstkAdjustment").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
			
   			document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
  			document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
  			document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
  			document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            }   */ 
        });
        
        
function chkbrand()
{
 
   
	
}
</script>
<div id="jqxstkAdjustment"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
