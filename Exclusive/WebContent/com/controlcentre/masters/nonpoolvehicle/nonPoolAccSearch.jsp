<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>


 <%--    <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
  <script type="text/javascript">
  <%-- <% System.out.println(request.getAttribute("docno"));%> --%>
    var data= '<%=cas.nonPoolAccSearch()%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  },
     						{name : 'address' , type: 'String' },
     						{name : 'com_mob' , type: 'String' },
     						{name : 'per_mob' , type: 'String' }
                 ],
                 localdata: data,
                
                
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
            $("#jqxNonPoolAccGrid").jqxGrid(
            {
                width: '100%',
                height: 374,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
               // showfilterrow: true,
               // filterable: true,
                pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', filtertype: 'number',datafield: 'doc_no', width: '20%' },
					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '80%' },
					{ text: 'Address',columntype: 'textbox', filtertype: 'input', datafield: 'address', width: '80%',hidden:true },
					{ text: 'Tel 1',columntype: 'textbox', filtertype: 'input', datafield: 'com_mob', width: '80%',hidden:true },
					{ text: 'Tel 2',columntype: 'textbox', filtertype: 'input', datafield: 'per_mob', width: '80%',hidden:true }

					]
            });

            $('#jqxNonPoolAccGrid').on('rowdoubleclick', function (event) 
            		{ 
            	  
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("txtaccname").value= $('#jqxNonPoolAccGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
		                document.getElementById("txtaccno").value = $("#jqxNonPoolAccGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		                document.getElementById("address").value = $("#jqxNonPoolAccGrid").jqxGrid('getcellvalue', rowindex1, "address");
		                document.getElementById("tel1").value = $("#jqxNonPoolAccGrid").jqxGrid('getcellvalue', rowindex1, "com_mob");
		                document.getElementById("tel2").value = $("#jqxNonPoolAccGrid").jqxGrid('getcellvalue', rowindex1, "per_mob");
		                $('#fleetno').trigger('focus');
		                $('#accountWindow').jqxWindow('close');
			             
            		 }); 
           
        });
    </script>
    <div id="jqxNonPoolAccGrid"></div>
