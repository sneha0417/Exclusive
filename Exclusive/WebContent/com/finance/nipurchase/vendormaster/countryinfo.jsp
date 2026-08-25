<%@page import="com.finance.nipurchase.vendormaster.ClsVendorDetailsDAO"%> 
<%
ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO();
%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">

<%--  
var trmps='<%=aa%>';
var vehdata;

 if(trmps!='NA')
	 { --%>

	 var vehdata='<%=DAO.countrySearch(session)%>'; 
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
                          	
     						{name : 'country', type: 'String'  },
     						{name : 'cdocno', type: 'String'  },
     						
     				                        	
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
            $("#countrysearch").jqxGrid(
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
					
					{ text: 'Country_Name', datafield: 'country', width: '100%'},
				
					{ text: 'Docno', datafield: 'cdocno', width: '10%' ,hidden:true },
		

					
					]
            });
            
            $('#countrysearch').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindex1=event.args.rowindex;
         
               document.getElementById("txtcdocno").value=$('#countrysearch').jqxGrid('getcellvalue', rowindex1, "cdocno");
               document.getElementById("txtcountryname").value=$('#countrysearch').jqxGrid('getcellvalue', rowindex1, "country");

                $('#countryinfowindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="countrysearch"></div>