<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<style>
.redClass{
color: red;
}
.blueClass{
color: blue;
}
</style>
<script type="text/javascript">
	 
        $(document).ready(function () { 
      
            var datahhhhh = '<%=DAO.toDoList(session)%>'; 
            	  
            var source =
            {
                datatype: "json",
                datafield: [
							{name : 'doc_no', type: 'int' },
							{name : 'date', type: 'date' },
    						{name : 'title', type: 'string' }, 
     						{name : 'description', type: 'String' },
-     						{name : 'priority', type: 'string'}
                        ],
                         localdata: datahhhhh,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        
     /*  if(sss>0)
    	 { */
    	 
    	  
    	 
    	 /* if($('#mode').val()=="view")
     		
 		{
    	 
            if($('#permissionval').val()=="1")
      	         {
            	
         
         	   $('#jqxToDoList').jqxGrid({ selectionmode: 'checkbox'}); 
            	
      	           }
        	  
 		} */
    	/*  }    */
      
      
      /* if($('#mode').val()=="E")
    	  {
    	  
    	  if($('#permissionval').val()=="1")
	         {

    		  $('#jqxToDoList').jqxGrid({ selectionmode: 'checkbox'}); 
	         }
    	  
    	  
    	  } */
      
                  
                  /* $("#jqxToDoList").on("bindingcomplete", function (event) {
                
                	  
                	  var rows = $("#jqxToDoList").jqxGrid('getrows');   
                	
                
                	  
                	  for(var i=0;i<rows.length;i++){
                		  
                		  var aa= $('#jqxToDoList').jqxGrid('getcellvalue',i, "srno");
                		  
                		
                		  if(aa!='NA'){
                			  
                			
                			   $('#jqxToDoList').jqxGrid('selectrow',i);   
                		  }
                		  
                	  }
                	  
                	  

                	  
                	  
                  });  */
                  
                  var cellclassname = function (row, column, value, data) {
                      if (data.priority == 'HIGH') {
                          return "redClass";
                      }else if (data.priority == 'LOW') {
                          return "blueClass";
                      };
                  }; 
                  
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxToDoList").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                selectionmode: 'checkbox',  
                       
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', hidden: true , width: '10%' },
							{ text: 'Date', datafield: 'date', hidden: true , cellsformat: 'dd.MM.yyyy' , cellclassname: cellclassname, width: '20%' },
							{ text: 'Title', datafield: 'title',  cellclassname: cellclassname , width: '30%' },
							{ text: 'Description', datafield: 'description',  cellclassname: cellclassname , width: '62%' },
							{ text: 'Priority', datafield: 'priority', hidden:true, cellclassname: cellclassname , width: '10%' },
						]
            });
            
        /*     if($('#mode').val()!="view")
            		
            		{
       if(($('#permissionval').val()==1))
            
            	{
            	
            	   $("#jqxToDoList").jqxGrid({ disabled: false});  
            	   
            	 } 
            		}
            if($('#mode').val()=="view"||($('#permissionval').val()==0)||($('#cmpermission').val()==0))
        		
    		{
            	

         	   $("#jqxToDoList").jqxGrid({ disabled: true}); 
            	
    		} */
    		
    		
    		$('#jqxToDoList').on('celldoubleclick', function (event) {
          			var rowindex1 = event.args.rowindex;
          			funNext();
          			document.getElementById("txttitle").value= $('#jqxToDoList').jqxGrid('getcellvalue', rowindex1, "title");
                    $("#jqxDate").jqxDateTimeInput('val', $("#jqxToDoList").jqxGrid('getcellvalue', rowindex1, "date"));
                    document.getElementById("cmbpriority").value= $('#jqxToDoList').jqxGrid('getcellvalue', rowindex1, "priority");
                    document.getElementById("txtdescription").value= $('#jqxToDoList').jqxGrid('getcellvalue', rowindex1, "description");
                    document.getElementById("docno").value= $('#jqxToDoList').jqxGrid('getcellvalue', rowindex1, "doc_no");
          			
    		});
            
    		 $("#btnHide").on('click', function () { 
			     var selectedrowindex = $("#jqxToDoList").jqxGrid('getselectedrowindex');
			     var rowscount = $("#jqxToDoList").jqxGrid('getdatainformation').rowscount;
			     if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
			         var id = $("#jqxToDoList").jqxGrid('getrowid', selectedrowindex);
			         var commit = $("#jqxToDoList").jqxGrid('deleterow', id);
			      } 
			   });
        
     
        });
        
        
       
        
        
</script>
<div id="jqxToDoList"></div>
