<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var yomdata;
 	   yomdata='<%=DAO.yomSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'yom',type:'String'},
                  		
                  		
                  		],
				    localdata: yomdata,
        
        
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
    
    
    $("#yomSearch").jqxGrid(
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
       				{ text:'YOM',datafield:'yom',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnyom" ).click(function() {
    	
    	var rows = $("#yomSearch").jqxGrid('selectedrowindexes');
    	rows = rows.sort(function(a,b){return a - b});
    	if(rows!=""){
    		setRemove()
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="YOM";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidyom").value="YOM";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nYOM";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidyom").value+="\nYOM";
        	}	
    	}
    	
		document.getElementById("hidyomid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#yomSearch').jqxGrid('getcellvalue',rows[i],'yom');
    		var docno=$('#yomSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidyom").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidyomid").value=docno;
    		}
    		else{
    			document.getElementById("hidyomid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#yomwindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#yomwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnyom" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="yomSearch"></div>