<%@page import="com.dashboard.audit.sjobuserlink.*" %>
<% ClsSjobUserLinkDAO card=new ClsSjobUserLinkDAO();%>

<%
String rowindex = request.getParameter("rowindex")==null?"":request.getParameter("rowindex");
 %> 


       <script type="text/javascript">
       
       var docdata='<%=card.docSearch()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'jobtype', type: 'string'  },
                            {name : 'rowno', type: 'string'  },
     						
                        ],
                		
                		//  url: url1,
                 localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#docsearch").jqxGrid(
            {
                width: '100%',
                height: 180,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'checkbox',
                  
                columns: [
		                      { text: 'Job Type', datafield: 'jobtype'},
		                      { text: 'rowno', datafield: 'rowno',hidden:true},
						
						]
            });
            
          <%-- $('#docsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                var mainrowindex='<%=rowindex%>';
                $('#detailsgrid').jqxGrid('setcellvalue', mainrowindex, "jobtype",$('#docsearch').jqxGrid('getcellvalue',rowindex2,'jobtype'));
              	$('#docwindow').jqxWindow('close'); 
            });  --%>
            
            
     $( "#btnserType" ).click(function() {
			var selectedrows=$("#docsearch").jqxGrid('selectedrowindexes');
			var docarray=new Array();
			var mainrowindex='<%=rowindex%>';
			var strjobtype="",strrowno="";
			for(var i=0;i<selectedrows.length;i++){
				var jobtype=$("#docsearch").jqxGrid('getcellvalue',selectedrows[i],'jobtype');
				var rowno=$("#docsearch").jqxGrid('getcellvalue',selectedrows[i],'rowno');
				docarray.push(rowno+"::"+jobtype);
				if(i==0){
					strjobtype+=jobtype;
					strrowno+=rowno;
				}
				else{
					strjobtype+=","+jobtype;
					strrowno+=","+rowno;
				}
				
			}
			$('#detailsgrid').jqxGrid('setcellvalue', mainrowindex, "jobtype",strjobtype);
			$('#detailsgrid').jqxGrid('setcellvalue', mainrowindex, "jobno",strrowno);
<%-- 			
			var rows = $("#docsearch").jqxGrid('getrows'); 
            	 
            		if(selectedrows.length>0){
            						var i=0;
	                
				    for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++)
						{
							if(selectedrows[j]==i)
							{
								
								alert(docarray);
							}
						}
						
						}
				  
				   
					
						if(i==rows.length){
							
							jobno=docarray[0].split('::')[0];
							docstring=docarray[1].split('::')[1];
							
							 $("#Countgrid").load("Countgrid.jsp?branchval="+'<%=branchval%>'+"&fromdate="+'<%=fromdate%>'+"&todate="+'<%=todate%>'+"&filtval="+'<%=val%>'+"&grpval="+'<%=grpval%>'+"&docarray="+docstring+"&id=1");
							 $('#detailsgrid').jqxGrid('setcellvalue', mainrowindex, "jobtype",docstring);
							  $('#detailsgrid').jqxGrid('setcellvalue', mainrowindex, "jobno",jobno);
							
						}
			
            			
            		}
            		else{
            			//alert("no data");
            		} 
         
         --%>    	
         $('#docwindow').jqxWindow('close');
        	});	
            
        });
        
        
    </script>
    <div align="center" style="padding-bottom:4px;"><button type="button" id="btnserType" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
    <div id="docsearch"></div>