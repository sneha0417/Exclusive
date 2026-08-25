<%@page import="com.controlcentre.masters.vehiclemaster.platecode.ClsPlateCodeDAO" %>
<%ClsPlateCodeDAO pd=new ClsPlateCodeDAO(); %>
<% 
 String itemno =request.getParameter("itemno")==null?"NA":request.getParameter("itemno").toString();
 %>

<script type="text/javascript">
	
	 var naliasdata;
	var bb='<%=itemno%>';
	if(bb!='NA'){
		naliasdata= '<%=pd.naliasdetails(itemno)%>';
	}
	else{
		naliasdata;
	}

$(document).ready(function () {
	

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'code', type: 'string'  },
                 	{name : 'doc_no', type: 'string'  }
                 	
						],
				    localdata: naliasdata,
        
        
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
    
    
    $("#jqxnalias").jqxGrid(
    {
        width: '60%',
        height: 80,
        source: dataAdapter,
        rowsheight:20,
    	 disabled:true,
    	// pageable: false,
    	  editable:true,
    	  
        selectionmode: 'singlecell',
        pagermode: 'default',
      
        
        
       /*  handlekeyboardnavigation: function (event) {
        	
        	
            var rows = $('#jqxnalias').jqxGrid('getrows');
               var rowlength= rows.length;
                 var cell1 = $('#jqxnalias').jqxGrid('getselectedcell');
                 
                 if (cell1.rowindex == rowlength - 1) {
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key ==9) {   
                  	   
                          $("#jqxnalias").jqxGrid('addrow', null, {});
                          
                          rowlength++;
                      
                     }
                 }
           },
         */
        
        columns: [

						{ text: 'NAlias', datafield: 'code', editable:true},
						{ text: 'Doc No', datafield: 'doc_no', hidden:true}
					
						
					]
    
    });
    
	/*  $("#jqxnalias").jqxGrid('addrow', null, {});  */
    $('#jqxnalias').on('cellclick', function (event) {
    	var rows1=$('#jqxnalias').jqxGrid('getrows');
   	    var rowlength= rows1.length;
         var rowindex1=event.args.rowindex;
        
          if (rowindex1 == rowlength - 1) {
            //  var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                   $('#jqxnalias').jqxGrid('addrow', null, {});
                  }
	});
   
});


</script>
<div id="jqxnalias"></div>