 <%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%ClsSalesOrderDAO DAO= new ClsSalesOrderDAO();%>

<%
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();

String enqdoc=request.getParameter("enqdoc")==null?"0":request.getParameter("enqdoc").trim();

String chk=request.getParameter("chk")==null?"NA":request.getParameter("chk").trim();

String cond=request.getParameter("cond")==null?"0":request.getParameter("cond").trim();

String from=request.getParameter("from")==null?"0":request.getParameter("from").trim();

String reftype=request.getParameter("reftype")==null?"NA":request.getParameter("reftype").trim();

String enqmasterdocno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();

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
var temp='<%=qotdoc%>';
var cond='<%=cond%>';

   if(cond=="0")
{

	qotgriddata='<%=DAO.qotgridreload(enqdoc)%>';  
 
}
  
  if(cond=="1") 
 {
	 
 	qotgriddata='<%=DAO.prdGridReload(session,enqdoc,dates,cmbbilltype)%>';  

 }
 else if(temp>0  && cond=="2")
{
	
	qotgriddata='<%=DAO.prdGridReload(session,qotdoc,enqdoc,reftype,dates,cmbbilltype)%>';  
 
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
              //  return "redClass";
            }
    		else{
    			//document.getElementById("errormsg").innetText="";
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
                 
                // alert($(this).val());
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


          	  var ss= $('#jqxSalesOrder').jqxGrid('getcellvalue', row, "qty");
            		          if(parseInt(ss)<=0)
            		  		{
            		  		
            		  		return "redClass";
            		  	
            		  		}
            	   
              	if ($("#mode").val() == "E") {    
       		   	  var clstatus= $('#jqxSalesOrder').jqxGrid('getcellvalue', row, "clstatus");
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
     						{name : 'stkid', type: 'number'    },
     						{name : 'method', type: 'number'    },
     						
     						{name : 'clstatus', type: 'number'    },
							{name : 'unitprice1', type: 'string'  }, 
     						
     						{name : 'disper1', type: 'string'  },
     						{name : 'brandname', type: 'string'},
     					   {name : 'allowdiscount', type: 'number'  },
     					   
     						
       					 {name : 'taxper', type: 'number'  },  
       					 {name : 'taxamount', type: 'number'  },
       					{name : 'taxperamt', type: 'number'  }, 
       					 {name : 'taxdocno', type: 'string'    },
       					 
       					 	{name : 'collectqty', type: 'string'  }, 
       					
                        ],
                        
                        
                       
                         localdata: qotgriddata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            
            $("#jqxSalesOrder").on("bindingcomplete", function (event) { 
    			
    			
                if($('#mode').val()=="A"){
       
              if($('#cmbreftype').val()=='SQOT'){
            	
             	 var rows = $("#jqxSalesOrder").jqxGrid('getrows');   
 
	             	  for(var i=0;i<rows.length;i++){
	             	   		var netotal=$('#jqxSalesOrder').jqxGrid('getcellvalue', i, "netotal"); 
	                		
	                		  var taxper= $('#jqxSalesOrder').jqxGrid('getcellvalue', i, "taxper"); 
	                		  
	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
	                		  
	                		  
	                		  $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxperamt",taxempamount);
	                		  
	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
	                		  
	                		  $('#jqxSalesOrder').jqxGrid('setcellvalue', i, "taxamount",taxtotalamount);
	              	 
	                		 
	             	                         }
                                    }
                               } 
         	         
     
    			
    			
    		}); 
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSalesOrder").jqxGrid(
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
                	
            var cell1 = $('#jqxSalesOrder').jqxGrid('getselectedcell');
                   
             
			 
       	 if (cell1 != undefined && cell1.datafield == 'unit') {  
       		 
   		 
       		 if((parseInt(document.getElementById("multimethod").value)==1))
				{	
       			 
       		 
               var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
               if (key == 114) {  
              	 
      			 
                 var rowindextemp=cell1.rowindex;
            	    document.getElementById("rowindex").value = cell1.rowindex;   
                	  $('#jqxSalesOrder').jqxGrid('clearselection');
                	  qtyinfoSearchContent('searchunit.jsp?psrno='+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "psrno")+
  			      			"&mode="+document.getElementById("mode").value+"&oldqty="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "oldqty")+"&unitdocno="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "unitdocno"));
                	
               	 
               }
               
				}
               
               
               }
			 
      

        			 
                    var cell4 = $('#jqxSalesOrder').jqxGrid('getselectedcell');
                   
                    
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
  	                	  
  	                	
  	                	
  	             	 if(document.getElementById("cmbreftype").value=="SQOT")
	                	{
	             	   
	   	               	 var rows = $("#prosearch").jqxGrid('getrows');  
	                	  
	   	     
	   	              
	   	              
	                   var unitprice=rows[0].unitprice;
	   	              
	   	              var prdid=rows[0].doc_no;
	   	                var disper=rows[0].discper;
	   
	              	  
		  	            		var rows1 = $("#jqxSalesOrder").jqxGrid('getrows');
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
  	                
  	              /*   if(parseInt(rows[0].method)==0)
  	              	  { */
  	              	  
  	            		var rows1 = $("#jqxSalesOrder").jqxGrid('getrows');
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
  	  		    
  	                	
  	                	   $('#jqxSalesOrder').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	               $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	            
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);
  	               
  	          $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "allowdiscount" ,rows[0].allowdiscount);
  	          
  	          
  		      $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "taxper" ,rows[0].taxper);
	  	        
	  	        
  	  	    $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "taxdocno" ,rows[0].taxdocno);

                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice" ,rows[0].unitprice);
                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "eidtprice" ,rows[0].eidtprice);
                
                
                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	 
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "productname" ,rows[0].productname);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue',  rowindex1, "qty" ,rows[0].qty );
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "outqty" ,rows[0].outqty );
  	                $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "balqty" ,rows[0].balqty );
  	              $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid );
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "stkid" ,rows[0].stkid );
  	            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "totqty" ,rows[0].totqty );
  	            
  	          $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "method" ,rows[0].method);
  	          
  	          
        	  document.getElementById("datas2").value="0";
        	  if(document.getElementById("cmbreftype").value=="DIR")
        		  
        		  
        		  {  
        	  if(parseInt(rows[0].discountset)>0)
        		  {
        		
        		   var dscper=document.getElementById("dscper").value;
        		 	if(dscper>0)
		      		{
        		  
        		 	var allowdiscount=rows[0].allowdiscount;
		      		var  discallowper=parseFloat(allowdiscount)*(parseFloat(dscper)/100);  
		      	 
		          document.getElementById("datas2").value="1";
		            $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,discallowper);
	        		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,discallowper);
	        		  
		      		}
        		 	else
        		 		{
        		 		  document.getElementById("datas2").value="1";
        		 		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].allowdiscount);
                		  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].allowdiscount);
        		 		}
        		  
        		  
        		  }
        

		      
		     	      
        		  }
		     	 
        	  document.getElementById("datas2").value="0";
  	          
  	          
  	          
  	          
  	        if(document.getElementById("cmbreftype").value=="SQOT")
        	{
  	        $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "total" ,rows[0].total);
		    $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,rows[0].discper);
  	    	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "dis" ,rows[0].dis);
  	   		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "netotal" ,rows[0].netotal);
  	  		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "unitprice1" ,rows[0].unitprice);
 	  		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "disper1" ,rows[0].discper);
        	}
  	          
         /* 	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "total" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "total"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "discper" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "discper"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "dis" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "dis"));
        	  $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindex1, "netotal" ,$('#prosearch').jqxGrid('getcellvalue', rowindex2, "netotal"));
  	           */
  	                
  	     // $("#jqxSalesOrder").jqxGrid('selectcell',rowindex1, "qty" ); 
  	        //  $("#jqxSalesOrder").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#jqxSalesOrder').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#jqxSalesOrder").jqxGrid('addrow', null, {});
               	} 
               
               $("#jqxSalesOrder").jqxGrid('ensurerowvisible', parseInt(rowindex1)+1);
               
               
  	        	            } 
  	                   
  	                if (key != 13) {           
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'productname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }}
              
            
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
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"/>' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
                       { text: 'Product Name', datafield: 'productname'   ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="productname" name="productname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},	
							{text: 'Brand Name', datafield: 'brandname', width: '10%' , editable:false ,cellclassname: cellclassname },
							{ text: 'Unit', datafield: 'unit', width: '4%',editable:false,cellclassname: cellclassname },	
							{ text: 'Size', datafield: 'size', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'Quantity', datafield: 'qty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2'},
							{ text: 'oldqty', datafield: 'oldqty', width: '7%',cellclassname: cellclassname,hidden:true   },
							{ text: 'TOT. Qty', datafield: 'totqty', width: '7%',cellclassname: cellclassname ,hidden:true   },
							{ text: 'FOC', datafield: 'foc', width: '7%',editable:false,cellclassname: cellclassname,hidden:true },
							{ text: 'OUT. Qty', datafield: 'outqty', width: '7%',cellclassname: cellclassname ,hidden:true },
							{ text: 'Bal. Qty', datafield: 'balqty', width: '7%',cellclassname: cellclassname ,hidden:true  },
							{ text: 'Total Weight KG', datafield: 'totwtkg', width: '10%',cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname},
							{ text: 'KG Price', datafield: 'kgprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,
								cellbeginedit: function (row) {
									var temp=$('#jqxSalesOrder').jqxGrid('getcellvalue', row, "eidtprice");
								     if (parseInt(temp)==0)
								    	 {
								    			    	 
								       return false; 
								    	 }
							         if (document.getElementById("cmbreftype").value=="SQOT")
		                             {
		                                  return false;
		                             } 
								   
								  },
								  
								 
							
							
							
							},
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							
							{ text: 'allowdiscount', datafield: 'allowdiscount', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname  ,hidden:true  },
							
							{ text: 'Discount%', datafield: 'discper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,
								
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("cmbreftype").value=="SQOT")
	                             {
	                                  return false;
	                             } 
	                                    
								 }, 
							
							},
							{ text: 'Discount', datafield: 'dis', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname,
								
								 cellbeginedit: function (row) {
	                                    if (document.getElementById("cmbreftype").value=="SQOT")
	                             {
	                                  return false;
	                             } 
	                                    
								 }, 
							
							},
							{ text: 'Net Total', datafield: 'netotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'stockid', datafield: 'stkid', width: '10%',cellclassname: cellclassname ,hidden:true  },
							
							{text: 'method', datafield: 'method', width: '10%',cellclassname: cellclassname,hidden:true  },
							
							{text: 'eidtprice', datafield: 'eidtprice', width: '10%' ,hidden:true },
							{text: 'clstatus', datafield: 'clstatus', width: '10%',cellclassname: cellclassname,hidden:true  },
							
							{text: 'unitprice1', datafield: 'unitprice1', width: '10%'  ,hidden:true },
							{text: 'disper1', datafield: 'disper1', width: '10%'  ,hidden:true},
							
							
							
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
							{ text: 'Total Amount', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							
							{text: 'taxdocno', datafield: 'taxdocno', width: '10%'   ,hidden:true },
									
							{text: 'qtysaves', datafield: 'collectqty', width: '15%'   ,hidden:true   },
							
						]
            });
           	 $('#jqxSalesOrder').on('cellclick', function (event) {
         		
    			 document.getElementById("errormsg").innerText="";	
    			 
    				var df=event.args.datafield;

       /*              
               	  if(df == "qty")
               		  { 
               		  
  			 if(document.getElementById("cmbreftype").value=="DIR" && ( parseInt(document.getElementById("batchno").value)==1 || parseInt(document.getElementById("expdate").value)==1))
					{	 
  			 
  			 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowvalss").value = rowindextemp;   
         	  $('#jqxSalesOrder').jqxGrid('clearselection');
         	batchinfoSearchContent('qtySearch.jsp?psrno='+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "psrno")+
         			 "&mode="+document.getElementById("mode").value+"&value="+document.getElementById("masterdoc_no").value);
         	
					}
  			 
  			 
  			 
               		  }
    			  */
    			 
    			 
    			 if(document.getElementById("cmbreftype").value=="DIR")
         		{
    							 
    			
    							  
    			             	  if(df == "unit")
    			             		  { 
    			             		 
    						 if(parseInt(document.getElementById("multimethod").value)==1)
    							{	 
    						 
    						 var rowindextemp = event.args.rowindex;
    			       	    document.getElementById("rowindex").value = rowindextemp;   
    			       	  $('#jqxSalesOrder').jqxGrid('clearselection');
    			      	qtyinfoSearchContent('searchunit.jsp?psrno='+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "psrno")+
    			      			"&mode="+document.getElementById("mode").value+"&oldqty="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "oldqty")+"&unitdocno="+$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "unitdocno"));
    							}
    						 
    						 
    						 
    			             		  }
    			       	
         		}
    			 
    		 }); 
         	 
            $('#jqxSalesOrder').on('cellbeginedit', function (event) {
               
            	
            	var columnindex1=event.args.columnindex;
            	 var prodsearchtype=$("#prodsearchtype").val();
            	 var refmasterdocno=$("#refmasterdocno").val();
            	 
              	
              	var df=event.args.datafield;

               
              	  if(df == "productid")
              		  { 
              		var clientid=document.getElementById("clientid").value;
              		var cmbprice=document.getElementById("cmbprice").value;
              		
              		
              	  if(document.getElementById("clientid").value=="")
        		  {

        		   document.getElementById("errormsg").innerText="Search Customer";  
        		   document.getElementById("txtclient").focus();
        		     
        		      return 0;
        		  }
           		  
             	 var clientcaid=document.getElementById("clientcaid").value; 
           		 var dates=document.getElementById("date").value;
           		 
           		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
              		
              		 
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
                	 var rowindextemp = event.args.rowindex;
            	    document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	   
               $('#part_no').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               $('#gridtext').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));
               
               
               
              
               $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
              	 if(df == "productname")
         		  { 
              		var clientid=document.getElementById("clientid").value;
              		var cmbprice=document.getElementById("cmbprice").value;
              		
              		
               		
              		
                	  if(document.getElementById("clientid").value=="")
          		  {

          		   document.getElementById("errormsg").innerText="Search Customer";  
          		   document.getElementById("txtclient").focus();
          		     
          		      return 0;
          		  }
             		  
                  	 var clientcaid=document.getElementById("clientcaid").value; 
               		 var dates=document.getElementById("date").value;
               		 
               		 var cmbbilltype=document.getElementById("cmbbilltype").value; 
               		 
                	 productSearchContent('productSearch.jsp?prodsearchtype='+prodsearchtype+'&enqmasterdocno='+refmasterdocno+'&cmbprice='+cmbprice+'&clientid='+clientid+'&reftypes='+document.getElementById("cmbreftype").value+"&clientcaid="+clientcaid+"&dates="+dates+"&cmbbilltype="+cmbbilltype);
        	 		 var rowindextemp = event.args.rowindex;
        	   		 document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      	 var temp= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "productname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#productname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#productname').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#jqxSalesOrder').jqxGrid('setcellvalue', rowindextemp, "productname" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
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
            	 qty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	 oldqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "oldqty");
            	 totqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "totqty");
            	 outqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "outqty");
            	 balqty= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "balqty");
            	 unitprice=	$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 totwtkg=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "totwtkg");
            	 kgprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "kgprice");
            	 unitprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            	 total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
            	 discper=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            	 discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            	 netotal=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "netotal");
            var	 method1=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "method");
            	
            	 if(datafield=='qty'){
            		 tmpqty=qty+outqty;
            		 /* -oldqty */
                	 tmpqty1=oldqty+balqty;
                	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "oldqty",qty);
             		//$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "outqty",tmpqty);
            //   alert(method1) ; 
             //  alert($('#cmbreftype').val()) ; 
          	if((method1=="0" && $('#cmbreftype').val()!='DIR') || method1=="1"){ 
          		
          	// alert("1");
          		
             	if($('#mode').val()=="E"){
     
            	 if(qty>totqty){
            		
           // 	 $("#jqxSalesOrder").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+totqty);
            	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
            	 
            	 document.getElementById("errormsg").innerText="Quantity should not be greater than available quantity "+totqty ;
            	 	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",totqty);
                   	qty=totqty;
            	 
            	 }
            	 
            	 else{
            		// $("#jqxSalesOrder").jqxGrid('hidevalidationpopups');
            		 document.getElementById("errormsg").innerText="";
            	 }
             		 }
             	
             	else if($('#mode').val()=="A"){
               
             		if(qty>balqty){
                		
                   	// $("#jqxSalesOrder").jqxGrid('showvalidationpopup', rowBoundIndex, "qty", "Quantity should not be greater than available  quantity "+balqty);
                   	 //$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",tmpqty1);
                   	  	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
                   		qty=balqty;
                   	 document.getElementById("errormsg").innerText="Quantity should not be greater than available  quantity "+balqty;
                   	 
                   	 }
                   	 
                   	 else{
                   		// $("#jqxSalesOrder").jqxGrid('hidevalidationpopups');
                   		 document.getElementById("errormsg").innerText="";
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
            		 $('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "qty",balqty);
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
            	
            	
      /*       	  if(datafield=='qty'){
              		
              		if(parseFloat(discper)>0)
              			{
              		   
              			
              			discount=(parseFloat(total)*parseFloat(discper))/100;
              		             			
              			}
              		
              	         }
            	 */
             
   
            	if(datafield=='dis'){
            	discper=(100/parseFloat(total))*parseFloat(discount);
             	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
             	
              
            	}
            	
            	
            	
            	if(datafield=='discper'){
            		
            	 		
                    
                    var dscper=document.getElementById("dscper").value;
                	      
                	 var  allowdiscount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "allowdiscount");
                	
                	 if($('#cmbreftype').val()=='SQOT')
                		 {
                		 var  allowdiscount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper"); 
                		 }
                	
                 	 
           	      
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
                	    	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
                	  	
                	    	 
                	    	
          
                	    	
                	    	}
                	    
            		
            		
            		
            		
            		
            		
            		if(discper>=0)
            			{
            		
            		
            	discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
            			}
            	
            	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            
       
            	}
            	
            	
              
		            	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
		     		   {
		            		discount=0.0;
		     		   }
            	
		 
             
            	
              	if(document.getElementById("cmbreftype").value=="SQOT")
            		
        		{
        		if($('#mode').val()=="A" || $('#mode').val()=="E")
        		{
        		if(datafield=='qty')
        			{
        			if(discper>0)
        				{
        		 
        		discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
        				}
        			}
        		}
        		
        		}
            	
    
            	netotal=parseFloat(total)-parseFloat(discount);
       
            	
            	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            	if(parseFloat(discount)>0 || parseFloat(discount)<0)
        		{
            		
            		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		
        		}
            	else
            		{
            		
            		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
            		
            		}
            	
            
            	
           // 	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            	
            //	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
           //  	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            	
            	
            	/*  	 if(datafield=='totwtkg' || datafield=='kgprice' || datafield=='qty' ){
            			unitprice=(parseFloat(kgprice)*parseFloat(totwtkg))/qty;
            			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",unitprice);
            		}
            		
            		if(datafield=='qty'  || datafield=='unitprice' ){
            			unitprice=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");
            			qty=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            			total=parseFloat(qty)*parseFloat(unitprice);
            			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
            		}
            		
            		if(datafield=='discper' ){
            			total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discper=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            			discount=(parseFloat(total)*parseFloat(discper))/100;
            			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
            			netotal=parseFloat(total)-parseFloat(discount);
            			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",netotal);
            		}
            		
            		
            		if(datafield=='dis' ){
            			total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
            			discount=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
            			discper=(100/parseFloat(total))*parseFloat(discount);
            			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",discper);
            			
            		} */ 
            	 
            	  if(datafield=='qty'){
                		
                		if(parseFloat(discper)>0)
                			{
                			
                		 	discount=(parseFloat(total)*(parseFloat(discper.toFixed(2))/100));
                			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "dis",discount);
                			}
          		  }
            		var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
	        		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
           document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
          document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
          document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
          
          var orderValue= parseFloat(document.getElementById("txtnettotal").value)+parseFloat(document.getElementById("nettotal").value);
      	funRoundAmt(orderValue,"orderValue");
          
       	var summaryData10= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
      	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
     	/*   
    	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
    	  */
    	 funRoundAmt4(aa1,"st");
    	 funRoundAmt4(aa1,"taxtotal");
            	   }
            
            
            
            $("#jqxSalesOrder").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		    
            		    
            		    if(datafield=='discper' && document.getElementById("cmbreftype").value=="DIR")
            		    	
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
            	   
            	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
                $('#sidesearchwndow').jqxWindow('close');
            		   }
            	   
            	   if(datafield=="productname")
            		   {
            		   	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "productname" ,$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
                        $('#sidesearchwndow').jqxWindow('close');
            		   
            		   }
            	   
            		  }
            	  
            	  if(datafield=='qty' || datafield=='dis' || datafield=='discper' || datafield=='unitprice'){	 
            		  valchange(rowBoundIndex,datafield);
            	  }
            	  
            	   	 if(datafield=='unitprice')
                    	 
            		 {
            		 
       	  		  var discount1=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "discper");
          		 
          		  
          		  if(parseFloat(discount1)==0)
      			  {
      		 
      			  }
          		  else
          			  {
          			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",0);
          			$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "discper",discount1);
          			  }
      		  
          		  
            		 
            		 }
              	  if(datafield=="netotal")
        		  {
              		  
              	
              		  var discount1=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "dis");
              		  var total=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "total");
              		 
              		  if(parseFloat(discount1)==0)
              			  {
              		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "netotal",total);
              			  }
              		  
        			var netotal=$('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "netotal"); 
        		
        		 	var taxper= $('#jqxSalesOrder').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
        		 	
        		 	if(parseFloat(taxper)>0)
        		 		{
        		 		
        		 		 
        		 	
        		 	
        		  
        		  	var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
        		  
        		  	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
        		  
        		  	var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
        		 	 
        		  	$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
        		  	
        			}
        		 	else
        		 		{
        		 		$('#jqxSalesOrder').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
        		 		}
              	  
              	  
        		  
        		 
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
                  //  document.getElementById("productname").focus();
                    	}
                
                
           
                $("#prosearch").jqxGrid('applyfilters');
                
        
            }
            
            if($('#mode').val()!="view"){
            	$("#jqxSalesOrder").jqxGrid('disabled', false);
            }
            
            if($('#cmbreftype').val()=='SQOT' ){
            	
            	if($('#mode').val()=="A"){	
            	
            var summaryData1= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
    		var summaryData= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'netotal', ['sum'],true);
    		var summaryData2= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
			
        document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
        document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
        document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
        document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
        
        
       	var summaryData10= $("#jqxSalesOrder").jqxGrid('getcolumnaggregateddata', 'taxperamt', ['sum'],true);
        
      	var aa1=summaryData10.sum.replace(/,/g,'');
  	   	
     	/*   
    	 var aa1 =parseFloat(aa)-parseFloat(document.getElementById("txtnettotal").value);
    	  */
    	 funRoundAmt4(aa1,"st");
    	 funRoundAmt4(aa1,"taxtotal");
		  funcalutax();
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
     
    	  
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'brandname');
    
    	  
    	  
        }
          else
      {
      
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'brandname');
      
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
    	 
    	  
    	  $('#taxsss').hide();
    	  
    	  
    	  $('#billname').show();
    	  $('#cmbbilltype').show();
    	  
    	 
    	  
    	  
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'taxper');
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'taxamount');
    	  $('#jqxSalesOrder').jqxGrid('showcolumn', 'taxperamt');
    
    	  
    	  
        }
          else
      {
        	  $('#taxsss').hide();
        	  
        	  $('#billname').hide();
        	  $('#cmbbilltype').hide();
        	  
        	  
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'taxper');
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'taxamount');
        	  $('#jqxSalesOrder').jqxGrid('hidecolumn', 'taxperamt');
      }
      
       }}
   x.open("GET","checktax.jsp?",true);
	x.send();
 
      
        
	
}   
</script>
<div id="jqxSalesOrder"></div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">


<input type="hidden" id="datas2"><!--  discount set at a time cellvalue change not working; -->
