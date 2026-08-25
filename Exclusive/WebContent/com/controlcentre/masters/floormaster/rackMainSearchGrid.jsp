 <%
 String code = request.getParameter("rackcode")==null?"0":request.getParameter("rackcode");
 String name = request.getParameter("rackname")==null?"0":request.getParameter("rackname");
%> 
<%@page import="com.controlcentre.masters.floormaster.rack.ClsRackDAO"%>
<%ClsRackDAO DAO= new ClsRackDAO(); %>
<script type="text/javascript">
    var data= '<%=DAO.racMainSearch(code, name)%>';
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'date',type:'date'},
                          	{name : 'flname', type: 'String'  },
     						{name : 'code', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'fl_id', type: 'String'  }
                          	],
                 localdata: data,

                 pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxRackMainSearch").jqxGrid(
            {
            	 width: '99%',
                 height: 300,
                 source: dataAdapter,
                 selectionmode: 'singlerow',
      			 editable: false,
      			 columnsresize: true,
	
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
						{ text: 'Date', datafield: 'date',  cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Floor', datafield: 'flname', width: '30%' },
						{ text: 'Code', datafield: 'code', width: '20%' },
						{ text: 'Name', datafield:'name', width:'30%'},
						{ text: 'Floor No.', datafield: 'fl_id', hidden: true,  width: '20%' },
					]
            });
                     
            $('#jqxRackMainSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxRackMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtfloorcode").value=$('#jqxRackMainSearch').jqxGrid('getcellvalue', rowindex1, "fl_id");
                document.getElementById("txtfloorname").value=$('#jqxRackMainSearch').jqxGrid('getcellvalue', rowindex1, "flname");
                document.getElementById("txtrackcode").value=$('#jqxRackMainSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtrackname").value=$('#jqxRackMainSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $("#rackDate").jqxDateTimeInput('val',$("#jqxRackMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               
                $('#window').jqxWindow('close');
            }); 
            
      
        });

</script>
<div id="jqxRackMainSearch"></div>
