<%@page import="com.dashboard.aviation.fueldeliveryfollowup.ClsFuelDeliveryFollowupDAO" %>
<% ClsFuelDeliveryFollowupDAO aa=new ClsFuelDeliveryFollowupDAO(); %>
<% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString(); %>
<% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); %>
<style type="text/css">
  .advanceClass
  {
      color: #FF0000;
  }
  .yellowClass
        {
       background-color: #ffc0cb; 
        }
</style>
 
<script type="text/javascript">

var check='<%= id%>';
var data;
var exceldata;
if(parseInt(check)==1){
	  data= '<%= aa.loadGridData(id,fromdate,todate)%>';
	  exceldata= '<%= aa.excelData(id,fromdate,todate)%>';
} 
else{
	 data;
}
$(document).ready(function () {
  
   var source =
    {
        datatype: "json",
        datafields: [   
                     {name :'voc_no', type:'String' },
                     {name :'row_no', type:'String' },
                     {name :'doc_no', type:'String' },
                     {name :'client', type:'String' },
                     {name :'vendor', type:'String' },
                     {name :'date', type:'date' },
				     {name : 'port', type: 'number'  },
					 {name :'product', type:'String' },
					 {name :'ac_type', type:'String'},
					 {name :'acraft_no', type:'number'},
					 {name :'flight_no', type:'number'},
					 {name :'operator' ,type:'String'}, 
					 {name :'eta' ,type:'String'},
					 {name :'etd' ,type:'String'},
					 {name :'tzone' ,type:'String'},
					 {name :'unit' ,type:'number'},
					 {name :'qty' ,type:'number'},
				    ],
				    localdata: data,
        
        
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
    
    
   
   
    
    $("#orderlistgrid").jqxGrid(
    {
        width: '98%',
        height: 505,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showaggregates:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                 
          
                   /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                     { text: 'VOC NO',datafield: 'voc_no', width: '5%' },
                     { text: 'DOC NO',datafield: 'doc_no', width: '5%',hidden:true },
                     { text: 'ROW NO',datafield: 'row_no',hidden:true, width: '5%' },
                     { text: 'CLIENT', datafield: 'client', width: '18%'},
         			 { text: 'VENDOR',datafield: 'vendor', width: '13%'},
         			 { text: 'DATE',datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '7%' },
         		     { text: 'PORT', datafield: 'port',  width: '5%' },
                     { text: 'PRODUCT', datafield: 'product',  width: '13%' },
           	         { text: 'ACC. TYPE', datafield: 'ac_type',  width: '7%' }, 
           	         { text: 'AIRCRAFT NO', datafield: 'acraft_no',  width: '11%' },
           	         { text: 'FLIGHT NO', datafield: 'flight_no',  width: '7%' },
           	         { text: 'OPERATOR', datafield: 'operator',  width: '13%' },
           	         { text: 'ETA', datafield: 'eta',  width: '5%' },
        	         { text: 'ETD', datafield: 'etd',  width: '5%' }, 
        	         { text: 'TIME ZONE', datafield: 'tzone',  width: '8%' },
        	         { text: 'UNIT', datafield: 'unit',  width: '6%' },
        	         { text: 'QTY', datafield: 'qty',  width: '4%' },
        	     
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    $('#orderlistgrid').on('rowdoubleclick', function (event) {
     	    var rowindex1=event.args.rowindex;
    	    document.getElementById("hiddocno").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "row_no");
    	    document.getElementById("hiddocno1").value=$('#orderlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    	    document.getElementById("hidrowindex").value=rowindex1;
        	 
        	 $('#txtdelnoteno').attr("disabled",true);
             $('#txtqty').attr("disabled",true);
             $('#txtdescription').attr("disabled",true);
        	 $('#pdate').jqxDateTimeInput({disabled: true});
        	 $('#btnupdate').attr("disabled",true);
    	     $('#cmbprocess').attr("disabled",false);
             document.getElementById('cmbprocess').value="";
             $('#pdate').val(new Date());
    	 
    });
    
    
   
});


</script>
<div id="orderlistgrid"></div>