
<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>GatewayERP(i)</title><!-- 1439578495 -->
<!-- <link rel="icon" href="/favicon.ico" type="image/x-icon"><link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<style>html{overflow-y:scroll}body{margin:0;background:#e0ecf8}h1,h2,h3,h4,p{margin:0;padding:0;font-weight:normal;font-family:Georgia,"Times New Roman",serif}#main{background:white;padding:20px}.wrap{margin:auto;width:1000px}.clear{clear:both}.unicode{font-family:'Code2000','Sun-ExtA','Arial Unicode MS','NSimSun',sans-serif}a{color:#c00;font-weight:bold;text-decoration:none}img{border:0 none}a:hover{text-decoration:underline}#left{float:left;width:73%}#left p{font-family:"Georgia","Times New Roman",serif;font-size:16px;line-height:1.5em;margin-bottom:8px;text-align:justify}#left h1 a,#left h2 a{color:#000}#left h1{font-size:30px;margin-top:20px}#left h2{font-size:28px;margin-top:20px;margin-bottom:10px}#left h3{font-size:26px;margin-top:20px;margin-bottom:10px}#left h4{font-size:24px;margin-top:20px;margin-bottom:10px}#left img{padding:10px;border:1px solid #ccc}#left li{list-style-type:square}#left pre{color:white;background:#211;-moz-border-radius:8px;-webkit-border-radius:8px;border-radius:8px;padding:10px 20px;font-size:13px}#left .button{text-align:center;margin:30px;font-family:Arial,Tahoma,Verdana}#left .button a{color:white;padding:10px 30px;text-decoration:none;-moz-border-radius:8px;-webkit-border-radius:8px;border-radius:8px;-webkit-box-shadow:0 1px 3px #666;-moz-box-shadow:0 1px 3px #666;text-shadow:0 1px 3px #666;border:solid #c00 2px;background:#c00;background:-webkit-gradient(linear,0 0,0 100%,from(#f00),to(#811));background:-moz-linear-gradient(top,#f00,#811);font-size:13px}#left time{font-size:14px;color:#666;margin-bottom:8px;margin-top:3px;display:block}#left time a{color:#000}#right{float:left;width:25%;margin-left:20px}#right ul{list-style:none;padding:0;margin:0}#right li{display:inline;margin-left:5px}#xfacebook{margin-left:-17px}header a{font-weight:300;font-size:30px;color:white;font-family:Arial,Tahoma,Verdana}header>div{position:relative}header #xname{float:left;padding-top:40px;padding-bottom:15px}header #xname span{font-size:13px;font-family:serif;color:#779}header ul{list-style:none;float:left;margin-left:140px;margin-top:60px}header li{display:inline;margin-left:20px}header li a{font-size:19px}footer div{height:90px;color:white;font-size:14px;padding-top:10px;font-family:Arial,Tahoma,Verdana}#cleft{float:left;width:60px}#cright{float:left;width:500px}textarea{resize:vertical;width:500px}input{width:400px;padding:4px}form p{margin-top:5px}form .button{text-align:left !important;margin:0 !important;margin-top:5px !important}form .button a{padding:5px 10px !important;font-size:13px !important}#comments img{border:0 none;padding:0}#comments h3,form h3{font-size:23px;margin-top:40px}#comments .comments{margin-top:30px}#comments time{display:inline;padding:0;margin:0}pre .str,code .str{color:#65b042}pre .kwd,code .kwd{color:#e28964}pre .com,code .com{color:#aeaeae;font-style:italic}pre .typ,code .typ{color:#89bdff}pre .lit,code .lit{color:#3387cc}pre .pun,code .pun{color:#fff}pre .pln,code .pln{color:#fff}pre .tag,code .tag{color:#89bdff}pre .atn,code .atn{color:#bdb76b}pre .atv,code .atv{color:#65b042}pre .dec,code .dec{color:#3387cc}pre.prettyprint,code.prettyprint{background-color:#000;-moz-border-radius:8px;-webkit-border-radius:8px;-o-border-radius:8px;-ms-border-radius:8px;-khtml-border-radius:8px;border-radius:8px}pre.prettyprint{width:95%;margin:1em auto;padding:1em;white-space:pre-wrap}
</style><link rel="pingback" href="/pingback/"><meta name="robots" content="index,follow"><meta name="ICBM" content="50.93793,14.84811"><meta property="fb:admins" content="1522308563"><meta name="author" content="Robert Eisele"><meta name="msapplication-config" content="none"><meta name="description" content=""><link rel="alternate" type="application/rss+xml" title="Code is poetry" href="http://feeds.feedburner.com/exarg"><link rel="canonical" href="/project/jquery-webcam-plugin/"><script>
var _gaq = _gaq || [];
_gaq.push(["_setAccount", "UA-1101037-2"]);
_gaq.push(["_trackPageview"]);

(function() {
var ga = document.createElement("script"); ga.type = "text/javascript"; ga.async = true;
ga.src = ("https:" == document.location.protocol ? "https://ssl" : "http://www") + ".google-analytics.com/ga.js";
var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(ga, s);
})(); -->
</script></head><body>
<% String contextPath=request.getContextPath();%>
<script src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>


<style type="text/css">

#webcam, #canvas {
 width: 320px;
 border:15px solid #333;
 background:#e0ecf8;
 -webkit-border-radius: 20px;
 -moz-border-radius: 20px;
 border-radius: 20px;
}

