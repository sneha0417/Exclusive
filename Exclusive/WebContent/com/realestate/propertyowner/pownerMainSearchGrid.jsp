<%@page import="com.realestate.propertyowner.ClsPropertyOwnerDAO" %>
<%
ClsPropertyOwnerDAO cud=new ClsPropertyOwnerDAO();
%>
<%
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
  		else
  			{
  			
  			}
        
  		$(document).ready(function (){ 	
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'owner' , type: 'String' },
     						{name : 'address', type: 'String'  },
     						{name : 'mobile', type: 'String'  },
     						{name : 'email', type: 'String'  },
     						{name : 'doc_no', type: 'int'  }
                 ],
               localdata: data1,
               
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
            $("#jqxPownerSearch").jqxGrid(
            {
            	width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                
                columns: [
					{ text: 'Name', datafield: 'owner', width: '40%' },
					{ text: 'Address.', datafield: 'address', width: '20%' },
					{ text: 'Mobile No.', datafield: 'mobile', width: '20%' },
					{ text: 'Email', datafield: 'email', width: '20%' },
					{ text: 'Doc No', hidden: true, datafield: 'doc_no', width: '5%' },
	              ]
            });
            
            $('#jqxPownerSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				
				$('#frmPropertyOwner select').attr('disabled', false);
				funReset();
				document.getElementById("txtprimeowner").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "owner");
                document.getElementById("txtaddress").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "address");
                document.getElementById("txtemail").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "email");
                document.getElementById("txtmobpho").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("docno").value= $('#jqxPownerSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                
                $('#jqxDate').jqxDateTimeInput({disabled: false});
                $('#jqxBirthDate').jqxDateTimeInput({disabled: false});
                $('#jqxexpiryDate').jqxDateTimeInput({disabled: false});
                  funSetlabel();
				setValues();
                
                $('#frmPropertyOwner select').attr('disabled', true);
                $('#jqxDate').jqxDateTimeInput({disabled: true});
                $('#jqxBirthDate').jqxDateTimeInput({disabled: true});
                $('#jqxexpiryDate').jqxDateTimeInput({disabled: true});
                $('#window').jqxWindow('close');
                document.getElementById("frmPropertyOwner").submit();
            }); 
        });
    </script>
    <div id="jqxPownerSearch"></div>
