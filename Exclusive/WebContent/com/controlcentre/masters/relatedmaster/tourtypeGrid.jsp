<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.relatedmaster.tourtype.ClsTourDAO"%>
<%
ClsTourDAO cd=new ClsTourDAO();
%>

<% String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 
<% String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype");  %>
<script type="text/javascript">
	
	var driverdata;
    
	$(document).ready(function () {
      	
      	var temp='<%=docno%>'; 

      	
         	   driverdata='<%=cd.getTourGrid()%>'; 
         	
                
          // prepare the data
          var source =
          {
              datatype: "json",
              datafields: [                          	
   						{name : 'doc_no', type: 'string' },
   						{name : 'name', type: 'string' },
   						{name : 'code', type: 'string'  },
   						{name : 'refund', type: 'string'  },
   						{name : 'refundable', type: 'string'  },
   						{name : 'childmin', type: 'string'  },
   						{name : 'childmax', type: 'string'  },
   						{name : 'hghtmin', type: 'string'  },
   						{name : 'hghtmax', type: 'string'  },
   						{name : 'wghtmin', type: 'string'  },
   						{name : 'wghtmax', type: 'string'  },
   						{name : 'agemin', type: 'string'  },
   						{name : 'agemax', type: 'string'  },
   						{name : 'description', type: 'string'  },
   						{name : 'transport', type: 'string'  },
   						{name : 'private', type: 'string'  },
   						{name : 'transportion', type: 'string'  }
   					],
               localdata: driverdata,
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
                   alert(error);    
                   }
            });
          
          var list = ['GCC', 'IDP','UAE'];
        
          $("#jqxTourSearch").jqxGrid(
          {
              
              						
				
                        width: '99%',
                        height: 300,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			filterable: true,
             			showfilterrow: true,
             			columnsresize: true,
             			localization: {thousandsSeparator: ""},
             			
                        columns: [
        					 { text: 'Doc No', datafield: 'doc_no', width: '5%' },
        					 { text: 'Name', datafield: 'name', width: '50%' },
        					 { text: 'Code', datafield: 'code', width: '25%' },
        					 { text: 'Refundable', datafield: 'refund', width: '20%' },
        					 { text: 'Refundable', datafield: 'refundable', width: '20%' ,hidden:true},
        					 { text: 'Childmin', datafield: 'childmin', width: '20%' ,hidden:true},
        					 { text: 'Childmax', datafield: 'childmax', width: '20%' ,hidden:true},
        					 { text: 'Hghtmin', datafield: 'hghtmin', width: '20%' ,hidden:true},
        					 { text: 'Hghtmax', datafield: 'hghtmax', width: '20%' ,hidden:true},
        					 { text: 'Wghtmin', datafield: 'wghtmin', width: '20%' ,hidden:true},
        					 { text: 'Wghtmax', datafield: 'wghtmax', width: '20%' ,hidden:true},
        					 { text: 'Agemin', datafield: 'agemin', width: '20%' ,hidden:true},
        					 { text: 'Agemax', datafield: 'agemax', width: '20%' ,hidden:true},
        					 { text: 'Description', datafield: 'description', width: '20%' ,hidden:true},
        					 { text: 'transport', datafield: 'transport', width: '20%',hidden:true },
        					 { text: 'transportion', datafield: 'transportion', width: '20%' ,hidden:true},
        					 { text: 'private', datafield: 'private', width: '20%' ,hidden:true},
        					]
                    });
          //Add empty row          
         /*  if(temp==0){   
         	   $("#jqxTourSearch").jqxGrid('addrow', null, {});
          	 }   
            
             if(temp>0){
             	$("#jqxTourSearch").jqxGrid('disabled', true);
             } */
             $('#jqxTourSearch').on('rowdoubleclick', function (event) 
               		{ 
     		            	var rowindex1=event.args.rowindex;
     		            	$('#frmTourType input').attr('readonly', false );
		                    $('#frmTourType input').attr('disabled', false );
		                    $('#frmTourType select').attr('disabled', false );
		                    $('#btnterms').val("Edit");
		                    $("#jqxComTerms").jqxGrid({ disabled: true});   
		                    document.getElementById("hidchkprivate").value= $('#jqxTourSearch').jqxGrid('getcellvalue', rowindex1, "private");
		                    var chkprivate= $('#jqxTourSearch').jqxGrid('getcellvalue', rowindex1, "private");
		        			if(chkprivate>0){                   
		        					document.getElementById("chkprivate").checked=true;                                          
		        			}else{
		        				document.getElementById("chkprivate").checked=false;  
		        			}
		                    document.getElementById("docno").value= $('#jqxTourSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
     		                document.getElementById("code").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "code");
     		                document.getElementById("name").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "name");
     		                document.getElementById("refund").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "refundable");
     		                document.getElementById("childmin").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "childmin");
     		                document.getElementById("childmax").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "childmax");
     		                document.getElementById("hghtmin").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "hghtmin");
     		                document.getElementById("hghtmax").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "hghtmax");
     		                document.getElementById("wghtmin").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "wghtmin");
     		                document.getElementById("wghtmax").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "wghtmax");
     		                document.getElementById("agemin").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "agemin");
     		                document.getElementById("agemax").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "agemax");
     		                document.getElementById("desc").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "description");
     		                
     		              document.getElementById("transportation").value = $("#jqxTourSearch").jqxGrid('getcellvalue', rowindex1, "transportion");
     		                var indexVal1 = document.getElementById("docno").value;  
		                    var qbrhid=<%=session.getAttribute("BRANCHID")%>;            
	 	                    $("#comtermsDiv").load("termsGrid.jsp?qbrhid="+qbrhid+"&qotdoc="+indexVal1); 
     		                $('#window').jqxWindow('close');
     		                 }); 
     		  
    
   
});
      
</script>
<div id="jqxTourSearch"></div>
 <input type="hidden" id="gridrowindex" name="gridrowindex"/>
<input type="hidden" id="chkvalid" name="chkvalid"> 