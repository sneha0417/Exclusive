<%@page import="com.common.ClsExeFolio" %>
<%ClsExeFolio cef=new ClsExeFolio(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" import="java.util.*" %>
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
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
 <% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
 <% String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype"); %>
 <% String brch = request.getParameter("brch")==null?"0":request.getParameter("brch"); %>
 <% String userid = request.getParameter("userid")==null?"0":request.getParameter("userid");%>
 <% String aprstatus = request.getParameter("aprstatus")==null?"0":request.getParameter("aprstatus");%>
 <% String isfirstappr = request.getParameter("isfirstappr")==null?"0":request.getParameter("isfirstappr"); %>
 
 <style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
    .greyClass
    {
        background-color: #D8D8D8;
    }
        
    .icon {
		width: 2.5em;
		height: 3em;
		border: none;
		background-color: #E0ECF8;
    }
     
     select.list1
{
    background-color: #99CCFF;
    font-size: 130%;
}
        
</style>


	<script type="text/javascript">
	$(document).ready(function(){
		getStatOpt();
		funcurdate();
	 	
		var data4='<%=cef.approvalGridload(session,dtype,brch,docNo)%>';
		//alert("===data4===="+data4);
		Check(data4);
			});	
	
	function Check(data4){
		   
		
		  var source =
          {
              datatype: "json",
              datafields: [
						{name : 'apprtype', type: 'String'   },
							{name : 'user_name', type: 'string'  }, 
      						{name : 'apprdatetime', type: 'string'   },
      						{name : 'remarks', type: 'string'   },
      						{name : 'apprlevel', type: 'string'   }
   						     						
               ],
               localdata: data4, 
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
		  
		  var cellclassname = function (row, column, value, data) {
      		if (data.apprlevel==1) {
                  return "redClass";
              } else if (data.apprlevel==2) {
                  return "yellowClass";
              }
              else{
              	return "greyClass";
              };
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
          
          $("#jqxApprovalGrid").jqxGrid(
          {
              width: '100%',
              height: 250,
              source: dataAdapter,
              columnsresize: true,
              editable: false,
              rowsheight:40,
              selectionmode: 'singlerow',
              columns: [
				{ text: '', datafield: 'apprtype',  width: '10%',cellclassname: cellclassname },
				{ text: 'User', datafield: 'user_name', width: '15%',cellclassname: cellclassname },
				{ text: 'Submit Time', datafield: 'apprdatetime', width: '12%',cellclassname: cellclassname },	
				{ text: 'Remarks' , datafield: 'remarks', width: '63%',cellclassname: cellclassname },
				{ text: 'ApprlLevel', datafield: 'apprlevel', hidden:true , width: '10%',cellclassname: cellclassname },
							
          ]
          });	
		 $('#jqxApprovalGrid').on('rowdoubleclick', function (event) 
              { 
               var rowindexes=event.args.rowindex;
               /* SaveToDisk($('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename")); */
              }); 
		 
		 $('#jqxApprovalGrid').on('rowclick', function (event) 
	              { 
	               var rowindexes=event.args.rowindex;
	               /* document.getElementById("filename").value= $('#jqxDocumentsAttach').jqxGrid('getcellvalue', rowindexes, "filename"); */
	              });
		 $("#jqxApprovalGrid").jqxGrid('autoresizecolumns');
	}
	 function saveApprlevel()  
	      {  
		
		 setTimeout(function() {$("#btnSend").attr("disabled", true);},1000);
		 var uri=encodeURI('saveApprove.action?docno='+$("#hidocno").val()+'&dtype='+$("#hidtype").val()+'&userid='+$("#hiuserid").val()+'&brchid='+$("#hibrchid").val()+'&desc='+$("#apprdesc").val()+'&apprlevel='+$("#apprlevel").val()+'&minapprl='+$("#minapprl").val()+'&optid='+$("#optid").val()+'&apprlist='+$("#apprlist").val());
		 //alert(uri);
		  /*  var reftypid=document.getElementById("reftypid").value; */     
			/* alert("===docno==="+$("#hidocno").val()+"===&dtype="+$("#hidtype").val()+"&userid===="+$("#hiuserid").val()+"==&brchid="+$("#hibrchid").val()+"===&desc="+$("#apprdesc").val()); */
	          $.ajaxFileUpload  
	          (    
	              {  
	                  url: uri,
	                  secureuri:false,//false  
	                  fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	                  dataType: 'String',// json  
	                  success: function (data, status)  //  
	                  {  
	                      //alert(data.message);//jsonmessage,messagestruts2
	                 	
	               //       $('#refreshdiv').load();
	                     
	                     if(status=='success'){   
	                    	 // funApproveBtn();
	                    	/*  getapprcount(); */
	                         $.messager.show({title:'Message',msg:'Transaction Completed',showType:'show',
	                            style:{left:15,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        });
	                         $("#windowapprove").jqxWindow('Close');     
	                      }
	                     
	                      if(typeof(data.error) != 'undefined')  
	                      {  
	                          if(data.error != '')  
	                          {  
	                              //$.messager.alert('Message',data.error);
	                              $.messager.show({title:'Message',msg: data.error,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	                        }); 
	                          }else  
	                          {  
	                              //$.messager.alert('Message',data.message);
	                              $.messager.show({title:'Message',msg: data.message,showType:'show',
		  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
		  	                        }); 
	                          }  
	                      }  
	                  },  
	                  error: function (data, status, e)//  
	                  {  
	                      //alert(e);  
	                      $.messager.alert('Message',e);
	                  }  
	              }  
	          )  
	          return false;  
	      }
		

	function funcurdate(){
	var currentdate=new Date();
	var date = currentdate.getDate()+ "/"+ (currentdate.getMonth()+1)+ "/"+currentdate.getFullYear(); 
    var time= currentdate.getHours() + ":"+currentdate.getMinutes();
   /*  + currentdate.getSeconds();
	alert("===datetime======"+datetime); */
	
    document.getElementById("apprdate").value=date;
    document.getElementById("apprtime").value=time;
    document.getElementById("hidocno").value='<%=docNo%>';
    document.getElementById("hidtype").value='<%=dtype%>';
    document.getElementById("hiuserid").value='<%=userid%>';
    document.getElementById("hibrchid").value='<%=brch%>';
     getapprlevel();
	}
	
	function gridLoad(){
		var aprstatus='<%=aprstatus%>';
		var isfirstappr='<%=isfirstappr%>';
		var apprlevel=document.getElementById('apprlevel').value;
		
		  if((parseInt(isfirstappr)==0)){
			$('#optdiv').hide();
		} 
		  
		  if((parseInt(aprstatus)==0)){
			  $('#masdiv').hide();
			} 
		
	}
	
	function getapprlevel(){
		
		var docno=document.getElementById('hidocno').value;
		var dtype=document.getElementById('hidtype').value;
		var brch='<%=session.getAttribute("BRANCHID")%>';
		var usrid='<%=session.getAttribute("USERID")%>';
		var isfirstappr='<%=isfirstappr%>';
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 		var apprlevel = items[1];
			 		var minapprl= items[2];
			 		var apprlist= items[3];
			 		document.getElementById('apprlevel').value=apprlevel;
			 		document.getElementById('minapprl').value=minapprl;
			 		document.getElementById('apprlist').value=apprlist;
			 		gridLoad();
			 		//alert("===apprlevel===="+apprlevel);
					
				}
		       else
			  {}
	     }
	      x.open("GET", <%=contextPath+"/"%>+"com/common/getApprLevel.jsp?docno="+docno+"&dtype="+dtype+"&brch="+brch+"&usrid="+usrid+"&isfirstappr="+isfirstappr,true);
	     x.send();
	    
	   }
	
	function getStat(c){
			
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	items = items.split('####');
			 	
			 		var reftype = items[0].split(",");
			 		var refcode  = items[1].split(",");
			 		var refdocno  = items[2].split(",");
			 		
			 		document.getElementById("optid").value=refdocno;
			    }
		       else
			  {}
	     }
	      x.open("GET", <%=contextPath+"/"%>+"com/common/getStat.jsp?opt_name="+c,true);
	     x.send();
	    
	   }
	
	function getStatOpt()
	{	
		
		
	var x=new XMLHttpRequest();
	var items,refname,refcode,refdocno;
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{  
	        items= x.responseText;
	        items=items.split('####');
	        
	        refname=items[0].split(",");
	        refcode=items[1].split(",");
	        refdocno=items[2].split(",");
	       
	        	var optionref = '';
	        	var optionscurr = '';
	       for ( var i = 0; i < refname.length; i++) {
	    	   
	    	   
	    	   getStat(refname[0]);
	    	   optionref += '<option value="' + refname[i] + '">' + refname[i] + '</option>';
	    	  
	        }
	       $("select#optname").html(optionref); 
	       
	        	
	        }
		else
			{
			}
	}
	x.open("GET",<%=contextPath+"/"%>+"com/common/getStatOpt.jsp",true);
	x.send();
	}
	 
	</script>
	
	
