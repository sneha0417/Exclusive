<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.operations.crm.callregister.ClsCallRegisterDAO"%>
<%ClsCallRegisterDAO DAO= new ClsCallRegisterDAO();%>
<%String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");%>
<script type="text/javascript">
var cldocno=parseInt(<%=cldocno%>);
if(cldocno>0){
	    var data='<%=DAO.cregGridData(session, cldocno)%>';;
}
        $(document).ready(function () { 
       // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							
     						{name : 'doc_no', type: 'string' },
     						{name : 'date', type: 'date' },
     						{name : 'vehicle', type: 'string'   },
     						{name : 'client', type: 'string'  },
     						{name : 'callby', type: 'string'  },
     						{name : 'mobno', type: 'string'  },
     						{name : 'type', type: 'string'  },
     						{name : 'description', type: 'string'  }
                 ],
                 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            } );

            
            
            $("#callRegisterGridID").jqxGrid(
            {
            	width: '99%',
                height: 220,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                columns: [
                          { text: 'Doc No', datafield: 'doc_no',width: '6%' },
                          { text: 'Date', datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy' },
                          { text: 'Vehicle', datafield: 'vehicle',width: '15%' },
                          { text: 'Client', datafield: 'client', width: '15%' },
                          { text: 'Called By', datafield: 'callby',width: '10%' },
						  { text: 'Mobile No.', datafield: 'mobno',width: '8%' },
						  { text: 'Type', datafield: 'type', hidden: true, width: '10%' },
						  { text: 'Remarks', datafield: 'description',width: '40%'},
						 ]
            });
        });

</script>
<div id="callRegisterGridID"></div>