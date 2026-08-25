<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
  <%@page import="com.dashboard.projectexecution.engineeringconfirmationupdate.ClsEngineeringConfirmationDAO"%>
<%
ClsEngineeringConfirmationDAO DAO=new ClsEngineeringConfirmationDAO();
%>
 
<%

//int loadid =request.getParameter("loadid")==null?0:Integer.parseInt(request.getParameter("loadid").trim()); 
String enqtrno=request.getParameter("enqtrno")==null?"0":request.getParameter("enqtrno").trim();
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String estdate=request.getParameter("estdate")==null?"0":request.getParameter("estdate").trim();
String ecmno=request.getParameter("ecmno")==null?"0":request.getParameter("ecmno").trim();
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
	chkproductconfig();
	 var cldocno='<%=cldocno%>';
	 var estdate='<%=estdate%>';
	 
   var enqtrno='<%=enqtrno%>';
  
   if(enqtrno>0){
	  
	   matdata='<%=DAO.materialGridReLoad(session,enqtrno,ecmno)%>';
	   loadSubGridDataexcel= '<%=DAO.materialGridReLoadexcel(session,enqtrno,ecmno) %>';
   }
   else{
	   matdata=[];   
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
 	

	      $("#prosearchGrid").jqxGrid('clearfilters');
	  
 //alert("gridtext="+$(this).val());
     $('#proname').val($(this).val());
     var dataField = "proname";
applyFilter(dataField,$(this).val());  
     
     
     
 });
 

 $('#gridtext1').keyup(function(){
 	

	      $("#prosearchGrid").jqxGrid('clearfilters');
	  

   $('#brandname').val($(this).val());
   var dataField = "brandname";
   applyFilter(dataField,$(this).val());  
   
   
   
});            

            
           	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
							{name : 'brand', type: 'string' },
     						{name : 'productid', type: 'string' },
     						{name : 'activity', type: 'string' },
     						{name : 'activityid', type: 'string' },
     						{name : 'brandname', type: 'string'},
     						{name : 'unit', type: 'string'  },
     						{name : 'qty', type: 'number'  },
     						{name : 'amount', type: 'number'  },
     						{name : 'total', type: 'number'  },
     						{name : 'nettotal', type: 'number'  },
     						{name : 'margin', type: 'number'  },
     						{name : 'invoiced', type: 'bool'  },
                    		{name : 'proname', type: 'string'    },
                    		{name : 'prodoc', type: 'number'    },
     						{name : 'unitdocno', type: 'number'    },
     						{name : 'psrno', type: 'number'    },
     						{name : 'proid', type: 'number'    },
     						{name : 'specid', type: 'number'    },  
     						{name : 'stypeid', type: 'number'    },
     						{name : 'site', type: 'string'    },
     						{name : 'sertype', type: 'string'    },
     						{name : 'brandid', type: 'number'    }, 
     						{name : 'productname', type: 'string'  },
     						{name : 'sitesrno', type: 'string'  },
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
             
            	  $("#materialEstPriceGrid").on("bindingcomplete", function (event) {
            			
                    	 var rowlength=$("#materialEstPriceGrid").jqxGrid('rows').records.length;
                    	 
                    	if(rowlength>0){
                    		var summaryData1= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
                    		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
                    		 var txtmatotal=document.getElementById("txtmatotal").value;
                       		
                       		 var grtotal=(parseFloat(txtmatotal));
                       		 document.getElementById("txtnettotal").value=grtotal;
                       		
                   
            		 }
                       });  
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#materialEstPriceGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                columnsresize:true,
                filterable:true,
                showfilterrow:true,
              //  disabled:true,
                statusbarheight: 21,
                editmode: 'selectedcell',
                selectionmode: 'singlecell',
                pagermode: 'default',
  handlekeyboardnavigation: function (event) {

                	
                    var cell4 = $('#materialEstPriceGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'proname' || cell4.datafield == 'brandname'  )) 
                    
                   {	 
                   
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	               
  	                  if (key == 9) { 
  	                	  
   	                	 if(cell4.datafield == 'proname')
 	                		  {
 	                		var aa= $('#proname').val();
 	                		  }
 	                	  else if(cell4.datafield == 'brandname')
 	                		  {
 	                		var aa= $('#brandname').val();  
 	                		  }
 	                		
 	                 
                    if(typeof(aa)=="undefined")
                    
                    	{
                    	 
                    	return 0;
                    	}
                    
  	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');
  	  		     	
  	                	   $('#materialEstPriceGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	
  	              	  $('#datas1').val(0);
  	              
  	            $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "product" ,rows[0].productname);
  	           $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "brand" ,rows[0].brandname);
  	            $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	             $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].productname);       
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
                   $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,rows[0].doc_no);
               
                   $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "amount" ,rows[0].amount);
                $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindex1, "brandid" ,rows[0].brandid);
  	  			
  	              
  
  	            $('#datas1').val(1);
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#materialEstPriceGrid').jqxGrid('getrows');
               var rowlength= rows.length;
           
               if(rowindex1 == rowlength -1)
               	{  
            	
               $("#materialEstPriceGrid").jqxGrid('addrow', null, {});
               	} 
               $("#materialEstPriceGrid").jqxGrid('ensurerowvisible', rowlength);
  	        	            } 
  	                   
  	                if (key != 13) {   
  	            	  if(document.getElementById("productchk").value==0)
  					{
            if (cell4 != undefined && cell4.datafield == 'proname') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'brandname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
  					}
  	                }
                   } 
       		 
            
                    },
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Site', datafield: 'site', width: '15%',editable:false },
							{text: 'Service Type', datafield: 'sertype', width: '10%',editable:false },
							{ text: 'Description', datafield: 'desc1', width: '27%',editable:true },
							
							{text: 'product id', datafield: 'productid', width: '10%',editable:false,hidden:true },	 

							{ text: 'Product', datafield: 'proname', width: '12%',cellclassname: cellclassname,columntype: 'custom',
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="proname" name="proname" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    }, 
  							 
  							 
							},
  							 
							{ text: 'Brand', datafield: 'brandname', width: '12%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  							 createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="brandname" name="brandname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},
							
							{ text: 'Unit', datafield: 'unit', width: '5%',editable:false,cellclassname: cellclassname },	
							{ text: 'Quantity', datafield: 'qty', width: '5%',cellclassname: cellclassname, cellsformat: 'd2' },
							{ text: 'Amount', datafield: 'amount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname ,hidden:true},
							{ text: 'Margin', datafield: 'margin', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right',hidden:true },
							{ text: 'Net Total', datafield: 'nettotal', width: '9%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false,cellclassname: cellclassname,hidden:true},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'productname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true}, 
							{text: 'brandid', datafield: 'brandid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'stypeid', datafield: 'stypeid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'sitesrno', datafield: 'sitesrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'product', datafield: 'product', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'brand', datafield: 'brand', width: '10%',cellclassname: cellclassname,hidden:true},
							/* { text: 'Invoiced', datafield: 'invoiced', columntype: 'checkbox', editable: true, checked: true, width: '5%',cellsalign: 'center', align: 'center' }, */
						]
            });
            
            $('#materialEstPriceGrid').on('cellbeginedit', function (event) {
                
                $('#datas').val(0);
            	var columnindex1=event.args.datafield;

            	// alert("in "+columnindex1);
            	  if(document.getElementById("productchk").value==0)
  					{
            	  
            	if(columnindex1 == "proname")
        		  { 
            	
            		productSearchContent('productSearch.jsp?id=1');
        							 var rowindextemp = event.args.rowindex;
        							    document.getElementById("rowindex").value = rowindextemp;  
        							    
        							      var temp= $('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "proname"); 
        						        
        							      
        						       //  alert(temp);
        						         if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        								   { 
        						      	   $('#gridtext').val(""); 
        						      	   $('#proname').val("");  
        								   }
        						         else
        						        	 {
        							    
        						
        						      	   $('#proname').val($('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
        						      	   
        						      	   $('#gridtext').val($('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
        						      	   
        						             
        						             $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindextemp, "proname" ,$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "product"));
        						
        						             
        						        	 }
                  
        	    		}
         
        	
                
            	
            	if(columnindex1 == "brandname")
      		  { 
          		 /*  if(document.getElementById("errormsg").innerText!="")
            		 {
               		   
            		 return 0;
            		 }	 */
        	    	
      	    		  
      	    		 
          		productSearchContent('productSearch.jsp?id=1');
      							 var rowindextemp = event.args.rowindex;
      							    document.getElementById("rowindex").value = rowindextemp;  
      							    
      							      var temp= $('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "brandname"); 
      						        
      							      
      						        // alert(temp);
      						         if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
      								   { 
      						      	   $('#gridtext1').val(""); 
      						      	   $('#brandname').val("");  
      								   }
      						         else
      						        	 {
      							    
      						
      						      	   $('#brandname').val($('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
      						      	   
      						      	   $('#gridtext1').val($('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
      						      	   
      						             
      						             $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowindextemp, "brandname" ,$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowindextemp, "brand"));
      						
      						             
      						        	 }
                
      	    		}
       
  					}
                   
                   });

                 
            
            function valchange(rowBoundIndex,datafield)
            {
            	//	 var summaryData1= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            		var summaryData= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	        	//	var summaryData2= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
     //      document.getElementById("txtproductamt").value=summaryData1.sum.replace(/,/g,''); 
       //   document.getElementById("txtdiscount").value=summaryData2.sum.replace(/,/g,''); 
          document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
         // document.getElementById("orderValue").value=summaryData.sum.replace(/,/g,''); 
            	   }
            
            
            
            $("#materialEstPriceGrid").on('cellvaluechanged', function (event) 
                    {
            	
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		    var discount=0;
    		    var margin=0;  
    		    var total=0;
    		    var qty=0;
    		    var amount=0;
    		    var nettotal=0;
    		    
    		    if(parseInt($('#datas').val())!=1) {
    	            
  	              if(datafield=="proname") {
  	            $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowBoundIndex, "proname" ,$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "product"));
  	               $('#sidesearchwndow').jqxWindow('close');
  	             }
  	            
  	              if(datafield=="brandname") {
  	               $('#materialEstPriceGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandname" ,$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "brand"));
  	                     $('#sidesearchwndow').jqxWindow('close');
  	             }
  	            
  	            }
  		    
    		    
    		    
    		    if(datafield=="qty" || datafield=="amount" || datafield=='margin' )
    		  {
    		    	
    		    qty= $('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	 amount= $('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               	  total=$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
     			 margin=$('#materialEstPriceGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
               		
     			if(( margin=="" || typeof(margin)=="undefined" || typeof(margin)=="NaN" ))
	       		   {
	                		
		    		 margin=0;
	              	    
	       		   }
     			 
    		    	if(!(qty==""||typeof(qty)=="undefined"|| typeof(qty)=="NaN" || amount=="" || typeof(amount)=="undefined" || typeof(amount)=="NaN"))
           		   {
    		    		total=parseFloat(qty)*parseFloat(amount);
    		    		nettotal=total;
    		    		discount=parseFloat(margin);
            			nettotal=parseFloat(total)+parseFloat(discount);
            
             			$('#materialEstPriceGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			$('#materialEstPriceGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
           		   }
    		  
    		  }
    		
    		     var summaryData1= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
        		document.getElementById("txtmatotal").value=summaryData1.sum.replace(/,/g,''); 
        		
        		
        		 var txtmatotal=document.getElementById("txtmatotal").value;
           		
           		 var grtotal=(parseFloat(txtmatotal));
           		 document.getElementById("txtnettotal").value=grtotal.toFixed(2);
           		
                   
            	
                    });
           
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context Menu1
               var contextMenu = $("#Menu1").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#materialEstPriceGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu1").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#materialEstPriceGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#materialEstPriceGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#materialEstPriceGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#materialEstPriceGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#materialEstPriceGrid").jqxGrid('deleterow', rowid);
                       var summaryData= $("#materialEstPriceGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
       	        	
                 document.getElementById("txtnettotal").value=summaryData.sum.replace(/,/g,'');
                   }
               });
               
               $("#materialEstPriceGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		//   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#materialEstPriceGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                //   }
        		   }
               });
                
              
               $('#materialEstPriceGrid').on('celldoubleclick', function(event) 
               		{
               	var rowBoundIndex = event.args.rowindex;
               	var datafield = event.args.datafield;
           	 
        	  if(datafield == "proname")
	  { 
       		  if(document.getElementById("productchk").value==1)
					{
				   	 productSearchContent('productMasterSearch.jsp');
			  		}
	   		  else{
 				//productSearchContent('productSearch.jsp?id=1');
	   			  }
var rowindextemp = event.args.rowindex;
   document.getElementById("rowindex").value = rowindextemp;  
   



	  } 
 
 
  if(datafield == "brandname")
 { 
	   if(document.getElementById("productchk").value==1)
		{
	   	 productSearchContent('productMasterSearch.jsp');
  		}
	  else{
		//productSearchContent('productSearch.jsp?id=1');
		  }
var rowindextemp = event.args.rowindex;
document.getElementById("rowindex").value = rowindextemp;  
 
} 	 

    		      if((datafield=="sertype"))
   	    	   {
    		    	getservicetype(rowBoundIndex);
   	    	   } 
    		      if((datafield=="site"))
     	    	   {
   		    	  var contracttrno=document.getElementById("hidcontracttrno").value;
   		    	 
   		    	  var id=0;
   		    	
   		    	  if(contracttrno>0){
   		    		 id=4;
   		    		  getsite(rowBoundIndex,contracttrno,id);
   		    	  }
   		    	 
     	    	   } 
               			
               		});
               
               $("#materialEstPriceGrid").jqxGrid('addrow', null, {});    
            	  
            	                
        });
        



var applyFilter = function (datafield,value) {
	 if(document.getElementById("productchk").value==0)
		{
	    if(parseInt($('#datas').val())!=1)
		  {   
    var filtertype = 'stringfilter';
  
		//  alert(datafield+"="+value);
  
    if (datafield == 'proname' || datafield == 'brandname') filtertype = 'stringfilter';
    var filtergroup = new $.jqx.filter();

        var filter_or_operator = 1;

        var filtervalue = value;
        var filtercondition = 'starts_with';
        
        var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
        filtergroup.addfilter(filter_or_operator, filter);
   
    
    if (datafield == 'proname') 
    	{
   
    $("#prosearchGrid").jqxGrid('addfilter', 'productname' , filtergroup);
 //   document.getElementById("part_no").focus();
    	}
    else  if (datafield == 'brandname') 
	         {
        
        $("#prosearchGrid").jqxGrid('addfilter', 'brandname' , filtergroup);
      //  document.getElementById("productname").focus();
        	}
    
    

    $("#prosearchGrid").jqxGrid('applyfilters');
    
		  }
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
    	 
    	     $('#materialEstPriceGrid').jqxGrid('setcolumnproperty','proname','editable',false);
    	   	$('#materialEstPriceGrid').jqxGrid('setcolumnproperty','brandname','editable',false);
    	   		
    	   } 
        
          else
      {
        	   document.getElementById("productchk").value=0; 
        	   $('#materialEstPriceGrid').jqxGrid('setcolumnproperty','proname','editable',true);
       	   	$('#materialEstPriceGrid').jqxGrid('setcolumnproperty','brandname','editable',true);
      }
      
       }}
   x.open("GET","checkproductconfig.jsp?",true);
	x.send();

	
} 

      
</script>

<div id='jqxWidget'>
   <div id="materialEstPriceGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu1'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">
