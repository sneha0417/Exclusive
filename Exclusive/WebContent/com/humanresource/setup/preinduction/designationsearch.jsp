
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
 <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO(); %>
 
<script type="text/javascript">
 
     var detdata111='<%=ClspreinductionDAO.search1()%>';
		$(document).ready(function () { 	
          
			var source =
            {
                datatype: "json",  
                datafields: [
                             
                              {name : 'designation1', type: 'string'  },
                              {name : 'designation2', type: 'string'  },
                            
                             
                              
                            ],
                       localdata: detdata111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#descigsearchgrid").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
               
                selectionmode: 'singlecell',
                       
                columns: [
               		 
				
                
                              
                              { text: 'Designation', datafield: 'designation1',hidden:true },
                              { text: 'Designation', datafield: 'designation2'  },
                             
                              
						]
            });
            
             
          $('#descigsearchgrid').on('celldoubleclick', function (event) {
        	
        	      var rowindex1= event.args.rowindex;
                  if(parseInt(document.getElementById("reportid").value)>0)
                	{
                	if(parseInt($("#descigsearchgrid").jqxGrid('getcellvalue', rowindex1, "designation1"))==parseInt(document.getElementById("reportid").value))
                		{
                		 document.getElementById("errormsg").innerText="Designation is Matching";
                		 return 0;
                		}
                	else
                		{
                		  
                		 document.getElementById("errormsg").innerText="";
                		}
                	}
        	     document.getElementById("designation").value=$('#descigsearchgrid').jqxGrid('getcellvalue', rowindex1, "designation2") ;
        	     document.getElementById("designationid").value= $('#descigsearchgrid').jqxGrid('getcellvalue', rowindex1, "designation1");
             
        	     $('#swin').jqxWindow('close');
                	 
        
            }); 
        });
    </script>
    <div id="descigsearchgrid"></div> 