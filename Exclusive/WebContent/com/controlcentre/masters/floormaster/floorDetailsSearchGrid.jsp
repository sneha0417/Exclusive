<%@page import="com.controlcentre.masters.floormaster.rack.ClsRackDAO"%>
<%ClsRackDAO DAO= new ClsRackDAO(); %>
<%
 String flname = request.getParameter("flname")==null?"0":request.getParameter("flname");
 String flcode = request.getParameter("flcode")==null?"0":request.getParameter("flcode");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">

	var data1= '<%=DAO.floorDetailsSearch(flname,flcode,chk) %>';
    
		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'code', type: 'String'  },
                          	{name : 'name', type: 'String'  }
                          	],
               localdata: data1,
                
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
            $("#jqxFloorSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,

                columns: [
					{ text: 'Doc No', datafield: 'doc_no', hidden: true, width: '10%' },
					{ text: 'Code', datafield: 'code', width: '35%' },
					{ text: 'Name', datafield: 'name', width: '65%' },
					]
            });
            
            $('#jqxFloorSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("txtfloorcode").value= $('#jqxFloorSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("txtfloorname").value = $("#jqxFloorSearch").jqxGrid('getcellvalue', rowindex1, "name");
               
                $('#floorDetailsWindow').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="jqxFloorSearch"></div>
