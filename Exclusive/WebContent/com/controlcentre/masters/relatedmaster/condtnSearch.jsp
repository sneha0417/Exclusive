<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.tourtype.ClsTourDAO"%>   
<%
ClsTourDAO cd=new ClsTourDAO();
%> 

<%
String rowindex2 = request.getParameter("rowindex2")==null?"0":request.getParameter("rowindex2");
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
String tdocno = request.getParameter("tdocno")==null?"0":request.getParameter("tdocno");
String cond = request.getParameter("cond")==null?"0":request.getParameter("cond");
%>   
<table width="100%" >             
<tr>
<td width="50%" align="center"><button class="myButtons" type="button" id="btnSend" name="btnSend" onClick="set();">Submit</button></td>
</tr>
</table>
<script type="text/javascript">
var temp='<%=dtype%>';
var rowindex2='<%=rowindex2%>';
var comconsearch= '<%=cd.condtnSearch(session,dtype,tdocno,cond) %>';
		$(document).ready(function () {                       	
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'doc_no', type: 'string'  },
                              {name : 'rdocno', type: 'string'  },
                              {name : 'termsfooter', type: 'string'  },
                              
                            ],
                       localdata: comconsearch,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcomcondtnSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'checkbox',
                       
                columns: [
                              { text: 'doc_no', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'rdocno', datafield: 'rdocno', width: '40%',hidden:true },
                              { text: 'Description', datafield: 'termsfooter', width: '100%',editable:false },
                              
						]
            });
            $('#jqxcomcondtnSearch').on('cellclick', function (event) {
            	
                var rowindex1= event.args.rowindex;
                var condid=$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                var txtcondid=document.getElementById("txtcond").value;
                
                $('#jqxComTerms').jqxGrid('setcellvalue', rowindex2, "conditions" ,$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rowindex1, "termsfooter"));
                condid=txtcondid+condid+",";
                
                document.getElementById("txtcond").value=condid;
                
              $('#concomsearchwndow').jqxWindow('close'); 
            }); 
             
          /* $('#jqxcomcondtnSearch').on('celldoubleclick', function (event) {
        	
                var rowindex1= event.args.rowindex;
                var condid=$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                var txtcondid=document.getElementById("txtcond").value;
                
                $('#jqxComTerms').jqxGrid('setcellvalue', rowindex2, "conditions" ,$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rowindex1, "termsfooter"));
                condid=txtcondid+condid+",";
                
                document.getElementById("txtcond").value=condid;
				
                
              $('#concomsearchwndow').jqxWindow('close'); 
            });  */
            
        });
		
		function set(){   
		   var rows = $("#jqxcomcondtnSearch").jqxGrid('selectedrowindexes');
		   
		   rows = rows.sort(function(a,b){return a - b});
		   for(var i=0 ; i < rows.length ; i++){
			   
			   var rowsss = $("#jqxComTerms").jqxGrid('getrows');
               var condid=$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rows[i], "doc_no");
               var txtcondid=document.getElementById("txtcond").value;
               $('#jqxComTerms').jqxGrid('setcellvalue', rowsss.length-2, "terms" ,$('#jqxComTerms').jqxGrid('getcellvalue', rowindex2, "terms"));
               $('#jqxComTerms').jqxGrid('setcellvalue', rowsss.length-2, "voc_no" ,$('#jqxComTerms').jqxGrid('getcellvalue', rowindex2, "voc_no"));
               $('#jqxComTerms').jqxGrid('setcellvalue', rowsss.length-2, "doc_no" ,$('#jqxComTerms').jqxGrid('getcellvalue', rowindex2, "doc_no"));
               $('#jqxComTerms').jqxGrid('setcellvalue', rowsss.length-2, "conditions" ,$('#jqxcomcondtnSearch').jqxGrid('getcellvalue', rows[i], "termsfooter"));
               condid=txtcondid+condid+",";                   
               
               document.getElementById("txtcond").value=condid;
				if(i < rows.length-1)
					{
	                $("#jqxComTerms").jqxGrid('addrow', null, {});
					}
				   
			 
		   } 
		   $('#concomsearchwndow').jqxWindow('close'); 
		
		}
	
    </script>
    <div id="jqxcomcondtnSearch"></div> 