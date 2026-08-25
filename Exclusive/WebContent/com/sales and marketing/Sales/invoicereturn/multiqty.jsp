 
 <script type="text/javascript">
 $(document).ready(function () {
	 chkmultiqty();
	 
	 
		$('#qtyWindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '60%'  , title: 'Search',position: { x: 700, y:100 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#qtyWindow').jqxWindow('close'); 
 });
 
 
 
 
 function chkmultiqty()
 {
  
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText.trim();
	   
	      if(parseInt(items)>0)
	       {
	     
	    	  
	     
	    	  document.getElementById("multimethod").value=1;
	    	  
	    	  
	        }
	          else
	      {
	      
	        	  document.getElementById("multimethod").value=0; 
	      
	      }
	      
	       } }
	   x.open("GET","chkmultiqty.jsp?",true);
		x.send();
	 
	      
	        
 	
 }
 
 
 function qtyinfoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#qtyWindow').jqxWindow('open');
		$('#qtyWindow').jqxWindow('setContent', data);
		       
	}); 
} 
 
</script>
 <body>
 
 <input type="hidden" id="multimethod" >
 
 <div id="qtyWindow"><div></div></div>
 
 </body>
 
 