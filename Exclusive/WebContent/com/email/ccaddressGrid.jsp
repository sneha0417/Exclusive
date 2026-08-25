<%@page import="com.email.ClsEmailDAO" %> 
<%ClsEmailDAO ced=new ClsEmailDAO(); %>
 

     <%-- <jsp:include page="../../includes.jsp"></jsp:include> --%> 
  <%@page import="javax.servlet.http.HttpSession" %>    
 <%
 //System.out.println("=dtype==dtype==="+request.getParameter("dtype"));
 String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 int value = Integer.parseInt(request.getParameter("value"));
 
%>    
     
  <script type="text/javascript">
    var data= '<%=ced.addressbook(session,name,dtype)%>';
    //alert("==================data");
         var num='<%=value%>';
         //alert(data);
    $(document).ready(function () { 	
    	    
            
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'String'  },
							{name : 'e_mail', type: 'String'  },
							{name : 'dtype', type: 'String'  }
						
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
            $("#jqxccaddressGrid").jqxGrid(
            {
            	width: '100%',
                height: 260,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:true,
               columns: [
   
					{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '40%' },    
					{ text: 'E-mail ID',columntype: 'textbox', filtertype: 'input', datafield: 'e_mail', width: '40%' },
					{ text: 'Doc Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtype', width: '15%' }
	              ]
            });
            
            $("#jqxccaddressGrid").bind('cellendedit', function (event) {
                if (event.args.value) {
                    $("#jqxccaddressGrid").jqxGrid('selectrow', event.args.rowindex);
                }
                else {
                    $("#jqxccaddressGrid").jqxGrid('unselectrow', event.args.rowindex);
                }
            });
        });
            function funUpdate(){
            	var temp="";
		        var rows = $("#jqxccaddressGrid").jqxGrid('selectedrowindexes');
              //alert(rows.length);
                var selectedRecords = new Array();
                for (var m = 0; m < rows.length; m++) {
                    var row = $("#jqxccaddressGrid").jqxGrid('getrowdata', rows[m]);
                    //alert("==row===="+ row.service);
                    var rowlength=$("#jqxccaddressGrid").jqxGrid('rows').records.length;
                    /* alert("row.serid"+row.e_mail);
                    alert("mmmmmmm"+m); */
                    //alert("grid data"+$('#jqxccaddressGrid').jqxGrid('getcellvalue', m, "e_mail"));
                   
				            	  //temp=temp+","+$('#jqxccaddressGrid').jqxGrid('getcellvalue', m, "e_mail");
				            	  if(m==0){
				            		  temp=row.e_mail;
				            	  }
				            	  else{
				            		  temp=temp+","+row.e_mail;
				            	  }
				            	  
				               //alert("==num===="+num);
				               if(num==0){
				            	   document.getElementById("recipient").value=temp;
				               }
				               if(num==1){
				            	   document.getElementById("CC").value=temp;
				               }
				               if(num==2){
				            	   document.getElementById("BCC").value=temp;
				               }
				               
                    //selectedRecords[selectedRecords.length] = row;
                }
                //alert("window close");
                $('#ccaddressWindow').jqxWindow('close');
            }; 
           
        
    </script>
    <div id=jqxccaddressGrid></div>
    
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
</head>
 <body bgcolor="#E0ECF8">
<div id=btnok>
<table width="100%" >
  <tr >
   <td align="left"><input type="button" name="btnOk" id="btnOk" class="myButton" value="OK" onclick="funUpdate();"></td>
   </tr></br>
   </table>
   </div>
   </body>
   </html>
