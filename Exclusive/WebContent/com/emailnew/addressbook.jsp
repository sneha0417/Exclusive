<%@page import="com.emailnew.ClsEmailDAO" %> 
<%ClsEmailDAO ced=new ClsEmailDAO(); %>
 <%@page import="javax.servlet.http.HttpSession" %>          
 <%      
 //System.out.println("=dtype==dtype==="+request.getParameter("dtype"));
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
%>      
     
  <script type="text/javascript">
    var datas= '<%=ced.addressbook(session,name,dtype,cldocno,id)%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'String'  },
							{name : 'e_mail', type: 'String'  },
							{name : 'dtype', type: 'String'  },
							{name : 'cperson', type: 'String'  },
							{name : 'activity', type: 'String'  },  
						
                 ],
                 localdata: datas,
                
                
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
            $("#jqxAddressbook").jqxGrid(
            {
            	width: '100%',
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow:'true',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
					{ text: 'E-mail ID',columntype: 'textbox', filtertype: 'input', datafield: 'e_mail', width: '30%' },
					{ text: 'Contact Person',columntype: 'textbox', filtertype: 'input', datafield: 'cperson', width: '20%' },
					{ text: 'Activity',columntype: 'textbox', filtertype: 'input', datafield: 'activity', width: '20%' },
					{ text: 'Doc Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtype', width: '20%' },
					   ]
            });

            $('#jqxAddressbook').on('rowdoubleclick', function (event)   
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("recipient").value= $('#jqxAddressbook').jqxGrid('getcellvalue', rowindex1, "e_mail");
		               // document.getElementById("txtsalikregno").value= $('#jqxAddressbook').jqxGrid('getcellvalue', rowindex1, "reg_no");
		              $('#ccaddressWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxAddressbook"></div>
