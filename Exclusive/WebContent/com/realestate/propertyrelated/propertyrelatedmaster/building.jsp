<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
 <%@page import="com.realestate.propertyrelated.propertyrelatedmaster.ClsPropertyRelatedMasterDAO"%>
<%ClsPropertyRelatedMasterDAO DAO= new ClsPropertyRelatedMasterDAO();%> 

<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
		$('#date').on('change', function (event) {
			  
 		    var maindate = $('#date').jqxDateTimeInput('getDate');
 		  	 if ($("#mode").val() == "A" || $("#mode").val() == "E" ) {   
 		    funDateInPeriodchk(maindate);
 		  	 }
 		   });
	    $('#btnSearch').attr('disabled', true);
  	  $('#areainfowindow').jqxWindow({ width: '55%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Area Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	  $('#areainfowindow').jqxWindow('close');
	    document.getElementById("formdet").innerText="Building(RLB)";
		document.getElementById("formdetail").value="Building";
		document.getElementById("formdetailcode").value="RLB";
		window.parent.formCode.value="RLB";
		window.parent.formName.value="Building";
 		var datab = '<%=DAO.Load(session)%>';
 
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
     						{name : 'plno', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                        	{name : 'areadocno', type: 'String'  },
     						{name : 'area', type: 'String'  },
     						{name : 'city_name', type: 'String'  },
     						{name : 'country_name', type: 'String'  },
     						{name : 'region_name', type: 'String'  }
                          	
       
                          	
                 ],
               localdata: datab,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxb1").jqxGrid(
                    {
                    	width: '100%',
                       height: 275,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Docno', datafield: 'doc_no', width: '8%' },
        					{ text: 'Date' , datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Name' , datafield: 'name' },
        					{ text: 'Plot Number' , datafield: 'plno', width: '25%' },
        					{ text: 'AREA', datafield: 'area', width: '20%' },
        					{ text: 'State', datafield: 'city_name', width: '25%',hidden:true  },
        					{ text: 'Country', datafield: 'country_name', width: '25%' ,hidden:true },
        					{ text: 'Region', datafield: 'region_name', width: '20%',hidden:true }
        					
        	              ]
                    });
            $('#jqxb1').on('rowdoubleclick', function (event) {
             var rowindex1=event.args.rowindex;
             
            //  docno plotnumber txtarea txtareadet txtareaid
             	if ($("#mode").val() != "A") 
             		
             		{
                document.getElementById("docno").value= $('#jqxb1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("plotnumber").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "plno");
                document.getElementById("name").value = $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "name");
                
       
                
          	  var temp="";
        	  temp=temp+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "country_name");
            temp=temp+","+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "region_name");
           
      
            	
	            	document.getElementById("txtareadet").value=temp; 
	                document.getElementById("txtareaid").value=$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "areadocno");
	               document.getElementById("txtarea").value=$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "area");
        	   
          
	               $('#contactgriddiv').load("contactgrid.jsp?docno="+$('#jqxb1').jqxGrid('getcellvalue', rowindex1, "doc_no")) ;
                
                
                $("#date").jqxDateTimeInput('val', $("#jqxb1").jqxGrid('getcellvalue', rowindex1, "date")); 
            }
                
            }); 
            
      	  
      	  $('#txtarea').dblclick(function(){
      		  $('#areainfowindow').jqxWindow('open');
  			  areaSearchContent('area.jsp?getarea=0');
  			  });
        });
    function getareas(event){
     	 var x= event.keyCode;
     	 if(x==114){
     	  		$('#areainfowindow').jqxWindow('open');
               areaSearchContent('area.jsp?getarea=0');  	 
               
     	 } else{}
     }
            	 
	 function areaSearchContent(url) {
	      	 $.get(url).done(function (data) {
	 		 $('#areainfowindow').jqxWindow('setContent', data);
	      	 }); 
	 }
	function funSearchLoad(){
		//changeContent('brandSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmB').trigger("reset");
		//document.getElementById("frmB").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmB input').attr('readonly', true);
	 
		$('#date').jqxDateTimeInput({ disabled: true});
		
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmB input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false});
		if($('#mode').val()=="A")
			{
			$('#date').val(new Date());

			 $("#contactgrids").jqxGrid('clear');
			    $("#contactgrids").jqxGrid('addrow', null, {});
			}
 		if ($("#mode").val() == "A" || $("#mode").val() == "E") {
			$("#contactgrids").jqxGrid({ disabled: false});
		}
		
		$('#txtarea').attr('readonly', true);
		$('#docno').attr('readonly', true);
	}
 
	function setValues() {
		 
		if($('#datehidden').val()){
			$("#date").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 var indexVal2 = document.getElementById("docno").value;

		 if(indexVal2>0)
			 {
			 $('#contactgriddiv').load("contactgrid.jsp?docno="+indexVal2) ;
			 }
		 
	}
	
	 
	 function funDateInPeriodchk(value){
 
		    var currentDate = new Date(new Date());
		 
		     if(value>currentDate){
		     document.getElementById("errormsg").innerText="Future Date, Transaction Restricted. ";
		    
		     return 0;
		    } 
		    
		    document.getElementById("errormsg").innerText="";
		   
		     return 1;
		 }

	 function funNotify(){
		 
			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriodchk(maindate);
			   
			  
			   
			   if(validdate==0){
			   return 0; 
			   }
			   
				 var plotnumber = document.getElementById("plotnumber").value;
				 var name = document.getElementById("docno").name;
				 

if(name=="")
	{
	 document.getElementById("errormsg").innerText="Name is required ";
	    
     return 0;
	}
				 

if(plotnumber=="")
	{
	 document.getElementById("errormsg").innerText="Plot Number	 is required ";
	    
     return 0;
	}
		
			   
			   
			   var rows = $("#contactgrids").jqxGrid('getrows');
			   
			   
		 
			    $('#gridlength').val(rows.length);
			    
			   for(var i=0 ; i < rows.length ; i++){ 
			  	  
			  	 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "TEMP"+i)
			       .attr("name", "TEMP"+i)
			       .attr("hidden", "true");
			  
			   newTextBox.val(rows[i].name+"::"+rows[i].mob+"::"+rows[i].remarks+"::");
			   newTextBox.appendTo('form');
			   }
				$('#date').jqxDateTimeInput({ disabled: false});
	    		return 1;
		} 
	     function funFocus(){
	    	 
	     }
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<form id="frmB" action="saveB1"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset>
	<!-- <legend> Building</legend> -->
	<table width="100%">
