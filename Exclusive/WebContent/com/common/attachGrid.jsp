<%@page import="com.common.ClsAttach" %>
<%ClsAttach ca=new ClsAttach(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
 

	<script type="text/javascript">
	$(document).ready(function(){
		var data4='<%= ca.reGridload(docNo,request.getParameter("formCode")) %>';
		
		Check(data4);
			});	
	
	function Check(data4){
		   
		
		  var source =
          {
              datatype: "json",
              datafields: [
						{name : 'sr_no', type: 'string'  },
   						{name : 'extension', type: 'string'  },
   						{name : 'description', type: 'string'    },
   						{name : 'filename', type: 'string'    },
   					    {name : 'path', type: 'string'    }
   						     						
               ],
               localdata: data4, 
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
          $("#jqxDocumentsAttach").jqxGrid(
          {
              width: '100%',
              height: 360,
              source: dataAdapter,
              editable: true,
              selectionmode: 'singlerow',
              columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              datafield: 'sr_no', width: '10%',cellsalign: 'center', align: 'center', editable: false	},
							{ text: 'Doc Type', datafield: 'extension', width: '10%', editable: false },
							{ text: 'Description', datafield: 'description', width: '60%', editable: false },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:false }
	              ]
          });	
		 $('#jqxDocumentsAttach').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"));
              }); 
	}
	 function ajaxFileUpload()  
	      {  
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#txtdesc").val() ,  
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'json',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                      <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
	                      alert("============="+data); --%>
	                     if(status=='success'){
	                      funAttachBtn(); 
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              alert(data.error);  
	                          }else  
	                          {  
	                              alert(data.message);  
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      alert(e);  
	                  }  
	              }  
	          )  
	          return false;  
	      }
	
	 function reload(){
		$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');
		
		<%--  $('#jqxDocumentsAttach').jqxGrid('refreshdata');
		 //Thread.sleep(10000);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>);
		 $("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>); --%>
	 }
 
	function SaveToDisk(fileURL, fileName) {
	  //alert(fileURL);
	   //fileName='';
	   var host = window.location.origin;
	   //alert("hooosssst"+host);
	  
	   var splt = fileURL.split("webapps"); 
	  //alert("after split"+splt[1]);
	   var repl = splt[1].replace( /;/g, "/");
	   repl = repl.replace( / /g, "%20");
	   repl = repl.replace( '#', "%23");
	   //alert("repl"+repl);
	   //alert("after replace===="+repl);
	   fileURL=host+repl;
	   //alert("fileURL===="+fileURL);
	    // for non-IE
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        //alert(save);
	       // alert(fileURL);
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
			
			window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
			
	        //var event = document.createEvent('Event');
	       // alert(event);
	        //event.initEvent('click', true, true);
	        //save.dispatchEvent(event);
	        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
	    }

	    // for IE
	    else if ( !! window.ActiveXObject && document.execCommand)     {
	        var _window = window.open(fileURL, '_blank');
	        _window.document.close();
	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
	        _window.close();
	    }
	}

 
	</script>
<body>
<div id="refreshdiv"><div id="jqxDocumentsAttach"></div></div>
</body>
</html>
