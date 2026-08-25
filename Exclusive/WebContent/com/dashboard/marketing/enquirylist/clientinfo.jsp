  <%@page import="com.dashboard.marketing.enquirylist.ClsEnqiryListDAO"%>
     <%
     ClsEnqiryListDAO cmd= new ClsEnqiryListDAO();
     %>


<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">

<%--  
var trmps='<%=aa%>';
var vehdata;

 if(trmps!='NA')
	 { --%>

	 var vehdata='<%=cmd.Searchclient(session)%>'; 
	// alert(vehdata);
/* alert
	 }
 else
	 {
	 vehdata;

	 } */
   // alert(data);
  /*  var url1='disfleetSearch.jsp'; */
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	
     						{name : 'refname', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						
     				                        	
                          	],
             
                          	localdata: vehdata,
                
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
            $("#clientsearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
              
              filterable: true,
              showfilterrow: true, 
                selectionmode: 'singlerow',
                pagermode: 'default',
              
                //Add row method
	
                columns: [
					
					{ text: 'Client Name', datafield: 'refname', width: '100%'},
				
					{ text: 'Cldocno', datafield: 'cldocno', width: '10%' ,hidden:true },
		

					
					]
            });
            
            $('#clientsearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
         
            	
        
               document.getElementById("cldocno").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
               document.getElementById("clientname").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
/*                document.getElementById("re_Km").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "kmin");
               document.getElementById("ratariff_fuel").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "fin");
               document.getElementById("payment_Conveh").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               document.getElementById("vehlocation").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "a_loc");
               
               document.getElementById("hidvehfuel").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex1, "hidfin"); */
               
               

                $('#clinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="clientsearch"></div>