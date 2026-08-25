<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.product.ClsProductDAO"%>
<%ClsProductDAO DAO= new ClsProductDAO();%>
<%String yomfrm=request.getParameter("yomfrm")==null?"0":request.getParameter("yomfrm").toString();%>
<%String yomto=request.getParameter("yomto")==null?"0":request.getParameter("yomto").toString();%>
<%String suitid=request.getParameter("suitid")==null?"0":request.getParameter("suitid").toString();%>

<%String chkbed=request.getParameter("chkbed")==null?"0":request.getParameter("chkbed").toString();%>
<%String chkbed2=request.getParameter("chkbed2")==null?"0":request.getParameter("chkbed2").toString();%>
<%String chkbed3=request.getParameter("chkbed3")==null?"0":request.getParameter("chkbed3").toString();%>

<%String chkcab=request.getParameter("chkcab")==null?"0":request.getParameter("chkcab").toString();%>
<%String chkcab2=request.getParameter("chkcab2")==null?"0":request.getParameter("chkcab2").toString();%>
<%String chkcab3=request.getParameter("chkcab3")==null?"0":request.getParameter("chkcab3").toString();%>

<%String rba=request.getParameter("rba")==null?"0":request.getParameter("rba").toString();%>
<%String rbb=request.getParameter("rbb")==null?"0":request.getParameter("rbb").toString();%>
<%String rca=request.getParameter("rca")==null?"0":request.getParameter("rca").toString();%>
<%String rcb=request.getParameter("rcb")==null?"0":request.getParameter("rcb").toString();%>

