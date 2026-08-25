<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.servicetype.ClsServiceTypeDAO"%>
<%ClsServiceTypeDAO DAO= new ClsServiceTypeDAO();

String stype = request.getParameter("stype")==null?"0":request.getParameter("stype");
 
 
%> 
 <script type="text/javascript">
 
  var searchdata;
  searchdata='<%=DAO.mainSrearch(stype)%>'; 
 
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
              
     						{name : 'stype', type: 'String'  },
     						{name : 'desc1', type: 'String'  },
      						{name : 'docno', type: 'String'  },
      						{name : 'date', type: 'String'  },
      						
                          	],
                          	localdata: searchdata,
                          
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Service Type', datafield: 'stype', width: '35%' },
					{ text: 'Description', datafield: 'desc1', width: '50%' },
					{ text: 'Docno', datafield: 'docno', width: '15%'},
					{ text: 'Date', datafield: 'date', width: '15%',hidden:true},
					
					
					]
            });
    
          /*   $("#jqxmainsearch").jqxGrid('addrow', null, {}); */
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				         document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				         document.getElementById("txtname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "stype");
				         document.getElementById("txtdesc").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "desc1");
				         $('#date').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "date"));           
				         
				         var docno=$('#docno').val();
				     	 $('#descGrid').load("descGrid.jsp?docno="+docno);
				     	 
				     	 $('#frmsurveytype input').attr('disabled', false );
				                  
				                $('#window').jqxWindow('close');
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
