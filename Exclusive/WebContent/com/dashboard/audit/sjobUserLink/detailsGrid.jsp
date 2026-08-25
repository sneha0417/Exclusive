<%@page import="com.dashboard.audit.sjobuserlink.*" %>
<% ClsSjobUserLinkDAO card=new ClsSjobUserLinkDAO();%>

 <%

   String barchval = request.getParameter("brhid")==null?"NA":request.getParameter("brhid");
 String check = request.getParameter("check")==null?"NA":request.getParameter("check");
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
 var temp4='<%=check%>';
 var apprdata;
 
if(temp4==1){
	 apprdata='<%=card.detailsgrid(check)%>';
}
else{
	apprdata=[];
	//  var list =["Project","Fit Out","Rectification","Comprehensive","Non Comprehensive"];
} 
	  


        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'username', type: 'String'  },
     						{name : 'userrole', type: 'String'},
     						{name : 'jobtype', type: 'String'},
     						{name : 'jobno', type: 'String'},
     						{name : 'save', type: 'String'},
     						 
     						
                          	],
                          	localdata: apprdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var cellclassname = function (row, column, value, data) {
          		if (data.apprlevel==1) {
                      return "redClass";
                  } else if (data.apprlevel==2) {
                      return "yellowClass";
                  }
                  else{
                  	return "greyClass";
                  };
              };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                showfilterrow:true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			                   { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '5%',cellclassname: cellclassname,
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							  { text: 'User Name', datafield: 'username', width: '25%'},
							  { text: 'User Role', datafield: 'userrole', width: '25%'},
							  { text: 'Job type', datafield: 'jobtype', width: '30%'},
							  { text: 'Job no', datafield: 'jobno', width: '30%',hidden:true},
	                          { text: 'Save', datafield: 'save', width: '15%',columntype:'button'},
				
					
					]
            });
            
            $("#overlay, #PleaseWait").hide(); 
            
           
            
            
            
            
            
            
            
            /* $("#detailsgrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
             
            		    var rowBoundIndex = event.args.rowindex;
            		    
        			 if(datafield=="jobtype"){
                    	   		
        				 document.getElementById("jobtype").value=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'jobtype');
        				 var newjobtype=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'jobtype');
        				 alert("jobtype value change==="+newjobtype);
        				 
                    	   	  }
                    });  
            
            
       
            $("#detailsgrid").on("cellclick", function (event) 
       		{
       		    var rowBoundIndex = event.args.rowindex;
       		    // row's visible index.
       		    var rowVisibleIndex = event.args.visibleindex;
       		    // right click.
       		    var rightclick = event.args.rightclick; 
       		    // original event.
       		    var ev = event.args.originalEvent;
       		    // column index.
       		    var columnindex = event.args.columnindex;
       		    // column data field.
       		    var dataField = event.args.datafield;
       		    // cell value
       		    var value = event.args.value;   
       			
       		    if(dataField=="save"){
       		    	
					valchange(rowBoundIndex);
       		    }
       		});
            
           function valchange(rowBoundIndex){
        	   
        	   //alert(1);
        	   var jobtype=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'jobtype');
        	   //alert(jobtype);
				if(jobtype!="Select Job Type")
				{
      		    	var username=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'username');
      		    	var userrole=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'userrole');
      		    	
      		     alert(newjobtype+"username=="+username+"userrole=="+userrole);
      			
      			getsavedata(newjobtype,username,userrole);
				}
        	   
        	   
           } 
            
             */
            
            
            
            
            $('#detailsgrid').on('celldoubleclick', function (event) 
            		   { 
            	
            	var rowBoundIndex = event.args.rowindex;
       		    // row's visible index.
       		    var rowVisibleIndex = event.args.visibleindex;
       		    // right click.
       		    var rightclick = event.args.rightclick; 
       		    // original event.
       		    var ev = event.args.originalEvent;
       		    // column index.
       		    var columnindex = event.args.columnindex;
       		    // column data field.
       		    var dataField = event.args.datafield;
       		    // cell value
       		    var value = event.args.value;
       		 	$('#docwindow').jqxWindow('open');
       			docnoSearchContent('docsearch.jsp?rowindex='+rowBoundIndex);
          });	
            
            
           
            $("#detailsgrid").on("cellclick", function (event) 
               		{
               		     var rowBoundIndex = event.args.rowindex;
               		    // row's visible index.
               		    var rowVisibleIndex = event.args.visibleindex;
               		    // right click.
               		    var rightclick = event.args.rightclick; 
               		    // original event.
               		    var ev = event.args.originalEvent;
               		    // column index.
               		    var columnindex = event.args.columnindex;
               		    // column data field.
               		    var dataField = event.args.datafield;
               		    // cell value
               		    var value = event.args.value;     
               			
               		    if(dataField=="save"){
               		    	
               		    	var jobtype=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'jobtype');
               		    	var jobtypeid=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'jobno');
               		    	//alert(jobtype);
            				if(jobtype!="Select Job Type")
            				{
                  		    	var username=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'username');
                  		    	var userrole=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'userrole');
                  		    	
                  		     //alert(jobtype+"username=="+username+"userrole=="+userrole);
                  			
                  			getsavedata(jobtype,username,userrole,jobtypeid);
            				}
        					
               		    }
               		}); 
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                 
        });
                     
    </script>
    <div id="detailsgrid"></div>