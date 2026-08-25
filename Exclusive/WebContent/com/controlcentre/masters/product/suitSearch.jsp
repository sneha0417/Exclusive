
<script type="text/javascript">

$(document).ready(function () {
 
document.getElementById('updatechk').value="0";
 
});

function fundisable(){
	/*alert("==chkbed===="+document.getElementById("chkbed").value);
	alert("==chkcab===="+document.getElementById("chkcab").value);
	alert("==rba===="+document.getElementById("rba").value);
	alert("==rbb===="+document.getElementById("rbb").value);
	alert("==rca===="+document.getElementById("rca").value);
	alert("==rcb===="+document.getElementById("rcb").value);*/
	
	if(document.getElementById("rba").checked)
		{
		document.getElementById("rba").value=1;
		document.getElementById("rbb").value=0;
		}
	if(document.getElementById("rbb").checked)
	{
	document.getElementById("rba").value=0;
	document.getElementById("rbb").value=1;
	}

	if(document.getElementById("rca").checked)
	{
	document.getElementById("rca").value=1;
	document.getElementById("rcb").value=0;
	}
if(document.getElementById("rcb").checked)
{
document.getElementById("rca").value=0;
document.getElementById("rcb").value=1;
}

	
}

function suitload(){
	
	var chkbed=document.getElementById("chkbed").value;
	
	var chkbed2=document.getElementById("chkbed2").value;
	
	var chkbed3=document.getElementById("chkbed3").value;
	
	
	var chkcab=document.getElementById("chkcab").value;
	
	var chkcab2=document.getElementById("chkcab2").value;
	
	var chkcab3=document.getElementById("chkcab3").value;
	
	var rba=document.getElementById("rba").value;
	var rbb=document.getElementById("rbb").value;
	var rca=document.getElementById("rca").value;
	var rcb=document.getElementById("rcb").value;
	var suitid=document.getElementById("hidsuitid").value;
	
	$("#suitSearchdiv").load("suitSearchGrid.jsp?typeid=1&suitid="+suitid+"&chkbed="+chkbed+"&chkbed2="+chkbed2+"&chkbed3="+chkbed3+"&chkcab="+chkcab+"&chkcab2="+chkcab2+"&chkcab3="+chkcab3+"&rba="+rba+"&rbb="+rbb+"&rca="+rca+"&rcb="+rcb);
	
 
}

function funUpdate(){
	
	
	if(document.getElementById('updatechk').value!="1")
		{
		document.getElementById("errormsg").innerText ="Press Ok Button Before Update !!!";
		return 0;
		}
	document.getElementById("errormsg").innerText ="";
    var row = $("#suitSearch").jqxGrid('selectedrowindexes');
    var rows = $("#suitSearch").jqxGrid('getrows');
    /* alert(rows.length); */
 //   var selectedRecords = new Array();
    
	row = row.sort(function(a,b){return a - b});
 
    for (var m = 0; m < row.length; m++) {
      //  var row = $("#suitSearch").jqxGrid('getrowdata', rows[m]);
        // alert("==row===="+ row.service);
       // var rowlength=$("#jqxSuitGrid").jqxGrid('rows').records.length;
 
       
       var rr=$("#jqxSuitGrid").jqxGrid('getrows');
       
                     
      
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"doc_no",rows[m].doc_no);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"brand",rows[m].brand);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"brandid",rows[m].brandid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"model",rows[m].model);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"modelid",rows[m].modelid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"submodel",rows[m].submodel);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"submodelid",rows[m].submodelid);
        
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"yomfrm",rows[m].yomfrm);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"yomto",rows[m].yomto);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"yomfrmid",rows[m].yomfrmid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"yomtoid",rows[m].yomtoid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"esize",rows[m].esize);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"esizeid",rows[m].esizeid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize1",rows[m].bsize1);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize1id",rows[m].bsize1id);
  
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize2",rows[m].bsize2);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize2id",rows[m].bsize2id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize3",rows[m].bsize3);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"bsize3id",rows[m].bsize3id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize1",rows[m].csize1);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize1id",rows[m].csize1id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize2",rows[m].csize2);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize2id",rows[m].csize2id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize3",rows[m].csize3);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',rr.length-1,"csize3id",rows[m].csize3id);
        $("#jqxSuitGrid").jqxGrid('addrow', null, {});
        	
        
    }
    $('#suitsearchwindow').jqxWindow('close');
}	
	

