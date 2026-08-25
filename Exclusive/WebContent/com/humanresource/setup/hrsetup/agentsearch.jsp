<%@page import="com.humanresource.setup.hrsetup.agent.ClsAgentDAO"%>
<% ClsAgentDAO showDAO = new ClsAgentDAO(); %>      
<script type="text/javascript">

	$(document).ready(function () {    
	 
	    var agentdata1='<%=showDAO.searchAgent()%>';
	    
	       var source =
    	   {
           datatype: "json",
           datafields: [
                     	{name : 'doc_no' , type: 'number' },
						{name : 'agent', type: 'String'  },
                     	{name : 'date', type: 'date'  },
                     	{name : 'remarks', type: 'String'  }
            ],
          localdata: agentdata1,

           pager: function (pagenum, pagesize, oldpagenum) {
               // callback called when a page or page size is changed.
           }
       };
	       
	   var dataAdapter = new $.jqx.dataAdapter(source);

       $("#agentgridsearch").jqxGrid(
               {
               	   width: "100%",
                   height: 330,
                   source: dataAdapter,
                   showfilterrow: true,
                   filterable: true,
                   selectionmode: 'singlerow',
                   
                   columns: [
			   					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
			   					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
			   					{ text: 'Agent',columntype: 'textbox', filtertype: 'input', datafield: 'agent', width: '38%' },
			   					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
   	              			]
               });
       
      $('#agentgridsearch').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex;
           
           document.getElementById("docno").value= $('#agentgridsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("agent").value = $("#agentgridsearch").jqxGrid('getcellvalue', rowindex1, "agent");
           $("#agentdate").jqxDateTimeInput('val', $("#agentgridsearch").jqxGrid('getcellvalue', rowindex1, "date"));
           
           
           document.getElementById("remarks").value = $("#agentgridsearch").jqxGrid('getcellvalue', rowindex1, "remarks");
           $('#window').jqxWindow('close');
         });   
     });
	
</script>
<div id="agentgridsearch"></div>  
        