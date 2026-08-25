<%@page import="com.controlcentre.masters.floormaster.bin.ClsBinDAO"%>
<%ClsBinDAO DAO= new ClsBinDAO(); %>
<%
 String rckname = request.getParameter("rckname")==null?"0":request.getParameter("rckname");
 String rckcode = request.getParameter("rckcode")==null?"0":request.getParameter("rckcode");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">

	var data2= '<%=DAO.rackDetailsSearch(rckname,rckcode,chk) %>';
    
		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'flname', type: 'String'  },
     						{name : 'code', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'fl_id', type: 'int'  }
                          	],
               localdata: data2,
                
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
            $("#jqxRackDetailsSearch").jqxGrid(
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
					{ text: 'Doc No', datafield: 'doc_no', hidden:true, width: '10%' },
					{ text: 'Floor', datafield: 'flname', width: '40%' },
					{ text: 'Code', datafield: 'code', width: '20%' },
					{ text: 'Name', datafield: 'name', width: '40%' },
					{ text: 'Floor Id', datafield: 'fl_id', hidden:true, width: '10%' },
					]
            });
            $('#jqxRackDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("txtrackcode").value = $("#jqxRackDetailsSearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtrackname").value = $("#jqxRackDetailsSearch").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtfloorcode").value= $('#jqxRackDetailsSearch').jqxGrid('getcellvalue', rowindex1, "fl_id");
                
                $('#rackDetailsWindow').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="jqxRackDetailsSearch"></div>
