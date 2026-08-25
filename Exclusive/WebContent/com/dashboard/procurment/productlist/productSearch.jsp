<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%ClsStockLedger DAO= new ClsStockLedger();%>
<%
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String catid=request.getParameter("catid")==null?"0":request.getParameter("catid");
String subcatid=request.getParameter("subcatid")==null?"0":request.getParameter("subcatid");

%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata;
   
	   proddata='<%=DAO.productSearch(session,brandid,catid,subcatid)%>';
	
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
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        showfilterrow: true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text:'Product Code',datafield:'prodcode',width:'30%'},
       				{ text:'Product Name',datafield:'prodname',width:'50%'},
       				{ text:'Brand',datafield:'brand',width:'20%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnproduct" ).click(function() {
    	
    	var rows = $("#prodSearch").jqxGrid('selectedrowindexes');
    	
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="PRODUCT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidproduct").value="PRODUCT";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nPRODUCT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidproduct").value+="\nPRODUCT";
        	}	
    	}
    	
		document.getElementById("hidproductid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#prodSearch').jqxGrid('getcellvalue',rows[i],'prodname');
    		var docno=$('#prodSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidproduct").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidproductid").value=docno;
    		}
    		else{
    			document.getElementById("hidproductid").value+=","+docno;
    		}
    	}
  
    		  	
    	$('#productwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#productwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnproduct" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="prodSearch"></div>