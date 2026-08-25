 <%@page import="com.controlcentre.settings.activity.ClsActivityDAO"%>
<%ClsActivityDAO DAO= new ClsActivityDAO();%>
 <script type="text/javascript">
  		var data= '<%=DAO.searchDetails() %>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                           {name : 'doc_no' , type: 'number' },
	                       {name : 'date', type: 'String' },
	                       {name : 'ay_name', type: 'String'  } ,
                           {name : 'ay_code', type: 'String'  }  
       						    
                            	
                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxActivitySearch").jqxGrid(
            {
                width: '100%',
                height: 327,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
                            { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
                            { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%' },
                            { text: 'Activity',columntype: 'textbox', filtertype: 'input', datafield: 'ay_name', width: '50%' },
                            { text: 'Activity Code',columntype: 'textbox', filtertype: 'input', datafield: 'ay_code', width: '40%' } 
           					
	              ]
            });
            $('#jqxActivitySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxActivitySearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("activity").value = $("#jqxActivitySearch").jqxGrid('getcellvalue', rowindex1, "ay_name");
                document.getElementById("activity_code").value = $("#jqxActivitySearch").jqxGrid('getcellvalue', rowindex1, "ay_code");
                $("#date_acti").jqxDateTimeInput('val', $("#jqxActivitySearch").jqxGrid('getcellvalue', rowindex1, "date"));
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
            $("#jqxActivitySearch").jqxGrid('hidecolumn', 'date'); 
        });
    </script>
    <div id="jqxActivitySearch"></div>
