<%@page import="com.dashboard.projectexecution.serviceclose.ServiceCloseDAO"%>
<% ServiceCloseDAO DAO= new ServiceCloseDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%

 String contracttype = request.getParameter("contracttype")==null?"0":request.getParameter("contracttype");
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno"); 
 String refno = request.getParameter("refno")==null?"0":request.getParameter("refno"); 
 String contractno = request.getParameter("contractno")==null?"0":request.getParameter("contractno"); 
 

 %>
 
<script type="text/javascript">
        
       var data5= '<%=DAO.contractDetailsSearch(session,cldocno, contracttype,refno,contractno)%>';  
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'dtype', type: 'string'   },
     						{name : 'contr', type: 'string'   },
     						{name : 'tr_no', type: 'int'   }
                        ],
                		 localdata: data5,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#contractDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'checkbox',
                
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '30%' },
							{ text: 'Doc Type', datafield: 'dtype', width: '30%' },
							{ text: 'Ref No', datafield: 'refno', width: '35%' },
							{ text: 'Tr No',  datafield: 'tr_no', hidden: true, width: '5%' },
							{ text: 'Contr',  datafield: 'contr', hidden: true, width: '5%' },
						]
            });
            
$( "#btncontract" ).click(function() {
            	
            	var rows = $("#contractDetailsSearch").jqxGrid('selectedrowindexes');
            	
            		/* alert("id one"); */
            	if(rows!=""){
            		if(document.getElementById("searchdetails").value==""){
                		document.getElementById("searchdetails").value="Contract";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidcontract").value="Contract";
                	}
                	else{
                		document.getElementById("searchdetails").value+="\n\nContract";
                		document.getElementById("searchdetails").value+="\n---------------------------";
                		document.getElementById("hidcontract").value+="\nContract";
                	}	
            	}
            	
        		document.getElementById("hidcontractid").value="";
            	
            	for(var i=0;i<rows.length;i++){
            		var dummy=$('#contractDetailsSearch').jqxGrid('getcellvalue',rows[i],'contr');
            		var docno=$('#contractDetailsSearch').jqxGrid('getcellvalue',rows[i],'tr_no');
            		document.getElementById("searchdetails").value+="\n"+dummy;
            		document.getElementById("hidcontract").value+="\n"+dummy;
            		if(i==0){
            			document.getElementById("hidcontractid").value=docno;
            		}
            		else{
            			document.getElementById("hidcontractid").value+=","+docno;
            		}
            	}
         
            	$('#contractwindow').jqxWindow('close');
        	});
            	  
        });
 
</script>
 <div align="center" style="padding-bottom:4px;"><button type="button" id="btncontract" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="contractDetailsSearch"></div>
 