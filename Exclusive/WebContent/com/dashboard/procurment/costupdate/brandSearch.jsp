<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%ClsStockLedger DAO= new ClsStockLedger();%>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var branddata;
   if(id=='1'){
	   branddata='<%=DAO.suitbrandSearch(session)%>';
	
}
   else if(id=='2'){
	   branddata='<%=DAO.brandSearch(session)%>';
	
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
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%'},
       				{ text:'Brand',datafield:'brand',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnbrand" ).click(function() {
    	
    	var rows = $("#brandSearch").jqxGrid('selectedrowindexes');
    	if(id=='1'){
    		/* alert("id one"); */
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="SUITABILITY BRAND";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsbrand").value="SUITABILITY BRAND";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSUITABILITY BRAND";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsbrand").value+="\nSUITABILITY BRAND";
        	}	
    	}
    	
		document.getElementById("hidsbrandid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'brand');
    		var docno=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidsbrand").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsbrandid").value=docno;
    		}
    		else{
    			document.getElementById("hidsbrandid").value+=","+docno;
    		}
    	}
    }
    	else if(id=='2'){
    		/* alert("id tow"); */
        	if(rows!=""){
        		if(document.getElementById("searchdetails").value==""){
            		document.getElementById("searchdetails").value="BRAND";
            		document.getElementById("searchdetails").value+="\n---------------------------";
            		document.getElementById("hidbrand").value="BRAND";
            	}
            	else{
            		document.getElementById("searchdetails").value+="\n\nBRAND";
            		document.getElementById("searchdetails").value+="\n---------------------------";
            		document.getElementById("hidbrand").value+="\nBRAND";
            	}	
        	}
        	
    		document.getElementById("hidbrandid").value="";
        	
        	for(var i=0;i<rows.length;i++){
        		var dummy=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'brand');
        		var docno=$('#brandSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("hidbrand").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidbrandid").value=docno;
        		}
        		else{
        			document.getElementById("hidbrandid").value+=","+docno;
        		}
        	}
        }	
    	
    	
    	$('#brandwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#brandwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnbrand" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="brandSearch"></div>