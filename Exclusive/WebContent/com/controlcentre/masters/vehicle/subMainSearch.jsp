<%@page import="com.controlcentre.masters.vehiclemaster.vehicle.ClsVehicleDAO" %>
<%ClsVehicleDAO cvd=new ClsVehicleDAO(); %>

<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String fleetname=request.getParameter("fleetname")==null?"0":request.getParameter("fleetname");
 String fleetno=request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 String engine=request.getParameter("engine")==null?"0":request.getParameter("engine");
 String chassis=request.getParameter("chassis")==null?"0":request.getParameter("chassis");
%> 
 <script type="text/javascript">
 var temp='<%=id%>';
  var loaddata;
if(temp==1){
	loaddata='<%=cvd.mainSearch(docno,fleetname,fleetno,regno,date,session,engine,chassis)%>';
}
else{
	
}
 
               
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                       
                         	
							{name : 'doc_no' , type: 'string' },
							{name : 'date' , type:'date'},
							{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no', type: 'String'  },
     						{name : 'engine', type: 'String'  },
     						{name : 'chassis', type: 'String'  }
      					
      						
      	      						
                          	],
                          	localdata: loaddata,
                          
          
				
                
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
                height: 280,
                source: dataAdapter,
                columnsresize: true,

                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
				
			{ text: 'Doc No', datafield: 'doc_no', width: '10%'},
				{ text: 'Date',  datafield: 'date',  width: '10%',cellsformat:'dd.MM.yyyy'},
				{ text: 'Fleet No',datafield: 'fleet_no', width: '10%' },
				{ text: 'Fleet Name', datafield: 'flname', width: '30%' },
				{ text: 'Engine No', datafield: 'engine', width: '15%' },
				{ text: 'Chassis No', datafield: 'chassis', width: '15%' },
				{ text: 'Reg No', datafield: 'reg_no', width: '10%' }
					 
			
								
					
					]
            });
    
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        		var rowindex1=event.args.rowindex;
				                document.getElementById("fleetno").value= $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
				                document.getElementById("fleetname").value = $("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "flname");
				                document.getElementById("regno").value = $("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
				                $('#window').jqxWindow('close');
				                funSetlabel();
				                document.getElementById("frmVehicle").submit();
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
