<%@page import="com.humanresource.setup.hrsetup.leave.ClsLeaveDAO"%>
<% ClsLeaveDAO DAO = new ClsLeaveDAO();%>     
  
<script type="text/javascript">
 
	var abbrevationData='<%=DAO.leaveAbbrevationDetails()%>'; 
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
 						{name : 'name', type: 'string'   },
 						{name : 'alpha', type: 'string'  }
                    ],
            		localdata: abbrevationData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#leaveAbbrevationSearchGrid").jqxGrid(
        {
        	width: '100%',
            height: 210,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			showfilterrow: true,
            filterable: true,
            
            columns: [
						{ text: 'Name', datafield: 'name', width: '60%' },
						{ text: 'Abbreviation', datafield: 'alpha', width: '40%' },
					]
        });
        
         $('#leaveAbbrevationSearchGrid').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
            
            document.getElementById("abbreviation").value = $('#leaveAbbrevationSearchGrid').jqxGrid('getcellvalue', rowindex1, "alpha");
        	
          $('#abbrevationDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="leaveAbbrevationSearchGrid"></div>