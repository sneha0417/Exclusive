 <%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO(); %>
<script type="text/javascript">
	$(document).ready(function () {    
  
 		var datab = '<%=DAO.Load(session)%>';
 
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
     						{name : 'plno', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                        	{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'city_name', type: 'String'  },
     						{name : 'country_name', type: 'String'  },
     						{name : 'region_name', type: 'String'  }
                 ],
               localdata: datab,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxb1").jqxGrid(
                    {
                    	width: '100%',
                       height: 350,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Docno', datafield: 'doc_no', width: '8%',hidden:true },
        				/* 	{ text: 'Date' , datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' }, */
        					{ text: 'Name' , datafield: 'name' },
        					/* { text: 'Plot Number' , datafield: 'plno', width: '25%' },
        					{ text: 'AREA', datafield: 'area', width: '20%' },
        					{ text: 'State', datafield: 'city_name', width: '25%',hidden:true  },
        					{ text: 'Country', datafield: 'country_name', width: '25%' ,hidden:true },
        					{ text: 'Region', datafield: 'region_name', width: '20%',hidden:true } */
        					
        	              ]
                    });
            $('#jqxb1').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
             
             
                document.getElementById("unitof").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("hidunitofid").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#usearchwindow').jqxWindow('close');
    
                
            }); 
            
	});
 
	  
</script>  
  
	
 
          <div id="jqxb1"> </div>  
 
 