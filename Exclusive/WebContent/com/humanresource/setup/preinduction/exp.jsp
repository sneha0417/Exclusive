 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO();
  String docno=request.getParameter("docno");
  %>
 
<script type="text/javascript">
var list =['YES','NO'];
     var detdata1='<%=ClspreinductionDAO.loadsearch2(docno)%>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'noof', type: 'number'  }, 
                              {name : 'expin', type: 'string'  },
                              {name : 'mnd', type: 'string'  },
                            ],
                       localdata: detdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#expgrid").jqxGrid(
            {
                width: '100%',
                height: 175,
                source: dataAdapter,
                editable:true,
                disabled:true,
                selectionmode: 'singlecell',
                       
                columns: [
                           { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
				            { text: 'Experience In ', datafield: 'expin'  },
          					{ text: 'No of Years', datafield: 'noof', width: '20%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
          					{ text: 'Mandatory', datafield: 'mnd', width: '20%' ,cellsalign: 'left', align:'left',columntype:'dropdownlist',createeditor: function (row, column, editor) {
                               editor.jqxDropDownList({autoDropDownHeight: true,  enableBrowserBoundsDetection:true,source: list });
                           	
        					}},
                              
						]
            });
            
             
          $('#expgrid').on('cellvaluechanged', function (event) {
        	  
        		
          	   var datafield = event.args.datafield;
       	 
         
              
        	   if(datafield=="expin")
        		   {
                
                   $("#expgrid").jqxGrid('addrow', null, {});
        		   }
                   	
                
            }); 
        });
    </script>
    <div id="expgrid"></div> 