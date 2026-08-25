<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.InventoryTransfer.InventoryTransferRecept.ClsTransferReceptDAO"%>
<%ClsTransferReceptDAO DAO= new ClsTransferReceptDAO();%>

<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();

 
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
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc)%>';  

 }
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc)%>';  

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
    		

      	  var ss= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', row, "qty");
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
     						{name : 'brandname', type: 'string'},
     						{name : 'refstkid', type: 'number'    },
     						
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInvReceptGrid").jqxGrid(
            {
                width: '99.5%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                	

                    var cell4 = $('#jqxInvReceptGrid').jqxGrid('getselectedcell');
                   
                    
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
  	                	  
	   	            	if($('#mode').val()=="A"){
	   	            		
	   	            		
	   	            		
	   	            		
		  	                   var stkids=rows[0].stkid;
		  	                 
		  	    
		  	              	  
		  	            		var rows1 = $("#jqxInvReceptGrid").jqxGrid('getrows');
		  	          	     var aa=0;
		  	          	    for(var i=0;i<rows1.length;i++){
		  	          	   
		  	          		   if(parseInt(rows1[i].stkid)==parseInt(stkids))
		  	          			   {
		  	          			   
		  	          		         			   
		  	          			   aa=1;
		  	          			   break;
		  	          			   }
		  	          		   else{
		  	          			   
		  	          			   aa=0;
		  	          		       } 
		
		  	          	 	     }
		  	          	   
	            	}
	            	
	          	if($('#mode').val()=="E"){
	          		
	             var stkid=rows[0].stkid;
                
			  	    
            	  
         		var rows1 = $("#jqxInvReceptGrid").jqxGrid('getrows');
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
         	   
            
               	  
  	 /*                   var prodocs=rows[0].doc_no;
  	                
  	                
  	              	  
  	            		var rows1 = $("#jqxInvReceptGrid").jqxGrid('getrows');
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
  	          	    */
  	            	 
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearch").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#jqxInvReceptGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	            
  	             $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	 
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid );
  	            $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	          $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice );
  	                
  	          //    $("#jqxInvReceptGrid").jqxGrid('selectcell',rowindex1, "qty" );
  	        //  $("#jqxInvReceptGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxInvReceptGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxInvReceptGrid").jqxGrid('addrow', null, {});
               	} 
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
  							 
							{ text: 'Product Name', datafield: 'productname' ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							{text: 'Brand Name', datafield: 'brandname', width: '15%' , editable:false  ,  cellclassname: cellclassname},
							{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '10%',cellclassname: cellclassname },
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname ,hidden:true  },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname,hidden:true   },
							{ text: 'FOC', datafield: 'foc',cellclassname: cellclassname,hidden:true },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname  ,hidden:true  },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname  ,hidden:true },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true},
							{ text: 'KG Price', datafield: 'kgprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Unit price', datafield: 'unitprice', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Total', datafield: 'total', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,hidden:true },
							{ text: 'Discount', datafield: 'dis', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,hidden:true},
							{ text: 'Net Total', datafield: 'netotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true },
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname ,hidden:true},
							
							
							{text: 'refstkid', datafield: 'refstkid', width: '10%',cellclassname: cellclassname,hidden:true },
							
							
							
						]
            });
  	 $('#jqxInvReceptGrid').on('cellclick', function (event) {
    			 
    			 document.getElementById("errormsg").innerText="";	 
    			 
    		 }); 
            $('#jqxInvReceptGrid').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var refmasterdocno=$("#refmasterdocno").val();
            	 var locationfrmid=$("#locationfrmid").val();
            	 
            		var df=event.args.datafield;

                    
               	  if(df == "productid")
               		  {  
            		 
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&locationfrmid='+locationfrmid);
            	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
                	 if(df == "productname")
              		  { 
                	  if(document.getElementById("errormsg").innerText!="")
             		 {
                		   
             		 return 0;
             		 }  
            		productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&locationfrmid='+locationfrmid);
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	     

              	   $('#productname').val($('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
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
            	 qty= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            	
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
                 	
       
             	if($('#mode').val()=="E"){
     				
            	 if(qty>balqty){
            		 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
            	// $("#jqxInvReceptGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than requested  quantity "+totqty);
            	 //$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 }
            	 
            	 else{
            		 document.getElementById("errormsg").innerText="";
            		 
            		 // $("#jqxInvReceptGrid").jqxGrid('hidevalidationpopups');
            	 }
             		 }
             	else if($('#mode').val()=="A"){
             		if(qty>totqty){
             			document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+totqty;
                   	 //$("#jqxInvReceptGrid").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than requested  quantity "+totqty);
                   	 //$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	 }
                   	 
                   	 else{
                   		document.getElementById("errormsg").innerText="";
                   		 //$("#jqxInvReceptGrid").jqxGrid('hidevalidationpopups');
                   	 }
             	}
            	 }
            	 /* } */
            	 /* if(searchtype!="0"){
                
            	 if(datafield=='qty'){
            	 if(qty>balqty){
            		 
            		 warning="quantity should not be greater than requested quantity";
            		 document.getElementById("errormsg").innerText=warning;
            		 $('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
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
            	
            	
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            	
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
            		netotal=parseFloat(total)-parseFloat(discount);
        			$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		
            		var summaryData1= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            	   }
            
            
            
            $("#jqxInvReceptGrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		            	   
            	  if(parseInt($('#datas').val())!=1)
            		  {
            	   
            
            	   if(datafield=="productid")
            		   {
            	   
            	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxInvReceptGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxInvReceptGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            	  
            	  
           			valchange(rowBoundIndex,datafield);
           		    	 
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
              //  document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'productname') 
            	         {
                    
                    $("#prosearch").jqxGrid('addfilter', 'productname' , filtergroup);
                  //  document.getElementById("productname").focus();
                    	}
                
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
                
                
        
            }
            
            if($('#mode').val()!="view"){
            	$("#jqxInvReceptGrid").jqxGrid('disabled', false);
            	if($('#rrefno').val()!=''){
                    var summaryData1= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
            		var summaryData2= $("#jqxInvReceptGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           			document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          			document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          			document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          			document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,'');
          		 
          			
                    }
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
     
    	  
    	  $('#jqxInvReceptGrid').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxInvReceptGrid').jqxGrid('hidecolumn', 'brandname');
      
      }
      
       }}
   x.open("GET","checkbrand.jsp?",true);
	x.send();
 
      
        
	
}
       
        
        
</script>
<div id="jqxInvReceptGrid"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
