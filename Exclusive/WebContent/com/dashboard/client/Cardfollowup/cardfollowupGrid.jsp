 


 
 <%
           	String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
           String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
       
           	  %> 
           	  
           	  
  
<script type="text/javascript">
 var temp4='<%=barchval%>';
var expdata;

 if(temp4!='NA')
{ 
	
	<%--  expdata='<%=com.dashboard.client.ClsClientDAO.cardfollowup(barchval,type)%>'; --%> 

	//alert(ssss);
} 
else
{ 
	
	expdata;

	}  
 var list =['Release','Extended'];
$(document).ready(function () {
   
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'type', type: 'String'  },
						{name : 'rdocno', type: 'String'  },
						 {name : 'cldocno', type: 'String'  }, 
						 {name : 'refname', type: 'String'  }, 
						{name : 'cardno', type: 'string'  },
						 {name : 'amount', type: 'string'  }, 
						{name : 'reldate', type: 'date'  },
						{name : 'action', type: 'String'  },
						{name : 'btnsave', type: 'String'  },
						{name : 'pytdoc', type: 'String'  },				
		        		{name : 'extdate', type: 'date'  },
						{name : 'remarks', type: 'string'  },
						{name : 'brhid', type: 'string'  },
						{name : 'voc_no', type: 'string'  }
		        		
						
					
		        		/* SELECT RIGHT(cardno , 4)  cardno FROM gl_rpyt;	 */
					
						
						],
				    localdata: expdata,
        
        
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
    
    
   
   
    
    $("#followup").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:true,
        columns: [   
                  



                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
				     { text: 'TYPE', datafield: 'type', editable:false, width: '6%' },
				     { text: 'PytDoc', datafield: 'pytdoc', editable:false, width: '5%',hidden:true },
				     { text: 'RANO', datafield: 'voc_no', editable:false, width: '5%' }, 
				     { text: 'Client No',datafield: 'cldocno',editable:false, width: '14%',hidden:true },
				     { text: 'Client Name',datafield: 'refname',editable:false, width: '15%' },
					 { text: 'Card No',datafield: 'cardno', editable:false,width: '8%' },
					 { text: 'Amount',datafield: 'amount',editable:false, width: '10%' },
					 { text: 'Release Date', datafield: 'reldate',editable:false, width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Action',datafield: 'action',editable:true, width: '8%' ,
						 cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
		                       editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list });
		                        
							
							}	 
					 
					 
					 
					 },
					 { text: ' ', datafield: 'btnsave', width: '7%',columntype: 'button',editable:false, filterable: false},
					 { text: 'Extended Date', datafield: 'ex_date', width: '9%',editable:true,columntype: 'datetimeinput',cellsformat:'dd.MM.yyyy',
						 cellbeginedit: function (row) {
								var temp=$('#followup').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 },
						 
						 cellbeginedit: function (row) {
								var temp=$('#followup').jqxGrid('getcellvalue', row, "action");
								 if (temp =="Release")
								       return false;
							     
						 }
					 },
					 { text: 'Remarks', datafield: 'rem', width: '20%',editable:true,
						 cellbeginedit: function (row) {
								var temp=$('#followup').jqxGrid('getcellvalue', row, "btnsave");
								 if (temp =="Edit")
								       return false;
							     
						 }},
					
					
						 { text: 'Branch',datafield: 'brhid', editable:false,width: '8%',hidden:true },
					     { text: 'RANO', datafield: 'rdocno', editable:false, width: '5%',hidden:true }, 
					]
   
    });

});


$("#overlay, #PleaseWait").hide();
$("#followup").on('cellvaluechanged', function (event) 
		{

	  var datafield = event.args.datafield;
		    var rowBoundIndex = event.args.rowindex;
		    if(datafield=="action")
		    
		    
		    $("#followup").jqxGrid('setcellvalue', rowBoundIndex, "ex_date", "");
		    
		    

		});






