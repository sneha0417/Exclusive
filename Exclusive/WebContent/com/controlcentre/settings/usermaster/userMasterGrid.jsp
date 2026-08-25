<%@page import="com.controlcentre.settings.usermaster.ClsUserMasterDAO" %>
<%ClsUserMasterDAO cud=new ClsUserMasterDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");%>  
<script type="text/javascript">
	 
        $(document).ready(function () { 
      
            var datahhhhh='<%=cud.FillGridDetails(docNo)%>'; 
            	  
       var sss='<%=docNo%>';
            var source =
            {
                datatype: "json",
                datafield: [
                             
							/* {name : 'chk', type: 'bool' }, */
							{name : 'brhid', type: 'number' },
    						{name : 'branchname', type: 'string' }, 
     						{name : 'compid', type: 'String' },
-     						{name : 'company', type: 'string'},
                             {name : 'srno', type: 'string'},
                           
                             
                        ],
                         localdata: datahhhhh,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        
     /*  if(sss>0)
    	 { */
    	 
    	  
    	 
    	 if($('#mode').val()=="view")
     		
 		{
    	 
            if($('#permissionval').val()=="1")
      	         {
            	
         
         	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
            	
      	           }
        	  
 		}
    	/*  }    */
      
      
      /* if($('#mode').val()=="E")
    	  {
    	  
    	  if($('#permissionval').val()=="1")
	         {

    		  $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	         }
    	  
    	  
    	  } */
      
                  
                  $("#jqxUserMaster").on("bindingcomplete", function (event) {
                
                	  
                	  var rows = $("#jqxUserMaster").jqxGrid('getrows');   
                	
                
                	  
                	  for(var i=0;i<rows.length;i++){
                		  
                		  var aa= $('#jqxUserMaster').jqxGrid('getcellvalue',i, "srno");
                		  
                		
                		  if(aa!='NA'){
                			  
                			
                			   $('#jqxUserMaster').jqxGrid('selectrow',i);   
                		  }
                		  
                	  }
                	  
                	  

                	  
                	  
                  }); 
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxUserMaster").jqxGrid(
            {
                width: '70%',
                height: 250,
                source: dataAdapter,
                editable: true,
               
                altrows: true,
                //showaggregates: true,
              /*   selectionmode: 'checkbox',  */
              
            
                       
                columns: [
							
                  	     	{ text: 'Branch id', datafield: 'brhid',hidden:true} ,
							{ text: 'Branch', datafield: 'branchname', editable: false},	
					
							{ text: 'Company id', datafield: 'compid',hidden:true}, 
							{ text: 'Company', datafield: 'company', editable: false },
							{ text: 'srno', datafield: 'srno', hidden:true}
							
							
						]
            });
            
            if($('#mode').val()!="view")
            		
            		{
       if(($('#permissionval').val()==1))
            
            	{
            	
            	   $("#jqxUserMaster").jqxGrid({ disabled: false});  
            	   
            	 } 
            		}
            if($('#mode').val()=="view"||($('#permissionval').val()==0)||($('#cmpermission').val()==0))
        		
    		{
            	

         	   $("#jqxUserMaster").jqxGrid({ disabled: true}); 
            	
    		}
            
            
        
     
        });
        
        
       
        
        
</script>
<div id="jqxUserMaster"></div>
