<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.termsnconditions.ClsTermsAndConditionsDAO"%>
<% String dtype = request.getParameter("dtype").trim()==null?"0":request.getParameter("dtype").trim().toString();
%>
<%ClsTermsAndConditionsDAO DAO= new ClsTermsAndConditionsDAO();%>


<script type="text/javascript">
var doctype='<%=dtype%>'; 
   var dtypedata = '<%=DAO.dtypeGridDetails(session) %>';  
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'dtype', type: 'string'   },
     						{name : 'description', type: 'string'  }
                        ],
                		localdata: dtypedata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDtypeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc Type', datafield: 'dtype', width: '40%' },
							{ text: 'Description', datafield: 'description', width: '60%' },
						]
            });
            
             $('#jqxDtypeSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                if(doctype=="1"){
                	document.getElementById("txthdoctype").value = $('#jqxDtypeSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
                	var dtype = $("#txthdoctype").val();
                	 $("#headerGridDiv").load("headerGrid.jsp?dtype="+dtype);
                	
                }
                else {
                	document.getElementById("txtfdoctype").value = $('#jqxDtypeSearch').jqxGrid('getcellvalue', rowindex1, "dtype");
                	}
                
                 
               
                /* $("#footerGridDiv").load("footerGrid.jsp?dtype="+dtype);  */
                $('#dtypeDetailsWindow').jqxWindow('close');  
            });  
        });
    </script>
    <div id="jqxDtypeSearch"></div>