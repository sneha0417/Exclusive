 
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
 
 String refnosss=request.getParameter("refnosss")==null?"0":request.getParameter("refnosss");
 
 String datess=request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid");
 
 String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");

 String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype");
 String locaid = request.getParameter("locaid")==null?"0":request.getParameter("locaid");
%>
 
 
<%@page import="com.sales.Sales.deliverynote.ClsDeliveryNoteDAO"%>
<%ClsDeliveryNoteDAO DAO= new ClsDeliveryNoteDAO();%>
 
 
 
<script type="text/javascript">

var Reqmaster;

var temps='<%=aa%>';

if(temps='yes')
	{
  Reqmaster= '<%=DAO.reqSearchMasters(session,docnoss,refnosss,datess,aa,clientid,locaid) %>'; 
	}
else
	{
	Reqmaster; 
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
     						{name : 'client', type: 'string'   },
     						{name : 'refno', type: 'string'  },
     						{name : 'chk', type: 'bool'  },
                 ],
                 localdata: Reqmaster,
                
                
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

            
            
            $("#reqMastersearch").jqxGrid(
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
							{ text: 'Client', datafield: 'client', width: '55%' , editable: false}	,
							
			              ]
               
            });
            
            
            
        
            $("#reqMastersearch").on('cellvaluechanged', function (event) 
            		{
            		    
            	  document.getElementById("errormsg").innerText="";
            		    
            		});  
            
            
      
   
        });
    </script>
    <div id=reqMastersearch></div>
 