<tr>
<td>
<table width="100%" >
		<tr><td width="6%" align="right">Date</td>
			<td width="10%"  align="left"><div id="date" name="date"></div>  
		  	</td>
			
      
	 <td width="6%" align="right">Name</td> 
			<td width="15%" align="left" ><input type="text" name="name"  readonly style="width:98%;" id="name"  value='<s:property value="name"/>' ></td>
			
			<td width="10%" align="right">Doc No.</td>
			<td width="10%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1">
			</td>
			</tr>
			<tr>
			
			<td width="10%" align="right">Plot Number</td>
				<td width="10%"><input type="text" id="plotnumber" name="plotnumber" style="width:98%;" value='<s:property value="plotnumber"/>'/></td>
				
			 
<td align="right" style="vertical-align: top;">Area</td>
<td colspan="2"><input type="text" id="txtarea" name="txtarea"   readonly placeholder="press F3 to search" value='<s:property value="txtarea"/>' onKeyDown=" getareas(event);"/> 
<input type="text" id="txtareadet" name="txtareadet" readonly style="width:68%;" value='<s:property value="txtareadet"/>'/>
 <input type="hidden" id="txtareaid" name="txtareaid"  value='<s:property value="txtareaid"/>'/></td>  
				
			</tr>
	</table>
    <input
				type="hidden" name="mode" id="mode"
				value='<s:property value="mode"/>' /> <input type="hidden"
				name="deleted" id="deleted" value='<s:property value="deleted"/>' />
			<input type="hidden" id="msg" name="msg"
				value='<s:property value="msg"/>' /></td> 
				<input type="hidden" id="datehidden" name="datehidden"
				value='<s:property value="datehidden"/>' />
						<input type="hidden" id="gridlength" name="gridlength"
				value='<s:property value="gridlength"/>' />
				
				
				
    </tr>
    </table>
	
	</fieldset>
    	<fieldset>
<div id="contactgriddiv">  <jsp:include page="contactgrid.jsp"></jsp:include></div>
 </fieldset>
	</form>
	
 
          <div id="jqxb1"></div>  
 
       
     <div id="areainfowindow">
   <div ></div>
   </div>
   
<br/>
 
	

</body>
</html>