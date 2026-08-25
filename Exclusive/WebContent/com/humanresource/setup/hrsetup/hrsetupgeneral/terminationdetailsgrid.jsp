 <%@page import="com.humanresource.setup.hrsetup.hrsetupgeneral.ClsGeneralDAO"%>
<% ClsGeneralDAO showDAO = new ClsGeneralDAO(); %>    
<% String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");%>

<script type="text/javascript">

       var docnoss='<%=docnos%>';
   	   
   	   if(docnoss>0) {
    		var termi='<%=showDAO.searchtermorelode(docnos)%>';
   	   } else {
   			var termi;
   	   }
		 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                           
                            {name : 'years', type: 'string'  },
                            {name : 'days', type: 'number'  },
                            {name : 'hidyears', type: 'string'  },
     						
                        ],
                		
                 localdata: termi,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#trmigrid").jqxGrid(
            {
                width: '100%',
                height: 107,
                source: dataAdapter,
                rowsheight:20,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
                       
                columns: [  
                              { text: 'Upto Years', datafield: 'years', width: '60%', align: 'left', cellsalign: 'left' } ,
                              { text: 'Days/Year', datafield: 'days', width: '40%' },
    						{ text: 'Hide Date', datafield: 'hidyears', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
	             
						]
            });
            
           if($("#mode").val() == "view") {
           
           if(docnoss>0) {
            	
 		   } else {
	            $("#trmigrid").jqxGrid('addrow', null, {});
	            $("#trmigrid").jqxGrid('addrow', null, {});
	            $("#trmigrid").jqxGrid('addrow', null, {});
	            $("#trmigrid").jqxGrid('addrow', null, {});
            } 
            
		}
            
           if ($("#mode").val() == "A" ||$("#mode").val() == "E" ) {
                $("#trmigrid").jqxGrid({ disabled: false});
           }
            
            $("#trmigrid").on('cellvaluechanged', function (event) {
            	 var rowindex1 = event.args.rowindex;
		
		 		 var rows = $('#trmigrid').jqxGrid('getrows');
         		 var rowlength= rows.length;
                 
         		 if (rowindex1 == rowlength - 1) {
                     $("#trmigrid").jqxGrid('addrow', null, {});	
                 }	
         
          
         		var datafield = event.args.datafield;
         		if(datafield=="years") {
		          var text = $('#trmigrid').jqxGrid('getcelltext', rowindex1, "years");
	        	  $('#trmigrid').jqxGrid('setcellvalue',rowindex1, "hidyears",text);
		       }
		    });
          
});
		
</script>

<div id="trmigrid"></div>