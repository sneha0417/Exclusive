<%@page import="com.email.ClsEmailDAO" %> 
<%ClsEmailDAO ced=new ClsEmailDAO(); %>
 

     <%-- <jsp:include page="../../includes.jsp"></jsp:include> --%> 
     
 <%@page import="javax.servlet.http.HttpSession" %>    
 <%
 //System.out.println("=dtype==dtype==="+request.getParameter("dtype"));
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 
%>    
     
  <script type="text/javascript">
    var datas= '<%=ced.addressbook(session,name,dtype)%>';
    //alert("==================data");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'String'  },
							{name : 'e_mail', type: 'String'  },
							{name : 'dtype', type: 'String'  }
						
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
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '40%' },
					{ text: 'E-mail ID',columntype: 'textbox', filtertype: 'input', datafield: 'e_mail', width: '40%' },
					{ text: 'Doc Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtype', width: '20%' }
					
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
