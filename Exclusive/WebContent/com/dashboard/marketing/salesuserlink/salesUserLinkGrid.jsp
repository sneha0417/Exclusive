<%@page import="com.dashboard.marketing.salesuserlink.ClsSalesUserLink" %>
<% ClsSalesUserLink DAO=new ClsSalesUserLink();%>
<% String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		  data='<%=DAO.salesUserLinkGridLoading(rpttype,check)%>';  
	  	}
  	
        $(document).ready(function () {
         	
        	var source =
            {
                datatype: "json",
                datafields: [
								{ name: 'code', type: 'string' },
								{ name: 'name', type: 'string' },
								{ name: 'account', type: 'string' },
			                    { name: 'email', type: 'string' },
			                    { name: 'mobile', type: 'string' },
			                    { name: 'docno', type: 'int' },
			                    { name: 'user_name', type: 'string' },
			                    {name : 'salesmaninfo', type: 'string'  }
				            ],
			                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	$("#salesUserLinkGridID").on("bindingcomplete", function (event) {
        		if(document.getElementById("rdlinking").checked==true){
        			$('#salesUserLinkGridID').jqxGrid('hidecolumn', 'user_name');
        		} else if(document.getElementById("rddelete").checked==true){
        			$("#salesUserLinkGridID").jqxGrid('showcolumn', 'user_name');
       		 }
        	});
        	
        	var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#salesUserLinkGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
						{ text: 'Code', datafield: 'code', width: '13%' },
	                    { text: 'Salesman Name', datafield: 'name' },
	                    { text: 'Account', datafield: 'account', width: '15%' },
	                    { text: 'Email', datafield: 'email', width: '20%' },
	                    { text: 'Mobile', datafield: 'mobile', width: '15%' },
	                    { text: 'User Name', datafield: 'user_name', width: '20%' },
	                    { text: 'Doc No', hidden: true, datafield: 'docno', width: '10%' },
	                    { text: 'Salesman Info', datafield: 'salesmaninfo', hidden:true, width: '10%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#salesUserLinkGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#salesUserLinkGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                if(document.getElementById("rdlinking").checked==true){
                	document.getElementById("txtsalesmanid").value = $('#salesUserLinkGridID').jqxGrid('getcellvalue', rowindex1, "docno");
                	$('#btnlinking').attr("disabled",false);$('#btnremovelinking').attr("disabled",true);
                	var values= $('#salesUserLinkGridID').jqxGrid('getcellvalue',rowindex1, "salesmaninfo");
                    var values1 = values.toString().replace(/\*/g, '\n');
                    document.getElementById("txtsalesmaninfo").value=values1;
                    
                } else if(document.getElementById("rddelete").checked==true){
                	document.getElementById("txtsalesmanid").value = $('#salesUserLinkGridID').jqxGrid('getcellvalue', rowindex1, "docno");
                	$('#btnlinking').attr("disabled",true);$('#btnremovelinking').attr("disabled",false);
                	var values= $('#salesUserLinkGridID').jqxGrid('getcellvalue',rowindex1, "salesmaninfo");
                    var values1 = values.toString().replace(/\*/g, '\n');
                    document.getElementById("txtsalesmaninfo").value=values1;
                }
            });  

        });

</script>
<div id="salesUserLinkGridID"></div>
