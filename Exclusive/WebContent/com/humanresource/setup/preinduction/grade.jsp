 

<%@page import="com.humanresource.setup.designationsetup.ClsdesignationsetupDAO"%>
<% ClsdesignationsetupDAO showDAO = new ClsdesignationsetupDAO(); %>

<script type="text/javascript">

	$(document).ready(function () {    
 
		var graddata='<%=showDAO.search1()%>';
		 
		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'grade', type: 'String'  },
                           
                 ],
               localdata: graddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#grdgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        height: 325,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' ,hidden:true},
		        					 
		        					{ text: 'Grade',columntype: 'textbox', filtertype: 'input', datafield: 'grade'   }
                    ]		
        	              
                    });
            
           $('#grdgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
     
                document.getElementById("gradeid").value= $('#grdgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("grade").value = $("#grdgrid").jqxGrid('getcellvalue', rowindex1, "grade");
                
                $('#swin').jqxWindow('close');
            });   
        });

 
	  
</script>  
 
 <div id="grdgrid"></div> 