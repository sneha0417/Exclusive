<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.pricemanagement.pricemanagementreview.ClsPriceManagementReviewDAO"%>
 <% ClsPriceManagementReviewDAO searchDAO = new ClsPriceManagementReviewDAO(); %>
<%
 

%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata;
   
	   proddata='<%=searchDAO.productSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'prodcode',type:'String'},
                  		{name : 'prodname',type:'String'},
                  		{name : 'brand',type:'String'},
                  		
                  		
                  		],
				    localdata: proddata,
        
        
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
    
    
    $("#prodSearch").jqxGrid(
    {
        width: '100%',
        height: 382,
        source: dataAdapter,
        showaggregates:true,
        showfilterrow: true, 
        filterable: true, 
         
        selectionmode: 'singlerow',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'10%',hidden:true},
       				{ text:'Product Code',datafield:'prodcode',width:'35%'},
       				{ text:'Product Name',datafield:'prodname',width:'65%'},
       				 
       
                  
					]

    });
    $('#prodSearch').on('rowdoubleclick', function (event) {
    	
        var rowindex1= event.args.rowindex;
        
        document.getElementById("name").value=$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "prodname");
        document.getElementById("psrno").value=$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        
      $('#productwindow').jqxWindow('close'); 
    }); 
     
     
});

	
	
</script>

<div id="prodSearch"></div>