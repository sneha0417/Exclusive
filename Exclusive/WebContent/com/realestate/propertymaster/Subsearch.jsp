<%@page import="com.realestate.propertymaster.ClsPropertyMasterDAO" %>
<%ClsPropertyMasterDAO DAO=new ClsPropertyMasterDAO();

String unitno = request.getParameter("unitno")==null?"":request.getParameter("unitno");
 String dno = request.getParameter("dno")==null?"NA":request.getParameter("dno");
 String owner = request.getParameter("owname")==null?"NA":request.getParameter("owname");
 String ptype = request.getParameter("prtype")==null?"NA":request.getParameter("prtype"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");  
 String addr = request.getParameter("paddress")==null?"NA":request.getParameter("paddress"); 
   
%>
<script type="text/javascript">    
//alert("ere");

var datamain1= '<%=DAO.materearch(session,dno,owner,addr,ptype,aa,unitno) %>'; 
        $(document).ready(function () {                            
            // prepare the data 
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'voc_no', type: 'int'   }, 
     						{name : 'owner', type: 'string'   },
     						{name : 'address', type: 'string'   },
     						{name : 'ptype', type: 'string'   },
     						{name : 'unitno', type: 'string'   },
     						{name : 'optid', type: 'string'   },
     					     						  
                        ],
                		localdata: datamain1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
                columnsresize:true,    
                enabletooltips:true,
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' }, 
							{ text: 'Property', datafield: 'address', width: '30%' },
							{ text: 'Owner ', datafield: 'owner', width: '30%'  },
							{ text: 'Type', datafield: 'ptype' },
							{ text: 'Unitno', datafield: 'unitno', width: '6%' },  
							{ text: 'Optid', datafield: 'optid', width: '6%' },
						]
            });
            
             $('#searshgrid').on('rowdoubleclick', function (event) {  
                var rowindex1 = event.args.rowindex;
                
           	 document.getElementById("docno").value = $('#searshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#searshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
        	   $('#window').jqxWindow('close');     
           	 
          	 funSetlabel();
            
              
              document.getElementById("frmpropertyMaster").submit();
        	 
             
            }); 
             
        });
    </script>
    <div id="searshgrid"></div>