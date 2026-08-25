 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.salesandmarketing.Sales.joborder.ClsJobOrderDAO"%>
<%ClsJobOrderDAO DAO= new ClsJobOrderDAO();%>
 <%
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");

String clmobs = request.getParameter("clmobs")==null?"0":request.getParameter("clmobs");
String Cl_salper = request.getParameter("Cl_salper")==null?"0":request.getParameter("Cl_salper");



%> 

 <script type="text/javascript">
 
 var masdata; 
 

  masdata='<%=DAO.searchMaster(session,docno,Cl_names,clmobs,Cl_salper)%>';

  $(document).ready(function () { 	 
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'brandname' , type: 'string' },
                	{name : 'modelname' , type: 'String' },
                	{name : 'yom' , type: 'String' },
                    {name : 'refname' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'address' , type: 'String' },
                 	{name : 'cldocno' , type: 'String' },
                 	{name : 'regno' , type: 'string' },
                	{name : 'brdid' , type: 'number' },
                	{name : 'modelid' , type: 'number' },
                 	{name : 'yomid' , type: 'number' },
                 	{name : 'voc_no' , type: 'number' },
                 	
                 	{name : 'esize', type: 'string'   },
                 	{name : 'esizeid', type: 'int'   },
                 	{name : 'bsize', type: 'string'   },
                 	{name : 'bsizeid', type: 'int'   },

                 	{name : 'csize', type: 'string'   },
                 	{name : 'csizeid', type: 'int'   },
                 	
                 	
                 	{name : 'submodel', type: 'string'  },
                 	{name : 'submodelid', type: 'int'   },
                 	
                   	{name : 'type', type: 'int'   },
                   	
                    {name : 'per_mob' , type: 'String' },
                    {name : 'sal_name' , type: 'String' },
                    
                 	
                    
                   	],
          localdata: masdata,
         
         
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
     $("#subquotationSearch").jqxGrid(
     {
         width: '100%',
         height: 295,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'voc_no', width: '6%'},
				
				{ text: 'Name', datafield: 'refname', width: '24%' },
				{ text: 'MOB', datafield: 'per_mob', width: '10%'  },
				
				{ text: 'Sales Person', datafield: 'sal_name', width: '20%'  },
				
				{ text: 'Reg No', datafield: 'regno', width: '8%' },
				{ text: 'Brand ', datafield: 'brandname', width: '18%'},
				{ text: 'Model', datafield: 'modelname', width: '18%'},
				
				{ text: 'Sub Model', datafield: 'submodel', width: '18%'},
				
				
				{ text: 'Yom', datafield: 'yom', width: '8%' },
				
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true},
				{ text: 'type', datafield: 'type', width: '10%',hidden:true},
			 
				
				]
     });
     
     $('#subquotationSearch').on('rowdoubleclick', function (event) {
         
     	 var rowindex1 = event.args.rowindex;
     	 
     	 
        document.getElementById("masterdoc_no").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        document.getElementById("docno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
  
        
        document.getElementById("txtclient").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "refname");
        document.getElementById("txtclientdet").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "address");
        
        document.getElementById("regno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "regno");         
        document.getElementById("brand").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "brandname");
        document.getElementById("model").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "modelname");
        document.getElementById("submodel").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "submodel");
        
        
        document.getElementById("yom").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "yom");
        document.getElementById("yomid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "yomid");
        
        
        document.getElementById("clientid").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");         
        document.getElementById("brandid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "brdid");
        document.getElementById("modelid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "modelid");
     
        document.getElementById("submodelid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "submodelid");
        
        
        document.getElementById("typesave").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "type");
        
   
        
        
        document.getElementById("txtclientmob").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
 
 		
 		document.getElementById("esize").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "esize");
 		document.getElementById("esizeid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "esizeid");
 		
 		
 		document.getElementById("bsize").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "bsize");
 		document.getElementById("bsizeid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "bsizeid");
 		
 		document.getElementById("csize").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "csize");
 		document.getElementById("csizeid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "csizeid");
        
    
        
        
        funSetlabel();
     document.getElementById("frmjoborder").submit();
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subquotationSearch"></div>

    
    </body>
</html>
