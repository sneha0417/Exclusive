<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO();
 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
%>
<script type="text/javascript">
 
     var detdata1111='<%=ClspreinductionDAO.loadtermssearch1(docno)%>';
		$(document).ready(function () { 	
         
			var source =
            {
                datatype: "json",  
                datafields: [
                              
                              {name : 'header', type: 'string'},
                              {name : 'rownoss', type: 'string'},
                             
                              
                            ],
                       localdata: detdata1111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jobgrid").jqxGrid(
            {
                width: '100%',
                height: 180,
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
                         { text: 'rowno', datafield: 'rownoss', editable: true,hidden:true  },
                             { text: 'Header', datafield: 'header', editable: true },
                             
                              
						]
            });
            
             
          $('#jobgrid').on('cellvaluechange', function (event) {
        	
        
             
                $("#jobgrid").jqxGrid('addrow', null, {});
                	 
        
            }); 
          $('#jobgrid').on('celldoubleclick', function (event) {
   
  			  var aa=$('#jobgrid').jqxGrid('getcellvalue', event.args.rowindex, "rownoss");
  			  
  			  if(parseInt(aa)>0)
  				  {
  				  document.getElementById("headname").innerText=$('#jobgrid').jqxGrid('getcellvalue', event.args.rowindex, "header");
  		     	  $('#edit2').attr('disabled', false);
  	        	  $('#save2').attr('disabled', false);
  	  			  $("#descgrid").jqxGrid({ disabled: false});
  	  			  $("#descgrid").jqxGrid('addrow', null,{});
  	  			  document.getElementById("valsss").value=$('#jobgrid').jqxGrid('getcellvalue', event.args.rowindex, "rownoss");
  	  			  $("#grid5").load("desc.jsp?docno="+$('#jobgrid').jqxGrid('getcellvalue', event.args.rowindex, "rownoss"));
  				  }
  			  else
  				  {
  				  document.getElementById("headname").innerText="";
  				 document.getElementById("valsss").value="";
  		     	  $('#edit2').attr('disabled', false);
  	        	  $('#save2').attr('disabled', true);
  	  			  $("#descgrid").jqxGrid({ disabled: true});
  	  		  $("#descgrid").jqxGrid('clear');
  	  			document.getElementById("valsss").value="";
  	  		 
  				  }
  			  
  			
          
          }); 
        });
    </script>
    <div id="jobgrid"></div> 