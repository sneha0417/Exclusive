  
<%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>

<%

ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String tenant = request.getParameter("tenant")==null?"NA":request.getParameter("tenant");
String pname = request.getParameter("pname")==null?"NA":request.getParameter("pname");
String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");  
String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions");  
String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
String brhid = request.getParameter("brhid")==null?"":request.getParameter("brhid"); 
%>
<script type="text/javascript">

var datamain11= [];
if(aa="yes"){
	datamain11='<%=DAO.materearch(session,docnoss,tenant,pname,datess,aa,descriptions,refnoss,brhid) %>';	
}

        $(document).ready(function () {                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },                            
                            {name : 'voc_no', type: 'int'   },                         
                            {name : 'date', type: 'date'   },     					 
     						{name : 'refname', type: 'string'   }, 
     						{name : 'pname', type: 'string'   },
     						{name : 'prid', type: 'string'   },
     						{name : 'tel', type: 'string'   },     					 
     						{name : 'mob', type: 'string'   }, 
     						{name : 'email', type: 'string'   },
     						{name : 'owner', type: 'string'   },  
     						{name : 'cldocno', type: 'int'   },
     						{name : 'pdocno', type: 'int'   },
     						{name : 'unitno',type:'string'}
                        ],
                		localdata: datamain11, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid1").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,           
                selectionmode: 'singlerow',                
                columns: [                
							{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Tenant ', datafield: 'refname', width: '24%'  },
							{ text: 'Unit No', datafield: 'unitno', width: '6%'},
							{ text: 'Property', datafield: 'pname' },
							{ text: 'prid', datafield: 'prid', width: '6%',hidden:true },
							{ text: 'tel', datafield: 'tel', width: '6%',hidden:true },
							{ text: 'mob', datafield: 'mob', width: '6%',hidden:true },
							{ text: 'email', datafield: 'email', width: '6%',hidden:true },
							{ text: 'owner', datafield: 'owner', width: '6%',hidden:true },
							{ text: 'tenantid', datafield: 'tenantid', width: '6%',hidden:true },
							{ text: 'tenant docno', datafield: 'cldocno', width: '6%',hidden:true },  
							{ text: 'tenant docno', datafield: 'pdocno', width: '6%',hidden:true },  
						]
            });
            
             $('#searshgrid1').on('rowdoubleclick', function (event) {    
             var rowindex1 = event.args.rowindex;
                
           	 document.getElementById("docno").value = $('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
        	 var tdocno=$('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "cldocno");
        	 var pdocno=$('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "pdocno");
        	 
        	 $('#txttenantdocno').val(tdocno);
        	 $('#txttenant').val($('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "refname"));
         
             $('#txtpropertydocno').val(pdocno);
             $('#txtproperty').val($('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "pname"));
        	 
        	 var str='';
        	 $('#propertydet').empty(); 
             str+=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "prid");
             str+='<br>';
             str+='Owner:' + $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "owner"); 
             $('#propertydet').append(str);  
             
             var str1='';
             $('#tenantdet').empty();
             str1+=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "refname");
             str1+='<br>';
             str1+='Tel:' + $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "tel");
             str1+='<br>';
             str1+='Mob:' + $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "mob");
             str1+='<br>';             
             if($('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "email") !='' || $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "email") !='undefined' || $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "email") !='null')
             {
             str1+='Email:' + $('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "email");
             }           
             $('#tenantdet').append(str1);  
           
             
             // Load Three Grids
             var docno=$('#searshgrid1').jqxGrid('getcellvalue', rowindex1, "doc_no");             
             $('#termsOfContractDiv').load("termsOfContractGrid.jsp?docno="+docno);
             $('#agentDiv').load("agentGrid.jsp?docno="+docno) ;
   		     $('#paymentDistributionDiv').load("paymentDistributionGrid.jsp?docno="+docno) ; 
        	 
        	 
   		     
   		     $('#window').jqxWindow('close');  
             	 
             funSetlabel();
              document.getElementById("frmTenancyContract").submit();
           	 
            }); 
             
        });
    </script>
    <div id="searshgrid1"></div>