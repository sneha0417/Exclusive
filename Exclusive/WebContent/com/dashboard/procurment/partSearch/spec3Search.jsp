<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   
   var spec3data;
   
	   spec3data='<%=DAO.suitSpec3Search(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'spec',type:'String'},
                  		
                  		
                  		],
				    localdata: spec3data,
        
        
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
    
    
    $("#spec3Search").jqxGrid(
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
       				{ text:'CabinSize',datafield:'spec',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnspec3" ).click(function() {
    	
    	var rows = $("#spec3Search").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="CABINSIZE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidspec1").value="CABINSIZE";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nCABINSIZE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidspec3").value+="\nCABINSIZE";
        	}	
    	}
    	
		document.getElementById("hidspec3id").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#spec3Search').jqxGrid('getcellvalue',rows[i],'spec');
    		var docno=$('#spec3Search').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidspec3").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidspec3id").value=docno;
    		}
    		else{
    			document.getElementById("hidspec3id").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#spec3window').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#spec3window').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnspec3" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="spec3Search"></div>