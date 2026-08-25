 <%@page import="com.humanresource.setup.hrsetup.hrsetupgeneral.ClsGeneralDAO"%>
<% ClsGeneralDAO showDAO = new ClsGeneralDAO(); %>    
<% String docnos = request.getParameter("docno")==null?"0":request.getParameter("docno");
   String modeval = request.getParameter("modeval")==null?"0":request.getParameter("modeval");%>

<script type="text/javascript">

       var docnoss='<%=docnos%>';
       var modess='<%=modeval%>';
    	   
       if(docnoss>0 && modess=="E") {
    	   var alldata='<%=showDAO.searchbenirelodeEdit(docnos)%>';   
       } else if(docnoss>0) {
    		var alldata='<%=showDAO.searchbenirelode(docnos)%>';
       } else {
    		 var alldata='<%=showDAO.searchAllowance()%>';
       }
			 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'string'  },
                            {name : 'allowance', type: 'string'  },
                            {name : 'allowanceid', type: 'number'  },
                            {name : 'ckecked', type: 'number'  },
                        ],
		                 localdata: alldata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            
            $("#benifitsgrid").on("bindingcomplete", function (event) {
            	
          	  var rows = $("#benifitsgrid").jqxGrid('getrows');   
          	  
          	  for(var i=0;i<rows.length;i++){
          		  var val= $('#benifitsgrid').jqxGrid('getcellvalue',i, "ckecked");
          		  if(parseInt(val)==1){
          			   $('#benifitsgrid').jqxGrid('selectrow',i);   
          		  }
          	  }
            }); 
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#benifitsgrid").jqxGrid(
            {
                width: '100%',
                height: 270,
                source: dataAdapter,
                selectionmode: 'checkbox',
                editable: false,
                       
                columns: [
                          { text: 'SL No', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '15%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Allowance', datafield: 'allowance', width: '76%' ,
                            		cellbeginedit: function (row) {
    									 var temp=$('#mode').val();
    									 if (temp =="view") {
    									       return false;
    								     }
    								  }
                            },
    	                    { text: 'allowanceid', datafield: 'allowanceid', width: '5%' , hidden: true },
						]
            });
            
            if ($("#mode").val() == "A" ||$("#mode").val() == "E" ) {
         	     $("#benifitsgrid").jqxGrid({ disabled: false});
         	} else {
           	 $("#benifitsgrid").jqxGrid({ disabled: true});
           	}
            
            $("#benifitsgrid").on('cellvaluechanged', function (event) {
            	 var rowindex1 = event.args.rowindex;
		 		 var rows = $('#benifitsgrid').jqxGrid('getrows');
                 var rowlength= rows.length;
                 if (rowindex1 == rowlength - 1) {
             		$("#benifitsgrid").jqxGrid('addrow', null, {});	
                 }	
		     });
        });
		
</script>
<div id="benifitsgrid"></div>