#webcam {
 position:relative;
 margin-top:50px;
 margin-bottom:50px;
}

#webcam > span {
 z-index:2;
 position:absolute;
 color:#eee;
 font-size:10px;
 bottom: -22px;
 left:100px;
}

#webcam > img {
 z-index:1;
 position:absolute;
 border:0px none;
 padding:0px;
 bottom:-40px;
 left:89px;
}

#webcam > div {
 border:5px solid #333;
 position:absolute;
 right:-90px;
 padding:5px;
 -webkit-border-radius: 8px;
 -moz-border-radius: 8px;
 border-radius: 8px;
 cursor:pointer;
}

#webcam a {
 background:#fff;
 font-weight:bold;
}

#webcam a > img {
 border:0px none;
}

#canvas {
 border:20px solid #ccc;
 background:#eee;
}

#flash {
 position:absolute;
 top:0px;
 left:0px;
 z-index:5000;
 width:100%;
 height:500px;
 background-color:#c00;
 display:none;
}

object {
 display:block; /* HTML5 fix */
 position:relative;
 z-index:1000;
}

#icon {
 width: 2.5em;
 height: 2em;
 border: none;
 background-color: #FFF;
}
</style>

<script type="text/javascript" src="<%=contextPath%>/js/jquery.webcam.min.js"></script>

<p id="status" style="height:12px; color:#c00;font-weight:bold;"></p>
<div id="webcam">
<span ><p>PoweredBy GateWayERP</p></span>
</div>
<!-- <p style="width:360px;text-align:center;font-size:12px;font-weight:bold;">
 <a href="javascript:webcam.capture();changeFilter();void(0);">Take Picture</a></p><br/>
 --> 
 
 <center><button id="icon"  title="Take Picture" style="width:60px;text-align:center;size:130px;font-weight:bold;" type="button" onclick="javascript:webcam.capture();changeFilter();void(0);">
			<img alt="Take Picture" src="<%=contextPath%>/icons/click.png">
		</button></center>
 
 <script type="text/javascript">

var pos = 0;
var ctx = null;
var cam = null;
var image = null;

var filter_on = false;
var filter_id = 0;

function changeFilter() {
 if (filter_on) {
 filter_id = (filter_id + 1) & 7;
 }
}

function toggleFilter(obj) {
 if (filter_on =!filter_on) {
 obj.parentNode.style.borderColor = "#c00";
 } else {
 obj.parentNode.style.borderColor = "#333";
 }
}

