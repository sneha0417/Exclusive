 <%
 String code = request.getParameter("flcode")==null?"0":request.getParameter("flcode");
 String name = request.getParameter("flname")==null?"0":request.getParameter("flname");
%> 

<%@page import="com.controlcentre.masters.floormaster.floor.ClsFloorDAO"%>
<%ClsFloorDAO DAO= new ClsFloorDAO(); %>

<script type="text/javascript">
    var data= '<%=DAO.flrMainSearch(code, name)%>';
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'date',type:'date'},
     						{name : 'code', type: 'String'  },
                          	{name : 'name', type: 'String'  }
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
            
            $("#jqxFloorMainSearch").jqxGrid(
            {
            	 width: '99%',
                 height: 300,
                 source: dataAdapter,
                 selectionmode: 'singlerow',
      			 editable: false,
      			 columnsresize: true,
	
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
						{ text: 'Date', datafield: 'date',  cellsformat: 'dd.MM.yyyy' , width: '20%' },
						{ text: 'Code', datafield: 'code', width: '20%' },
						{text: 'Name', datafield:'name',width:'40%'},
					]
            });
                     
            $('#jqxFloorMainSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxFloorMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtfloorcode").value=$('#jqxFloorMainSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtfloorname").value=$('#jqxFloorMainSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $("#floorDate").jqxDateTimeInput('val',$("#jqxFloorMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               
                $('#window').jqxWindow('close');
            }); 
            
      
        });
    </script>
    <div id="jqxFloorMainSearch"></div>
