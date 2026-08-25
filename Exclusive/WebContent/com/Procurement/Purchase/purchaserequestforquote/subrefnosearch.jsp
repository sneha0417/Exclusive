 
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 
 String refnosss=request.getParameter("refnosss")==null?"0":request.getParameter("refnosss");
 
 String datess=request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");

 String acno=request.getParameter("acno")==null?"0":request.getParameter("acno");

 String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype");
 
%>
 <%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<% ClspurchaserequestforquoteDAO  purchaserequestforquoteDAO = new ClspurchaserequestforquoteDAO(); %> 
 
 
 
 
 
 
<script type="text/javascript">

var vahReqmaster;

var temps='<%=aa%>';

if(temps='yes')
	{
	var vahReqmaster= '<%=purchaserequestforquoteDAO.reqSearchMasters(session,docnoss,refnosss,datess,aa,acno,cmbreftype) %>'; 
	}
else
	{
	  vahReqmaster; 
	}



            	
        $(document).ready(function () { 	
        
 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                                
                             {name : 'voc_no', type: 'int'},  
     		 				{name : 'doc_no', type: 'int'},
     						{name : 'date', type: 'date'  },
     						{name : 'description', type: 'string'   },
     						{name : 'chk', type: 'bool'  },
     						{name : 'refno', type: 'string'  },
     						{name : 'ckvalue', type: 'int'  },
     						
     						
     						
     											
                 ],
                 localdata: vahReqmaster,
                
                
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

            
            
            $("#vehreqMastersearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
             
                
          
          

                       
                columns: [      
                            { text: ' ', datafield: 'chk',columntype: 'checkbox', editable: true,   width: '10%',cellsalign: 'center', align: 'center'},
                            { text: 'masterDoc NO', datafield: 'doc_no', width: '10%' ,hidden:true},	
							{ text: 'DocNo', datafield: 'voc_no', width: '10%', editable: false },	
							{ text: 'Date', datafield: 'date', width: '15%' ,cellsformat:'dd.MM.yyyy', editable: false},
							{ text: 'RefNo', datafield: 'refno', width: '10%', editable: false },
							
							{ text: 'Description', datafield: 'description', width: '55%' , editable: false}	,
							
							{ text: 'chkvalue', datafield: 'ckvalue', width: '10%'  ,hidden:true }	
							
							
			              ]
               
            });
            
            
            
        
            $("#vehreqMastersearch").on('cellvaluechanged', function (event) 
            		{
            		    
            	  document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
      
   
        });
    </script>
    <div id=vehreqMastersearch></div>
 