jQuery("#webcam").webcam({

 width: 320,
 height: 240,
 mode: "callback",
 swffile: "jscam_canvas_only.swf",

 onTick: function(remain) {

 if (0 == remain) {
 jQuery("#status").text("Cheese!");
 } else {
 jQuery("#status").text(remain + " seconds remaining...");
 }
 },

 onSave: function(data) {

 var col = data.split(";");
 var img = image;

 if (false == filter_on) {

 for(var i = 0; i < 320; i++) {
 var tmp = parseInt(col[i]);
 img.data[pos + 0] = (tmp >> 16) & 0xff;
 img.data[pos + 1] = (tmp >> 8) & 0xff;
 img.data[pos + 2] = tmp & 0xff;
 img.data[pos + 3] = 0xff;
 pos+= 4;
 
 }
 
 
 } else {

 var id = filter_id;
 var r,g,b;
 var r1 = Math.floor(Math.random() * 255);
 var r2 = Math.floor(Math.random() * 255);
 var r3 = Math.floor(Math.random() * 255);

 for(var i = 0; i < 320; i++) {
 var tmp = parseInt(col[i]);

 /* Copied some xcolor methods here to be faster than calling all methods inside of xcolor and to not serve complete library with every req */

 if (id == 0) {
 r = (tmp >> 16) & 0xff;
 g = 0xff;
 b = 0xff;
 } else if (id == 1) {
 r = 0xff;
 g = (tmp >> 8) & 0xff;
 b = 0xff;
 } else if (id == 2) {
 r = 0xff;
 g = 0xff;
 b = tmp & 0xff;
 } else if (id == 3) {
 r = 0xff ^ ((tmp >> 16) & 0xff);
 g = 0xff ^ ((tmp >> 8) & 0xff);
 b = 0xff ^ (tmp & 0xff);
 } else if (id == 4) {

 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 var v = Math.min(Math.floor(.35 + 13 * (r + g + b) / 60), 255);
 r = v;
 g = v;
 b = v;
 } else if (id == 5) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 if ((r+= 32) < 0) r = 0;
 if ((g+= 32) < 0) g = 0;
 if ((b+= 32) < 0) b = 0;
 } else if (id == 6) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 if ((r-= 32) < 0) r = 0;
 if ((g-= 32) < 0) g = 0;
 if ((b-= 32) < 0) b = 0;
 } else if (id == 7) {
 r = (tmp >> 16) & 0xff;
 g = (tmp >> 8) & 0xff;
 b = tmp & 0xff;
 r = Math.floor(r / 255 * r1);
 g = Math.floor(g / 255 * r2);
 b = Math.floor(b / 255 * r3);
 }

 img.data[pos + 0] = r;
 img.data[pos + 1] = g;
 img.data[pos + 2] = b;
 img.data[pos + 3] = 0xff;
 pos+= 4;
 }
 }

 if (pos >= 0x4B000) {
 ctx.putImageData(img, 0, 0);
 pos = 0;
 }
 },

 onCapture: function () {
 webcam.save();

 jQuery("#flash").css("display", "block");
 jQuery("#flash").fadeOut(100, function () {
 jQuery("#flash").css("opacity", 1);
 });
 },

 debug: function (type, string) {
 jQuery("#status").html(type + ": " + string);
 },

 onLoad: function () {
/* 
 var cams = webcam.getCameraList();
 for(var i in cams) {
 //jQuery("#cams").append("<li>" + cams[i] + "</li>");
 } */
 }
});

function getPageSize() {

 var xScroll, yScroll;

 if (window.innerHeight && window.scrollMaxY) {
 xScroll = window.innerWidth + window.scrollMaxX;
 yScroll = window.innerHeight + window.scrollMaxY;
 } else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
 xScroll = document.body.scrollWidth;
 yScroll = document.body.scrollHeight;
 } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
 xScroll = document.body.offsetWidth;
 yScroll = document.body.offsetHeight;
 }

 var windowWidth, windowHeight;

 if (self.innerHeight) { // all except Explorer
 if(document.documentElement.clientWidth){
 windowWidth = document.documentElement.clientWidth;
 } else {
 windowWidth = self.innerWidth;
 }
 windowHeight = self.innerHeight;
 } else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
 windowWidth = document.documentElement.clientWidth;
 windowHeight = document.documentElement.clientHeight;
 } else if (document.body) { // other Explorers
 windowWidth = document.body.clientWidth;
 windowHeight = document.body.clientHeight;
 }

 // for small pages with total height less then height of the viewport
 if(yScroll < windowHeight){
 pageHeight = windowHeight;
 } else {
 pageHeight = yScroll;
 }

 // for small pages with total width less then width of the viewport
 if(xScroll < windowWidth){
 pageWidth = xScroll;
 } else {
 pageWidth = windowWidth;
 }

 return [pageWidth, pageHeight];
}

window.addEventListener("load", function() {

 jQuery("body").append("<div id=\"flash\"></div>");

 var canvas = window.opener.document.getElementById("canvas");
 //window.opener.document.getElementById("canvasdet").value=window.opener.document.getElementById("canvas").toDataURL().replace(/^data:image\/(png|jpg);base64,/, "");
 //window.location=canvas.toDataURL();
 /* window.open(canvas,"mywindow","menubar=1,resizable=1,width=500,height=500"); */
 if (canvas.getContext) {
 ctx = window.opener.document.getElementById("canvas").getContext("2d");
 ctx.clearRect(0, 0, 320, 240);

 var img = new Image();
 img.src = "/image/logo.gif";
 img.onload = function() {
 ctx.drawImage(img, 129, 89);
 }
 image = ctx.getImageData(0, 0, 320, 240);
 }
 
 var pageSize = getPageSize();
 jQuery("#flash").css({ height: pageSize[1] + "px" });

}, false);

window.addEventListener("resize", function() {

 var pageSize = getPageSize();
 jQuery("#flash").css({ height: pageSize[1] + "px" });

}, false);

</script></body></html>