  
 
 
 <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" 
 
 
  %>
  
  <%ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO(); %>
 
<script type="text/javascript">

	$(document).ready(function () {    
 
		var graddata1111111111111='<%=ClspreinductionDAO.search1()%>';
	 
		var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'designation1' , type: 'number' },
     						{name : 'designation2', type: 'String'  },
                           
                 ],
               localdata: graddata1111111111111,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
		
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#reportgrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        height: 325,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'designation1', width: '10%'  ,hidden:true},
		        					 
		        					{ text: 'Designation',columntype: 'textbox', filtertype: 'input', datafield: 'designation2'   }
                    ]		
        	              
                    });
            
           $('#reportgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                if(parseInt(document.getElementById("designationid").value)>0)
                	{
                	if(parseInt($("#reportgrid").jqxGrid('getcellvalue', rowindex1, "designation1"))==parseInt(document.getElementById("designationid").value))
                		{
                		 document.getElementById("errormsg").innerText="Designation is Matching";
                		 return 0;
                		}
                	else
                		{
                		 
                		 document.getElementById("errormsg").innerText="";
                		}
                	}
                
                
                document.getElementById("reportid").value= $('#reportgrid').jqxGrid('getcellvalue', rowindex1, "designation1"); 
                document.getElementById("report").value= $("#reportgrid").jqxGrid('getcellvalue', rowindex1, "designation2");
                
                $('#swin').jqxWindow('close');
            });   
        });

 
	  
</script>  
 
 <div id="reportgrid"></div> 