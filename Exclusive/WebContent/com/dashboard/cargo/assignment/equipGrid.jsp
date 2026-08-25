 <%@page import="com.dashboard.cargo.equipment.ClsEquipment"%>
 <% ClsEquipment searchDAO = new ClsEquipment(); 

 
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String flname = request.getParameter("flname")==null?"0":request.getParameter("flname");
 String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

<script type="text/javascript">
        
        

    var data2= '<%=searchDAO.equipmentSearch(session,flname,fleetno,regno,check) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'fleetno', type: 'string'   },
     						{name : 'flname', type: 'string'   },
     						{name : 'reg_no', type: 'string'   },
     						{name : 'trackid', type: 'string'   },
     						
     						
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxEquipmentSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                            { text: 'FLEETNO', datafield: 'fleetno', width: '25%' },
							{ text: 'FLNAME', datafield: 'flname', width: '30%' },
							{ text: 'REG_NO', datafield: 'reg_no', width: '25%' },
							{ text: 'TRAILER_NO', datafield: 'trackid', width: '20%' },
						]
            });
            
             $('#jqxEquipmentSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("trackid").value = $('#jqxEquipmentSearch').jqxGrid('getcellvalue', rowindex1, "trackid");
                document.getElementById("equipment").value = $('#jqxEquipmentSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
             	document.getElementById("hidequipmentid").value = $('#jqxEquipmentSearch').jqxGrid('getcellvalue', rowindex1, "fleetno");
             	$('#jqxEquipmentSearch').jqxGrid('clear');
             	$('#enqwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxEquipmentSearch"></div>
 