    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
 <%@page import="com.dashboard.project.callregisterstatus.callregisterstatusDAO" %>
<%
callregisterstatusDAO sd=new callregisterstatusDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>


 <% String fromdate =request.getParameter("froms")==null?"0":request.getParameter("froms").toString();%>
 <% String todate =request.getParameter("tos")==null?"0":request.getParameter("tos").toString();%>
 <% String rds =request.getParameter("rds")==null?"0":request.getParameter("rds").toString();%>
 <% String barchval =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>

 <script type="text/javascript">
 var data,callregisterexcel;
 
 var bb='<%=rds%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(fromdate,todate,rds,barchval)%>';
 callregisterexcel= '<%= sd.loadGridExcel(fromdate,todate,rds,barchval)%>';
	}
	else{
		bb=1;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'custid', type: 'String' },
     						{name : 'cname', type: 'String' },
     						{name : 'cbname', type: 'String' },
     						{name : 'cbmobno', type: 'String' },
     						{name : 'ctype', type: 'String' },
     						{name : 'cno', type: 'String' },
     						{name : 'site', type: 'String' },
						{name : 'descp', type: 'String' },
						{name : 'view', type: 'String' },,
     						{name : 'attach', type: 'String' },
     						{name : 'path', type: 'String' },
     						{name : 'menuname', type: 'String' }
     						
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
		            }		
            );
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 550,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc Type',  datafield: 'dtype', width: '5%' },
					{ text: 'Doc No', datafield: 'doc_no', width: '4%' },
					{ text: 'Name', datafield: 'cname', width: '15%' },
					{ text: 'Called By Name', datafield: 'cbname', width: '7%' },
					{ text: 'Mobile No.', datafield: 'cbmobno', width: '7%' },
					{ text: 'Contract Type',  datafield: 'ctype', width: '7%' },
					{ text: 'Contract No.',  datafield: 'cno', width: '6%' },
					{ text: 'Site',  datafield: 'site', width: '4%' },
					{ text: 'Description',  datafield: 'descp', width: '35%' },
					{ text: '',  datafield: 'view',columntype: 'button', width: '4%' },
					{ text: '',  datafield: 'attach',columntype: 'button', width: '6%' },
					{ text: 'Path',  datafield: 'path', hidden: true, width: '5%' },
					{ text: 'name',  datafield: 'menuname', hidden: true, width: '5%' },
	              ]
            });
             $('#jqxloaddataGrid').on('cellclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	var datafield = event.args.datafield;
		            	
		            	 if(datafield=="view"){
		         			 var path1=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "path");
		     				 var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch");
		     				 var doctype=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
		     				 var  doc_no=0;
		     				
		     					  doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		     				
		     				 var name=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
		     				
		     				 var url=document.URL;
		       				var reurl=url.split("com");
		       
		     			  window.parent.formName.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
		     			  window.parent.formCode.value=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
		     			  var detName=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "menuname");
		     			  
		     			  var path= path1+"?modes=view&mastertrno="+doc_no+"&isassign=1&brch="+brch+"&doctype="+doctype+"&name="+name;
		     			 
		     			   top.addTab( detName,reurl[0]+""+path);
		     				
		                 	
		                 }
 	
		            	 if(datafield=="attach"){
		         			 var path1="com/common/attachGrid.jsp";
		     				 var brch=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "branch");
		     				 var doctype=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "dtype");
		     				 var  doc_no=0;
		     				
		     					  doc_no=$("#jqxloaddataGrid").jqxGrid('getcellvalue', rowindex1, "doc_no");
		     				 var url=document.URL;
		       				var reurl=url.split("com");
		       		  var path= path1+"?formCode=CREG&docno="+doc_no;
		     			  $("#windowattach").jqxWindow('setTitle',"CREG - "+doc_no);
		     				changeClientAttachContent(reurl[0]+""+path);
		     	         	
		                 }
		              
            		 });
            function changeClientAttachContent(url) {
        		$.get(url).done(function (data) {
        			    $('#windowattach').jqxWindow('open');
        				$('#windowattach').jqxWindow('setContent',data);
        				$('#windowattach').jqxWindow('bringToFront');
        	}); 
        	}
                 $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
