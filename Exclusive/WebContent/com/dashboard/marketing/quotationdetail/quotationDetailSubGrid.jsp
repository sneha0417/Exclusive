<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% String contextPath=request.getContextPath();%>
 <%@page import="com.dashboard.marketing.quotationdetail.ClsQuotationDetailDAO"%> 
<%ClsQuotationDetailDAO DAO= new ClsQuotationDetailDAO();%>
 
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
var value;
$(document).ready(function () {
   var docno='<%=docno%>';
   
   if(doc_no>0){
		
	   matdata = '<%=DAO.quotSubGridLoad(session,docno) %>';
   	
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
	 value=aggregates['sum'];
	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
}
 
             
            
           	 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'desc1', type: 'string'  },
							{name : 'product', type: 'string' },
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
     						{name : 'tr_no', type: 'number'    },
     						
                        ],
                        
                        
                       
                         localdata: matdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            		
            };
            	
           
            $("#qutDetSubGrid").on("bindingcomplete", function (event) {
                document.getElementById("estimationtotal").value=value; 
          }); 
            
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#qutDetSubGrid").jqxGrid(
            {
                width: '100%',
                height: 240,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                statusbarheight: 21,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                pagermode: 'default',
/*                 handlekeyboardnavigation: function (event) {

                    var cell4 = $('#qutDetSubGrid').jqxGrid('getselectedcell');
                   
                    
                    if (cell4 != undefined && (cell4.datafield == 'productid' || cell4.datafield == 'brandname'  )) 
                    
                   {	 
                   	 
                   	 
                   	 
  	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
  	                 
  	                  if (key == 9) { 
  	                	  
  	                	$('#sidesearchwndow').jqxWindow('close');
  	                	  
  	             	   
	   	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');  
  	                	  
  	                	  
  	                   var prodocs=rows[0].doc_no;
  	                
  	                if(parseInt(rows[0].method)==0)
  	              	  {
  	              	  
  	            		var rows1 = $("#qutDetSubGrid").jqxGrid('getrows');
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
  	                	  
  	                	  
  	                	  
  	     
  	                	  
  	                	   
  	               	 var rows = $("#prosearchGrid").jqxGrid('getrows');
  	  		    
  	                	
  	                	   $('#qutDetSubGrid').jqxGrid('render');
  	              	  var rowindex1 =$('#rowindex').val();
  	              	  $('#datas1').val("0");
  	               $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proid" ,rows[0].part_no);
  	               $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "proname" ,rows[0].brandname);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "productid" ,rows[0].part_no);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,rows[0].brandname);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "prodoc" ,	rows[0].doc_no);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,rows[0].unit);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "unitdocno" ,rows[0].unitdocno);
  	                $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "psrno" ,rows[0].psrno ); 
  	              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindex1, "specid" ,rows[0].specid ); 
  	            $('#datas1').val("1");
  	        //  $("#qutDetSubGrid").jqxGrid('begincelledit', rowindex1, 'qty');
  	        
  	       
  	             $('#sidesearchwndow').jqxWindow('close'); 
  	                	   
  	          var rows = $('#qutDetSubGrid').jqxGrid('getrows');
               var rowlength= rows.length;
               if(rowindex1 == rowlength - 1)
               	{  
               $("#qutDetSubGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
               	} 
  	        	            } 
  	                   
  	          $("#qutDetSubGrid").jqxGrid('ensurerowvisible', rowlength);
            if (cell4 != undefined && cell4.datafield == 'productid') {
       
       		 
       		   document.getElementById("gridtext").focus();
       		 
            }
            if (cell4 != undefined && cell4.datafield == 'brandname') {
    	        
       		 
       		   document.getElementById("gridtext1").focus();
       		 
          }
              
            
                   } 
       		 
            
                    }, */
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Site', datafield: 'site', width: '10%',editable:true },
							{text: 'Service Type', datafield: 'sertype', width: '10%',editable:false },
							{ text: 'Description', datafield: 'desc1', width: '14%',editable:true },
							{ text: 'Product', datafield: 'productid',columntype: 'custom', width: '7%',cellclassname: cellclassname,
	                          	  
  							    createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							     
  							         editor.html('<input type="text" id="part_no" name="part_no" style="width:100%;height:99%;"   />' ); 
  							   
  							        
  							    },  
  							 
							},
  							 
							{ text: 'Brand', datafield: 'brandname', width: '10%'  ,cellclassname: cellclassname ,columntype: 'custom',
								

  								
  								createeditor: function (row, cellvalue, editor, cellText, width, height) {
  							       
  							         editor.html('<input type="text" id="brandname" name="brandname" style="width:100%;height:99%;"   />' ); 
  							     
  							        
  							    },  
							
							},
							
							{ text: 'Unit', datafield: 'unit', width: '7%',editable:false,cellclassname: cellclassname },	
							{ text: 'Quantity', datafield: 'qty', width: '6%',cellclassname: cellclassname, cellsformat: 'd2' },
							{ text: 'Amount', datafield: 'amount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname },
							{ text: 'Total', datafield: 'total', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,cellclassname: cellclassname },
							{ text: 'Margin', datafield: 'margin', width: '5%',cellclassname: cellclassname, cellsformat: 'd2', cellsalign: 'right' },
							{ text: 'Net Total', datafield: 'nettotal', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',aggregates: ['sum'],aggregatesrenderer: rendererstring ,editable: false,cellclassname: cellclassname},
							{text: 'pid', datafield: 'proid', width: '10%',cellclassname: cellclassname,hidden:true }, 
  							{text: 'pname', datafield: 'proname', width: '10%',cellclassname: cellclassname,hidden:true },
  							{text: 'prodoc', datafield: 'prodoc', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'unitdocno', datafield: 'unitdocno', width: '10%',cellclassname: cellclassname,hidden:true },
							{text: 'psrno', datafield: 'psrno', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'specid', datafield: 'specid', width: '10%',cellclassname: cellclassname,hidden:true}, 
							{text: 'brandid', datafield: 'brandid', width: '10%',cellclassname: cellclassname,hidden:true},
							{text: 'stypeid', datafield: 'stypeid', width: '10%',cellclassname: cellclassname,hidden:true},
							{ text: 'Tr No', datafield: 'tr_no',  width: '5%',hidden:true }, 
						]
            });
            
            
            $('#qutDetSubGrid').on('cellbeginedit', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var datafield=event.args.datafield;
            	 $('#datas').val("0");
            	  if(datafield == "productid")
            		  { 
            		 
                	 productSearchContent('productSearch.jsp?cldocno='+document.getElementById("cldocno").value+'&estdate='+document.getElementById("date").value+'&brhid='+document.getElementById("brhid").value);
            	     var rowindextemp = event.args.rowindex;
            	     document.getElementById("rowindex").value = rowindextemp;  
            	    
           var temp= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "productid"); 
           


           if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
           { 
          	 $('#gridtext').val("");  
          	 $('#part_no').val("");  
           }
           else
          	 {
          	 
          	 $('#part_no').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
               $('#gridtext').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));
              $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindextemp, "productid" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proid"));

               
          	 }
            
               
            		  } 
            	  
            	  
            	  if(datafield == "brandname")
        		  { 
            		productSearchContent('productSearch.jsp?cldocno='+document.getElementById("clientid").value+'&estdate='+document.getElementById("date").value);
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        	    
        	      var temp= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "brandname"); 
                
        	      
                // alert(temp);
                 if(temp==""||typeof(temp)=="undefined"|| typeof(temp)=="NaN")
        		   { 
              	   $('#gridtext1').val(""); 
              	   $('#brandname').val("");  
        		   }
                 else
                	 {
        	    

              	   $('#brandname').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
              	   $('#gridtext1').val($('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));
              	   
                     
                     $('#qutDetSubGrid').jqxGrid('setcellvalue', rowindextemp, "brandname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowindextemp, "proname"));

                     
                	 }
                  

         
        		  
            }	 
                   
                   });
            
            
            
           /*  function valchange(rowBoundIndex,datafield)
            {alert("fun");
            	//	 var summaryData1= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
            	//	var summaryData= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
	        	//	var summaryData2= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'dis', ['sum'],true);
        			
         // document.getElementById("estimationtotal").value=summaryData.sum.replace(/,/g,'');
            	   } */
            
            
            
            $("#qutDetSubGrid").on('cellvaluechanged', function (event) 
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
    	            
    	              if(datafield=="productid") {
    	            $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "productid" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "proid"));
    	               $('#sidesearchwndow').jqxWindow('close');
    	             }
    	            
    	              if(datafield=="brandname") {
    	               $('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandname" ,$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "proname"));
    	                     $('#sidesearchwndow').jqxWindow('close');
    	             }
    	            
    	             } 
    		    
    		    
    		    if(datafield=="qty" || datafield=="amount" || datafield=='margin' )
    		  {
    		    	
    		    qty= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
               	 amount= $('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "amount");
               	  total=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
     			 margin=$('#qutDetSubGrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");
               		
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
            
             			$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
             			$('#qutDetSubGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
           		   }
    		  
    		  }
    		    
    		    
    			/*  var summaryData3= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
 	         	document.getElementById("estimationtotal").value=summaryData3.sum.replace(/,/g,''); 
    		 */
    		      var summaryData1= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true); 
        		document.getElementById("estimationtotal").value=summaryData1.sum.replace(/,/g,''); 
        		
        		
        		
           		/*  document.getElementById("txtnettotal").value=grtotal.toFixed(2); */
           		
                   
            	
                    });
            
            
            
            var applyFilter = function (datafield,value) {
                
            	 if(parseInt($('#datas').val())!=1) {
                var filtertype = 'stringfilter';
              
              
                if (datafield == 'part_no' || datafield == 'brandname') filtertype = 'stringfilter';
                var filtergroup = new $.jqx.filter();
         
                    var filter_or_operator = 1;

                    var filtervalue = value;
    	            var filtercondition = 'starts_with';
                    
                    var filter = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
                    filtergroup.addfilter(filter_or_operator, filter);
               
                
                if (datafield == 'part_no') 
                	{
               
                $("#prosearchGrid").jqxGrid('addfilter', 'part_no' , filtergroup);
                //document.getElementById("part_no").focus();
                	}
                else  if (datafield == 'brandname') 
            	         {
                    
                    $("#prosearchGrid").jqxGrid('addfilter', 'brandname' , filtergroup);
                   // document.getElementById("brandname").focus();
                    	}
                
                
           
                $("#prosearchGrid").jqxGrid('applyfilters');
            	 }
          }
            
          /*   if($('#mode').val()!="view"){
            	$("#qutDetSubGrid").jqxGrid('disabled', false);
            } */
            
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#qutDetSubGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#qutDetSubGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#qutDetSubGrid").offset();
                       $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#qutDetSubGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#qutDetSubGrid").jqxGrid('getrowid', rowindex);
                      
                       $("#qutDetSubGrid").jqxGrid('deleterow', rowid);
                       var summaryData1= $("#qutDetSubGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true); 
               		document.getElementById("estimationtotal").value=summaryData1.sum.replace(/,/g,''); 
               		
                   }
               });
               
               $("#qutDetSubGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		  // if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                       $("#qutDetSubGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                 // }
        		   }
               });
                
              
               $('#qutDetSubGrid').on('celldoubleclick', function(event) 
               		{
               	var rowBoundIndex = event.args.rowindex;
               	var datafield = event.args.datafield;
               	 
    		      if((datafield=="sertype"))
   	    	   {
    		    	getservicetype(rowBoundIndex);
   	    	   } 
   		     
               			
               		});
               
               $("#qutDetSubGrid").jqxGrid('addrow', null, {"scopeproduct": "1"});
        });
        
        
</script>

<div id='jqxWidget'>
   <div id="qutDetSubGrid"></div>
    <div id="popupWindow">
 
 <div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
<input type="hidden" id="rowindex">
<input type="hidden" id="datas">
<input type="hidden" id="datas1">


