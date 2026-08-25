 <%@page import="com.humanresource.setup.hrsetup.leavesetup.ClsLeavesetupDAO"%>
<% ClsLeavesetupDAO showDAO = new ClsLeavesetupDAO(); %>    
 
<script type="text/javascript">

	$(document).ready(function () {    
	 
	    var data1='<%=showDAO.searchrefsearch()%>';
	   
        var source =
        {
           datatype: "json",
           datafields: [
                     	{name : 'doc_no' , type: 'number' },
                     	{name : 'date', type: 'date'  },
                    	{name : 'valfrmdate', type: 'date'  },
                    	{name : 'revdate', type: 'date'  },
                    	{name : 'cat', type: 'String'  },
                     	{name : 'catid', type: 'String'  },
                       	{name : 'leavdesc', type: 'String'  },
                    	{name : 'sowlabel', type: 'String'  },
                      ], 
          			  localdata: data1,
           
           pager: function (pagenum, pagesize, oldpagenum) {
               // callback called when a page or page size is changed.
           }
       };
       
       var dataAdapter = new $.jqx.dataAdapter(source);
 
       $("#refsearch").jqxGrid(
               {
               	   width: "100%",
                   height: 350,
                   source: dataAdapter,
                   showfilterrow: true,
                   filterable: true,
                   selectionmode: 'singlerow',
                   
                   columns: [
   							{ text: 'Ref DocNo',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	     					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
   							{ text: 'Valid From',columntype: 'textbox', filtertype: 'input', datafield: 'valfrmdate', width: '12%',cellsformat:'dd.MM.yyyy' },
		   					{ text: 'Last Revised On',columntype: 'textbox', filtertype: 'input', datafield: 'revdate', width: '13%',cellsformat:'dd.MM.yyyy'   },
		   					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'cat', width: '53%'  },
		   					{ text: 'Category doc',columntype: 'textbox', filtertype: 'input', datafield: 'catid', width: '29%' ,hidden: true },
		   					{ text: 'Annual Leave',columntype: 'textbox', filtertype: 'input', datafield: 'leavdesc', width: '25%' ,hidden: true },
		   					{ text: 'sowlabel',columntype: 'textbox', filtertype: 'input', datafield: 'sowlabel', width: '25%' ,hidden: true },
		   	              ]
               });
       
      $('#refsearch').on('rowdoubleclick', function (event) {
           var rowindex1=event.args.rowindex; 
           
           document.getElementById("refno").value= $('#refsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
           document.getElementById("category").value= $('#refsearch').jqxGrid('getcellvalue', rowindex1, "cat"); 
           document.getElementById("catid").value= $('#refsearch').jqxGrid('getcellvalue', rowindex1, "catid"); 
           document.getElementById("newmode").value="";
       	   document.getElementById("showlabel").innerText=$('#refsearch').jqxGrid('getcellvalue', rowindex1, "sowlabel"); 
       	   document.getElementById("hidshowlabel").value=$('#refsearch').jqxGrid('getcellvalue', rowindex1, "sowlabel"); 
           $("#lsetup1").load("leavesetupgrid.jsp?docno="+$('#refsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));
           $("#lsetup2").load("condtiongrid.jsp");
           $('#savebtn').attr('disabled', true);
  		   $('#deltbtn').attr('disabled', true);
             
  		   $('#refSearchwindow').jqxWindow('close');
         });
      
});

</script>
<div id="refsearch"></div>  
        
        