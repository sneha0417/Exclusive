 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockanalysis.ClsStockanalysisDAO" %>
<%ClsStockanalysisDAO DAO= new ClsStockanalysisDAO();%>
<%
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
System.out.println("==catid===="+brhid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   
   var locdata;
   locdata='<%=DAO.locationSearch(session,brhid)%>';
	

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'}, 
                  		{name : 'locname',type:'String'},
                  		{name : 'branchname',type:'String'},
                  		
                  		
                  		],
				    localdata: locdata,
        
        
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
    
    
    $("#locsearch").jqxGrid(
    {
        width: '100%',
        height: 340,
        source: dataAdapter,
 
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%',hidden:true} ,
              		
       				{ text:'Location',datafield:'locname',width:'45%'},
       				{ text:'BRANCH',datafield:'branchname',width:'50%'}
       				
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnloc" ).click(function() {
    	
    	var rows = $("#locsearch").jqxGrid('selectedrowindexes');
    	
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="LOCATION";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidloc").value="LOCATION";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nLOCATION";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidloc").value+="\nLOCATION";
        	}	
    	}
    	
		//document.getElementById("hidsubcatid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#locsearch').jqxGrid('getcellvalue',rows[i],'locname');
    		var docno=$('#locsearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidloc").value+="\n"+dummy;
    		if(i==0){
    		 	
 			
    			
      			if(document.getElementById("hidlocid").value=="")
				{
			document.getElementById("hidlocid").value+=docno;
				}
			else
				{
				document.getElementById("hidlocid").value+=","+docno;
				}
    			
    			
    			
    		}
    		else{
    			document.getElementById("hidlocid").value+=","+docno;
    		}
    	}
  
    		  	
    	$('#locationwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#locationwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnloc" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="locsearch"></div>