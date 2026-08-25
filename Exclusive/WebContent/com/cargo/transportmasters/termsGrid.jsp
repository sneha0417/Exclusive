<%@page import="com.cargo.transportmasters.terms.ClsTermsDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsTermsDAO td=new ClsTermsDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
		 var data;  
        $(document).ready(function () { 
           
        	  var temp='<%=check%>';
              
              if(temp>0){   
             	 data='<%=td.getTermsGrid(check)%>';    
            	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date' }, 
     						{name: 'modeid',type: 'int'},
     						{name : 'modename', type: 'string'  },
     						{name : 'terms', type: 'string'   },
     					    {name : 'tcode', type: 'String'   }
     					
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            
            $("#jqxterms").jqxGrid(
            {
                 width: '99.5%',
                 height: 240,
                 source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
              
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '15%' },
                                                        { text: 'Date', datafield: 'date',filtertype: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '15%' },
                                                        { text: 'Mode Id', datafield: 'modeid',filtertype: 'number',hidden:true, editable: false, width: '25%' },
							{ text: 'Mode', datafield: 'modename', filtertype: 'list',editable: false, width: '25%' },
							{ text: 'Name', datafield: 'terms', filtertype: 'textbox',editable: false, width: '25%' },
							{ text: 'Code', datafield: 'tcode', filtertype: 'textbox',width: '20%',editable: false },
							]
            });
            $('#jqxterms').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxterms').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#termsdate").jqxDateTimeInput('val', $("#jqxterms").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("hidcmbmode").value = $("#jqxterms").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("cmbmode").value = $("#jqxterms").jqxGrid('getcellvalue', rowindex1, "modename");
                document.getElementById("name").value = $("#jqxterms").jqxGrid('getcellvalue', rowindex1, "terms");
                document.getElementById("code").value = $("#jqxterms").jqxGrid('getcellvalue', rowindex1, "tcode");
                getMode();
               
                $('#window').jqxWindow('hide');
            });
           
         	
        });
    </script>
    <div id="jqxterms"></div>
    
