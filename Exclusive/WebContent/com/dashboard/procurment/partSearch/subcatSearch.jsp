<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.partSearch.ClsPartSearchDAO"%>
<%ClsPartSearchDAO DAO= new ClsPartSearchDAO();%>
<%
String catid=request.getParameter("catid")==null?"0":request.getParameter("catid");
System.out.println("==catid===="+catid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
   
   var subcatdata;
   subcatdata='<%=DAO.subCatSearch(session,catid)%>';
	

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'subcat',type:'String'},
                  		{name : 'cat',type:'String'},
                  		
                  		
                  		],
				    localdata: subcatdata,
        
        
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
    
    
    $("#scatSearch").jqxGrid(
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
       				{ text:'Sub Category',datafield:'subcat',width:'40%'},
       				{ text:'Category',datafield:'cat',width:'40%'}
       				
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnscat" ).click(function() {
    	
    	var rows = $("#scatSearch").jqxGrid('selectedrowindexes');
    	
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="SUBCATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsubcat").value="SUBCATEGORY";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSUBCATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidsubcat").value+="\nSUBCATEGORY";
        	}	
    	}
    	
		document.getElementById("hidsubcatid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#scatSearch').jqxGrid('getcellvalue',rows[i],'subcat');
    		var docno=$('#scatSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidsubcat").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsubcatid").value=docno;
    		}
    		else{
    			document.getElementById("hidsubcatid").value+=","+docno;
    		}
    	}
  
    		  	
    	$('#psubcategorywindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#psubcategorywindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnscat" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="scatSearch"></div>