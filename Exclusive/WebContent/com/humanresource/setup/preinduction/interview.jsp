 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 
   <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO(); 
  
  String docno=request.getParameter("docno");
  %>
 
 
<script type="text/javascript">
 
     var detdata111='<%=ClspreinductionDAO.loadsearch3(docno)%>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              
                              {name : 'desc1', type: 'string'  },
                             
                              
                            ],
                       localdata: detdata111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#intervewgrid").jqxGrid(
            {
                width: '100%',
                height: 180,
                disabled:true,
                source: dataAdapter,
                editable:true,
                selectionmode: 'singlecell',
                       
                columns: [
               		   { text: 'SL#', sortable: false, filterable: false, editable: false,
                           groupable: false, draggable: false, resizable: false,
                           datafield: 'sl', columntype: 'number', width: '4%',
                           cellsrenderer: function (row, column, value) {
                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                           }  
                         },		
                              
                              
                              { text: 'Description', datafield: 'desc1' },
                             
                              
						]
            });
            
             
          $('#intervewgrid').on('cellvaluechanged', function (event) {
        	
       	   var datafield = event.args.datafield;
    	 
      
     	   if(datafield=="desc1")
     		   {
             
                $("#intervewgrid").jqxGrid('addrow', null, {});
     		   }
                	 
        
            }); 
        });
    </script>
    <div id="intervewgrid"></div> 