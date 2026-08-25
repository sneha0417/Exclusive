<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.activityanalysis.ClsActivityAnalysisDAO"%>
<%
ClsActivityAnalysisDAO DAO= new ClsActivityAnalysisDAO();   
int id2=request.getParameter("id2")==null?0:Integer.parseInt(request.getParameter("id2"));
%> 
<script type="text/javascript">
var data1;
var id2='<%= id2%>';
if(id2==1){
	data1='<%=DAO.searchHigh()%>';
}else{
	data1;
} 
 
  $(document).ready(function () { 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'highlight', type: 'String'  },
     					],
                          	localdata: data1,
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
            $("#Jqxhighlightsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Highlight', datafield: 'highlight', width: '100%' },
				]
            });
            $('#Jqxhighlightsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
            	document.getElementById("txthigh").value= $('#Jqxhighlightsearch').jqxGrid('getcellvalue', rowindex1, "highlight");
                $('#highLsearch').jqxWindow('close');
       });       
        
  }); 
				       
                       
    </script>
    <div id="Jqxhighlightsearch"></div>
    