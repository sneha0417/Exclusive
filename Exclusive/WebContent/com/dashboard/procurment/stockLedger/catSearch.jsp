<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.stockLedger.ClsStockLedger" %>
<%ClsStockLedger DAO= new ClsStockLedger();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var catdata;
   catdata='<%=DAO.catSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'cat',type:'String'},
                  		
                  		
                  		],
				    localdata: catdata,
        
        
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
    
    
    $("#catSearch").jqxGrid(
    {
        width: '100%',
        height: 340,
        source: dataAdapter,
      
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%',hidden:true},
       				{ text:'Category',datafield:'cat',width:'95.5%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btncat" ).click(function() {
    	
    	var rows = $("#catSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="CATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidcat").value="CATEGORY";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nCATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidcat").value+="\nCATEGORY";
        	}	
    	}
    	
		//document.getElementById("hidcatid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#catSearch').jqxGrid('getcellvalue',rows[i],'cat');
    		var docno=$('#catSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidcat").value+="\n"+dummy;
    		if(i==0){
    			//document.getElementById("hidcatid").value+=docno;
    			
    			
    			if(document.getElementById("hidcatid").value=="")
				{
			document.getElementById("hidcatid").value+=docno;
				}
			else
				{
				document.getElementById("hidcatid").value+=","+docno;
				}
    			
    			
    			
    			
    			
    		}
    		else{
    			document.getElementById("hidcatid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#pcategorywindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#pcategorywindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btncat" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="catSearch"></div>