
<%@page import="com.finance.nipurchase.vendormaster.ClsVendorDetailsDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%  ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<%  ClsVendorDetailsDAO cd=new ClsVendorDetailsDAO(); %>
<script type="text/javascript">

	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	if(temp>0){
         	    driverdata='<%=cd.vendorGrid(docno)%>';
         	}
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
                        
   						
   						{name : 'servicetype', type: 'string' },
   						{name : 'servid',type:'String'},
   						{name : 'availability', type: 'string' },
   						{name : 'paymenttype', type: 'string' },
   						],
               localdata: driverdata,
                                      
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          $("#jqxService").jqxGrid(
          {
              
              						
				
                        width: '100%',
                        height: 250,
                        source: dataAdapter,
                        selectionmode: 'singlecell',
             			editable: true,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
                           { text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                             groupable: false, draggable: false, resizable: false,datafield: '',
                             columntype: 'number', width: '12%',cellsalign: 'center', align: 'center',
                             cellsrenderer: function (row, column, value) {
  	                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                             }  
	                         },
        					
        					 { text: 'Service Type', datafield: 'servicetype', width: '38%' },
        					 { text: 'Availability',  datafield: 'availability',columntype:'dropdownlist',
			
			createeditor: function (row, column, editor) {
				
				 billmodelist = ["YES","NO"];
				
				editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
			
			},
	},
			{ text: 'Payment Type',  datafield: 'paymenttype',columntype:'dropdownlist',
			
			createeditor: function (row, column, editor) {
				
				 billmodelist = ["CASH","CREDIT"];
				
				editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
			
			},
	 	 initeditor: function (row, cellvalue, editor) {
              
			var terms = $('#jqxService').jqxGrid('getcellvalue', row, "type");
			
				editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
			
            }, 

       },
        					 {text:'Service Id',datafield:'servid',width:'5%',hidden: true}
 							
        					]
                    });
          //Add empty row          
          if(temp==0) {   
         	   $("#jqxService").jqxGrid('addrow', null, {});
          	 }   
          
            
             if(temp>0){
             	$("#jqxService").jqxGrid('disabled', true);
             	$("#jqxService").jqxGrid('addrow', null, {});
             }
          
             $("#jqxService").on('celldoubleclick', function (event) 
                     {
             			var datafield = event.args.datafield;
         			    var rowBoundIndex = event.args.rowindex;
         			 
				
         			   
         			    if(datafield=='servicetype'||datafield=='insurancetype'){
         			    	 $('#gridrowindex').val(rowBoundIndex);
              			    $('#srvtypserchwindow').jqxWindow('open');
              				srvTypSerchContent('srvTypeSearch.jsp?gridrowindex='+$('#gridrowindex').val()+'&docno='+$('#docno').val());
         			    } 
         			   
         			    
                     });
             if(($('#mode').val()=='A')||($('#mode').val()=='E'))
     		{
     		  $("#jqxService").jqxGrid({ disabled: false}); 
     		}
             
     	
    	
   
});
      
</script>
<div id="jqxService"></div>
<input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid">