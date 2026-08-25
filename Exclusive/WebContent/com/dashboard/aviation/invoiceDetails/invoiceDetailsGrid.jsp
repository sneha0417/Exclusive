
 
 <%@page import="com.dashboard.aviation.invoicedetails.ClsinvoiceDetailsDAO"%>
 <% ClsinvoiceDetailsDAO searchDAO = new ClsinvoiceDetailsDAO(); %>
 <% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); %>
 
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
 data= '<%=searchDAO.loadGridData(sortby,fromdate,todate,clientid,portid,id)%>'; 
 }else{
 	data;
 }
  
 $(document).ready(function () {
   
	 var rendererstring=function (aggregates){
        	var value=aggregates['sum'];
        	if(typeof(value) == "undefined"){
        		value=0.00;
        	}
        	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
        }
 	
 	var rendererstring1=function (aggregates){
         var value1=aggregates['sum1'];
         return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
        }
	 
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
 				    ],
 				    localdata: data,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
    var cellclassname =  function (row, column, value, data) {
    
    }
    
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
 		            
 	            }		
     );
     
     
    
    
     
     $("#invoicedetailsgrid").jqxGrid(
     {
         width: '98%',
         height: 505,
         statusbarheight:25,
         source: dataAdapter,
         enableAnimations: true,
         filtermode:'excel',
         filterable: true,
         sortable:true,
         showaggregates:true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         editable:false,
         showstatusbar:true,
         columns: [  
                     /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                      { text: 'DOC NO',datafield: 'doc_no', width: '5%' },
                      { text: 'DATE',datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '7%' },
                      { text: 'CLIENT', datafield: 'client', width: '20%'},
                      { text: 'PORT', datafield: 'port',  width: '7%' },
                      { text: 'REGION',datafield: 'region', width: '8%'},
                      { text: 'AIRCRAFT', datafield: 'acraft_no',  width: '8%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname },
                      { text: 'QTY(LTR)', datafield: 'ltrqty',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
                      { text: 'QTY(USG)', datafield: 'usgqty',  width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
                      { text: 'SELLING PRICE', datafield: 'sprice',  width: '13%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
            	      { text: 'AMOUNT(USD)', datafield: 'amountusd',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname}, 
            	      { text: 'AMOUNT(AED)', datafield: 'amountaed',  width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
            	  	]
    
     });
     $("#overlay, #PleaseWait").hide();
    
 });


 </script>
 <div id="invoicedetailsgrid"></div>