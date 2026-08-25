<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String submodelid=request.getParameter("submodelid");%>
<%String brandid=request.getParameter("brandid");%>
<%String modelid=request.getParameter("modelid");%>
<script type="text/javascript">
var uomrow='<%=request.getParameter("rowno") %>';
var type='<%=request.getParameter("type") %>';
$(document).ready(function () {
  
   var spec1search;
  
   spec1search='<%=DAO.suitSpec1Search(session,submodelid,brandid,modelid) %>';
	
	   var source =
       {
           datatype: "json",  
           datafields: [
                         {name : 'doc_no', type: 'string'  },
                         {name : 'spec', type: 'string'  }
                       ],
                  localdata: spec1search,
           
           pager: function (pagenum, pagesize, oldpagenum) {
               // callback called when a page or page size is changed.
           }
       };
    
       var dataAdapter = new $.jqx.dataAdapter(source);
       
       $("#spec1search").jqxGrid(
       {
           width: '100%',
           height: 375,
           source: dataAdapter,
           showfilterrow: true, 
           filterable: true, 
           selectionmode: 'singlecell',
                  
           columns: [
                         { text: 'Doc_no', datafield: 'doc_no', width: '40%'},
                         { text: 'Spec', datafield: 'spec', width: '60%' },
                         
					]
       });
       
        
     $('#spec1search').on('celldoubleclick', function (event) {
   	
           var rowindex1= event.args.rowindex;
           if(type=="1"){
           $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize1',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "spec"));
           $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize1id',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "doc_no"));
           }
           
           if(type=="2"){
               $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize2',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "spec"));
               $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize2id',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "doc_no"));
               }
           
           if(type=="3"){
               $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize3',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "spec"));
               $('#jqxSuitGrid').jqxGrid('setcellvalue', uomrow, 'bsize3id',$('#spec1search').jqxGrid('getcellvalue', rowindex1, "doc_no"));
               }
           
         $('#spec1searchwindow').jqxWindow('close'); 
       });
     
     $("#spec1search").jqxGrid('addrow', null, {});
   });
</script>
<div id="spec1search"></div> 