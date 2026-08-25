<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%-- <jsp:include page="includes.jsp"></jsp:include> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.sales.marketing.salesquotation.ClsSalesQuotationDAO"%>
<%ClsSalesQuotationDAO DAO= new ClsSalesQuotationDAO();
String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
String qotdoc=request.getParameter("qotdoc")==null?"0":request.getParameter("qotdoc").trim();
System.out.println("=qotdoc====="+qotdoc);
System.out.println("=dtype====="+dtype);
%> 
<script type="text/javascript">
		 var termsdata;  
        $(document).ready(function () { 
           
            var temp='<%=dtype%>';
            var temp2='<%=qotdoc%>';
             if(temp2!='0'){
            	termsdata='<%=DAO.termsGridReLoad(session,dtype,qotdoc)%>';
            }
             else{
            	
                 termsdata='<%=DAO.termsGridLoad(session,dtype)%>';     
                
             }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'string' },
							{name : 'dtype', type: 'string' },
     						{name : 'terms', type: 'string' }, 
     						{name : 'conditions', type: 'string'}
                        ],
                         localdata: termsdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxTerms").jqxGrid(
            {
                width: '99.5%',
                height: 150,
                source: dataAdapter,
                editable: true,
                disabled:true,
                selectionmode: 'singlecell',
              /*   handlekeyboardnavigation: function (event) {
                    var rows = $('#jqxTerms').jqxGrid('getrows');
                       var rowlength= rows.length;
                       var cell = $('#jqxTerms').jqxGrid('getselectedcell');
         				if (cell != undefined && cell.datafield == 'conditions' && cell.rowindex == rowlength - 1) {
                           var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                           if (key == 9) {                                                        
                               var commit = $("#jqxTerms").jqxGrid('addrow', null, {});
                               rowlength++;                           
                           }
                       }
   },   */
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Voc_no', datafield: 'voc_no', width: '10%',hidden:true },
							{ text: 'Dtype', datafield: 'dtype',  width: '10%',hidden:true },
							{ text: 'Terms', datafield: 'terms',  width: '10%',editable:false },
							{ text: 'Description', datafield: 'conditions', width: '85%' },	
							
						]
            });
            
            if ($('#mode').val() == 'A') {
				$("#jqxTerms").jqxGrid({
					disabled : false
				});
				
				  $("#jqxTerms").jqxGrid('addrow', null, {});
			}
            
            $('#jqxTerms').on('celldoubleclick', function (event) {
                
            	var columnindex1=event.args.columnindex;
            	 var rowindex1 = event.args.rowindex;
            	 var datafield = event.args.datafield;
            	 var dtype=document.getElementById("formdetailcode").value;
            	
            	 var tmp;
            	 if(datafield=='terms'){
            		 
            		 tmp=$('#jqxTerms').jqxGrid('getcellvalue', rowindex1, "conditions");
            		 
            		 if(tmp==""||typeof(tmp)=="undefined"|| typeof(tmp)=="NaN")
          		   { 
            			 
            			 termsSearchContent("termsSearch.jsp?dtype="+dtype+"&rowindex2="+rowindex1);  
          		   }
                   else
                  	 {

           
          		  } 
            	 }
            	 });
            $('#jqxTerms').on('cellvaluechanged', function (event) {
			     var rowindex1=event.args.rowindex;
			     var rows = $('#jqxTerms').jqxGrid('getrows');
	               var rowlength= rows.length;
	               if(rowindex1 == rowlength - 1)
	               	{  
	            	  
	               $("#jqxTerms").jqxGrid('addrow', null, {});
	               
	            
	         
	               	}    
			     
			     
			 }); 
        });
</script>
<div id="jqxTerms"></div>
