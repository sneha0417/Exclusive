<%@page import="com.humanresource.setup.hrsetup.leave.ClsLeaveDAO"%>
<% ClsLeaveDAO showDAO = new ClsLeaveDAO(); %>
     
<script type="text/javascript">

	$(document).ready(function () {    
	 
	    var docdata1='<%=showDAO.searchLeave()%>';
 
	       var source =
    	   {
        	   datatype: "json",
           	   datafields: [
                     	{name : 'doc_no' , type: 'number' },
						{name : 'leave1', type: 'String'  },
                     	{name : 'date', type: 'date'  },
                     	{name : 'remarks', type: 'String'  },
                     	{name : 'abbreviation', type: 'String'  },
            			],
			          localdata: docdata1,
           
           pager: function (pagenum, pagesize, oldpagenum) {
               // callback called when a page or page size is changed.
           }
       };
	       
	   var dataAdapter = new $.jqx.dataAdapter(source);

       $("#leavegridsearch").jqxGrid(
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
	   							{ text: 'Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leave1', width: '38%' },
	   							{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
			   					{ text: 'Abbreviation', datafield: 'abbreviation', width: '40%' ,hidden:true}
			   	            ]
               });
       
  		$('#leavegridsearch').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex;
       
           document.getElementById("docno").value= $('#leavegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("abbreviation").value=$("#leavegrid").jqxGrid('getcellvalue', rowindex1, "abbreviation"); 
           document.getElementById("leave").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "leave1");
           $("#leavedate").jqxDateTimeInput('val', $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "date"));
           document.getElementById("remarks").value = $("#leavegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            
           $('#window').jqxWindow('close');
       });
  		
});

</script>
<div id="leavegridsearch"></div>  
        
        