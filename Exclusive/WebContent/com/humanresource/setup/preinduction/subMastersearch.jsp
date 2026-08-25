
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
   <%@page import="com.humanresource.setup.preinduction.ClspreinductionDAO" %>
  <% ClspreinductionDAO ClspreinductionDAO=new ClspreinductionDAO();
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String gds = request.getParameter("gds")==null?"0":request.getParameter("gds");
 String des = request.getParameter("des")==null?"0":request.getParameter("des");
 String mmdate = request.getParameter("mmdate")==null?"0":request.getParameter("mmdate");
 
 
 
%> 

 <script type="text/javascript">
 
 var  masterdata='<%=ClspreinductionDAO.searchMaster(session,gds,msdocno,des,mmdate)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json", 
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                	{name : 'refno' , type: 'String' },
                	{name : 'desc1' , type: 'String' },
                    {name : 'designation' , type: 'String' },
                   	{name : 'noof_pos' , type: 'String' },
                   	{name : 'grade' , type: 'String' },
                 	{name : 'sal_frm' , type: 'String' },
                 	{name : 'sal_to' , type: 'String' },
                 	
                	{name : 'rep_to' , type: 'String' },
                 	
                	 {name : 'des', type: 'String'  },
					 {name : 'grd', type: 'String'  },
					 {name : 'rep', type: 'String'  },
					  
                 	
                   	],
          localdata: masterdata,
         
         
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
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
 
 
		{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
		{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
		{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
		{ text: 'Designation', datafield: 'des', width: '20%' },
		{ text: 'Grade', datafield: 'grd', width: '20%'},
		 
		{ text: 'Description', datafield: 'desc1'  },

 
				]
     });
     
     $('#subquotationSearch').on('celldoubleclick', function (event) {
         
 		
	  	  $("#jobgrid").jqxGrid('clear');
	  	  $("#descgrid").jqxGrid('clear');
		
     	 var rowindex1 = event.args.rowindex;
     	$('#masterdate').jqxDateTimeInput({ disabled: false});
     	$('#masterdate').val($("#subquotationSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
     	
     	document.getElementById("masterdoc_no").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("docno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
        
        document.getElementById("refno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "refno");
        document.getElementById("designation").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "des");         
        document.getElementById("designationid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "designation");
        document.getElementById("desc1").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "desc1");
        document.getElementById("noofpos").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "noof_pos");
        
        document.getElementById("grade").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "grd");
        document.getElementById("gradeid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "grade");
        document.getElementById("fromsal").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "sal_frm");
        
        document.getElementById("tosal").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "sal_to");
        
        document.getElementById("report").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "rep");
        document.getElementById("reportid").value=$('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "rep_to");
     	  var docVal1 = document.getElementById("masterdoc_no").value;
        	if(docVal1>0)
        		{
  		 var indexVal2 = document.getElementById("masterdoc_no").value;
           $("#grid1").load("qual.jsp?docno="+indexVal2);
           $("#grid2").load("exp.jsp?docno="+indexVal2);
           $("#grid3").load("interview.jsp?docno="+indexVal2);
           $("#grid4").load("job.jsp?docno="+indexVal2);
           document.getElementById("valsss").value="";
        	$("#jobgrid").jqxGrid({ disabled: true});
    		$("#descgrid").jqxGrid({ disabled: true});
     		
     		$('#edit1').attr('disabled', false);
     		$('#save1').attr('disabled', true);
     		
     		$('#edit2').attr('disabled', false);
     		$('#save2').attr('disabled', true);
        		}
        	 document.getElementById("headname").innerText="";
        	$('#masterdate').jqxDateTimeInput({ disabled: true});
        $('#window').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subquotationSearch"></div>

    
    </body>
</html>
