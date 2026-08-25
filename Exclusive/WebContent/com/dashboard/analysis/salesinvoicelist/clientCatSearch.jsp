<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var clientdata;
   if(id=='1'){
	   clientdata='<%=csd.getClientCategory()%>';
	
}
else{
	clientdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'clientcatname',type:'String'},
                  		
                  		
                  		],
				    localdata: clientdata,
        
        
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
    
    
    $("#clientCatSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%'},
       				{ text:'Category Name',datafield:'clientcatname',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnok_clientcat" ).click(function() {
    	var rows = $("#clientCatSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Client Category";	
        		document.getElementById("clientcat").value="Client Category";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nClient Category";
        		document.getElementById("clientcat").value+="\nClient Category";
        	}	
    	}
    
    	
    	document.getElementById("hidclientcat").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#clientCatSearch').jqxGrid('getcellvalue',rows[i],'clientcatname');
    		var docno=$('#clientCatSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("clientcat").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidclientcat").value=docno;
    		}
    		else{
    			document.getElementById("hidclientcat").value+=","+docno;
    		}
    	}
    	$('#clientwindow').jqxWindow('close');
    	});
    
    $( "#btncancel_clientcat" ).click(function() {
    	$('#clientwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok_clientcat" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel_clientcat" name="btncancel" class="myButton" >Cancel</button></div>
<div id="clientCatSearch"></div>