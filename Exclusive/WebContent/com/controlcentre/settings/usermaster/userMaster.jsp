<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  $("#jqxUserMasterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  $('#roleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    	  $('#roleDetailsWindow').jqxWindow('close');
    	  
    	  $('#txtpasswordconfirm').on('keyup', function () {
        	 // alert($(this).val() == $('#txtuserpassword').val());
        	    if ($(this).val() == $('#txtuserpassword').val()) {
        	    	//alert("in");
        	        $('#message').html('Matching').css('color', 'green');
        	    } else $('#message').html('Not Matching').css('color', 'red');
        	});
    	   
    	       
    	  $('#txtbrole').dblclick(function(){
  	  	    $('#roleDetailsWindow').jqxWindow('open');
  	   
  	  	roleSearchContent('userRoleSearchGrid.jsp?', $('#roleDetailsWindow')); 
         
    	  
    	  });
      });
     
      
      
      
      function roleSearchContent(url) {
          $('#roleDetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
       $('#roleDetailsWindow').jqxWindow('setContent', data);
       $('#roleDetailsWindow').jqxWindow('bringToFront');
      }); 
       
      }
     
		function funReadOnly(){
			$('#frmUserMaster input').attr('readonly', true );
			$('#frmUserMaster select').attr('disabled', true );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: true});
			
			
		}
		function funFocus(){
			$('#jqxUserMasterDate').jqxDateTimeInput('focus'); 
		}
		function funRemoveReadOnly(){
			$('#frmUserMaster input').attr('readonly', false );
			$('#frmUserMaster select').attr('disabled', false );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			$('#docno').attr('readonly', true);
			
			$('#txtbrole').attr('readonly', true);
			if($('#mode').val()=="A")
				{
				 $('#jqxUserMasterDate').val(new Date());
			 $("#userMasterDiv").load("userMasterGrid.jsp");
			  
			
				}
			
			if ($("#mode").val() == "E") {
				if(document.getElementById("permissionval").value==1)
					{
					
				/*     $("#jqxUserMaster").jqxGrid('clear');	 */
				/* 	 var docnumber=document.getElementById("docno").value;
					 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);  */
			    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
			    	 /*   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
					 $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); */ 
					}
			}
			
			if ($("#mode").val() == "D") {
				
				
				$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			}
			
			 getLang();
			
		}

		function getLang() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					items = items.split('####');
					var langItems = items[0].split(",");
					var optionslang = '';
					for (var i = 0; i < langItems.length; i++) {
						optionslang += '<option value="' + langItems[i] + '">'
								+ langItems[i] + '</option>';
					}
					
					$("select#cmblanguage").html(optionslang);
					
					if ($('#langval').val()!="") {
						
					
						var aa=$('#langval').val().trim();
						
					    $('#cmblanguage').val(aa) ;
			            
			            }
			
					
				} else {
				}
			}
			x.open("GET", "getLang.jsp", true);
			x.send();
		}
		
		
		function funSearchLoad()
		{
		 changeContent('masterSearchuser.jsp'); 
		}
		
		
		function checkUserid() {
		
			var userid=document.getElementById("txtuser").value;
			
			  var masterdoc=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("useridchk").value=1;				 		
				 			document.getElementById("errormsg").innerText="User ID Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("useridchk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUserid.jsp?userid="+userid+"&masterdoc="+masterdoc, true);
			x.send();
		}
		
		function checkUsername() {
		
			var username=document.getElementById("txtusername").value;
			
			  var masterdocs=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("usernamechk").value=1;		
				 			document.getElementById("errormsg").innerText="User Name Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("usernamechk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUsername.jsp?username="+username+"&masterdocs="+masterdocs, true);
			x.send();
		}
		
		
		$(function(){
		    $('#frmUserMaster').validate({
		             rules: {
		            	 txtuser:{
		                	 required:true,maxlength:10
		                 },
		                 txtusername:{
		                	 required:true,maxlength:30
		                 },
		               
		            	 txtuserpassword:{
		                	 required:true,maxlength:100
			                 },
			             txtpasswordconfirm:{
		                	 required:true
			                 },
			                 
			                 txtusermail:"required"
		            
		             },
		             messages: {
		            	 txtuser:{
		            		 required:" *required",maxlength:"max 10 chars"
		                 },
		                 txtusername:{
		                	 required:"*required",maxlength:" max 30 chars"
		                 },
		              
		            	 txtuserpassword:{
		                	  required:" *required",maxlength:" max 100 chars"
		                  },
		                  txtpasswordconfirm:{
		                	  required:" *required"
				                 },
				                 txtusermail:" *Enter Valid Email",          
				  
		             }
		    });
		    });
		
		  function funNotify(){
			
			 
           var useridchk= document.getElementById("useridchk").value;
			 
			 if(parseInt(useridchk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User ID Already Exists";
				 document.getElementById("txtuser").focus();
		 			return  0;
				 
				 }
              var usernamechk= document.getElementById("usernamechk").value;
			 
			 if(parseInt(usernamechk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User Name Already Exists";
				 document.getElementById("txtusername").focus();
		 			return  0; 
				 
				 }
			 var levelss= document.getElementById("levels").value;
			 if(levelss=="")
				 {
				 document.getElementById("errormsg").innerText="Select Discount Level";
				 document.getElementById("levels").focus();
		 			return  0; 
				 }
			 var rolelevel= document.getElementById("txtbrole").value;
			 if(rolelevel=="")
				 {
				 document.getElementById("errormsg").innerText="Select Role";
				 document.getElementById("txtbrole").focus();
		 			return  0; 
				 }
			 
			 
			 if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val())
				 {
				 
				 document.getElementById("errormsg").innerText="Password Is Not Matching";
		 			return  0; 
				 }
			
			 
			 
			    if($('#cmpermission').val()==1)

		    	   {	   			    
			   var z=0;
		       var rows = $("#jqxUserMaster").jqxGrid('getrows');                    
		           
		       var selectedRecords = new Array();
		       var selectedrows=$("#jqxUserMaster").jqxGrid('selectedrowindexes');
		      
			  if(selectedrows.length==0){
			   $.messager.alert('Warning','Select Branch & Company.');
			   return false;
			  }
		  
		      $('#existusermaster').val(selectedrows.length);
		    /*   alert("Length = "+$('#existusermaster').val()); */
		      for (var i = 0; i < rows.length; i++) {
		      for(var j=0;j<selectedrows.length;j++){
		       if(selectedrows[j]==i){
		        
		        newTextBox = $(document.createElement("input"))
		           .attr("type", "dil")
		           .attr("id", "test"+z)
		           .attr("name", "test"+z)
		           .attr("hidden","true");
		        
		       newTextBox.val(rows[i].brhid+"::"+rows[i].compid);
		     /*   alert("newTextBox.val() = "+newTextBox.val()); */
		       newTextBox.appendTo('form');
		       z++;
		       }
		      }
		   }
		    
		    	   }
		
		    
			    return 1;
		} 
		  
	
	       function getURole(event){
	              var x= event.keyCode;
	              if(x==114){
	               roleSearchContent('userRoleSearchGrid.jsp');
	              }
	              else{
	               }
	              }
	     function fungriddis()
	     {
	       
	       if($('#cmpermission').val()==1)

	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
	    	   
	    	   
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   
	    	   }
	       else
	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: true}); 
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   }
	     }
	     
	   
	     function checkvals()
	     {
	     
	 
	   if($('#permissionval').val()!="")
	  {
	  
	 
	  $('#cmpermission').val($('#permissionval').val());
	  }
	   
	   if($('#hidelevels').val()!="")
	  {
	 
	  $('#levels').val($('#hidelevels').val());
	  }
	     
	   
	   
	   
	   
	     }

	     
		function setValues() {
			if($('#hidjqxUserMasterDate').val()){
				$("#jqxUserMasterDate").jqxDateTimeInput('val', $('#hidjqxUserMasterDate').val());
			}
			var docnumber=document.getElementById("docno").value;
			
			if(parseInt(docnumber)>0)
				{ 
				
		
				 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);
			}  
			
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
		    }
			
			
			 getLang();
	        checkvals();
			document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			funSetlabel();
			
		
			
		}

		
  </script>
