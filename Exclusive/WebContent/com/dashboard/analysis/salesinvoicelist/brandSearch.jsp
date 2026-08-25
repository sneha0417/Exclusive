<%@page import="com.dashboard.analysis.salesinvoice.ClsSalesInvoiceDAO" %>
<% ClsSalesInvoiceDAO csd=new ClsSalesInvoiceDAO();%>

<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var branddata;
   if(id=='1'){
	   branddata='<%=csd.getBrand()%>';
	
}
else{
	branddata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'brand',type:'String'},
                  		
                  		
                  		],
				    localdata: branddata,
        
        
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
    
    
    $("#brandSearch").jqxGrid(
    {
        width: '100%',
        height: 330,
        source: dataAdapter,
        showaggregates:true,
        //filtermode:'excel',
        showfilterrow:true,
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No', filtertype:'number',datafield:'doc_no',width:'20%'},
       				{ text:'Name',filtertype:'input',columntype:'textbox',datafield:'brand',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });

    $( "#btnok" ).click(function() {
    	var rows = $("#brandSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="Brand";
        		document.getElementById("brand").value="Brand";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nBrand";
        		document.getElementById("brand").value+="\nBrand";
        	}	
    	}
    	
    	
    	document.getElementById("hidbrand").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'brand');
    		var docno=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("brand").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidbrand").value=docno;
    		}
    		else{
    			document.getElementById("hidbrand").value+=","+docno;
    		}
    	}
    	$('#brandwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#brandwindow').jqxWindow('close');
    	});
});

</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnok" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnclearc" name="btnclear" class="myButton" >Cancel</button></div>
<div id="brandSearch"></div>
