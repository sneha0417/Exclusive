<%@page import="com.controlcentre.settings.approvalmaster.ClsApprovalMasterDAO" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
<%ClsApprovalMasterDAO camd=new ClsApprovalMasterDAO(); %>


 <script type="text/javascript">

    var data1= '<%=camd.doctypesearch(session) %>';
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_type' , type: 'String' },
     						{name : 'menu_name', type: 'String'  }
                          	
                          	],
                 localdata: data1,
                
                
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
            $("#jqxSearchuser").jqxGrid(
            {
                width: '100%',
                height: 355,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               // altRows: true,
               // sortable: true,
                 filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                //sortable: true,
                //Add row method
	
                columns: [
					{ text: 'DOC TYPE', datafield: 'doc_type', width: '30%' },
					{ text: 'NAME', datafield: 'menu_name', width: '70%' }
					
					]
            });
    
           
     /*        $('#jqxSearchuser').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("doctype").value= $('#jqxSearchuser').jqxGrid('getcellvalue', rowindex1, "doc_type");
                document.getElementById("doctypename").value=$('#jqxSearchuser').jqxGrid('getcellvalue', rowindex1, "menu_name");
               
                document.close();
                $('#userinfoWindow').jqxWindow('close');
            }); 
             */
            $('#jqxSearchuser').on('rowdoubleclick', function (event) 
            		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("doctype").value= $('#jqxSearchuser').jqxGrid('getcellvalue', rowindex1, "doc_type");
                document.getElementById("doctypename").value=$('#jqxSearchuser').jqxGrid('getcellvalue', rowindex1, "menu_name");
            /*     document.getElementById("txtfinal_minapproval").value="0"; */
             document.getElementById("errormsg").innerText="";
              //  document.close();
                $('#userinfoWindow').jqxWindow('close');
            		 }); 
      
        });
    </script>
    <div id="jqxSearchuser"></div>