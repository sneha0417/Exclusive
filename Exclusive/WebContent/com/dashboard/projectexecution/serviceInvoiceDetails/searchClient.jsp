 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.projectexecution.serviceInvoiceDetails.ClsServiceInvoiceDetails" %>
<%
ClsServiceInvoiceDetails DAO= new ClsServiceInvoiceDetails();
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
%> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchClient(session,clname,mob)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						 {name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						 {name : 'mail1', type: 'String'  },
     						 {name : 'pertel', type: 'String'  },
     						
                          	],
                          	localdata: cldata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
					{ text: 'NAME', datafield: 'refname', width: '30%' },
					{ text: 'ADDRESS', datafield: 'address', width: '60%' }, 
					{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden:true}, 
					{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
					 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
					
					
					
					]
            });
    
           
            $( "#btnclient" ).click(function() {
            	
            	var rows = $("#Jqxclientsearch").jqxGrid('selectedrowindexes');
            	
            		/* alert("id one"); */
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Client";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidclient").value="Client";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nClient";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidclient").value+="\nClient";
                	}	
            	}
            	
        		document.getElementById("hidclientid").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#Jqxclientsearch').jqxGrid('getcellvalue',rows[i],'refname');
            		var docno=$('#Jqxclientsearch').jqxGrid('getcellvalue',rows[i],'cldocno');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("hidclient").value+="\n"+dummy;
            		if(i==0){
            			document.getElementById("hidclientid").value=docno;
            		}
            		else{
            			document.getElementById("hidclientid").value+=","+docno;
            		}
            	}
         
            	$('#clientsearch1').jqxWindow('close');
        	});
        
                  }); 
				       
                       
    </script>
    <div align="center" style="padding-bottom:4px;"><button type="button" id="btnclient" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="Jqxclientsearch"></div>
    