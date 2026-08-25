<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO"%>
<%
ClsHotelDAO cd=new ClsHotelDAO();
%>

<% String docno = request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String id = request.getParameter("id")=="" || request.getParameter("id")==null?"0":request.getParameter("id"); %>
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<% String contextPath=request.getContextPath();%>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getHotelGrid(docno,id)%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'roomtype', type: 'string'  },
   						
   						{name : 'category', type: 'string'  },
   						{name : 'rtypeid', type: 'string'  },
   						{name : 'name', type: 'string'  },
   						{name : 'adult', type: 'string'  },
   						{name : 'child', type: 'string'  },
   						{name : 'extrabed', type: 'string'  },
   						{name : 'btnattach', type: 'string'  },
   						{name : 'srno', type: 'string'  },
   						{name : 'roomsize', type: 'string'  },
   						{name : 'adultonly', type: 'string'  },
   						{name : 'maxcount', type: 'string'  }
   						               ],
               localdata: driverdata,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
        
        
          $("#jqxHotel").jqxGrid(
          {
              
              						
				
                        width: '100%',
                        height: 250,
                        source: dataAdapter,
             			editable:true,
             			//columnsresize: true,
                		showfilterrow:true,
                		filterable:true,
                		enableAnimations: true,
		                enabletooltips:true,
		                filtermode:'excel',		    
		                sortable:true,
		                selectionmode: 'singlecell',
		                handlekeyboardnavigation: function (event) {
		                   	
		                	 var cell1 = $('#jqxHotel').jqxGrid('getselectedcell');
		                	 if (cell1 != undefined && cell1.datafield == 'roomtype') {  
		                	
		                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                        if (key == 114) {  
		                         	 document.getElementById("gridrowindex").value = cell1.rowindex;
		                       
		                        	roominfoSearchContent('roomsearch.jsp');
		                        	 $('#jqxHotel').jqxGrid('render');
		                        }
		                        }
		                   
		               
		              
		              
		                  }, 
		                
		               
             			
             			
             			
                        columns: [
        					
        					 
        					 { text: 'Room Type', datafield: 'roomtype',editable: true, width: '25%' },

        					 { text: 'Category', datafield: 'category',editable: true, width: '10%' },
        					 { text: 'Name', datafield: 'name',editable: true },
        					 { text: 'Room Size', datafield: 'roomsize',editable: true, width: '6%' },
        					 { text: 'Max Count', datafield: 'maxcount',editable: true, width: '6%' },
        					 { text: 'Adult Only', datafield: 'adultonly',editable: true, width: '6%' },
        					 { text: 'Max Adult', datafield: 'adult',editable: true, width: '6%' },
        					 { text: 'Max Child', datafield: 'child',editable: true, width: '6%' },

        					 { text: 'Extra Bed', datafield: 'extrabed',editable: true, width: '6%' },
        					 { text: ' ', datafield: 'btnattach',columntype: 'button',editable:false, filterable: false ,width: '6%'},
        					 { text: 'rdocno', datafield: 'srno',editable: true,hidden:true },
        					 { text: 'RTypeid', datafield: 'rtypeid',editable: true,hidden:true },
        					
        					]
                    });
          //Add empty row          
          
            
             /* if(temp>0){
             	$("#jqxHotel").jqxGrid('disabled', true);
             } */
             $('#jqxHotel').on('celldoubleclick', function (event) 
               		{ 
            	 var datafield = event.args.datafield;
            	 var columnindex1=event.args.columnindex;
             	  if(datafield =="roomtype")
             		  { 
           		
             	 var rowindextemp = event.args.rowindex;
             	    document.getElementById("gridrowindex").value = rowindextemp;  
             	  $('#jqxHotel').jqxGrid('clearselection');
             	roominfoSearchContent('roomsearch.jsp');
             	
             		  } 
     		                 }); 
     		  $("#jqxHotel").on('cellclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            		    
            		    
             			 if(datafield=="btnattach"){
                       	
                       		 
                       		 document.getElementById("chng").value=$('#jqxHotel').jqxGrid('getcellvalue',rowBoundIndex, "srno");
                       		 
                       		
                       		 
                       		
                       		 funAttachBtn();
                       		 
                       		 
             			 }
             			 
            
     		  
     
   
                   });
      });             
              function funAttachBtn(){
              
              var brchid='<%=session.getAttribute("BRANCHID").toString()%>';
              var tempk= document.getElementById("chng").value;
        	  var code="HTL";
        	  $("#windowattach").jqxWindow('setTitle',"HTL - "+tempk);
        		changeAttachContent("<%=contextPath%>/com/controlcentre/masters/relatedmaster/Attach.jsp?formCode="+code+"&docno="+tempk+"&barchvals="+brchid);		
        	
        	
        }
      
</script>
<div id="jqxHotel"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 
<input type="hidden" id="chng" name="chng">