 <%
 String code = request.getParameter("bincode")==null?"0":request.getParameter("bincode");
 String name = request.getParameter("binname")==null?"0":request.getParameter("binname");
%> 
<%@page import="com.controlcentre.masters.floormaster.bin.ClsBinDAO"%>
<%ClsBinDAO DAO= new ClsBinDAO(); %>
<script type="text/javascript">
    var data= '<%=DAO.binMainSearch(code, name)%>';
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
                          	{name : 'date',type:'date'},
                          	{name : 'flname', type: 'String'  },
                          	{name : 'rckname', type: 'String'  },
     						{name : 'code', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'fl_id', type: 'String'  },
                          	{name : 'rck_id', type: 'String'  }
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
            
            $("#jqxBinMainSearch").jqxGrid(
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
						{ text: 'Floor', datafield: 'flname', width: '20%' },
						{ text: 'Rack', datafield: 'rckname', width: '20%' },
						{ text: 'Code', datafield: 'code', width: '10%' },
						{ text: 'Name', datafield:'name', width:'30%'},
						{ text: 'Floor No.', datafield: 'fl_id', hidden: true,  width: '10%' },
						{ text: 'Rack No.', datafield: 'rck_id', hidden: true,  width: '10%' },
					]
            });
                     
            $('#jqxBinMainSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtfloorcode").value=$('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "fl_id");
                document.getElementById("txtrackcode").value=$('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "rck_id");
                document.getElementById("txtrackname").value=$('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "rckname");
                document.getElementById("txtbincode").value=$('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("txtbinname").value=$('#jqxBinMainSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $("#binDate").jqxDateTimeInput('val',$("#jqxBinMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               
                $('#window').jqxWindow('close');
            }); 
            
      
        });

</script>
<div id="jqxBinMainSearch"></div>
