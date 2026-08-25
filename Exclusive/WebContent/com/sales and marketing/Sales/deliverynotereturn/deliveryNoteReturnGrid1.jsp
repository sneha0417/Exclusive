<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.Sales.deliverynotereturn.ClsDeliverynoteReturnDAO"%>
<%ClsDeliverynoteReturnDAO DAO= new ClsDeliverynoteReturnDAO();%>
 
<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String locaid=request.getParameter("locaid")==null?"NA":request.getParameter("locaid").trim();



//System.out.println("==qotdoc==qwqw="+qotdoc+"==enqdoc==qwqw=="+enqdoc); 
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
var qotgriddata;
$(document).ready(function () {
	chkfoc();
	chkbrand();
var temp2='<%=enqdoc%>';
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

 if(temp2>0 && cond=="0")
{

	qotgriddata='<%=DAO.qotgridreload(enqdoc)%>';  
 
}

  else if(cond=="1")
 {
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,locaid)%>';  

 }
 else if(temp>0  && cond=="2")
{

	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,locaid)%>';  

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
    		if (data.qty==0) {
    			document.getElementById("errormsg").innetText="Quantity Should not Be Zero";
                return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
    		}
    		
    		 var ss= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', row, "qty");
	          if(parseInt(ss)<=0)
	  		{
	  		
	  		return "redClass";
	  	
	  		}
    		
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


            	  var ss= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', row, "qty");
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
     						{name : 'foc', type: 'number' },
     						{name : 'refqty', type: 'number'  },
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
     						{name : 'refstkid', type: 'number'    },
     						
     						{name : 'brandname', type: 'string'    },
     						
     						
     						{name : 'rdocno', type: 'number'    },
     						
     						{name : 'detdocno', type: 'number'    },
     						
     						
     						
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDeliveryNoteReturn").jqxGrid(
            {
                width: '99.5%',
                height:  240,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	

                    var cell4 = $('#jqxDeliveryNoteReturn').jqxGrid('getselectedcell');
                   
                    
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
  	                	  
	   	     /*        	if($('#mode').val()=="A"){ */
	   	            		
	   	            		
				   	            		
				   	            		
			  	                   var doc_no=rows[0].doc_no;
			  	                 var rdocno=rows[0].rdocno;
			  	    
			  	              	  
			  	            		var rows1 = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
			  	          	     var aa=0;
			  	          	    for(var i=0;i<rows1.length;i++){
			  	          	   
			  	          		   if(parseInt(rows1[i].rdocno)==parseInt(rdocno))
			  	          			   {
			  	          		   if(parseInt(rows1[i].prodoc)==parseInt(doc_no))
		  	          			   { 
			  	          		     
			  	          			   
			  	            		   var munit=rows1[0].unitdocno;
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
			  	          		   else{
			  	          			   
			  	          			   aa=0;
			  	          		       } 
			
			  	          	 	     }
			  	          	   
	   	            /* 	}
	   	            	 */
/* 	   	          	if($('#mode').val()=="E"){
	   	          		
	   	             var stkid=rows[0].stkid;
  	                 
				  	    
 	              	  
	            		var rows1 = $("#jqxDeliveryNoteReturn").jqxGrid('getrows');
	          	     var aa=0;
	          	    for(var i=0;i<rows1.length;i++){
	          	   
	          	      var refstockid=rows1[i].refstkid;
	            	     
	            	     if(parseInt(refstockid)>0)
	            	    	 {
	            	    	
	            	    	 }
	            	     else
	            	    	 {
	            	    	 
	            	    	refstockid=rows1[i].stkid;
	            	    	 }
	          	    	
	          	    	
	          	    	
	          		   if(parseInt(refstockid)==parseInt(stkid))
	          			   {
	          			   
	          		         			   
	          			   aa=1;
	          			   break;
	          			   }
	          		   else{
	          			   
	          			   aa=0;
	          		       } 

	          	 	     }
	   	          		
	   	          		
	   	          	 
	   	            	
  	                  } */
  	          	   
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
  	  		    
  	                	
  	                	   $('#jqxDeliveryNoteReturn').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	               $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	               
  	               $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	               
  	             
  	               
  	 
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	           		$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid );
  	            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	            
  	            
  	            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "rdocno" ,rows[0].rdocno );
  	            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindex1, "detdocno" ,rows[0].detdocno );
  	                
  	              //$("#jqxDeliveryNoteReturn").jqxGrid('selectcell',rowindex1, "qty" );
  	        //  $("#jqxDeliveryNoteReturn").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxDeliveryNoteReturn').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxDeliveryNoteReturn").jqxGrid('addrow', null, {});
               	} 
               
               
               $("#jqxDeliveryNoteReturn").jqxGrid('ensurerowvisible', rowlength);
               
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
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '20%',cellclassname: cellclassname,
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
                        { text: 'Product Name', datafield: 'productname'   ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false,cellclassname: cellclassname  },
							{ text: 'Unit', datafield: 'unit', width: '6%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '10%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', cellclassname: cellclassname },
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname   ,hidden:true},
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname  ,hidden:true  },
							{ text: 'FOC', datafield: 'foc', width: '7%',editable:false,cellclassname: cellclassname,hidden:true},
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname  ,hidden:true},
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname,hidden:true  },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right',editable:false, align: 'right',cellclassname: cellclassname},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right',editable:false, align: 'right',cellclassname: cellclassname },
							{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
							{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname   ,hidden:true   },
							{text: 'refstkid', datafield: 'refstkid', width: '10%',cellclassname: cellclassname  ,hidden:true   },
							
							{text: 'rdocno', datafield: 'rdocno', width: '10%',cellclassname: cellclassname  ,hidden:true   },
							{text: 'deldocno', datafield: 'detdocno', width: '10%',cellclassname: cellclassname  ,hidden:true  },
							
							
							
							
						]
            });
       	 $('#jqxDeliveryNote').on('cellclick', function (event) {
			 
			 document.getElementById("errormsg").innerText="";	 
			 
		 }); 
            $('#jqxDeliveryNoteReturn').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var refmasterdocno=$("#refmasterdocno").val();
            	 
            		var df=event.args.datafield;

                    
                 	  if(df == "productid")
                 		  { 
            		 
                 		  
                 	  		
                   		 if(document.getElementById("locationid").value=="")
                		  {

                		   document.getElementById("errormsg").innerText="Search Location";  
                		   document.getElementById("txtlocation").focus();
                		     
                		      return 0;
                		  }
                   		  
                 		  
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&locaid='+document.getElementById("locationid").value);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
                 	 if(df == "productname")
             		  { 
               	  if(document.getElementById("errormsg").innerText!="")
            		 {
               		   
            		 return 0;
            		 }
               	  
               	  
            		
           		 if(document.getElementById("locationid").value=="")
        		  {

        		   document.getElementById("errormsg").innerText="Search Location";  
        		   document.getElementById("txtlocation").focus();
        		     
        		      return 0;
        		  }
           		  
               	  
            		productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&locaid='+document.getElementById("locationid").value);
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
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
            	 qty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
     
             	if($('#mode').val()=="E"){
     				
            	 if(qty>balqty){
            		 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
            	// $("#jqxDeliveryNoteReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
            	 //$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            		 $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
                	 qty=balqty;
            	 }
            	 
            	 else{
            		// $("#jqxDeliveryNoteReturn").jqxGrid('hidevalidationpopups');
            		//document.getElementById("errormsg").innerText="";
            	 }
             		 }
             	else if($('#mode').val()=="A"){
             		if(qty>totqty){
             			 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+totqty;
             			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",totqty);
                   	 qty=totqty;
                   	// $("#jqxDeliveryNoteReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
                   	 //$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 }
                   	 
                   	 else{
                   		// $("#jqxDeliveryNoteReturn").jqxGrid('hidevalidationpopups');
                   		//document.getElementById("errormsg").innerText="";
                   	 }
             	}
            	 }
            	 /* } */
            	 /* if(searchtype!="0"){
                
            	 if(datafield=='qty'){
            	 if(qty>balqty){
            		 
            		 warning="quantity should not be greater than requested quantity";
            		 document.getElementById("errormsg").innerText=warning;
            		 $('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
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
            	
            	
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            	
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
            	 
            		
            		var summaryData1= $("#jqxDeliveryNoteReturn").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxDeliveryNoteReturn").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxDeliveryNoteReturn").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            	   }
            
            
            
            $("#jqxDeliveryNoteReturn").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		            	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            	   
            
            	   if(datafield=="productid")
            		   {
            	   
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            	  var qty=0.0;
            	  var oldqty=0.0;
            	  var totqty=0.0;
            	  var outqty=0.0;
            	  var balqty=0.0;
            	  var tmpqty=0;
              	  var tmpqty1=0;
            	  
            	  qty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
             	 oldqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
             	 totqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
             	 outqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
             	 balqty= $('#jqxDeliveryNoteReturn').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	  
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
       
             	if($('#mode').val()=="E"){
     				
             		 if(qty>balqty){
            		
            	/*  $("#jqxDeliveryNoteReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty); */
            	     		 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
            	$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
            	 qty=balqty;
            	 }
            	 
            	 else{
            		/*  $("#jqxDeliveryNoteReturn").jqxGrid('hidevalidationpopups'); */
            	 }
             		 }
             	else if($('#mode').val()=="A"){
             		
             		
             		
             		
             		if(qty>balqty){
                		
                   	/*  $("#jqxDeliveryNoteReturn").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty); */
                   	 //$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 
             		 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
             		$('#jqxDeliveryNoteReturn').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
             		 qty=balqty;
                   	 }
                   	 
                   	 else{
                   		 //$("#jqxDeliveryNoteReturn").jqxGrid('hidevalidationpopups');
                   	 }
             	}
            	 }
             	 
             	 
           			//valchange(rowBoundIndex,datafield);
           		    	 
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
            	$("#jqxDeliveryNoteReturn").jqxGrid('disabled', false);
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
     
    	  
    	  $('#jqxDeliveryNoteReturn').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxDeliveryNoteReturn').jqxGrid('hidecolumn', 'brandname');
      
      }
      
       }}
   x.open("GET","checkbrand.jsp?",true);
	x.send();
 
      
        
	
} 
        
        
</script>
<div id="jqxDeliveryNoteReturn"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
