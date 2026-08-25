<%@page import="com.cargo.transportmasters.terms.ClsTermsAction" %>
<%ClsTermsAction cta=new ClsTermsAction(); %>
<script type="text/javascript">
  		
  		var srvcdata= '<%=cta.searchDetails() %>';
        
  		$(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
      						{name : 'date', type: 'date' }, 
      						{name: 'modeid',type: 'int'},
      						{name : 'modename', type: 'string'  },
      						{name : 'terms', type: 'string'   },
      					    {name : 'tcode', type: 'String'   }
      					
                         ],
               localdata: srvcdata,
        
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxTermsSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
                
                columns: [
                      	{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '15%' },
                        { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '15%' },
                        { text: 'Mode Id', datafield: 'modeid',hidden:true, editable: false, width: '25%' },
						{ text: 'Mode', datafield: 'modename', editable: false, width: '25%' },
						{ text: 'Name', datafield: 'terms', editable: false, width: '25%' },
						{ text: 'Code', datafield: 'tcode',width: '20%',editable: false },
						]
            });
            $('#jqxTermsSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxTermsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#termsdate").jqxDateTimeInput('val', $("#jqxTermsSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("hidcmbmode").value = $("#jqxTermsSearch").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("cmbmode").value = $("#jqxTermsSearch").jqxGrid('getcellvalue', rowindex1, "modename");
                document.getElementById("name").value = $("#jqxTermsSearch").jqxGrid('getcellvalue', rowindex1, "terms");
                document.getElementById("code").value = $("#jqxTermsSearch").jqxGrid('getcellvalue', rowindex1, "tcode");
                getMode();
               
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxTermsSearch"></div>
