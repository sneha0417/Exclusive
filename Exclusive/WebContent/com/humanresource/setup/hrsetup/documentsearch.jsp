 <%@page import="com.humanresource.setup.hrsetup.document.ClsDocumentDAO"%>
<%
	ClsDocumentDAO showDAO = new ClsDocumentDAO();
%>    
<script type="text/javascript">

	$(document).ready(function () {    
	 
	    var docdata1='<%=showDAO.searchDocument()%>';
        var num = 0; 
       var source =
       {
           datatype: "json",
           datafields: [
                     	{name : 'doc_no' , type: 'number' },
						{name : 'document', type: 'String'  },
                     	{name : 'date', type: 'date'  },
                     	
                     	{name : 'remarks', type: 'String'  }
            ],
          localdata: docdata1,
           //url: "/searchDetails",
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

       $("#documentsearch").jqxGrid(
               {
               	width: "100%",
                height: 330,
                   source: dataAdapter,
                   showfilterrow: true,
                   filterable: true,
                   selectionmode: 'singlerow',
                   //Add row method
                   columns: [
   					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
   					
   					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
   					{ text: 'Document',columntype: 'textbox', filtertype: 'input', datafield: 'document', width: '38%' },
   					
   					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
   	              ]
               });
  $('#documentsearch').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex;
           document.getElementById("docno").value= $('#documentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("document").value = $("#documentsearch").jqxGrid('getcellvalue', rowindex1, "document");
           $("#documentdate").jqxDateTimeInput('val', $("#documentsearch").jqxGrid('getcellvalue', rowindex1, "date"));
           
           
           document.getElementById("remarks").value = $("#documentsearch").jqxGrid('getcellvalue', rowindex1, "remarks");
     
            
           $('#window').jqxWindow('close');
       });  
   });
	</script>
	 <div id="documentsearch"></div>  
        
        