</head>
<body onload="setValues();getLang();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>
<fieldset><legend>User Master Info</legend>
<table width="100%" >
  <tr>
    <td width="6%" align="right">Date</td>
    <td colspan="4"><div id='jqxUserMasterDate' name='jqxUserMasterDate' value='<s:property value="jqxUserMasterDate"/>'></div>
                   <input type="hidden" id="hidjqxUserMasterDate" name="hidjqxUserMasterDate" value='<s:property value="hidjqxUserMasterDate"/>'/></td>
    <td width="16%" align="right"></td>
    
    <td width="44%" align="center" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    Doc No <input type="text" id="docno" name="docno" style="width:23%;"  tabindex=-1; value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
    <td align="right">User ID</td>  
    <td width="16%"><input type="text" id="txtuser" name="txtuser" style="width:50%;" placeholder="Enter user ID" value='<s:property value="txtuser"/>' onblur="checkUserid()"/></td>
    <td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    User Name &nbsp;<input type="text" id="txtusername" name="txtusername" placeholder="Enter user Name" style="width:60%;" value='<s:property value="txtusername"/>' onblur="checkUsername()"/>
  </td>
<!--     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
     <td>&nbsp;Discount Level&nbsp;<select id="levels" name="levels" style="width:25%;" value='<s:property value="levels"/>' >    
     <option value="" >--Select--</option> 
      <option value=1>Level 1</option>
       <option value=2>Level 2 </option>
        <option value=3>Level 3</option>
        
       </select>
    
    </td>   
  </tr>
  <tr>
    <td align="right">Role</td>
          <td colspan="4"><input type="text" id="txtbrole" name="txtbrole"  style="width:58%;" placeholder="Press F3 to Search" value='<s:property value="txtbrole"/>' placeholder="Press F3 to Search"  onkeydown="getURole(event);" />
         <input type="hidden" id="txtroleid" name="txtroleid" value='<s:property value="txtroleid"/>'/></td>
    <td align="right">&nbsp;</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Language&nbsp;<select id="cmblanguage" name="cmblanguage" style="width:25%;" value='<s:property value="cmblanguage"/>' >    
     <%--  <option value="-1">--Select--</option> --%></select>
      <input type="hidden" id="hidcmblanguage" name="hidcmblanguage" value='<s:property value="hidcmblanguage"/>'/></td>
  </tr>
  <tr>
    <td align="right">Email</td> 
    <td colspan="4"><input type="email" id="txtusermail" name="txtusermail"  style="width:58%;" placeholder="Email" value='<s:property value="txtusermail"/>' />&nbsp;&nbsp;
  <%--   <span STYLE="font-weight: bold" id='message1'></span> --%>
     <td align="right">&nbsp;</td>
     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Permission&nbsp;<select id="cmpermission" name="cmpermission" style="width:25%;" value='<s:property value="cmpermission"/>' onchange="fungriddis()">    
      <option value="0">All Branch</option>
       <option value="1">Selected Branch  </option></select>
      <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>  
    </td>    
  </tr>
  <tr>
  <td align="right">E-mail Password</td> 
    <td colspan="4"><input type="password" id="txtmailpswd" name="txtmailpswd"  style="width:58%;" placeholder="Email Password" value='<s:property value="txtmailpswd"/>' />&nbsp;&nbsp;
  <%--   <span STYLE="font-weight: bold" id='message1'></span> --%>
     <td align="right">&nbsp;</td>
     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Signature&nbsp;<input type="text" id="txtmailsign" placeholder="Email Signature" name="txtmailsign" style="width:55%;" value='<s:property value="txtmailsign"/>' >    
            <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>  
    </td>
  </tr> 
  <tr>
  <td align="right">E-mail Host</td> 
    <td colspan="4"><input type="text" id="txtmailhost" name="txtmailhost"  style="width:58%;" placeholder="Email Host" value='<s:property value="txtmailhost"/>' />&nbsp;&nbsp;
  <%--   <span STYLE="font-weight: bold" id='message1'></span> --%>
     <td align="right">&nbsp;</td>
     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E-mail Port&nbsp;<input type="text" id="txtmailport" placeholder="Email Port" name="txtmailport" style="width:32%;" value='<s:property value="txtmailport"/>' >    
            <input type="hidden" id="hidcmpermission" name="hidcmpermission" value='<s:property value="hidcmpermission"/>'/>  
    </td>
  </tr>  
  <tr>
    <td align="right">Password</td> 
    <td colspan="4"><input type="password" id="txtuserpassword" name="txtuserpassword" style="width:40%;font-size:10px;height:122%;" placeholder="Enter Password" value='<s:property value="txtuserpassword"/>'/></td>  
    <td align="right">&nbsp;</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Confirm&nbsp;<input type="password" id="txtpasswordconfirm" name="txtpasswordconfirm" style="width:32%;font-size:10px;height:122%;" placeholder="Enter Confirm Password" value='<s:property value="txtpasswordconfirm"/>'/>&nbsp;&nbsp;
    <span STYLE="font-weight: bold" id='message'></span>
    </td>  
  </tr>
</table><br/>
</fieldset><br/>
<div id="userMasterDiv" align="center"><jsp:include page="userMasterGrid.jsp"></jsp:include></div>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="useridchk" name="useridchk"  value='<s:property value="useridchk"/>'/>
<input type="hidden" id="usernamechk" name="usernamechk"  value='<s:property value="usernamechk"/>'/>


<input type="hidden" id="langval" name="langval"  value='<s:property value="langval"/>'/>
<input type="hidden" id="permissionval" name="permissionval"  value='<s:property value="permissionval"/>'/> 


 <input type="hidden" id="existusermaster" name="existusermaster" value='<s:property value="existusermaster"/>'/>
  <input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>
</form>
<div id="roleDetailsWindow">
 <div></div>
</div>
</div>
</body>
</html>