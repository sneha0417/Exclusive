<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();%> 
 <script type="text/javascript">
 
 var datatype='<%=DAO.prdtypeLoad(session)%>';
        $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [ 
                         
     						{name : 'doc_no', type: 'int'  },
     						{name : 'code', type: 'String' },
     						{name : 'prtype', type: 'String' },
     						
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
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
     					
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '10%' },
					 { text: 'Date', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy'  },
					  { text: 'Code', datafield: 'code', width: '40%'},  
					 { text: 'Name', datafield: 'prtype', width: '40%' },
					
					
					]
            });
            
         
            
			  $('#jqxtypegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                if(document.getElementById("mode").value!='A'){  
                 document.getElementById("docno").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("ptmtype").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "prtype");
                document.getElementById("pcode").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("ptmdate").value= $('#jqxtypegrid').jqxGrid('getcellvalue', rowindex1, "date");
                }
               
            });  
				           
}); 
				       
                       
    </script>
    <div id="jqxtypegrid"></div>
    