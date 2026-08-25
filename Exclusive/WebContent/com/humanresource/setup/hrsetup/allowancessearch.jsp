<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>    
<script type="text/javascript">

	$(document).ready(function () {    
	 
		  var alcdata1='<%=showDAO.searchAllowance()%>';
           
          var source =
          {
              datatype: "json",
              datafields: [
                        	{name : 'doc_no' , type: 'number' },
                        	{name : 'code', type: 'String'  },
   							{name : 'allowance', type: 'String'  },
                        	{name : 'date', type: 'date'  },
                        	{name : 'remarks', type: 'String'  },
	                       	{name : 'acno', type: 'String'  },
	                       	{name : 'accname', type: 'String'  },
	                       	{name : 'accdocno', type: 'String'  },
		               	 ],
             			localdata: alcdata1,
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source);
  
          $("#allowanceSearchgrid").jqxGrid(
                  {
                  	  width: "100%",
                      height: 330,
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'singlerow',
                      
                      columns: [
		      					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '12%' },
		      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '14%',cellsformat:'dd.MM.yyyy' },
		      					{ text: 'Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '14%' },
		      					{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '30%' },
		      					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' },
		      					{ text: 'acno',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%', hidden: true },
		      					{ text: 'accname',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '20%' ,hidden: true},
		      					{ text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
		      	              ]
                  });
          
       $('#allowanceSearchgrid').on('rowdoubleclick', function (event) {
              var rowindex1=event.args.rowindex;
          
              document.getElementById("docno").value= $('#allowanceSearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
              document.getElementById("allowancecode").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "code");
              document.getElementById("allowance").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "allowance");
              $("#allowancedate").jqxDateTimeInput('val', $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
              document.getElementById("remarks").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              document.getElementById("acno").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "acno");
              document.getElementById("accname").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "accname");
              document.getElementById("accdocno").value = $("#allowanceSearchgrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
              
              $('#window').jqxWindow('close'); 
          });   
      });
	
</script>
<div id="allowanceSearchgrid"></div>  
        
        