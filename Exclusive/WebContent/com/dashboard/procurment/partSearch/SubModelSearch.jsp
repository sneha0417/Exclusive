<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
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
       				{ text:'Sub Model',datafield:'submodel',width:'40%'},
       				{ text:'Model',datafield:'model',width:'40%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnsubmodel" ).click(function() {
    	
    	var rows = $("#submodelSearch").jqxGrid('selectedrowindexes');
    	
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="SUB MODEL";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsubmodel").value="SUB MODEL";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSUB MODEL";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsubmodel").value+="\nSUB MODEL";
        	}	
    	}
    	
		document.getElementById("hidsubmodelid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#submodelSearch').jqxGrid('getcellvalue',rows[i],'submodel');
    		var docno=$('#submodelSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidsubmodel").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsubmodelid").value=docno;
    		}
    		else{
    			document.getElementById("hidsubmodelid").value+=","+docno;
    		}
    	}
  
    		  	
    	$('#submodelwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#submodelwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnsubmodel" name="btnsubmodel" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="submodelSearch"></div>