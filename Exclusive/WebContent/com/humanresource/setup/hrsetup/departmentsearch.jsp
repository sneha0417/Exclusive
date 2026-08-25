<%@page import="com.humanresource.setup.hrsetup.department.ClsDepartmentDAO"%>
<% ClsDepartmentDAO showDAO = new ClsDepartmentDAO(); %>    

<script type="text/javascript">

	$(document).ready(function () {    
	 
		 var deptdata1='<%=showDAO.searchDepartment()%>';

		 var source =
         {
             datatype: "json",
             datafields: [
                       	{name : 'doc_no' , type: 'number' },
  						{name : 'department', type: 'String'  },
                       	{name : 'date', type: 'date'  },
                       	{name : 'remarks', type: 'String'  }
              ],
              localdata: deptdata1,
             
             pager: function (pagenum, pagesize, oldpagenum) {
                 // callback called when a page or page size is changed.
             }
         };
		 
		 var dataAdapter = new $.jqx.dataAdapter(source);
 
         $("#departmentsearch").jqxGrid(
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
		     					{ text: 'Department',columntype: 'textbox', filtertype: 'input', datafield: 'department', width: '38%' },
		     					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
     	              		  ]
                 });
         
          $('#departmentsearch').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
         
             document.getElementById("docno").value= $('#departmentsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
             document.getElementById("department").value = $("#departmentsearch").jqxGrid('getcellvalue', rowindex1, "department");
             $("#deptdate").jqxDateTimeInput('val', $("#departmentsearch").jqxGrid('getcellvalue', rowindex1, "date"));
             document.getElementById("remarks").value = $("#departmentsearch").jqxGrid('getcellvalue', rowindex1, "remarks");

             $('#window').jqxWindow('close');
         });   
     });
	
</script>
<div id="departmentsearch"></div>  
        
        