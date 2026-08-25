<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO();
String docno=request.getParameter("docno");
%>  
<script type="text/javascript"> 

$(document).ready(function () { 	
     
	var data= '<%=DAO.searchunitm(docno) %>'; 
       var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'doc_no' , type: 'number' },
						{name : 'unittype', type: 'String'  },
						{name : 'prtypeid', type:  'String'},
						{name : 'prtype', type:  'String'},
						{name : 'date', type:  'date'},						
                  	
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
  
    $("#jqxUnitSearch1").jqxGrid(
            {
            	width: '100%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
         
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
					{ text: 'Property type' , datafield: 'prtype',width: '50%'},
					{ text: 'Unit Type'  ,datafield: 'unittype', width: '50%' },				 
	              ]
            });
    $('#jqxUnitSearch1').on('rowdoubleclick', function (event)        
    		{ 
            	var rowindex1=event.args.rowindex;        
                $("#unittype").val($("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unittype"));
                $("#hidunittypeid").val($("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "doc_no"));   
            	$('#unittypesearchwindow').jqxWindow('close');
    		 });   
	 
});

    </script>
         <div  id="jqxUnitSearch1"></div>