  
<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO();%>  
<script type="text/javascript">
 
$(document).ready(function () { 	 
	var data1= '<%=DAO.searchsalesman() %>'; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'doc_no' , type: 'number' },
						{name : 'sal_name', type: 'String'  },						 
						{name : 'mob_no', type: 'String'  },	
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
  
    $("#jqxsalesman").jqxGrid(
            {
            	width: '100%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',         
                columns: [
						{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },					 
						{ text: 'Sales Man' , datafield: 'sal_name',width: '50%'},
						{ text: 'Mobile' , datafield: 'mob_no',width: '50%'},				 
	              ]
            });
    $('#jqxsalesman').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                
                $("#txtsalesman").val($("#jqxsalesman").jqxGrid('getcellvalue', rowindex1, "sal_name"));
                $("#txtcontactnumber").val( $("#jqxsalesman").jqxGrid('getcellvalue', rowindex1, "mob_no"));  
                $("#hidcmbcontactperson").val($("#jqxsalesman").jqxGrid('getcellvalue', rowindex1, "doc_no"));
             
            	$('#salesmansearchwindow').jqxWindow('close');
                
             
    		 });
    
	 
});

    </script>
         <div  id="jqxsalesman"></div>