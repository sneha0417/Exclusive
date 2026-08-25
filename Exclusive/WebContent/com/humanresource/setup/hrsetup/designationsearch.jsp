 <%@page import="com.humanresource.setup.hrsetup.designation.ClsDesignationDAO"%>
<% ClsDesignationDAO showDAO = new ClsDesignationDAO(); %>   

<script type="text/javascript">

	$(document).ready(function () {    
	    
		    var desigdata1='<%=showDAO.searchDesignation()%>';
	    
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'designation', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
	               localdata: desigdata1,
    
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#designationsearch").jqxGrid(
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
        					{ text: 'Designation',columntype: 'textbox', filtertype: 'input', datafield: 'designation', width: '38%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
           $('#designationsearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
            
                document.getElementById("docno").value= $('#designationsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("designation").value = $("#designationsearch").jqxGrid('getcellvalue', rowindex1, "designation");
                $("#desigdate").jqxDateTimeInput('val', $("#designationsearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#designationsearch").jqxGrid('getcellvalue', rowindex1, "remarks");

                $('#window').jqxWindow('close');
            });   
        });
	
</script>
<div id="designationsearch"></div>  
        
        