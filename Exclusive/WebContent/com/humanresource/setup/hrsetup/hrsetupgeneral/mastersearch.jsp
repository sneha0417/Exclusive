 <%@page import="com.humanresource.setup.hrsetup.hrsetupgeneral.ClsGeneralDAO"%>
<% ClsGeneralDAO showDAO = new ClsGeneralDAO(); %>    
 
<script type="text/javascript">

	$(document).ready(function () {    
	 
	    var agentdata1='<%=showDAO.mastersearch()%>';
	    
		 
        var num = 0; 
       var source =
       {
           datatype: "json",
           datafields: [
                     	{name : 'doc_no' , type: 'number' },
					
                     	{name : 'date', type: 'date'  },
                    	{name : 'valfrmdate', type: 'date'  },
                    	{name : 'revdate', type: 'date'  },
                     	
                     	{name : 'cat', type: 'String'  },
                       	{name : 'leavdesc', type: 'String'  },
                     	
                      
                     	
            ],
          localdata: agentdata1,
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
 
       $("#mastersearchgrid").jqxGrid(
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
   					
   					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '11%',cellsformat:'dd.MM.yyyy' },
   					{ text: 'Valid From',columntype: 'textbox', filtertype: 'input', datafield: 'valfrmdate', width: '12%',cellsformat:'dd.MM.yyyy' },
   					
   					{ text: 'Last Revised On',columntype: 'textbox', filtertype: 'input', datafield: 'revdate', width: '13%',cellsformat:'dd.MM.yyyy' },
   					
   					
   					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'cat', width: '29%'  },
   					{ text: 'Annual Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leavdesc', width: '25%'  },
   					
   	              ]
               });
      $('#mastersearchgrid').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex;
           funReset();
           document.getElementById("docno").value= $('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("frmhrsetups").submit();
             $('#window').jqxWindow('close');
         });   
     });
	</script>
	 <div id="mastersearchgrid"></div>  
        
        