<body>
<div id=search>
 <table width="100%">
 <tr>
    <td>
     <div id="masdiv"><table width="100%">
    <tr>
    <td width="21%" align="right"><b>Date:</b></td>
    <td width="15%"><input type="text" name="apprdate" id="apprdate" style="width:90%" readonly value='<s:property value="apprdate"/>'></td>
    <td width="64%"><input type="text" name="apprtime" id="apprtime" style="width:30%" readonly value='<s:property value="apprtime"/>'></td>
  </tr>
  <tr>
    <td colspan="3"><textarea maxlength="540" id="apprdesc" style="height:85px;width:98%;font: 10px Tahoma;resize:none"  name="apprdesc" ><s:property value="apprdesc" ></s:property></textarea></td>
  </tr>
  <tr>
  
    <td colspan="2"><div id="optdiv"><table width="100%">
  <tr>
    <td align="right"><b>Status</b></td>
    <td><select name="optname"  class="list1" id="optname"  onchange="getStat(this.value);"></select></td>
  </tr>
</table></div></td>
    <td colspan="2" align="left"><button class="myButton" type="button" id="btnSend" name="btnSend" onClick="saveApprlevel()">SUBMIT</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table></div>
</td>
  </tr>
  <tr>
    <td align="center"><div id="refreshdiv"><div id="jqxApprovalGrid"></div></div>
    <input type="hidden" id="optid"/>
    <input type="hidden" id="hidtype"/>
    <input type="hidden" id="hidocno"/>
    <input type="hidden" id="hiuserid"/>
    <input type="hidden" id="hibrchid"/>
    <input type="hidden" id="apprlevel"/>
    <input type="hidden" id="minapprl"/>
    <input type="hidden" id="apprlist"/></td>
  </tr>
</table>
 
 
 
 </div>
 
  
</body>

</html>
