  

  <%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO();



%>  
<script type="text/javascript">


$(document).ready(function () { 	
 
    
	var data1= '<%=DAO.searchptypr() %>';
 
	
	
       var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'doc_no' , type: 'number' },
						{name : 'prtype', type: 'String'  },
						 
						
                  	
         ],
         localdata: data1,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
            }		
    );
  
    $("#jqxp").jqxGrid(
            {
            	width: '100%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
         
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },					 
					{ text: 'Property Type' , datafield: 'prtype',width: '100%'},
	              ]
            });
    $('#jqxp').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex; 
                document.getElementById("propertytype").value = $("#jqxp").jqxGrid('getcellvalue', rowindex1, "prtype");
                document.getElementById("hidpropertytype").value = $("#jqxp").jqxGrid('getcellvalue', rowindex1, "doc_no");
                 
                document.getElementById("unittype").value = "";
                document.getElementById("hidunittypeid").value = "";
             
            	$('#ptytypesearchwindow').jqxWindow('close');
                
             
    		 });
    
	 
});

    </script>
         <div  id="jqxp"></div>