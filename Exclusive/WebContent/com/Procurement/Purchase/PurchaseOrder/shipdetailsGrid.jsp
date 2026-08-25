 
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

/* String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 
 String refnosss=request.getParameter("refnosss")==null?"0":request.getParameter("refnosss");
 
 String datess=request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");
 String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype");
 
 String acno=request.getParameter("acno")==null?"0":request.getParameter("acno"); */
 
 String aa=request.getParameter("aa")==null?"0":request.getParameter("aa"); 
 
 
 String masterdoc=request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc"); 
 String formcode=request.getParameter("formcode")==null?"0":request.getParameter("formcode"); 
 
%>
 
 
 <%@page import="com.procurement.purchase.purchaseorder.ClspurchaseorderDAO"%>
<% ClspurchaseorderDAO purchaseorderDAO = new ClspurchaseorderDAO(); %> 
 
 
 
 
<script type="text/javascript">

var shipdatas;

var temps='<%=aa%>';

if(temps='yes')
	{
	 
	shipdatas='<%=purchaseorderDAO.reloadshipSearch(session,masterdoc,formcode) %>';
	}
else
	{
	shipdatas; 
	}



            	
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                            
     		 				{name : 'doc_nos', type: 'int' },
     						{name : 'desc1', type: 'string'  },
     						{name : 'refno', type: 'string'   },
     						{name : 'date', type: 'date'  },
     						
     						
     						
     											
                 ],
                 localdata: shipdatas,
                
                
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

            
            
            $("#shipdata").jqxGrid(
            {
                width: '100%',
                height: 127,
                source: dataAdapter,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#shipdata').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'desc1') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex2").value = cell1.rowindex;
                       
                         	shipdescSearchContent('deldetailSearch.jsp');
                        	 $('#shipdata').jqxGrid('render');
                        }
                        }
                   
              
              
                  },    
              
                columns: [
                            { text: 'masterDoc NO', datafield: 'doc_nos', width: '10%' ,hidden:true},	
                            { text: 'Description', datafield: 'desc1', width: '55%' ,editable: false},
							{ text: 'RefNo', datafield: 'refno', width: '27%', editable: true },
							{ text: 'Date', datafield: 'date',columntype: 'datetimeinput', width: '18%' ,cellsformat:'dd.MM.yyyy', editable: true},
							
							
							//{ text: 'hiddate', datafield: 'hiddate',columntype: 'datetimeinput', width: '18%' ,cellsformat:'dd.MM.yyyy', editable: true},
							
							
							

							
							
			              ]
               
            });
         /*    if(temps=='yes')
        	{
           
        	}
            else
            	{
            	 $("#shipdata").jqxGrid('addrow', null, {});
                 
            	} */
            	
            	
            	
                var rows = $('#shipdata').jqxGrid('getrows');
            	
            	
                var rowlength= rows.length;
                
                if(rowlength ==0)
                	{  
                $("#shipdata").jqxGrid('addrow', null, {});
                	} 
                	  
                $('#shipdata').on('cellvaluechanged', function (event) {
   			     var rowindex1=event.args.rowindex;
   			     var rows = $('#shipdata').jqxGrid('getrows');
   	               var rowlength= rows.length;
   	               if(rowindex1 == rowlength - 1)
   	               	{  
   	            	  
   	               $("#shipdata").jqxGrid('addrow', null, {});
   	               
   	            
   	         
   	               	}    
   			     
   			     
   			 }); 
 /*        
            $("#shipdata").on('cellvaluechanged', function (event) 
            		{
            		    
            	  document.getElementById("errormsg").innerText="";
            		    
            		});  
             */
            
         
         
         if(($('#mode').val()=='A')||($('#mode').val()=='E'))
 		       {
 		  $("#shipdata").jqxGrid({ disabled: false}); 
 		    
 		       
 		       
 		       
 		       }
      
   
             

         $('#shipdata').on('celldoubleclick', function (event) {
        	 var datafield = event.args.datafield;
		       
		    
		      if(datafield=="desc1")
		           {
         		
           	 var rowindextemp = event.args.rowindex;
           	    document.getElementById("rowindex2").value = rowindextemp;  
           	  $('#shipdata').jqxGrid('clearselection');
           	shipdescSearchContent('deldetailSearch.jsp');
           	
           		  } 
           	  
 
    
           	
           	  
               }); 
         
        }); 
         
         /*  $("#shipdata").on('cellvaluechanged', function (event) 
       		   {
       		        		  
       		       var rowBoundIndex = event.args.rowindex;
       		       
       		       var datafield = event.args.datafield;
       		       
        		       
       		      if(datafield=="date")
     		           {
       		    	  
       		    	 
         		    	  
         		    	   var text1 = $('#shipdata').jqxGrid('getcelltext', rowBoundIndex, "date");
      		        	// alert(text1);
      		        	  $('#shipdata').jqxGrid('setcellvalue',rowBoundIndex, "hiddate",text1);
       		       
       		     
     		           }
         
         
             
        }); */
    </script>
    
    <input type="hidden" id="rowindex2">
    <div id=shipdata></div>
 