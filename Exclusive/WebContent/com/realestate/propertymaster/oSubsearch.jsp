 
<%@page import="com.realestate.propertyowner.ClsPropertyOwnerDAO" %>
<%

ClsPropertyOwnerDAO cud=new ClsPropertyOwnerDAO();

String powner = request.getParameter("powner")==null?"0":request.getParameter("powner");
String address = request.getParameter("address")==null?"0":request.getParameter("address");
String vndmob = request.getParameter("vndmob")==null?"0":request.getParameter("vndmob");
String vndemail = request.getParameter("vndemail")==null?"0":request.getParameter("vndemail");
String id = request.getParameter("id")==null?"0":request.getParameter("id");
 
 
%>
<script type="text/javascript">
var data1;
	var id='<%= id%>';
	if(id=="1")
		{
		 data1= '<%= cud.vndMainSearch(powner,address,vndmob,vndemail,id) %>';
		}
	
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                         	{name : 'owner' , type: 'String' },
     						{name : 'address', type: 'String'  },
     						{name : 'mobile', type: 'String'  },
     						{name : 'email', type: 'String'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'acno', type: 'string'   },
     						//atype code curid rate lpono sal_name sal_id deldate deltime fixdate costtr_no costtype
     						  
                        ],
                		localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#cormainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                      	{ text: 'Name', datafield: 'owner', width: '40%' },
    					{ text: 'Address.', datafield: 'address', width: '20%' },
    					{ text: 'Mobile No.', datafield: 'mobile', width: '20%' },
    					{ text: 'Email', datafield: 'email', width: '20%' },
    					{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '5%' },
						{ text: 'acc number', datafield: 'acno', width: '20%',hidden:true },
								 
						]
            });
            
             $('#cormainsearshgrid').on('rowdoubleclick', function (event) {  
                var rowindex1 = event.args.rowindex;
                
                 document.getElementById("ownerid").value = $('#cormainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
   
	        	 document.getElementById("owner").value = $('#cormainsearshgrid').jqxGrid('getcellvalue',rowindex1, "owner");
	               	 
	        	 document.getElementById("owacno").value = $('#cormainsearshgrid').jqxGrid('getcellvalue',rowindex1, "acno");
	        	 
	        	 if($('#owacno').val()!="")
				 {
		        	 $('#divownerac').show();
					 $('#lblowneraccount').text("Owner Account Number: " + $('#cormainsearshgrid').jqxGrid('getcellvalue',rowindex1, "acno"));
				 }
	        	 
	        	 $('#refnosearchwindow').jqxWindow('close'); 	        	 
             
            });  
             
        });
    </script>
    <div id="cormainsearshgrid"></div>