$("#followup").on('cellclick', function (event) 
		{
		 
		    var datafield = event.args.datafield;

		    var rowBoundIndex = event.args.rowindex;
		    
		    
		    var columnindex = event.args.columnindex;
		  
		    
		  if(columnindex>8)
			  {
			  if(columnindex!=10)
				  {
			  if($('#followup').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Edit"){
				  
				  $.messager.alert('Message',' Click Edit Button ','warning');     
			    	
				 	
			            }
			  
				  }
			  
			  
			  }
		   if(datafield=="ex_date")
		    {
			   var act=$('#followup').jqxGrid('getcellvalue', rowBoundIndex, "action");
			   
			   if(act=="Release")
      		      {
				   $.messager.alert('Message',' Extended Date Not Enter In Release ','warning');   
				   
			            			
      		      }
			   }	  
		 	
			   
		    	
		  
		  		   
		    
          if(datafield=="btnsave"){
        	  
        	 if($('#followup').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Save"){
        		
        		 var clientid= $('#followup').jqxGrid('getcellvalue', rowBoundIndex, "cldocno");
        		 var type= $('#followup').jqxGrid('getcellvalue',rowBoundIndex, "type");
      
        		 var exdate= $('#followup').jqxGrid('getcelltext', rowBoundIndex, "ex_date");

        		 var renval=$('#followup').jqxGrid('getcellvalue',rowBoundIndex, "rem");
        		 var rdocno=$('#followup').jqxGrid('getcellvalue',rowBoundIndex, "rdocno");
        		 
        		 var pytdoc=$('#followup').jqxGrid('getcellvalue',rowBoundIndex, "pytdoc");
        		 
        		 var action=$('#followup').jqxGrid('getcellvalue',rowBoundIndex, "action");
        		 
        		var branchid=$('#followup').jqxGrid('getcellvalue',rowBoundIndex, "brhid");
        		      	
	        		      		 if(action==""||typeof(action)=="undefined")
			            		 {
	        		      			  $.messager.alert('Message',' Select Action ','warning');   
			                         
			            			  
			            				return false; 
			          
			            		 }  
	        		      		
        		      		
		        		      		 if(action=="Extended")
				            		 {
		        		                         
								            		  if(exdate==""||exdate==null||typeof(exdate)=="undefined")
								            		 {
								            			
								            			  $.messager.alert('Message','  Enter Extended Date ','warning'); 
										                        
										            			  
										            				return false; 
								            			
								                       }
						            		  
				            		 }		  
				            	  if(renval==""||typeof(renval)=="undefined")
					            		 {
				            		  $.messager.alert('Message','  Enter Remarks  ','warning'); 
					                         
					            			   
					            				return false; 
					          
					            		 }  
        		 
			            		 var nmax = renval.length;
			            		
			            		
			     		           if(nmax>99)
			     		        	   {
			     		        	  $.messager.alert('Message',' Remarks Cannot Contain More Than 100 Characters','warning'); 
			     		        	   
			     		        	
			             				return false; 
			     		        	   
			     		        	 
			     		        	   } 
			     		           
			     		           
			     		          
			     	        	   $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			     	 		        	  
			     	 	     		       
			     					       		        	if(r==false)
			     					       		        	  {
			     					       		        		return false; 
			     					       		        	  }
			     					       		        	else{
			     					       		        	
			     					        				 savegriddata(clientid,type,exdate,renval,rdocno,pytdoc,action,branchid);
			     					       		        	   }
			     	 		                      });
			     		           
			     		           
			     		           
        		    	}
 		        
        	
        	 else {
        		 
        	
        	  $('#followup').jqxGrid('setcellvalue',rowBoundIndex, "btnsave","Save");
        	    }
          }
		   
		}); 




function savegriddata(clientid,type,exdate,renval,rdocno,pytdoc,action,branchid)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
		
		 	var items= x.responseText;
		 	
		
		 	 $.messager.alert('Message', 'Record successfully Updated ', function(r){
				     
			     });
		 	 
		 	funreload(event);
		 	 
    }
	}
     x.open("GET","savecardgriddate.jsp?clientid="+clientid+"&type="+type+"&exdate="+exdate+"&renval="+renval+"&rdocno="+rdocno+"&pytdoc="+pytdoc+"&action="+action+"&branchid="+branchid,true);
    x.send();
   
  
}
</script>
<div id="followup"></div>