<%@page import="com.common.ClsAttach"%>
<%ClsAttach ca= new ClsAttach(); %>

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
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno");


 
 %>
 <style type="text/css">

 .attachicon {
 width: 2.5em;
 height: 2em;
 border: none;
 background-color: #E0ECF8;
}

.attach {
	color: black;
	background-color:#E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

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
              height: 327,
              source: dataAdapter,
              editable: true,
              selectionmode: 'singlerow',
              columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              datafield: 'sr_no', width: '10%',cellsalign: 'center', align: 'center', editable: false	},
							{ text: 'Doc Type', datafield: 'extension', width: '10%', editable: false },
							{ text: 'Description', datafield: 'description', width: '60%', editable: false },
							{ text: 'File Name', datafield: 'filename', width: '20%', editable: false },
							{ text: 'File Location', datafield: 'path', width: '20%', editable: false,hidden:true }
	              ]
          });	
		 $('#jqxDocumentsAttach').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"));
              }); 
		 $('#jqxDocumentsAttach').on('rowclick', function (event) 
	               { 
	                var rowindexes=event.args.rowindex;
	                document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename");
	               });
	}
	 function ajaxFileUpload()  
	      {  
		  //check whether browser fully supports all File API
		    if (window.File && window.FileReader && window.FileList && window.Blob)
		    {
		        //get the file size and file type from file input field
		        var fsize = $('#file')[0].files[0].size;
		        
		        if(fsize>1048576) //do something if file size more than 1 mb (1048576)
		        {
		            //$.messager.alert('Message',fsize +' bites\nToo big!','warning');
		            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                 }); 
		            return;
		        }
		    }else{
		    	//$.messager.alert('Message','Please upgrade your browser, because your current browser lacks some new features we need!','warning');
		    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                     }); 
		        return;
		    }
	          $.ajaxFileUpload  
	          (  
	              {  
	                  url:'fileAttachAction.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&branchids=<%=request.getParameter("barchvals")%>&descpt='+$("#txtdesc").val() ,  
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
	                      
	                      $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
	                      }
	                     
	                      $("#testImg").attr("src",data.message);
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                        	  $.messager.show({title:'Message',msg: data.error,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }else  
	                          {  
	                        	  $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                	  $.messager.alert('Message',e);
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
	   //alert("repl"+repl);
	   //alert("after replace===="+repl);
	   fileURL=host+repl;
	   //alert("fileURL===="+fileURL);
	    // for non-IE
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        //alert(save);
	      //  alert(fileURL);
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
	function Delete(){
	     var filename=document.getElementById("filename").value;
	     /* var spltname = filename.split(".");
	     alert("==spltname==="+spltname[0]); */
	     <%-- alert("==filename=="+filename);
	     var dtype=<%=request.getParameter("formCode")%>;
	     alert("==dtype=="+dtype);
	     var doc_no=<%=request.getParameter("docno")%>;
	      --%>
	    
	     //alert("==doc_no=="+doc_no);
	  var x=new XMLHttpRequest();
	  var items,brchItems,currItems,mcloseItems;
	  x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	          items= x.responseText;
	          if(items>0){
	           funAttachBtn();
	           $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
                   style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
               }); 
	          }
	          else
	        	  {
	        	  $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
	                  style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	              });
	        	  }
	         
	          }
	   else
	    {
	    }
	  }
	  x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
	  x.send();
	 }
 
	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right"><label class="attach">Description</label></td>
    <td colspan="2"><input type="text" name="txtdesc" id="txtdesc" style="height:20px;width:100%;" value='<s:property value="txtdesc"/>'></td>
    <td align="right"><input type="file" id="file" name="file" /></td>  
    <td width="27%" align="center"> <button class="attachicon" id="btnsearch" title="Attach" onclick="return ajaxFileUpload();">
       <img alt="Attach" src="<%=contextPath%>/icons/attachicon.png">
      </button>
    <button class="attachicon" id="btnAttachDelete" title="Delete current Document" onclick="Delete();">
       <img alt="deleteDocument" src="<%=contextPath%>/icons/attachdelete.png">
      </button></td>
  </tr>
  
  <tr>
  
    <td colspan="5"> <div id="refreshdiv"><div id="jqxDocumentsAttach"></div></div>
    </td>
  </tr>
</table>
<input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
  </div>
</body>
</html>
