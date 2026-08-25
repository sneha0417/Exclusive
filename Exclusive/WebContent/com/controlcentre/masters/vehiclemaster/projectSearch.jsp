<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<% ClsProjectDAO cpd =new ClsProjectDAO();%>

<script type="text/javascript">
 var data= '<%=cpd.projectDetailsLoading() %>'; 
 $(document).ready(function () {           
	 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	     						{name : 'project_name', type: 'String'  },
	                          	{name : 'date', type: 'date'  },
	                          	{name : 'refname', type: 'String'  }
	                 ],
	               localdata: data,
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    }
			            }		
	            );
	    
	            $("#jqxProjectSearch").jqxGrid(
	                    {
	                    	width: '100%',
	                    	height: 357,
	                        source: dataAdapter,
	                        filterable:true,
	                        showfilterrow:true,
	                        selectionmode: 'singlerow',
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '50%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '40%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Client Name',columntype: 'textbox', hidden: true, filtertype: 'input', datafield: 'refname', width: '10%' },
	        	              ]
	                    });
	            $('#jqxProjectSearch').on('rowdoubleclick', function (event) {
	                var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxProjectSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("txtprojectname").value = $("#jqxProjectSearch").jqxGrid('getcellvalue', rowindex1, "project_name");
	                $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtclientname").value = $("#jqxProjectSearch").jqxGrid('getcellvalue', rowindex1, "refname");
	                $('#window').jqxWindow('close');
	            }); 
          });

</script>
<div id="jqxProjectSearch"></div>
