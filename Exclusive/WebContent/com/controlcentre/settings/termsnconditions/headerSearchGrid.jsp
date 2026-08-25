<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page
	import="com.controlcentre.settings.termsnconditions.ClsTermsAndConditionsDAO"%>
<% String dtype = request.getParameter("dtype").trim()==null?"0":request.getParameter("dtype").trim().toString();
%>
<%ClsTermsAndConditionsDAO DAO= new ClsTermsAndConditionsDAO();%>


<script type="text/javascript">
var doctype='<%=dtype%>'; 
   var headsearchdata = '<%=DAO.headerSearchGridDetails(session,dtype) %>';  
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'voc_no', type: 'number'   },
     						{name : 'dtype', type: 'string'   },
     						{name : 'description', type: 'string'  },
     						{name : 'mand', type: 'bool'  }
                        ],
                		localdata: headsearchdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxHeaderSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '40%',hidden:true },
							{ text: 'Doc Type', datafield: 'dtype', width: '40%' },
							{ text: 'Description', datafield: 'description', width: '50%' },
							{ text: 'Mandatory', datafield: 'mand', width: '10%',columntype: 'checkbox' },
						]
            });
            
             $('#jqxHeaderSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                $("#jqxFooter").jqxGrid('addrow', null, {"btnsave":"Edit"});
              //  $("#jqxFooter").jqxGrid('addrow', null, {});
                	document.getElementById("txtfheaderdescription").value = $('#jqxHeaderSearch').jqxGrid('getcellvalue', rowindex1, "description");
                	document.getElementById("headerid").value = $('#jqxHeaderSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
                	
                 

                	 var fdtype = $("#txtfdoctype").val();
    				 var fhdesc = $("#headerid").val();
    				 
    	            $("#footerGridDiv").load("footerGrid.jsp?dtype="+fdtype+"&fhdesc="+fhdesc);
    			
               
                
                $('#dtypeDetailsWindow').jqxWindow('close');  
            });  
        });
    </script>
<div id="jqxHeaderSearch"></div>