<%String typeid=request.getParameter("typeid")==null?"0":request.getParameter("typeid").toString();%>
<script>
$(document).ready(function () {
	var typeid='<%=typeid %>';
	

	
	   var suitdata;
	  
		    suitdata='<%=DAO.suitSearch(session,yomfrm,yomto,suitid,chkbed,chkbed2,chkbed3,chkcab,chkcab2,chkcab3,rba,rbb,rca,rcb,typeid) %>'; 
		
	    // prepare the data
	    var source =
	    {
	        datatype: "json",
	        datafields: [

		{name : 'doc_no', type: 'string'  },          
		{name : 'model', type: 'string'  },
		{name : 'modelid', type: 'int'   },
		{name : 'submodel', type: 'string'  },
		{name : 'submodelid', type: 'int'   },
		{name : 'brand', type: 'string'   },
		{name : 'brandid', type: 'int'   },
		{name : 'yomfrm', type: 'string'   },
		{name : 'yomto', type: 'string'   },
		{name : 'yomfrmid', type: 'int'   },
		{name : 'yomtoid', type: 'int'   },
		{name : 'esize', type: 'string'   },
		{name : 'esizeid', type: 'int'   },
		{name : 'bsize1', type: 'string'   },
		{name : 'bsize1id', type: 'int'   },
		{name : 'bsize2', type: 'string'   },
		{name : 'bsize2id', type: 'int'   },
		{name : 'bsize3', type: 'string'   },
		{name : 'bsize3id', type: 'int'   },
		{name : 'csize1', type: 'string'   },
		{name : 'csize1id', type: 'int'   },
		{name : 'csize2', type: 'string'   },
		{name : 'csize2id', type: 'int'   },
		{name : 'csize3', type: 'string'   },
		{name : 'csize3id', type: 'int'   },
		
	                  		
	                  		
	                  		],
					    localdata: suitdata,
	        
	        
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
	    
	    
	    $("#suitSearch").jqxGrid(
	    {
	        width: '100%',
	        height: 350,
	        source: dataAdapter,
	        showaggregates:true,
	        showfilterrow: true, 
	        filterable: true,
	        selectionmode: 'checkbox',
	       sortable:false,
	        columns: [
	               
					
	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '3%', cellsrenderer: function (row, column, value) {
	    return "<div style='margin:4px;'>" + (value + 1) + "</div>";
	}   },
	{ text: 'doc_no', datafield: 'doc_no', hidden: true, width: '10%',cellsalign: 'center', align: 'center' },
	{ text: 'Yom(From)', datafield: 'yomfrm', editable: false, width: '5%',cellsalign: 'center', align: 'center' },
	{ text: 'Yomfrmid', datafield: 'yomfrmid', width: '15%',cellsalign: 'center', align: 'center' ,hidden:true},
	{ text: 'Yom(To)', datafield: 'yomto', editable: false, width: '5%',cellsalign: 'center', align: 'center' },
	{ text: 'Yomtoid', datafield: 'yomtoid', width: '15%',cellsalign: 'center', align: 'center',hidden:true },
	{ text: 'typeid', datafield: 'typeid', width: '5%',hidden:true },
	{ text: 'modelid', datafield: 'modelid', width: '5%',hidden:true },
	{ text: 'brandid', datafield: 'brandid', width: '5%',hidden:true },
	{ text: 'submodelid', datafield: 'submodelid', width: '5%',hidden:true },
	{ text: 'Type', datafield: 'ptype', editable: false, width: '15%',cellsalign: 'center', align: 'center',hidden:true },
	{ text: 'Brand', datafield: 'brand', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
	{ text: 'Model', datafield: 'model', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
	{ text: 'Sub Model', datafield: 'submodel', editable: false, width: '15%',cellsalign: 'center', align: 'center' },
	{ text: 'EngineSize', datafield: 'esize', editable: false, width: '10%',cellsalign: 'center', align: 'center' },
	{ text: 'spec2id', datafield: 'esizeid', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'BedSize1', datafield: 'bsize1', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
	{ text: 'BedSize2', datafield: 'bsize2', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
	{ text: 'BedSize3', datafield: 'bsize3', editable: false, width: '12%',cellsalign: 'center', align: 'center' },
	{ text: 'bsize1id', datafield: 'bsize1id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'bsize2id', datafield: 'bsize2id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'bsize3id', datafield: 'bsize3id', hidden:true, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'CabinSize1', datafield: 'csize1', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'csize1id', datafield: 'csize1id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },
	{ text: 'CabinSize2', datafield: 'csize2', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'csize2id', datafield: 'csize2id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },
	{ text: 'CabinSize3', datafield: 'csize3', editable: false, width: '11%',cellsalign: 'center', align: 'center' },
	{ text: 'csize3id', datafield: 'csize3id' , hidden:true, width: '12%',cellsalign: 'center', align: 'center' },


						]
	    
	    
			
	    });
	    
	    if(typeid=='1')
	    {
		   var rowlength=$("#suitSearch").jqxGrid('getrows').length;
		    
		    for (var n=0;n < rowlength; n++) {
		    $('#suitSearch').jqxGrid('selectrow', n);
		    
		    }  
	    }
	    
	    
	  /*   if ((document.getElementById('chkbed').checked)|| (document.getElementById('chkcab').checked)) { */
	/*     var rowlength=$("#suitSearch").jqxGrid('getrows').length;
	    
	    for (var n=0;n < rowlength; n++) {
	    $('#suitSearch').jqxGrid('selectrow', n);
	    
	    } */
	    
	   /*  } */
	    
	    $( "#btnsuit" ).click(function() {
	    	
	    	var rows = $("#suitSearch").jqxGrid('selectedrowindexes');
	   
	    	
	    	
			document.getElementById("hidsuitid").value="";
	    	
	    	for(var i=0;i<rows.length;i++){
	    		var dummy=$('#suitSearch').jqxGrid('getcellvalue',rows[i],'spec');
	    		var docno=$('#suitSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
	    		
	    		if(i==0){
	    			document.getElementById("hidsuitid").value=docno;
	    		}
	    		else{
	    			document.getElementById("hidsuitid").value+=","+docno;
	    		}
	    	}
	    	/* if ($("#mode").val() == "A") {
	    		if ((document.getElementById('chkbed').checked)|| (document.getElementById('chkcab').checked)) {
	    			document.getElementById("errormsg").innerText ="";
	    			if (!(document.getElementById('rba').checked || document.getElementById('rbb').checked || document.getElementById('rca').checked || document.getElementById('rcb').checked )) {
	    				document.getElementById("errormsg").innerText ="Select any of the option!!!";
	 				   //$.messager.alert('Message','Select any of the option','warning');
	 				   return false;
	 			   }
	    		suitload();
	    		 
	    		  
	    		}
	    		 else{
	    			 
	    		} 
	    
	    	}
	    	else if($("#mode").val() == "E"){
	    		if ((document.getElementById('chkbed').checked)|| (document.getElementById('chkcab').checked)) {
	    		suitload();
	    		 
	    	}
	    		else{
	    			 
	    		} 
	    	}
	    	 */
	    	 if ((document.getElementById('chkbed').checked) || (document.getElementById('chkbed2').checked) || (document.getElementById('chkbed3').checked)  ) {
	    			document.getElementById("errormsg").innerText ="";
	    			if (!(document.getElementById('rba').checked || document.getElementById('rbb').checked   )) {
	    				document.getElementById("errormsg").innerText ="Select any of the option!!!";
	 				   //$.messager.alert('Message','Select any of the option','warning');
	 				   return false;
	 			   }
	    	 }
	    			
		    		if ((document.getElementById('chkcab').checked) || (document.getElementById('chkcab2').checked) || (document.getElementById('chkcab3').checked) ) {
		    			document.getElementById("errormsg").innerText ="";
		    			if (!(document.getElementById('rca').checked || document.getElementById('rcb').checked )) {
		    				document.getElementById("errormsg").innerText ="Select any of the option!!!";
		 				   //$.messager.alert('Message','Select any of the option','warning');
		 				   return false;
		 			   }
		    					
		    		}
	    			
		    		
		    		document.getElementById('updatechk').value="1";
		    		
		    		
		    		
	    		suitload();
	    		
	    		
	    		
	    	 
	    	});
	    
	     $("#btncancel" ).click(function() {
	    	$('#suitsearchwindow').jqxWindow('close');
	    	});
	 
	});

</script>
<div id="suitSearch"></div>