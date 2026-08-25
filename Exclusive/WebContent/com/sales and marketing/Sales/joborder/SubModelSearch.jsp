<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
<%
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String smodelid=request.getParameter("modelid")==null?"0":request.getParameter("modelid");

System.out.println("==brandid===="+brandid);
System.out.println("==smodelid===="+smodelid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
	
   var submodeldata;
	   submodeldata='<%=DAO.subModelSearch(session,brandid,smodelid)%>';
	    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'submodel',type:'String'},
                  		{name : 'model',type:'String'},
                  		
                  		
                  		],
				    localdata: submodeldata,
        
        
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
    
    
    $("#submodelSearch").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
  
        
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%',hidden:true},
       				{ text:'Sub Model',datafield:'submodel',width:'100%'},
       				{ text:'Model',datafield:'model',width:'40%',hidden:true}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#submodelSearch').on('rowdoubleclick', function (event) {
   	 
        var rowindex1 = event.args.rowindex;
        document.getElementById("submodelid").value = $('#submodelSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        
        document.getElementById("submodel").value = $('#submodelSearch').jqxGrid('getcellvalue', rowindex1, "submodel");
        
        
 
   			 
   			 document.getElementById("esize").value="";
   			 document.getElementById("esizeid").value="";
   			 
   			 document.getElementById("bsize").value="";
   			 document.getElementById("bsizeid").value="";
   			 
   			 document.getElementById("csize").value="";
   			 document.getElementById("csizeid").value="";
   			 
   			document.getElementById("errormsg").innerText="";
        
    	$('#submodelsearchwndows').jqxWindow('close');
    	});
});

	
	
</script>

<div id="submodelSearch"></div>