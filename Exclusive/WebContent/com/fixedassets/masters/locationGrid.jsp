<%@page import="com.fixedassets.masters.locationmaster.ClsFixedAssetLocationDAO" %>
<%ClsFixedAssetLocationDAO fal=new ClsFixedAssetLocationDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>


<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <script type="text/javascript">
 
 var dataloc='<%=fal.locgridLoad(session)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'doc_no', type: 'int'  },
     						{name : 'loc_name', type: 'String' },
     						{name : 'loc_code', type: 'String' },
     						{name : 'locdate', type: 'date' }
                          	],
                          	localdata: dataloc,
                
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
            $("#jqxLocationgrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Location Name', datafield: 'loc_name', width: '40%' },
					 { text: 'Location Code', datafield: 'loc_code', width: '30%'},
					 { text: 'Date', datafield: 'locdate', width: '20%', cellsformat: 'dd.MM.yyyy'  }
					]
            });
            
			  $('#jqxLocationgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
               if(document.getElementById("mode").value=='E'){
                 document.getElementById("docno").value= $('#jqxLocationgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("flmname").value= $('#jqxLocationgrid').jqxGrid('getcellvalue', rowindex1, "loc_name");
                document.getElementById("flmcode").value= $('#jqxLocationgrid').jqxGrid('getcellvalue', rowindex1, "loc_code");
                document.getElementById("flmdate").value= $('#jqxLocationgrid').jqxGrid('getcellvalue', rowindex1, "locdate");
               }
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxLocationgrid"></div>
    