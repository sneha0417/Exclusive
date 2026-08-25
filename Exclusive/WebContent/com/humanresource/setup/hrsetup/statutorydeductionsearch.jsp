<%@page import="com.humanresource.setup.hrsetup.statutorydeductions.ClsStatutorydeductionsDAO"%>
<% ClsStatutorydeductionsDAO showDAO = new ClsStatutorydeductionsDAO(); %>     
<script type="text/javascript">

	$(document).ready(function () {    
	 
		   var statu1='<%=showDAO.searchstatu()%>';
           
	       var source =
	         {
	             datatype: "json",
	             datafields: [
	                        	{ name : 'doc_no' , type: 'number' },
	   							{ name : 'satudeduction', type: 'String'  },
	                        	{ name : 'date', type: 'date'  },
	                        	{ name : 'remarks', type: 'String'  },
		                       	{ name : 'acno', type: 'String'  },
	    	                   	{ name : 'accname', type: 'String'  },
	        	               	{ name : 'accdocno', type: 'String'  },
		                      	{ name : 'chktype', type: 'String'  },
	               			 ],
	             			localdata: statu1,
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
	       
	      var dataAdapter = new $.jqx.dataAdapter(source);
  
          $("#statugrid").jqxGrid(
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
      							{ text: 'Statutory Deductions',columntype: 'textbox', filtertype: 'input', datafield: 'satudeduction', width: '38%' },
		      					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
		      					{ text: 'acno',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%',hidden: true },
      							{ text: 'accname',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '20%' ,hidden: true},
		      					{ text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
		      					{ text: 'chktype',columntype: 'textbox', filtertype: 'input', datafield: 'chktype', width: '10%' ,hidden: true},
      	              		  ]
                  });
          
       	  $('#statugrid').on('rowdoubleclick', function (event) {
              var rowindex1=event.args.rowindex;
              
              document.getElementById("docno").value= $('#statugrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
              document.getElementById("satudeduction").value = $("#statugrid").jqxGrid('getcellvalue', rowindex1, "satudeduction");
              $("#statudate").jqxDateTimeInput('val', $("#statugrid").jqxGrid('getcellvalue', rowindex1, "date"));
              document.getElementById("remarks").value = $("#statugrid").jqxGrid('getcellvalue', rowindex1, "remarks");
              document.getElementById("acno").value = $("#statugrid").jqxGrid('getcellvalue', rowindex1, "acno");
              document.getElementById("accname").value = $("#statugrid").jqxGrid('getcellvalue', rowindex1, "accname");
              document.getElementById("accdocno").value = $("#statugrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
          	  $('#frmstatudeduction select').attr('disabled', false);
              document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
              
              if ($("#mode").val() == "view") {
		          	$('#frmstatudeduction select').attr('disabled', true);
              }
              
              $('#window').jqxWindow('close'); 
          });   
      });
	
</script>
<div id="statugrid"></div>  
        
        