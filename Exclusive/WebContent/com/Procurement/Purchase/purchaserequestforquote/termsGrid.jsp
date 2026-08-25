<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%-- <jsp:include page="includes.jsp"></jsp:include> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 

<%@page import="com.procurement.purchase.purchaserequestforquote.ClspurchaserequestforquoteDAO"%>
<% ClspurchaserequestforquoteDAO  purchaserequestforquoteDAO = new ClspurchaserequestforquoteDAO();  

String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");

String masterdoc = request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc");
 %> 

 
<script type="text/javascript">
		 var termsdata;  
        $(document).ready(function () { 
           
            var temp='<%=dtype%>';
             
            var masterdocno='<%=masterdoc%>';
            
            if(masterdocno!='0')
            	{
            	termsdata='<%=purchaserequestforquoteDAO.termsGridreLoad(masterdoc)%>';     
            	
            	}
            else
            	{
            	termsdata='<%=purchaserequestforquoteDAO.termsGridLoad(session,dtype)%>';     
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
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                
                disabled:true,
                
                selectionmode: 'singlecell',
      /*           handlekeyboardnavigation: function (event) {
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
							{ text: 'Voc_no', datafield: 'voc_no', hidden:true, width: '10%' },
							{ text: 'Dtype', datafield: 'dtype', hidden:true,  width: '10%' },
							{ text: 'Terms', datafield: 'terms',  width: '10%',editable:false },
							{ text: 'Description', datafield: 'conditions', width: '85%' },	
							
						]
            });
            
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		       {
    		  $("#jqxTerms").jqxGrid({ disabled: false}); 
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
            			//alert("1"); 
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
