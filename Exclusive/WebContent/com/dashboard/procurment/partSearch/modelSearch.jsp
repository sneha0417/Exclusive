<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
<%String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
System.out.println("==brandid===="+brandid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
   var modeldata;
   if(id=='1'){
	   modeldata='<%=DAO.suitmodelSearch(session,brandid)%>';
	
}
   else if(id=='2'){
	   modeldata='<%=DAO.suitmodelSearch(session,brandid)%>';
	
}
else{
	modeldata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'model',type:'String'},
                  		{name : 'brand',type:'String'},
                  		
                  		
                  		],
				    localdata: modeldata,
        
        
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
    
    
    $("#modelSearch").jqxGrid(
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
       				{ text:'Model',datafield:'model',width:'40%'},
       				{ text:'Brand',datafield:'brand',width:'40%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnmodel" ).click(function() {
    	
    	var rows = $("#modelSearch").jqxGrid('selectedrowindexes');
    	
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="SUITABILITY MODEL";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsmodel").value="SUITABILITY MODEL";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSUITABILITY MODEL";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsmodel").value+="\nSUITABILITY MODEL";
        	}	
    	}
    	
		document.getElementById("hidsmodelid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#modelSearch').jqxGrid('getcellvalue',rows[i],'model');
    		var docno=$('#modelSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidsmodel").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsmodelid").value=docno;
    		}
    		else{
    			document.getElementById("hidsmodelid").value+=","+docno;
    		}
    	}
  
    		  	
    	$('#modelwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#modelwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnmodel" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="modelSearch"></div>