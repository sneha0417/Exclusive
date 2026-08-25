<%@page import="com.controlcentre.masters.vehiclemaster.securitypass.ClsSecurityPassDAO" %>
<%ClsSecurityPassDAO DAO=new ClsSecurityPassDAO();%>
<script>
$(document).ready(function(){

var spdata='<%=DAO.searchDetails()%>'; 


		
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
							{name : 'description',type:'string'},
                 ],
               localdata: spdata,
                //url: "/searchDetails",
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
    
            $("#securityPassSearchGrid").jqxGrid(
                    {
                    	width: '100%',
                    	height:350,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
							{ text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
        	              ]
                    });
            $('#securityPassSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#securityPassSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#securityPassSearchGrid").jqxGrid('getcellvalue', rowindex1, "name");
				document.getElementById("description").value = $("#securityPassSearchGrid").jqxGrid('getcellvalue', rowindex1, "description");
                $("#date").jqxDateTimeInput('val', $("#securityPassSearchGrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
                // 
            }); 
});
            </script>
            <div id="securityPassSearchGrid"></div>