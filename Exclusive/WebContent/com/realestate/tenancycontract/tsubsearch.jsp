<%-- <%
String item1 = request.getParameter("item1")==null?"NA":request.getParameter("item1");

%> --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
 <%
 ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String rno = request.getParameter("rno")==null?"0":request.getParameter("rno");
 String contact =request.getParameter("contact")==null?"0":request.getParameter("contact");
%> 
 <script type="text/javascript">
 
 var loaddata;
  <%--if('NA' != '<%=item1%>')  {
	 loaddata = '<%=item1%>';
 }
 alert("radata"+loaddata); --%>
 
 loaddata='<%=DAO.clientSrearch(session,sclname,smob,rno,contact)%>';
               
        $(document).ready(function () {  
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                              
     						{name : 'refname', type: 'String'  },
     						{name : 'com_mob', type: 'String'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'contact', type: 'String'  },
      						{name : 'tel', type: 'String'  },
      						{name : 'mob', type: 'String'  }, 
      						{name : 'email', type: 'String'  } 
                          	],
                          	localdata: loaddata, 
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true, 
                selectionmode: 'singlerow', 
                //Add row method
	 
                columns: [
                     	 { text: 'Doc No', datafield: 'cldocno', width: '10%'  },
						 { text: 'NAME', datafield: 'refname'  }, 
						 { text: 'MOB', datafield: 'com_mob', width: '20%' }, 
						 { text: 'CONTACT', datafield: 'contact', width: '20%' },
						 { text: 'mob', datafield: 'mob' ,hidden:true }, 
						 { text: 'tel', datafield: 'tel', width: '20%' ,hidden:true}, 
						 { text: 'email', datafield: 'email', width: '20%' ,hidden:true}
					 
					]
            });
    
            //$("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
           { 
        	  var rowindex1=event.args.rowindex;
          
               document.getElementById("txttenantdocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
               document.getElementById("txttenant").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname");
              
                 var str='';
                 $('#tenantdetail').empty();
                 str+=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname");
                 str+='<br>';
                 str+='Tel:' + $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "tel");
                 str+='<br>';
                 str+='Mob:' + $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "mob");
                 str+='<br>';
                 
                 if($('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "email") !='' || $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "email") !='undefined' || $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "email") !='null')
                 {
                 str+='Email:' + $('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "email");
                 }
               
               $('#tenantdetail').append(str);  
              
                $('#refnosearchwindow1').jqxWindow('close');  
               
            
        });	 
           
    
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
