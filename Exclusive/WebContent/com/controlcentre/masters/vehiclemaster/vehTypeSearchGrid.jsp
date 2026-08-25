<%@page import="com.controlcentre.masters.vehiclemaster.vehtype.*" %>
<%ClsVehTypeDAO dao=new ClsVehTypeDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var searchdata=[];
	if(id=="1"){
		searchdata='<%=dao.getVehTypeData(id)%>';
	}
    
    $(document).ready(function () { 	
   		var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'doc_no' , type: 'number' },
     			{name : 'name', type: 'String'  },
                {name : 'date', type: 'date'  },
            ],
            localdata: searchdata,
            
            pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
            }
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        	{
            	loadError: function (xhr, status, error) {
	            	// alert(error);    
	        	}
			}		
        );
        $("#vehTypeSearchGrid").jqxGrid(
        {
        	width: '100%',
            height: 358,
            source: dataAdapter,
            columnsresize: true,
            filterable:true,
            showfilterrow: true,
            altRows: true,
            sortable: true,
            selectionmode: 'singlerow',
            pagermode: 'default',
            sortable: true,
            columns: [
				{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
				{ text: 'Vehicle Type', columntype: 'textbox', filtertype: 'input',datafield: 'name', width: '70%' },
				{ text: 'Date', datafield: 'date', width: '20%',columntype: 'textbox', filtertype: 'input',cellsformat:'dd.MM.yyyy' }
	        ]
        });
		
		$('#vehTypeSearchGrid').on('rowdoubleclick', function (event) 
        { 
			var rowindex1=event.args.rowindex;
		    document.getElementById("docno").value= $('#vehTypeSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		    document.getElementById("name").value = $("#vehTypeSearchGrid").jqxGrid('getcellvalue', rowindex1, "name");
		    $("#date").jqxDateTimeInput('val', $("#vehTypeSearchGrid").jqxGrid('getcellvalue', rowindex1, "date")); 
		    $('#window').jqxWindow('hide');
        }); 
        
    });
</script>
<div id="vehTypeSearchGrid"></div>