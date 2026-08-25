<%@page import="com.humanresource.setup.hrsetup.hrsetupgeneral.ClsGeneralDAO"%>
<% ClsGeneralDAO showDAO = new ClsGeneralDAO(); %>    
<% String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");%>

<script type="text/javascript">

       var docnoss='<%=docnos%>';
    	   
    	   if(docnoss>0) {
    			var rdatas='<%=showDAO.searchresiorelode(docnos)%>';
    	   } else {
    		     var rdatas;
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
                		
                 localdata: rdatas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#resiggrid").jqxGrid(
            {
            	 width: '100%',
                 height: 107,
                 source: dataAdapter,
                 rowsheight:20,
                 editable: true,
                 disabled:true,
                 selectionmode: 'singlecell',
                       
                columns: [
                            
                              { text: 'Upto Years', datafield: 'years', width: '60%',align: 'left', cellsalign: 'left' } ,
                              { text: 'Days/Year', datafield: 'days', width: '40%'/* ,
                            		cellbeginedit: function (row) {
    									var temp=$('#mode').val();
    									 if (temp =="view")
    										 {
    									       return false;
    										 }
    								    
    								  } */},
    						{ text: 'Hide Date', datafield: 'hidyears', width: '11%',editable:false, cellsalign: 'left',align: 'left',hidden:true},
						]
            });
            
            if ($("#mode").val() == "A" ||$("#mode").val() == "E" ) {
         	     $("#resiggrid").jqxGrid({ disabled: false});
         	    }
            
            if($("#mode").val() == "view") {
            	
            if(docnoss>0) {
            	
 		   } else {
              	$("#resiggrid").jqxGrid('addrow', null, {});
              	$("#resiggrid").jqxGrid('addrow', null, {});
              	$("#resiggrid").jqxGrid('addrow', null, {});
              	$("#resiggrid").jqxGrid('addrow', null, {});  
            	}
            }
            
            
            $("#resiggrid").on('cellvaluechanged', function (event) {
            	 var rowindex1 = event.args.rowindex;
		
		 		 var rows = $('#resiggrid').jqxGrid('getrows');
                 var rowlength= rows.length;
                 if (rowindex1 == rowlength - 1) {
                   $("#resiggrid").jqxGrid('addrow', null, {});	
        	     }	

                 var datafield = event.args.datafield;
         		 if(datafield=="years") {
		          var text = $('#resiggrid').jqxGrid('getcelltext', rowindex1, "years");
		        	  $('#resiggrid').jqxGrid('setcellvalue',rowindex1, "hidyears",text);
		       }
		    });
          
});
		
</script>

<div id="resiggrid"></div>