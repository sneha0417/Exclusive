<%@page import="com.dashboard.aviation.fuelstatus.ClsFuelStatusDAO" %>
<% ClsFuelStatusDAO sd=new ClsFuelStatusDAO(); %>
 <% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();%>
  <% String sortby =request.getParameter("sortby")==null?"0":request.getParameter("sortby").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% String portid =request.getParameter("portid")==null?"0":request.getParameter("portid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>

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

var data;
var id='<%= id%>';
if(id>0){
data= '<%=sd.loadGridData(dtype,sortby,clientid,portid,id)%>'; 
}else{
	data;
}
 
$(document).ready(function () {
  
   var source =
    {
        datatype: "json",
        datafields: [   
                     {name :'doc_no', type:'number' },
                     {name :'client', type:'String' },
                     {name :'date', type:'date' },
				     {name : 'port', type: 'number'  },
				     {name :'region', type:'String' },
				     {name :'acraft_no', type:'number'},
					 {name :'ltrqty' ,type:'number'},
					 {name :'usgqty' ,type:'number'},
					 {name :'sprice' ,type:'number'},
					 {name :'amountusd' ,type:'number'},
					 {name :'amountaed' ,type:'number'},
					 {name :'description' ,type:'String'},
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
                     { text: 'DOC NO',datafield: 'doc_no', width: '5%' },
                     { text: 'DATE',datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '7%' },
                     { text: 'CLIENT', datafield: 'client', width: '20%'},
                     { text: 'PORT', datafield: 'port',  width: '7%' },
                     { text: 'REGION',datafield: 'region', width: '13%'},
                     { text: 'AIRCRAFT', datafield: 'acraft_no',  width: '11%' },
                     { text: 'QTY(LTR)', datafield: 'ltrqty',  width: '5%' },
                     { text: 'QTY(USG)', datafield: 'usgqty',  width: '5%' },
                     { text: 'SELLING PRICE', datafield: 'sprice',  width: '13%' },
           	         { text: 'AMT(USD)', datafield: 'amountusd',  width: '7%' }, 
           	         { text: 'AMOUNT(AED)', datafield: 'amountaed',  width: '7%' },
           	         { text: 'DESCRIPTION', datafield: 'description',  width: '10%' },
           	  	]
   
    });
    $("#overlay, #PleaseWait").hide();
   
});


</script>
<div id="orderlistgrid"></div>