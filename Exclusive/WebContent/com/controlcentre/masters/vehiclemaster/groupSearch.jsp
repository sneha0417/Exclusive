<%@page import="com.controlcentre.masters.vehiclemaster.group.ClsGroupAction" %>
<% ClsGroupAction cga =new ClsGroupAction();%>

<script type="text/javascript">
    var data= '<%=cga.searchDetails() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'gid', type: 'String'  },
                          	{name : 'gname', type: 'String'  },
                          	{name : 'date',type:'date'},
                          	{name : 'utype',type:'number'},
                          	{name : 'level',type:'number'}
                          	
                          	
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
		            }		
            );
            $("#jqxGroupSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method

                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Group ID',columntype: 'textbox', filtertype: 'input', datafield: 'gid', width: '50%' },
					{ text: 'Group Name',columntype: 'textbox', filtertype: 'input',datafield:'gname',width:'40%'},
					{ text: 'Level', datafield: 'level', width: '20%',hidden:true },
					{ text: 'Utility Type', datafield: 'utype', width: '20%',hidden:true },
					{ text: 'Date', datafield: 'date', width: '20%',hidden:true ,cellsformat:'dd.MM.yyyy'},
					]
            });
          

            $('#jqxGroupSearch').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxGroupSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                document.getElementById("group").value=$('#jqxGroupSearch').jqxGrid('getcellvalue', rowindex1, "gid");
		                document.getElementById("name").value=$('#jqxGroupSearch').jqxGrid('getcellvalue', rowindex1, "gname");
		                $("#groupdate").jqxDateTimeInput('val',$("#jqxGroupSearch").jqxGrid('getcellvalue', rowindex1, "date"));
		       //	$('#groupdate').jqxDateTimeInput({ disabled: false}); 
		       //	$('#utype').jqxDateTimeInput({ disabled: false}); 

		            	$('#window').jqxWindow('hide');
            		 }); 
        
        });
    </script>
    <div id="jqxGroupSearch"></div>
