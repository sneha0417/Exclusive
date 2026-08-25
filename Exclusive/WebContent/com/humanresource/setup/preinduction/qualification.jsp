 
<%@page import="com.humanresource.setup.designationsetup.ClsdesignationsetupDAO"%>
<% ClsdesignationsetupDAO showDAO = new ClsdesignationsetupDAO(); %>
   
<script type="text/javascript">
	$(document).ready(function () {    
	   
 
		    var docdata='<%=showDAO.search2()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'qualification', type: 'String'  },
                          
                          	 
                 ],
               localdata: docdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#qualificationgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        height: 350,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%',hidden:true },
		        				 
		        					{ text: 'Qualification',columntype: 'textbox', filtertype: 'input', datafield: 'qualification'   }
        	              ]
                    });
            
          $('#qualificationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
  
                
            	 var rowno =  document.getElementById("rowindex").value;
             	 
                 
       		  
      		   
      		   $('#qualgrid').jqxGrid('setcellvalue', rowno, "qualdoc" ,$('#qualificationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
                 $('#qualgrid').jqxGrid('setcellvalue', rowno, "qual" ,$('#qualificationgrid').jqxGrid('getcellvalue', rowindex1, "qualification"));
         	
         	        
                 $('#abcwn').jqxWindow('close');
                
                 $("#qualgrid").jqxGrid('addrow', null, {});
     
            });  
        });
 
	  
</script>   
 
 <div id="qualificationgrid"></div> 