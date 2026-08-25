<%@page import="com.controlcentre.masters.relatedmaster.hoteltype.ClsHotelDAO"%>

       

       <%
       
       ClsHotelDAO viewDAO=new ClsHotelDAO();
       %>
       <script type="text/javascript">
 
       /*    var temp=document.getElementById("txtcusid").value;
		if(temp>0)
			{
			var url1='disDriver.jsp?clientid='+temp;
			
			}
		else
			{
			var url1;
			} */
			 var barnddata= '<%=viewDAO.searchRoom() %>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'remarks', type: 'string'  },
                            {name : 'name', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxroomSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'Room Type', datafield: 'name' },
                              { text: 'Remarks', datafield: 'remarks', width: '75%',hidden:true }
						
			
	             
						]
            });
            
          $('#jqxroomSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#gridrowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxHotel').jqxGrid('setcellvalue', rowindex1, "roomtype" ,$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "name"));
                $('#jqxHotel').jqxGrid('setcellvalue', rowindex1, "rtypeid" ,$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                $('#jqxHotel').jqxGrid('setcellvalue', rowindex1, "category" ,$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "remarks"));
               /*  document.getElementById("brandval").value=$('#jqxroomSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                document.getElementById("gridval").value=1;
                var rows = $('#jqxEnquiry').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	  $("#jqxEnquiry").jqxGrid('addrow', null, {});	
                }
              
                document.getElementById("errormsg").innerText=""; */
                
                
              $('#roominfowindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxroomSearch"></div>