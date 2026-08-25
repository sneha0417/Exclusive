<%@page import="com.messenger.ClsMessengerDAO" %> 
<%ClsMessengerDAO cmd=new ClsMessengerDAO(); %>
 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <style>
.column
{
   background-color: #ECF8E0;
   color: red;
   font-weight: bold;            
}

.jqx-grid-cell
    {
        border: none;
    }
    
    /* .green {
            color: black\9;
            background-color: #b6ff00\9;
        }
        .yellow {
            color: black\9;
            background-color: yellow\9;
        }
        .red {
            color: black\9;
            background-color: #e83636\9;
        }
*/

        .column:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected), .jqx-widget .column:not(.jqx-grid-cell-hover):not(.jqx-grid-cell-selected) {
            color:#142fa8;
            background-color:#e6eafc;
        }
</style>

 <script type="text/javascript">
 
 var dtype;

 
 dtype='<%=cmd.userSearch(session)%>';
        $(document).ready(function () { 
         	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     				
     						{name : 'user', type: 'String'  },
     						{name : 'doc_no', type: 'String'  },
     						
     						
                          	],
                          	localdata: dtype,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
     	  
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxusersearch").jqxGrid(
            {
                width: '100%',
                height: 400,
                //autoheight:true,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                rowsheight:30,
                theme: 'energyblue',
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,cellclassname:'column',hidden:true,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'CONTACTS', datafield: 'user', width: '100%',cellclassname:'column'},
					{ text: 'Doc_no', datafield: 'doc_no', width: '8%',hidden:true,cellclassname:'column'}
					 
					
					]
            });
    
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
            $("#jqxusersearch").jqxGrid('addrow', null, {});
				           $('#jqxusersearch').on('rowdoubleclick', function (event) 
				            		{ 
		
				              	var rowindex1=event.args.rowindex;
				               	document.getElementById("usertoid").value=$('#jqxusersearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               			//alert("dtype====="+document.getElementById("usertoid").value);
				            	getMsgHistory();
				              
				                //$('#userinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxusersearch"></div>
    
    </body>
</html>