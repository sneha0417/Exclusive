<%@page import="com.project.execution.surveyDetails.ClsSurveyDetailsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 ClsSurveyDetailsDAO DAO=new ClsSurveyDetailsDAO();
 
 String Cl_names=request.getParameter("Cl_names")==null?"":request.getParameter("Cl_names").trim().toString();
 String msdocno=request.getParameter("msdocno")==null?"0":request.getParameter("msdocno").trim().toString();
 String Cl_mobno=request.getParameter("Cl_mobno")==null?"0":request.getParameter("Cl_mobno").trim().toString();
 String enqdate=request.getParameter("enqdate")==null?"0":request.getParameter("enqdate").trim().toString();
 
 %> 
 <script type="text/javascript">
  var enquirydata;
  

 <%--  enquirydata='<%=DAO.enquirySrearch(session, msdocno, Cl_names,Cl_mobno,enqdate)%>'; --%>
 
               
        $(document).ready(function () { 
         
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                        
							{name : 'doc_no', type: 'String'  },
     						{name : 'voc_no', type: 'String'  },
     						{name : 'name', type: 'String'  },
      						{name : 'clientid', type: 'String'  },
      						{name : 'details', type: 'String'  },
      						{name : 'cperson', type: 'String'  },
      						{name : 'cpersonid', type: 'String'  },
      						{name : 'contmob', type: 'String'  },
      						{name : 'date', type: 'string'  }
                          	],
                          	localdata: enquirydata,
                          
          
				
                
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
            $("#jqxenquirysearch").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',

     					
                columns: [
                      { text: 'Enquiry No', datafield: 'voc_no', width: '15%'},
					  { text: 'Doc_no', datafield: 'doc_no', width: '40%',hidden:true }, 
					  { text: 'Client', datafield: 'name', width: '35%' },
					  { text: 'clientid', datafield: 'clientid', width: '30%',hidden:true },
					  { text: 'Contact Person', datafield: 'cperson', width: '30%',hidden: true },
					  { text: 'cpersonid', datafield: 'cpersonid', width: '30%',hidden: true },
					  { text: 'Mob', datafield: 'contmob', width: '25%' },
					  { text: 'date', datafield: 'date', width: '25%' },
					  { text: 'details', datafield: 'details', width: '30%',hidden:true }
					 
					]
            });
    
				          $('#jqxenquirysearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				        
				                     document.getElementById("txtenquiry").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				                     document.getElementById("enqdoc_no").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				                     document.getElementById("txtclient").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "name");
				                     document.getElementById("clientid").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "clientid");
				                     document.getElementById("txtcontact").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				                     document.getElementById("contactnumber").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "contmob");
				                     document.getElementById("cpersonid").value=$('#jqxenquirysearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
				                    
				        
				                $('#window').jqxWindow('close');
				               
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxenquirysearch"></div>
    
