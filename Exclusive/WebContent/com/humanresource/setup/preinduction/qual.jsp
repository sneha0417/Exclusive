 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
  <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO(); 
  
  String docno=request.getParameter("docno");
  
  %>
 
 
      
<script type="text/javascript">
 
     var detdata11s111111111='<%=ClspreinductionDAO.loadsearch1(docno)%>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'qualdoc', type: 'int'  },
                              {name : 'qual', type: 'string'  },
                              {name : 'remarks', type: 'string'  },
                          
                              
                            ],
                       localdata: detdata11s111111111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#qualgrid").jqxGrid(
            {
                width: '100%',
                height: 175,
                source: dataAdapter,
                disabled:true,
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
                              
               		 
                              { text: 'Doc_no', datafield: 'qualdoc', width: '20%',hidden:true},
                              
                              { text: 'Qualification', datafield: 'qual',editable:false },
                              { text: 'Remarks', datafield: 'remarks', width: '35%'  },
                             
                              
						]
            });
            
        
         	
        	 $('#qualgrid').on('cellclick', function (event) {
        		 
        		 
        			var df=event.args.datafield;

        			  
              	  if(df == "qual") 
              		  { 
              		 
        		 	 
              		 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value=rowindextemp;   
              	  $('#qualgrid').jqxGrid('clearselection');
              SearchContent3('qualification.jsp?');
        		
        			}
              	  
              	  
              	 
        		 
        		 
        		 
              		  
        	 });
        	
             
       
        });
		
		
		  function SearchContent3(url) {
	 	       //alert(url);
	 	          $.get(url).done(function (data) {
	 	  //alert(data);
	 	    $('#abcwn').jqxWindow('open');
	 	        $('#abcwn').jqxWindow('setContent', data);

	 	  	}); 
	 	    	} 
	         
    </script>
    <div id="qualgrid"></div> 
        <input type="hidden" id="rowindex"/> 