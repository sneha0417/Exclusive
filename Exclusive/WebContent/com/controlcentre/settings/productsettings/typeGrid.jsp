<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>


<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
 <script type="text/javascript">
 
 var datatype='<%=DAO.prdtypeLoad(session)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int'  },
     						{name : 'prd_type', type: 'String' },
     						{name : 'date', type: 'date' }
                          	],
                          	localdata: datatype,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxtypegrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                showfilterrow:true,
                filterable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Product Type', datafield: 'prd_type', width: '60%' },
					/*  { text: 'type Code', datafield: 'grp_code', width: '30%'}, */
					 { text: 'Date', datafield: 'date', width: '20%', cellsformat: 'dd.MM.yyyy'  }
					]
            });
            
            if(document.getElementById("mode").value=='A'){
            	$('#jqxtypegrid').jqxGrid({ disabled: true});
            }
            
			  $('#jqxtypegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                 document.getElementById("docno").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("ptmtype").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "prd_type");
                document.getElementById("ptmdate").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "date");
               
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxtypegrid"></div>
    