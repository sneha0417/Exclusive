<%@page import="com.controlcentre.settings.approvalmaster.ClsApprovalMasterDAO" %>
<%ClsApprovalMasterDAO camd=new ClsApprovalMasterDAO(); %>
    <script type="text/javascript">
    var count='<%=request.getParameter("count")%>';
    var levels='<%=request.getParameter("levels")%>';
    <% String txtuserdoc = request.getParameter("txtuserdoc")==null?"0":request.getParameter("txtuserdoc"); %>
    var data= '<%=camd.usersearchDetails(txtuserdoc) %>';
        $(document).ready(function () { 	
        	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'user_id', type: 'String'  },
     						{name : 'user_name', type: 'String'  }
     						
     						
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
            $("#jqxApprUserSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
              //  pageable: true,
               // altRows: true,
              //  sortable: true,
                 filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
               // sortable: true,
                //Add row method
	
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Name', datafield: 'user_name', width: '40%' },
					{ text: 'User', datafield: 'user_id', width: '60%' }
					
					
					]
            });
    
           
            $('#jqxApprUserSearch').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
            	if(levels=="level1")
            		{
                document.getElementById("txtfinal_user"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_name");
                document.getElementById("txtfinal_userdoc"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtfinal_userfull"+count).value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_id");
                
            		}
            	else{}
            	if(levels=="level2")
        		{
            		document.getElementById("txtsecond_user"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_name");
                    document.getElementById("txtsecond_userdoc"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                    document.getElementById("txtsecond_userfull"+count).value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_id");
        		}
        	else{}
            	if(levels=="level3")
        		{
            		document.getElementById("txtfirst_user"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_name");
                    document.getElementById("txtfirst_userdoc"+count).value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            		document.getElementById("txtfirst_userfull"+count).value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "user_id");
            
        		}
            	
        	else{}
            	document.getElementById("txtuserdoc").value+=","+$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#userWindow').jqxWindow('close');
                
            }); 
            
        
            /* var rowindex3=event.args.rowindex;
            document.getElementById("txtfinal_user3").value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex3, "user_name");
            document.getElementById("txtfinal_userfull3").value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex3, "user_id");
            document.close();
            var rowindex4=event.args.rowindex;
            document.getElementById("txtfinal_user4").value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex4, "user_name");
            document.getElementById("txtfinal_userfull4").value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex4, "user_id");
            document.close();
            var rowindex5=event.args.rowindex;
            document.getElementById("txtfinal_user5").value= $('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex5, "user_name");
            document.getElementById("txtfinal_userfull5").value=$('#jqxApprUserSearch').jqxGrid('getcellvalue', rowindex5, "user_id");
            document.close(); */
            
            $('#jqxApprUserSearch').on('rowdoubleclick', function (event) 
            		{ 
            	document.getElementById("search").style.display="none";
            	 
            		 }); 
      
        });
    </script>
    <div id="jqxApprUserSearch"></div>
