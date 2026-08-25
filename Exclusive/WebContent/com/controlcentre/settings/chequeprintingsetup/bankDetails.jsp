<%@page import="com.controlcentre.settings.chequeprintingsetup.ClsChequeSetUpDAO" %>
<%ClsChequeSetUpDAO csu=new ClsChequeSetUpDAO(); %>

<script type="text/javascript">
        
   var data2= '<%= csu.bankDetails(session)%>'; 
   $(document).ready(function () { 
               
      // prepare the data
      var source =
      {
          datatype: "json",
          datafields: [
                        {name : 'doc_no', type: 'int'   },
						{name : 'account', type: 'string'   },
						{name : 'description', type: 'string'   },
						{name : 'currency', type: 'string'  },
 						{name : 'curid', type: 'int'  },
 						{name : 'rate', type: 'string'  }
                  ],
          		localdata: data2, 
          
          pager: function (pagenum, pagesize, oldpagenum) {
              // callback called when a page or page size is changed.
          }
                                  
      };
      
      var dataAdapter = new $.jqx.dataAdapter(source);
      
      $("#jqxBankSearch").jqxGrid(
      {
          width: '100%',
          height: 375,
          source: dataAdapter,
          showfilterrow: true, 
          filterable: true, 
          selectionmode: 'singlerow',
                 
          columns: [
						{ text: 'Bank Id', datafield: 'account', width: '40%' },
						{ text: 'Bank Name', datafield: 'description', width: '60%' },
						{ text: 'Bank Id', datafield: 'doc_no', hidden:true, width: '10%' },
					]
      });
      
       $('#jqxBankSearch').on('rowdoubleclick', function (event) {
          var rowindex1 = event.args.rowindex;
          document.getElementById("txtbankdocno").value = $('#jqxBankSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
          document.getElementById("txtbankid").value = $('#jqxBankSearch').jqxGrid('getcellvalue', rowindex1, "account");
          document.getElementById("txtbankname").value = $('#jqxBankSearch').jqxGrid('getcellvalue', rowindex1, "description");
      	  
    	  $('#bankDetailsWindow').jqxWindow('close');  
      });  
  });
</script>
<div id="jqxBankSearch"></div>
