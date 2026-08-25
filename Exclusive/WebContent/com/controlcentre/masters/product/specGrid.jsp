<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<% String contextPath=request.getContextPath();%>
<%ClsProductDAO DAO= new ClsProductDAO(); 
String psrno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
%>
<script type="text/javascript">
		 var specdata;  
        $(document).ready(function () { 
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'spec1', type: 'string' }, 
     						{name : 'spec2', type: 'string'   },
     						{name : 'spec3', type: 'string'  },
     						{name : 'spec4', type: 'string'   }
							
                        ],
                         localdata: specdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSpecGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                columnsresize: true,
                selectionmode: 'singlecell',
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
							{ text: 'Spec1'+document.getElementById("spec1").value, datafield: 'spec1', editable: true, width: '20%',cellsalign: 'center', align: 'center' },
							{ text: 'Spec2'+document.getElementById("spec2").value, datafield: 'spec2', width: '20%' },	
							{ text: 'Spec3'+document.getElementById("spec3").value, datafield: 'spec3', width: '20%' },	
							{ text: 'Spec4'+document.getElementById("spec4").value, datafield: 'spec4', width: '20%' },
						

						]
            });
           
          
        });
</script>
<div id="jqxSpecGrid"></div>
