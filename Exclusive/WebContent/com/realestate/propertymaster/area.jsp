<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO(); %>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>

 <script type="text/javascript">
 var radata;
 var value = '<%=request.getParameter("getarea")%>';
 radata='<%=DAO.areaSearch(session)%>';
 $(document).ready(function () {
	 var num = 0; 
	 var source = 
	 {
			 datatype: "json",
			 datafields: [
     						{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'city_name', type: 'String'  },
     						{name : 'country_name', type: 'String'  },
     						{name : 'region_name', type: 'String'  }
     					],
     						localdata: radata,
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
            $("#jqxareasearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'AREA', datafield: 'area', width: '24%' },
					{ text: 'State', datafield: 'city_name', width: '24%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '20%' }
					]
            });
            $('#jqxareasearch').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
            	var temp="";
            	temp=temp+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "country_name");
            	temp=temp+","+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "region_name");
            	if(value==0)
            	{
            		document.getElementById("txtareadet").value=temp; 
            		document.getElementById("txtareaid").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno");
            		document.getElementById("txtarea").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area");
            	}
            	if(value==1)
            	{
            		$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area"));
            		$('#cpDetailsGrid').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno"));
            	}

            	$('#areainfowindow').jqxWindow('close');
            		}); 	 
 }); 
				       
                       
    </script>
    <div id="jqxareasearch"></div>
    
    </body>
</html>