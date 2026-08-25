<%@page import="com.dashboard.audit.ClsAudit" %>
<% ClsAudit ca=new ClsAudit();%>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();%>
<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=ca.clientAuditGridLoading(branchval)%>';  
	  	}
	  	
  	
        $(document).ready(function () {
        	
         	
        	var source =
            {
                datatype: "json",
                datafields: [
					{ name: 'date', type: 'date' },
					{ name: 'category', type: 'string' },
					{ name: 'cldocno', type: 'int' },
                    { name: 'name', type: 'string' },
                    { name: 'mobile', type: 'string' },
                    { name: 'salesman', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'email', type: 'string' },
                    { name: 'branchid', type: 'int' }
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
            $("#audit").jqxGrid(
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
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '10%' },
						{ text: 'Category', datafield: 'category', width: '10%' },
						{ text: 'Cldocno', datafield: 'cldocno', hidden: true, width: '10%' },
	                    { text: 'Name', datafield: 'name', width: '20%' },
	                    { text: 'Mobile', datafield: 'mobile', width: '10%' },
	                    { text: 'Salesman', datafield: 'salesman', width: '10%' },
	                    { text: 'Address', datafield: 'address', width: '25%' },
	                    { text: 'Email Id', datafield: 'email', width: '15%' },
	                    { text: 'Branch Id', hidden: true, datafield: 'branchid', width: '15%' }
					 ]
            });
            
            if(temp=='NA'){
                $("#audit").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#audit').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcldocno").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtclientname").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("txtbranchid").value = $('#audit').jqxGrid('getcellvalue', rowindex1, "branchid");
            });  

        });

</script>
<div id="audit"></div>
