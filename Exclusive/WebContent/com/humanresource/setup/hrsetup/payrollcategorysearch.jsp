<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO(); %> 
  
<script type="text/javascript">

	$(document).ready(function () {    
	 
	   var catdata1='<%=showDAO.searchcategory()%>';
       
       var source =
       {
           datatype: "json",
           datafields: [
                     	{name : 'doc_no' , type: 'number' },
						{name : 'category', type: 'String'  },
                     	{name : 'date', type: 'date'  },
                     	{name : 'remarks', type: 'String'  },
                     	{name : 'timesheet', type: 'Int'  }
            ],
          	localdata: catdata1,
           
           pager: function (pagenum, pagesize, oldpagenum) {
               // callback called when a page or page size is changed.
           }
       };
       
       var dataAdapter = new $.jqx.dataAdapter(source);

       $("#categorygridsearch").jqxGrid(
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
   								{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
   								{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
   								{ text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%' ,hidden: true},
   	              ]
               });

       $('#categorygridsearch').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex;

           document.getElementById("docno").value= $('#categorygridsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("category").value = $("#categorygridsearch").jqxGrid('getcellvalue', rowindex1, "category");
           $("#parrolldate").jqxDateTimeInput('val', $("#categorygridsearch").jqxGrid('getcellvalue', rowindex1, "date"));
           document.getElementById("remarks").value = $("#categorygridsearch").jqxGrid('getcellvalue', rowindex1, "remarks");
          
           $('#timesheet').attr('disabled', false);
           var timesheet=$("#categorygridsearch").jqxGrid('getcellvalue', rowindex1, "timesheet");
           if(parseInt(timesheet)==1) {
           	 	document.getElementById("timesheet").checked = true;
      		    document.getElementById("timesheet").value=1;
           } else {
          	    document.getElementById("timesheet").checked = false;
      		    document.getElementById("timesheet").value=0;
           }
           
           if ($("#mode").val() == "view") {
           		$('#timesheet').attr('disabled', true);
           }
           
           $('#window').jqxWindow('close');
          
       });  
});

</script>
<div id="categorygridsearch"></div>
  
        
        