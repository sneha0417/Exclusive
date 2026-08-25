 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 
    <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO();
 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String aa = request.getParameter("aa")==null?"0":request.getParameter("aa");

%>
 
<script type="text/javascript">
 
     var detdata111111='<%=ClspreinductionDAO.loadtermssearch2(docno)%>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              
                              {name : 'desc1', type: 'string'},
                              {name : 'refno', type: 'string'},
                             
                              
                            ],
                       localdata: detdata111111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#descgrid").jqxGrid(
            {
                width: '100%',
                height: 170,
                source: dataAdapter,
                disabled: true,
                editable: true,
                selectionmode: 'singlecell',
                       
                columns: [
               		   { text: 'SL#', sortable: false, filterable: false, editable: false,
                           groupable: false, draggable: false, resizable: false,
                           datafield: 'sl', columntype: 'number', width: '4%',
                           cellsrenderer: function (row, column, value) {
                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                           }  
                         },		
                         { text: 'refno', datafield: 'refno', editable: true,hidden:true },
                              
                              { text: 'Description', datafield: 'desc1', editable: true },
                             
                              
						]
            });
            
            
            var aa='<%=docno%>';
            if(aa>0)
            	{
            	$("#descgrid").jqxGrid({ disabled: false});
            	  $("#descgrid").jqxGrid('addrow', null, {});
            	}
            
            
            var bb='<%=aa%>';
            if(bb>0)
            	{
            	$("#descgrid").jqxGrid({ disabled: true});
            	  
            	}
            
     
             
          $('#descgrid').on('cellvaluechanged', function (event) {
        	
        
             
                $("#descgrid").jqxGrid('addrow', null, {});
                	 
        
            }); 
        });
    </script>
    <div id="descgrid"></div> 