/* function funUpdate(){
    var rows = $("#suitSearch").jqxGrid('selectedrowindexes');
   
    var selectedRecords = new Array();
    for (var m = 0; m < rows.length; m++) {
        var row = $("#suitSearch").jqxGrid('getrowdata', rows[m]);
        // alert("==row===="+ row.service);
        var rowlength=$("#jqxSuitGrid").jqxGrid('rows').records.length;
        
        if(rowlength==0)
        	{
        $("#jqxSuitGrid").jqxGrid('addrow', null, {});
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"doc_no",row.doc_no);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"brand",row.brand);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"brandid",row.brandid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"model",row.model);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"modelid",row.modelid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"submodel",row.submodel);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"submodelid",row.submodelid);
        
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"yomfrm",row.yomfrm);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"yomto",row.yomto);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"yomfrmid",row.yomfrmid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"yomtoid",row.yomtoid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"esize",row.esize);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"esizeid",row.esizeid);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize1",row.bsize1);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize1id",row.bsize1id);
       
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize2",row.bsize2);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize2id",row.bsize2id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize3",row.bsize3);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"bsize3id",row.bsize3id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"csize1",row.csize1);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"csize1id",row.csize1id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"csize2",row.csize2);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',m,"csize2id",row.csize2id);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize3",row.csize3);
        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize3id",row.csize3id);
        
        	}
        else
        	{
        	var totrow=0;
        	totrow=row.length+rowlength;
        	var test=0;
        	for (var n =rowlength-1;n < totrow; n++) {
        		var rowspec = $("#jqxSuitGrid").jqxGrid('getrowdata',n);
        		
        		if((row.doc_no==rowspec.doc_no))
        			{
        			 
        				test=1;
        				break;
            		}
        	}
        	if(test==0){
        		$("#jqxSuitGrid").jqxGrid('addrow', null, {});
        		 
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"doc_no",row.doc_no);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"brand",row.brand);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"brandid",row.brandid);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"model",row.model);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"modelid",row.modelid);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"submodel",row.submodel);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"submodelid",row.submodelid);
        	        
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"yomfrm",row.yomfrm);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"yomto",row.yomto);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"yomfrmid",row.yomfrmid);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"yomtoid",row.yomtoid);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"esize",row.esize);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"esizeid",row.esizeid);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize1",row.bsize1);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize1id",row.bsize1id);
        	       
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize2",row.bsize2);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize2id",row.bsize2id);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize3",row.bsize3);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"bsize3id",row.bsize3id);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize1",row.csize1);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize1id",row.csize1id);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize2",row.csize2);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize2id",row.csize2id);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize3",row.csize3);
        	        $('#jqxSuitGrid').jqxGrid('setcellvalue',n,"csize3id",row.csize3id);
        	}
        	}
        selectedRecords[selectedRecords.length] = row;
    }
    $('#suitsearchwindow').jqxWindow('close');
}	
	 */
</script>
<body>
<form>
<div style="background-color:#E0ECF8 !important;">
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnsuit" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btnupdate1" name="btnupdate1" class="myButton" onclick=" funUpdate();" >Update</button>
&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<!-- <table style="width:100%;" style="align:center;">
<tr>
<td width="30%">&nbsp;</td>
<td width="60%">
<table style="width:60%;">
  <tr>
    <td colspan="2" align="right">Bed Size</td>
    <td width="37"><input type="checkbox"  id="chkbed" name="chkbed" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" ></td>
    <td width="83"> 
       <label class="branch">ALL</label> 
       <input type="radio" id="rba" name="category" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()"> </td>
	 	<td width="113"><label class="branch">BLANK</label>
         <input type="radio" id="rbb" name="category" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" ></td>
  </tr>
  <tr>
    <td colspan="2" align="right">Cabin Size</td>
    <td> <input type="checkbox"  id="chkcab" name="chkcab" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" ></td>
    <td width="83"> 
       <label class="branch">ALL</label> 
       <input type="radio" id="rca" name="category1" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > </td>
	 	<td><label class="branch">BLANK</label>
         <input type="radio" id="rcb" name="category1" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" ></td>
  </tr>
</table>
</td><td width="10%">&nbsp;</td></tr></table> -->

  <table style="width:100%;" >
  <tr>
   <td style="width:100%;" align="center"> 
   <table width="100%">
   <tr>
  <td width="30%">&nbsp;</td>
   <td >
    <input type="checkbox"  id="chkbed" name="chkbed" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" >
    Bed Size1 </td>
       <td><input type="checkbox"  id="chkbed2" name="chkbed2" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" >
     Bed Size2</td> 
      <td><input type="checkbox"  id="chkbed3" name="chkbed3" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" >
    Bed Size3 </td> 
      <td> <input type="radio" id="rba" name="category" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()">       <label class="branch">ALL</label>   
    </td><td><input type="radio" id="rbb" name="category" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > <label class="branch">BLANK</label>
    </td>
        <td width="30%">&nbsp;</td>
 </tr>
 <tr>
  <td width="30%">&nbsp;</td>
 <td>
   <input type="checkbox"  id="chkcab" name="chkcab" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > 
       Cabin Size1</td>
    <td>  <input type="checkbox"  id="chkcab2" name="chkcab2" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > 
       Cabin Size2</td>
     <td> <input type="checkbox"  id="chkcab3" name="chkcab3" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > 
         Cabin Size3</td>
 
<td>
       <input type="radio" id="rca" name="category1" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" >
              <label class="branch">ALL</label></td>  
	 	
        <td> <input type="radio" id="rcb" name="category1" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundisable()" > 
          <label class="branch">BLANK</label></td>
            <td width="30%">&nbsp;</td>
          </tr>
          
           </table>
          </td>
  </tr>
</table>  
 <input type="hidden" id="updatechk" >   


<div id="suitSearchdiv"><jsp:include page="suitSearchGrid.jsp"></jsp:include></div>
</div>
</form>
</body>