<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Gateway ERP - Control &amp; Grow Your Business</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="Tightframes,Tightframes Entertainment,Tightframes Kochi"/>
        <meta name="keywords" content="Tightframes,Kochi,Web designing,Photography"/>
        <meta property="og:title" content="Tightframes Entertainment Kochi"/>
        <meta property="og:url" content="http://tightframes.in"/>
        <meta property="og:description" content="Tightframes,Tightframes Entertainment,Tightframes Kochi"/>
        <meta property="og:image" content="http://tightframes.in/images/tightbanner.jpg"/>
        <link href="images/gatelogo.ico" rel="icon" type="image/png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        
        <link href="https://fonts.googleapis.com/css?family=Black+Ops+One|Lobster|Roboto:900" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.theme.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.transitions.css">
        <style type="text/css">
            body{
                width: 100%;
                height: 100%;
                overflow: hidden;
            }
            .outer-container{
             width: 100%;
                height: 100%;   
            }
            .box-red{
                width: 300px;
                height: 600px;
                background: #E44D26;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to right, #F16529, #E44D26);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to right, #F16529, #E44D26); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
                transform: rotate(125deg);
                position: absolute;
                bottom: -350px;
            }
            .box-blue-bottom-right{
                width: 350px;
                height: 500px;
                background: #0575E6;  /* fallback for old browsers */
background: -webkit-linear-gradient(to left, #021B79, #0575E6);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to left, #021B79, #0575E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
background: #ff00cc;  /* fallback for old browsers */
background: -webkit-linear-gradient(to left, #333399, #333399);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to left, #333399, #333399); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

                transform: rotate(150deg);
                position: absolute;
                bottom: -100px;
                float: right;
                right: -170px;
                border-radius: 30px;
                z-index: 5;
            }
            .box-blue-top-center{
                width: 350px;
                height: 500px;
                background: #0575E6;  /* fallback for old browsers */
background: -webkit-linear-gradient(to left, #021B79, #0575E6);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to left, #021B79, #0575E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
background: #ff00cc;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #333399, #ff00cc);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #333399, #ff00cc); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

                transform: rotate(150deg);
                position: absolute;
                top: -250px;
                margin: 0 auto;
                text-align: center;
                border-radius: 30px;
                left: 50%;
                z-index: 5;
                opacity: 0.5;
            }
            .box-blue-top-right{
                width: 400px;
                height: 500px;
                background: #0575E6;  /* fallback for old browsers */
background: -webkit-linear-gradient(to left, #021B79, #0575E6);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to left, #021B79, #0575E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
background: #ff00cc;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #333399, #ff00cc);  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #333399, #ff00cc); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

                transform: rotate(60deg);
                position: absolute;
                top: -150px;
                margin: 0 auto;
                text-align: center;
                border-radius: 30px;
                
                right: -100px;
                z-index: 5;
                opacity: 0.5;
            }
            .box-blue-main{
                background: #0575E6;  /* fallback for old browsers */
                background: -webkit-linear-gradient(to left, #021B79, #0575E6);  /* Chrome 10-25, Safari 5.1-6 */
                background: linear-gradient(to left, #021B79, #0575E6); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

                transform: rotateY(-45deg);
                position: relative;
                width:1200px;height: 600px;
                border-radius: 80px;

            }
.outer-container .main-container, .outer-container .svg-container{
                height: 100%;
            }
            .outer-container .main-container{
                width: 60%;
                margin-top: 70px;
            }
            .outer-container .svg-container{
                width: 30%;
                right: 100px;
                position: absolute;
                z-index: 15;
                float: right;
            }

            .st0{fill:#EFB025;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st1{fill:#E8E7E6;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st2{fill:none;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st3{fill:#A8A5A5;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st4{fill:#FFFFFF;stroke:#000000;stroke-width:2;stroke-miterlimit:10;}
            .st5{fill:#A1C0DB;stroke:#000000;stroke-miterlimit:10;}
            .st6{fill:#A1C0DB;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st7{fill:#999695;stroke:#000000;stroke-width:2;stroke-miterlimit:10;}
            .st8{fill:none;stroke:#000000;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
            .st9{fill:#FFFFFF;stroke:#000000;stroke-miterlimit:10;}
            .st10{fill:#B29097;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st11{fill:#999695;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st12{fill:#EAE4DA;stroke:#000000;stroke-width:2;stroke-miterlimit:10;}
            .st13{fill:none;stroke:#000000;stroke-miterlimit:10;}
            .st14{fill:#2AE8D6;stroke:#000000;stroke-miterlimit:10;}
            .st15{fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;}
            .st16{fill:#F4EA78;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            .st17{fill:none;stroke:#000000;stroke-width:3;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;}
            .st18{fill:none;stroke:#000000;stroke-miterlimit:10;stroke-dasharray:2.9668,2.9668;}
            .st19{stroke:#FFFFFF;stroke-miterlimit:10;}
            .st20{fill:#EA6D28;stroke:#000000;stroke-width:3;stroke-miterlimit:10;}
            #svg-animation *{
                opacity: 0;
            }


            @keyframes slideInRight {
              from {
                -webkit-transform: translate3d(100%, 0, 0) rotate(-45deg);
                transform: translate3d(100%, 0, 0) rotate(-45deg);
               opacity: 0;
              }

              to {
                -webkit-transform: translate3d(0, 0, 0) rotate(-45deg);
                transform: translate3d(0, 0, 0) rotate(-45deg);
                opacity: 1;
              }
            }
            
            .slideInDownCenter{
                animation-name:slideInDownCenter; 
            }
            @keyframes slideInDownCenter {
                0% {
                    transform: translate3d(0, -100%, 0) rotate(150deg);
                    visibility: visible
                }
                to {
                    transform: translateZ(0) rotate(150deg);
                }
            }
            .slideInRightTop{
                animation-name:slideInRightTop; 
            }
            @keyframes slideInRightTop {
              from {
                -webkit-transform: translate3d(100%, 0, 0) rotate(60deg);
                transform: translate3d(100%, 0, 0) rotate(60deg);
               opacity: 0;
              }

              to {
                -webkit-transform: translate3d(0, 0, 0) rotate(60deg);
                transform: translate3d(0, 0, 0) rotate(60deg);
                opacity: 1;
              }
            }
            .slideInUpLeft{
                animation-name: slideInUpLeft
            }
            @keyframes slideInUpLeft {
                0% {
                    transform: translate3d(0, 100%, 0) rotate(125deg);
                    visibility: visible
                }
                to {
                    transform: translateZ(0) rotate(125deg);
                }
            }

            .custom-navbar{
                background-color: transparent;
                border-color: transparent;
            }
            .btnlogin{
                padding-top: 5px;
                padding-bottom: 5px;
                padding-left: 35px;
                padding-right: 35px;
                background-color: #28D330;
                border-color: #28D330;
                color: #fff;
                border-radius: 15px;
                margin-top: 20px;
                transition: all 0.25s ease-in;
                text-transform: uppercase;
                font-family: 'Roboto';
            }
            .btnabout{
                padding-top: 5px;
                padding-bottom: 5px;
                padding-left: 35px;
                padding-right: 35px;
                background-color: #fff;
                border-color: #fff;
                color: #000;
                border-radius: 15px;
                margin-top: 20px;
                transition: all 0.25s ease-in;
                text-transform: uppercase;
                font-family: 'Roboto';
            }
            .btnlogin:hover,.btnlogin:active,.btnabout:focus,.btnabout:hover,.btnabout:active,.btnabout:focus{
                background-color: #333399;
                color: #fff;
                font-weight: bold;
            }
            .btn-container li{
                margin-right: 15px;
            }
            .navbar-brand{
                margin-left:0; 
                width: 40%;
                height: 100%;
            }
            .navbar-brand img{
                width: 100%;
                height: 100%;
            }
            .footer-image-container{
                float: right;
                position: absolute;
                width: 9%;
                height: 5%;
                bottom: 20px;
                right: 0px;
                z-index: 999;
            }
            .footer-image-container img{
                width: 100%;
                height: 100%;
            }
            #quote-slider{
                position: absolute;
                z-index: -1;
                top: 30%;
                transform: translateY(-50%);
            }
            #quote-slider h2{
                font-family: 'Roboto';
                font-weight: bolder;
                color: #000;
                opacity: 0.7;
                font-size: 6.5em;
                font-style: italic;
            }
            #product-slider{
                position: absolute;
                z-index: 5;
                top: 75%;
                left: 15%;
                transform: translate(-50%,-50%);   
                /*border: 1px solid red; */
                margin-left: 50%;
            }

            .card-container{
                width: 550px;
                height: 300px;
                box-shadow: 0 19px 38px rgba(0,0,0,0.30), 0 15px 12px rgba(0,0,0,0.22);
                left: 50%;
                background-color: rgba(255,255,255,0.7);
                /*top: 50%;
                left: 50%;
                transform: translate(-50%,-50%);
                position: absolute;*/
                padding:20px 20px 20px 20px;
                margin-bottom: 40px;
                margin-left: 30px;
            }
            .card-container .card-top,.card-container .card-bottom{
                float: left;
                height: 100%;
                text-align: center;
            }
            .card-container .card-top{
                width: 40%;

            }
            .card-container .card-bottom{
                width: 60%;
            }
            .card-svg{
                width: 100%;
                height: 100%;
                z-index: 4;
            }
            .card-svg svg{
                width: 100%;
                height: 100%;
            }
            .product-heading{
                font-family: 'Black Ops One', cursive;
            }
            .product-detail{
                font-family: 'Lobster', cursive;
            }
            .card-bottom p{
                text-align: justify;
            }

        </style>
    </head>      
    <body>
    <nav class="navbar navbar-default navbar-fixed-top custom-navbar">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="#" class="navbar-brand"><img src="<%=contextPath%>/icons/gwinnovationslogo.png" alt=""></a>
                </div>
                <!-- Collection of nav links and other content for toggling -->
                <div id="navbarCollapse" class="collapse navbar-collapse">
                    <!-- <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Home</a></li>
                        <li><a href="#">Profile</a></li>
                        <li><a href="#">Messages</a></li>
                    </ul> -->
                    <ul class="nav navbar-nav navbar-right btn-container">
                        <li><!-- <a href="#" class="btn btn-default btnlogin">Login</a> -->
                            <button class="btn btn-default btnabout" onclick="window.open('http://gatewayerp.com')">about us</button>
                        </li>
                        <li><!-- <a href="#" class="btn btn-default btnlogin">Login</a> -->
                            <button class="btn btn-default btnlogin"  onclick="openNewWindow();">sign in</button>
                        </li>
                        
                    </ul>
                </div>
            </div>
        </nav>
        <div class="outer-container">
        <div class="svg-container">
                <?xml version="1.0" encoding="utf-8"?>
                <!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
                <svg version="1.1" id="svg-animation" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="440 50 420 460" style="enable-background:new 440 50 420 460;" xml:space="preserve">
                    <rect x="632" y="312" class="st0 logo-table" width="6.5" height="16"/>
                    <rect x="529" y="274" class="st0 logo-table" width="8" height="45.3"/>
                    <rect x="509" y="174" class="st1 logo-curtain" width="277" height="5.5"/>
                    <polygon class="st1 logo-curtain" points="776.5,179.5 519,179.5 513,189.5 782.5,189.5 "/>
                    <polygon class="st1 logo-curtain" points="778,189.5 519,189.5 513,199.5 782.5,199.5 "/>
                    <polygon class="st1 logo-curtain" points="779,199.5 519,199.5 513,209.5 782.5,209.5 "/>
                    <path class="st0 logo-table" d="M808.3,328H485.8c-3.2,0-5.8,2.6-5.8,5.8l0,0c0,3.2,2.6,5.8,5.8,5.8h322.5c3.2,0,5.8-2.6,5.8-5.8l0,0
                        C814,330.6,811.4,328,808.3,328z"/>
                    <rect x="500" y="339.5" class="st0 logo-table" width="84" height="85"/>
                    <rect x="509" y="390" class="st0 logo-table" width="64" height="25.5"/>
                    <path class="st2 logo-table-opener" d="M547.3,405h-12.5c-1.2,0-2.3-1-2.3-2.3l0,0c0-1.2,1-2.3,2.3-2.3h12.5c1.2,0,2.3,1,2.3,2.3l0,0
                        C549.5,404,548.5,405,547.3,405z"/>
                    <rect x="509" y="346.5" class="st0 logo-table" width="64" height="26.5"/>
                    <path class="st2 logo-table-opener" d="M547.3,362.5h-12.5c-1.2,0-2.3-1-2.3-2.3l0,0c0-1.2,1-2.3,2.3-2.3h12.5c1.2,0,2.3,1,2.3,2.3l0,0
                        C549.5,361.5,548.5,362.5,547.3,362.5z"/>
                    <rect x="584" y="339.5" class="st0 logo-table" width="202" height="18.5"/>
                    <rect x="786" y="339.5" class="st0 logo-table" width="10" height="85"/>
                    <path class="st3 logo-desktop" d="M716.8,313h-95.5c-3.7,0-6.8-3-6.8-6.8v-58c0-3.7,3-6.8,6.8-6.8h95.5c3.7,0,6.8,3,6.8,6.8v58
                        C723.5,310,720.5,313,716.8,313z"/>
                    <path class="st4 logo-desktop-screen" d="M714,246.5h-88.5c-2.2,0-4,1.8-4,4V295H718v-44.5C718,248.3,716.2,246.5,714,246.5z"/>
                    <rect x="759.5" y="209.5" class="st0 logo-table" width="6.5" height="118.5"/>
                    <path class="st5 logo-lamp" d="M537,320.5h-23c-4.1,0-7.5,3.4-7.5,7.5l0,0h38l0,0C544.5,323.9,541.1,320.5,537,320.5z"/>
                    <path class="st6 logo-lamp" d="M532.1,320.5c0.3-0.6,0.4-1.2,0.4-1.9c0-3.1-3-5.6-6.8-5.6s-6.8,2.5-6.8,5.6c0,0.7,0.1,1.3,0.4,1.9"/>
                    <ellipse class="st7 logo-lamp" cx="499.8" cy="285.5" rx="5.8" ry="5.5"/>
                    <line class="st2 logo-lamp" x1="499.8" y1="291" x2="522.2" y2="313.9"/>
                    <line class="st2 logo-lamp" x1="503.1" y1="280.8" x2="523.2" y2="260.9"/>
                    <path class="st6 logo-lamp" d="M528.5,254.2l-3.1,3.2c-3.8,4-3.7,10.3,0.2,14.1l10.3,10c0.4,0.4,1,0.4,1.4,0l15.6-16.2c0.4-0.4,0.4-1,0-1.4
                        l-10.3-10C538.6,250.1,532.3,250.2,528.5,254.2z"/>
                    <line class="st8 logo-bottomline" x1="494" y1="424.5" x2="806.5" y2="424.5"/>
                    <line class="st2 logo-desktop" x1="614.5" y1="298.5" x2="723.5" y2="298.5"/>
                    <circle class="st9 logo-desktop" cx="669.9" cy="305.8" r="3.2"/>
                    <path class="st10 logo-curtain-opener" d="M774.8,262L774.8,262c-1.5,0-2.8-1.2-2.8-2.8v-3c0-1.5,1.2-2.8,2.8-2.8l0,0c1.5,0,2.8,1.2,2.8,2.8v3
                        C777.5,260.8,776.3,262,774.8,262z"/>
                    <line class="st2 logo-curtain-opener" x1="774.8" y1="210.5" x2="774.8" y2="253.5"/>
                    <path class="st11 logo-lamp" d="M523.6,259.8c-1.3-1-2.1-2.5-2.1-4.3c0-3,2.4-5.4,5.4-5.4c1.7,0,3.3,0.8,4.3,2.1"/>
                    <rect x="701.5" y="377" class="st12 logo-switchboard" width="28" height="13"/>
                    <line class="st13 logo-switchboard" x1="715.5" y1="390" x2="715.5" y2="377"/>
                    <path class="st3 logo-desktop" d="M687,320.5h3.5c4.1,0,7.3,3.1,7.3,7v0.5H645v-0.5c0-3.9,3.2-7,7.3-7h5.5"/>
                    <polygon class="st14 logo-penholder" points="793.5,328 780,328 777.5,309 796,309 "/>
                    <line class="st8 logo-penholder" x1="794" y1="294.5" x2="790" y2="308.3"/>
                    <line class="st15 logo-penholder" x1="786" y1="298.6" x2="786" y2="308.3"/>
                    <line class="st13 logo-penholder" x1="778.5" y1="316.8" x2="795" y2="316.8"/>
                    <path class="st16 logo-lamp-bulb" d="M548.6,269.8c0.8,1,1.4,2.2,1.4,3.6c0,3-2.4,5.4-5.4,5.4c-1.3,0-2.5-0.5-3.5-1.3"/>
                    <line class="st13 logo-penholder" x1="794.6" y1="319.5" x2="779" y2="319.5"/>
                    <path class="st2 logo-desktop" d="M652,320.5c0,0,8,1.2,10-6.6"/>
                    <path class="st2 logo-desktop" d="M690.5,320.5c0,0-9.5-1.3-10.5-6.6"/>
                    <path class="st2 logo-mug" d="M597.5,319.4c0.9,0.6,1.9,0.9,3,0.9c3,0,5.4-2.4,5.4-5.4s-2.4-5.4-5.4-5.4c-1.1,0-2.1,0.3-3,0.9"/>
                    <path class="st2 logo-desktop" d="M721.3,328c4.4-7.4,16.3-7.4,22.9,0"/>
                    <path class="st13 logo-switchboard" d="M669.9,389.1c0,11.2,9.5,21.2,20.7,21.2s18-10,18-21.2"/>
                    <line class="st13 logo-switchboard" x1="669.9" y1="358" x2="669.9" y2="390"/>
                    <line class="st17 logo-bottom-bullet" x1="481" y1="425" x2="489.5" y2="425"/>
                    <line class="st17 logo-bottom-bullet" x1="811" y1="424.5" x2="815.3" y2="424.5"/>
                    <line class="st2 logo-table" x1="500" y1="382" x2="584" y2="382"/>
                    <g>
                        <g>
                            <line class="st13 logo-dottedline" x1="537.3" y1="281.5" x2="537.8" y2="282.9"/>
                            <line class="st18 logo-dottedline" x1="538.8" y1="285.7" x2="552.2" y2="323.4"/>
                            <line class="st13 logo-dottedline" x1="552.7" y1="324.8" x2="553.2" y2="326.3"/>
                        </g>
                    </g>
                    <rect x="632" y="209.5" class="st0 logo-table" width="6.5" height="32"/>
                    <rect x="658.8" y="209.5" class="st0 logo-table" width="6.5" height="31.5"/>
                    <circle class="st13 logo-cable-circle" cx="722.7" cy="383.5" r="4.3"/>
                    <circle class="st19 logo-cable-circle" cx="708.5" cy="383.5" r="4.3"/>
                    <circle class="st13 logo-cable-circle" cx="708.5" cy="387.8" r="1.2"/>
                    <circle class="st13 logo-cable-circle" cx="724.7" cy="383.2" r="0.3"/>
                    <path class="st2 logo-lamp" d="M531.2,251.1"/>
                    <path class="st2 logo-curtain" d="M531.2,210.1"/>
                    <path class="st2 logo-lamp" d="M537.3,250.1"/>
                    <path class="st2 logo-curtain" d="M537.3,209.5"/>
                    <path class="st20 logo-mug" d="M591.5,328H582c-3.3,0-6-2.7-6-6v-16.5h21.5V322C597.5,325.3,594.8,328,591.5,328z"/>
                    <circle class="st13 logo-cable-circle" cx="720.7" cy="383.5" r="0.3"/>
                    <g>
                        <g>
                            <line class="st13 logo-dottedline" x1="552.9" y1="265.3" x2="554.8" y2="266.6"/>
                            <line class="st18 logo-dottedline" x1="558.7" y1="269.1" x2="610.5" y2="303.5"/>
                            <line class="st13 logo-dottedline" x1="612.5" y1="304.8" x2="614.5" y2="306.2"/>
                        </g>
                    </g>
                    <polygon class="st3 logo-desktop" points="684.3,320.3 658.8,320.3 662,313.9 680,313.9 "/>
                    <polyline class="st0 logo-table" points="529,250.5 529,210.1 535.3,210.1 535.3,251.1 "/>
                    <line class="st13 logo-lamp" x1="530.8" y1="313.9" x2="525.1" y2="313.3"/>
                    <image class="logo-desktop-logo" style="overflow:visible;" width="408" height="392" xlink:href="images/gwlogo.png"  transform="matrix(0.1132 0 0 0.1107 376.598 299.6039)">
</image>
                </svg>
            </div>
            <div class="box-red img-rounded animated slideInUpLeft"></div>
            <div class="box-blue-bottom-right img-rounded animated slideInRight"></div>
            <div class="box-blue-top-right img-rounded "></div>
            <div class="box-blue-top-center img-rounded animated slideInDownCenter "></div>
            <div style="width:1200px;height: 600px;float: right;perspective: 900px;margin-top: -250px;z-index:-1;" class="animated slideInDown">
                <div class="box-blue-main img-rounded"></div>
            </div>
            <div id="quote-slider" class="owl-carousel">
                <div>
                    <h2>Developing</h2>
                </div>
                <div>
                    <h2>Deploying</h2>
                </div>
                <div>
                    <h2>Sustaining</h2>
                </div>
            </div>
            <div class="container animated fadeIn">
                <div class="row">
                    <div class="owl-carousel owl-theme" id="product-slider">
                        <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
                                    <!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
                                    <svg version="1.1" id="svg-fleet" class=card-svg-logo" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
                                        <path style="fill:#FFB47D;" d="M489.798,239.613c-16.627-10.241-70.258-23.335-145.52-23.335l-39.756-46.38
                                        c-8.385-9.782-20.627-15.413-33.511-15.413H152.008c-12.644,0-24.87,4.523-34.47,12.751L70.624,207.45l-50.039,7.148
                                        c-7.106,1.015-12.889,6.231-14.63,13.195l-5.95,23.794l132.415,61.792h370.755v-49.903
                                        C503.173,253.717,498.107,244.732,489.798,239.613z"/>
                                        <path style="fill:#FF9164;" d="M503.173,269.241c0-17.655-26.482-35.31-150.067-35.31H8.831c-4.875,0-8.827,3.953-8.827,8.827
                                        v52.965l167.725,26.482h335.445V269.241z"/>
                                        <path style="fill:#FF7D5A;" d="M503.173,304.551H89.244l-78.5-17.443c-4.715-1.035-9.474,1.935-10.535,6.702
                                        c-1.052,4.759,1.949,9.474,6.707,10.53l79.447,17.655c0.629,0.142,1.267,0.211,1.913,0.211h414.894c4.879,0,8.828-3.953,8.828-8.827
                                        C511.999,308.504,508.052,304.551,503.173,304.551z"/>
                                        <circle style="fill:#EDEDEE;" cx="423.72" cy="304.549" r="44.137"/>
                                        <path style="fill:#504B5A;" d="M423.725,357.516c-29.207,0-52.965-23.758-52.965-52.965c0-29.207,23.758-52.965,52.965-52.965
                                        s52.965,23.758,52.965,52.965C476.69,333.758,452.932,357.516,423.725,357.516z M423.725,269.241
                                        c-19.473,0-35.31,15.837-35.31,35.31c0,19.473,15.837,35.31,35.31,35.31s35.31-15.836,35.31-35.31
                                        C459.035,285.078,443.199,269.241,423.725,269.241z"/>
                                        <circle style="fill:#DCDBDE;" cx="423.72" cy="304.549" r="17.655"/>
                                        <circle style="fill:#EDEDEE;" cx="88.275" cy="304.549" r="44.137"/>
                                        <path style="fill:#504B5A;" d="M88.279,357.516c-29.207,0-52.965-23.758-52.965-52.965c0-29.207,23.758-52.965,52.965-52.965
                                        s52.965,23.758,52.965,52.965C141.243,333.758,117.485,357.516,88.279,357.516z M88.279,269.241c-19.473,0-35.31,15.837-35.31,35.31
                                        c0,19.473,15.837,35.31,35.31,35.31s35.31-15.836,35.31-35.31C123.589,285.078,107.752,269.241,88.279,269.241z"/>
                                        <circle style="fill:#DCDBDE;" cx="88.275" cy="304.549" r="17.655"/>
                                        <g>
                                            <path style="fill:#FF7D5A;" d="M353.105,286.896H167.728c-4.875,0-8.827-3.953-8.827-8.827l0,0c0-4.875,3.953-8.827,8.827-8.827
                                            h185.377c4.875,0,8.827,3.952,8.827,8.827l0,0C361.933,282.945,357.98,286.896,353.105,286.896z"/>
                                            <path style="fill:#FF7D5A;" d="M503.173,286.896h-8.827c-4.875,0-8.828-3.953-8.828-8.827l0,0c0-4.875,3.953-8.827,8.828-8.827
                                            h8.827c4.875,0,8.827,3.952,8.827,8.827l0,0C512,282.945,508.048,286.896,503.173,286.896z"/>
                                        </g>
                                        <path style="fill:#FF9164;" d="M70.624,207.449l46.914-40.214c9.6-8.228,21.826-12.751,34.47-12.751h119.003
                                        c12.885,0,25.125,5.63,33.511,15.413l39.756,46.38H135.276c-7.78,0-15.546-0.643-23.221-1.922L70.624,207.449z"/>
                                        <path style="fill:#625D6B;" d="M261.294,169.664c-3.354-4.025-8.323-6.352-13.563-6.352h-81.524c-4.682,0-9.173,1.86-12.483,5.171
                                        l-26.482,26.482c-2.341,2.341-3.657,5.516-3.657,8.827l0,0c0,6.894,5.589,12.484,12.484,12.484h154.647
                                        c3.742,0,5.786-4.365,3.391-7.24L261.294,169.664z"/>
                                        <polygon style="fill:#504B5A;" points="185.381,216.276 158.898,216.276 176.553,163.312 194.208,163.312 "/>
                                        <path style="fill:#EDEDEE;" d="M493.697,242.759h-8.181c-4.875,0-8.827,3.952-8.827,8.827s3.953,8.827,8.827,8.827h17.261
                                        C502.011,253.548,498.814,247.337,493.697,242.759z"/>
                                        <path style="fill:#625D6B;" d="M304.522,169.897c-2.115-2.468-4.48-4.669-7.036-6.585H283.08c-3.742,0-5.786,4.364-3.391,7.24
                                        l32.813,39.374c3.354,4.025,8.323,6.352,13.562,6.352h18.213L304.522,169.897z"/>
                                        <path style="fill:#FF6464;" d="M0.004,242.759v8.827h17.655c4.875,0,8.827-3.952,8.827-8.827s-3.953-8.827-8.827-8.827H8.831
                                        C3.955,233.931,0.004,237.884,0.004,242.759z"/>
                                    </svg>
                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Fleet Management System</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail">Rental, Leasing and Limousine services are the operational segments, having controls on Fleet Management  (Induction, Maintenance, Depreciation and De-Fleet), Toll and Fine Management, Strict Documentation with Internal Audit System</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
                                    <!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
                                    <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                         viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
                                    <path style="fill:#F04D4E;" d="M279.273,139.636h46.545V34.909h-93.091v38.877C260.189,83.479,279.273,109.801,279.273,139.636z"/>
                                    <rect x="349.091" y="34.909" style="fill:#DE333F;" width="23.273" height="104.727"/>
                                    <rect x="395.636" y="81.455" style="fill:#70B7E5;" width="46.545" height="58.182"/>
                                    <path style="fill:#4C9CD6;" d="M407.273,139.636c2.246,0,4.503,0.652,6.458,1.955l5.178,3.456V81.455h-23.273v63.581l5.19-3.456
                                        C402.781,140.288,405.027,139.636,407.273,139.636z"/>
                                    <path style="fill:#DD353F;" d="M301.917,160.14c0.372-2.909,0.628-5.853,0.628-8.867c0-31.942-21.469-58.799-50.735-67.107
                                        c16.815,12.893,27.462,33.199,27.462,55.471c0,1.769-0.07,3.526-0.209,5.271L301.917,160.14z"/>
                                    <g>
                                        <circle style="fill:#014463;" cx="186.182" cy="477.091" r="23.273"/>
                                        <circle style="fill:#014463;" cx="395.636" cy="477.091" r="23.273"/>
                                    </g>
                                    <path style="fill:#FFCA5D;" d="M435.433,349.091c11.38,0,21.236-8.495,22.935-19.759l28.218-166.423h-374.33l36.934,186.182H435.433
                                        z"/>
                                    <path style="fill:#F5B445;" d="M464.454,162.909L439.459,306.06c-1.687,11.264-11.555,19.759-22.924,19.759H145.222l4.154,23.273
                                        h286.057c11.38,0,21.236-8.495,22.935-19.759l28.486-166.423H464.454z"/>
                                    <g>
                                        <path style="fill:#014463;" d="M407.273,302.545c-6.435,0-11.636-5.201-11.636-11.636v-93.091c0-6.435,5.201-11.636,11.636-11.636
                                            s11.636,5.201,11.636,11.636v93.091C418.909,297.344,413.708,302.545,407.273,302.545z"/>
                                        <path style="fill:#014463;" d="M337.455,302.545c-6.435,0-11.636-5.201-11.636-11.636v-93.091c0-6.435,5.201-11.636,11.636-11.636
                                            s11.636,5.201,11.636,11.636v93.091C349.091,297.344,343.889,302.545,337.455,302.545z"/>
                                        <path style="fill:#014463;" d="M267.636,302.545c-6.435,0-11.636-5.201-11.636-11.636v-93.091c0-6.435,5.201-11.636,11.636-11.636
                                            s11.636,5.201,11.636,11.636v93.091C279.273,297.344,274.071,302.545,267.636,302.545z"/>
                                        <path style="fill:#014463;" d="M197.818,302.545c-6.435,0-11.636-5.201-11.636-11.636v-93.091c0-6.435,5.201-11.636,11.636-11.636
                                            s11.636,5.201,11.636,11.636v93.091C209.455,297.344,204.253,302.545,197.818,302.545z"/>
                                    </g>
                                    <circle style="fill:#FFCA5D;" cx="34.909" cy="81.455" r="11.636"/>
                                    <path style="fill:#D98B37;" d="M218.799,94.022c-2.909-0.628-6.004-0.931-9.344-0.931c-25.67,0-46.545,20.876-46.545,46.545H256
                                        C256,117.562,240.349,98.374,218.799,94.022z"/>
                                    <path style="fill:#014463;" d="M509.254,143.756c-2.211-2.607-5.457-4.119-8.89-4.119h-34.909V69.818
                                        c0-6.435-5.201-11.636-11.636-11.636h-58.182V23.273c0-6.435-5.201-11.636-11.636-11.636h-46.545H221.091
                                        c-6.435,0-11.636,5.201-11.636,11.636v46.545c-38.505,0-69.818,31.313-69.818,69.818h-31.814L96.279,75.369
                                        c-2.944-16.71-17.361-28.823-34.257-28.823H34.909C15.663,46.545,0,62.208,0,81.455s15.663,34.909,34.909,34.909
                                        s34.909-15.663,34.909-34.909c0-3.34-0.617-6.505-1.501-9.565c2.548,1.711,4.48,4.305,5.062,7.564l53.527,276.713
                                        c-13.254,8.204-22.179,22.761-22.179,39.471c0,25.67,20.876,46.545,46.545,46.545h302.545c6.435,0,11.636-5.201,11.636-11.636
                                        c0-6.435-5.201-11.636-11.636-11.636H151.273c-12.835,0-23.273-10.438-23.273-23.273c0-12.835,10.438-23.273,23.273-23.273h284.16
                                        c22.796,0,42.554-17.012,45.917-39.366l30.487-179.782C512.407,149.841,511.465,146.385,509.254,143.756z M34.909,93.091
                                        c-6.423,0-11.636-5.213-11.636-11.636c0-6.423,5.213-11.636,11.636-11.636s11.636,5.213,11.636,11.636
                                        C46.545,87.878,41.332,93.091,34.909,93.091z M395.636,81.455h46.545v58.182h-46.545V81.455z M349.091,34.909h23.273v34.909v69.818
                                        h-23.273V34.909z M232.727,73.786V34.909h93.091v104.727h-23.273h-23.273c0-29.917-19.27-56.134-46.732-65.734
                                        C232.611,73.856,232.657,73.833,232.727,73.786z M209.455,93.091c3.34,0,6.435,0.303,9.344,0.931
                                        C240.349,98.374,256,117.562,256,139.636h-93.091C162.909,113.967,183.785,93.091,209.455,93.091z M458.368,329.332
                                        c-1.699,11.264-11.567,19.759-22.935,19.759H149.19l-36.934-186.182h374.33L458.368,329.332z"/>

                                    </svg>

                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Supply Chain Management</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail">Product Data Management, Supply Chain Management  Procurement, Logistics, Warehousing &amp; Sales, Price Management with loyalty programs embedded with Accounting, Fixed Asset Management and HR</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 501.416 501.416" style="enable-background:new 0 0 501.416 501.416;" xml:space="preserve">
<g>
    <polygon style="fill:#6E76E5;" points="420.176,346.401 360.654,332.173 298.867,270.386 270.583,298.671 332.369,360.458 
        346.598,419.98 427.837,501.22 501.416,427.642   "/>
    <path style="fill:#00EED1;" d="M165.104,255.089l-14.425,14.407c-40.696-13.031-86.181-2.479-116.921,28.205
        c-34.169,34.108-43.429,86.397-23.041,130.117l12.057,25.854l55.322-55.194l9.194,9.177l115.192-115.192L165.104,255.089z"/>
    <path style="fill:#00EED1;" d="M407.841,87.104l8.971,8.938l-17.909-17.876l55.344-55.215l-25.973-12.068
        C384.51-9.453,332.162-0.212,298.011,33.875c-30.739,30.685-41.32,76.086-28.286,116.725l-14.383,14.365l37.32,37.317
        L407.841,87.104z"/>
    <path style="fill:#00CCB3;" d="M292.662,202.282l37.147,37.144l14.42-14.401c11.483,3.676,23.34,5.475,35.146,5.475
        c30.037-0.002,59.708-11.653,81.774-33.68c34.17-34.107,43.43-86.397,23.042-130.118l-12.056-25.854l-55.323,55.194l-8.971-8.938
        L292.662,202.282z"/>
    <path style="fill:#00CCB3;" d="M87.281,407.664l8.723,8.69L40.659,471.57l25.974,12.068c15.484,7.195,32.039,10.687,48.487,10.687
        c30.038-0.001,59.708-11.653,81.775-33.68c30.741-30.685,41.321-76.086,28.288-116.725l14.387-14.369l-37.089-37.087
        L87.281,407.664z"/>
    <path style="fill:#B39A7C;" d="M27.639,14.052C37.712,6.579,49.702,2.279,62.371,1.661C49.702,2.279,37.712,6.579,27.639,14.052z"
        />
    <path style="fill:#B39A7C;" d="M20.463,20.243C8.403,32.303,1.766,48.333,1.775,65.379c0.009,17.032,6.65,33.045,18.697,45.085
        l219.096,219.087l0.067,0.067l45.101-45.101L20.463,20.243z"/>
    <path style="fill:#C0AB91;" d="M284.737,284.517l45.082-45.082c-0.009-0.009-219.149-219.13-219.149-219.13
        C98.656,8.251,82.659,1.603,65.625,1.584l-0.073,0c-1.064,0-2.125,0.026-3.18,0.077c-12.669,0.617-24.659,4.917-34.732,12.39
        c-2.518,1.868-4.917,3.935-7.176,6.192L284.737,284.517z"/>

</svg>

                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Service Sector</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail"> Projects, Contracting, Annual Maintenance contracts, after Sales Service Contracts, attending Complaint calls,
Gateway ERP audience in this segment are industries doing fire protection service projects, maintenance and services of any kind, after sales AMC service providers, contracting and maintenance companies, contract projects, Insurance etc.</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
<path style="fill:#CEDEEC;" d="M400.696,467.196C359.532,495.452,309.702,512,256,512C114.615,512,0,397.384,0,256
    c0-44.35,11.283-86.064,31.127-122.435h113.568V25.402C178.352,9.127,216.11,0,256,0c141.384,0,256,114.616,256,256
    c0,63.794-23.341,122.132-61.939,166.957h-49.366V467.196z"/>
<g>
    <path style="fill:#ABC5FF;" d="M256,512L256,512c-55.325,0-100.174-44.849-100.174-100.174V100.174C155.826,44.849,200.675,0,256,0
        l0,0c55.325,0,100.174,44.849,100.174,100.174v311.652C356.174,467.151,311.325,512,256,512z"/>
    <path style="fill:#ABC5FF;" d="M20.349,155.826h471.304C504.747,186.595,512,220.449,512,256s-7.253,69.405-20.349,100.174H20.349
        C7.253,325.405,0,291.551,0,256S7.253,186.595,20.349,155.826z"/>
</g>
<path style="fill:#809DED;" d="M155.826,155.826h200.348v200.348H155.826V155.826z"/>
<path style="fill:#FFB933;" d="M456.348,405.632v12.388c0,4.341-3.064,8.078-7.32,8.93l-22.707,4.541
    c-1.581,5.65-3.821,11.021-6.642,16.027l12.847,19.27c2.408,3.612,1.932,8.421-1.138,11.491l-8.76,8.76
    c-3.07,3.07-7.879,3.546-11.491,1.138l-19.27-12.847c-5.005,2.819-10.377,5.06-16.027,6.64l-4.541,22.707
    c-0.852,4.256-4.589,7.32-8.93,7.32h-12.388c-4.341,0-8.078-3.064-8.93-7.32l-4.541-22.707c-5.65-1.581-11.021-3.821-16.027-6.64
    l-19.27,12.847c-3.612,2.408-8.421,1.932-11.491-1.138l-8.76-8.76c-3.07-3.07-3.546-7.879-1.138-11.491l12.847-19.27
    c-2.819-5.005-5.06-10.377-6.642-16.027l-22.707-4.541c-4.256-0.851-7.32-4.589-7.32-8.93v-12.388c0-4.341,3.064-8.078,7.32-8.93
    l22.707-4.541c1.581-5.65,3.821-11.021,6.642-16.027l-12.847-19.27c-2.408-3.612-1.932-8.421,1.138-11.491l8.76-8.76
    c3.07-3.07,7.879-3.546,11.491-1.138l19.27,12.847c5.005-2.819,10.377-5.06,16.027-6.64l4.541-22.707
    c0.852-4.256,4.589-7.32,8.93-7.32h12.388c4.341,0,8.078,3.064,8.93,7.32l4.541,22.707c5.65,1.581,11.021,3.821,16.027,6.64
    l19.27-12.847c3.612-2.408,8.421-1.932,11.491,1.138l8.76,8.76c3.07,3.07,3.546,7.879,1.138,11.491l-12.847,19.27
    c2.819,5.005,5.06,10.377,6.642,16.027l22.707,4.541C453.284,397.554,456.348,401.291,456.348,405.632z"/>
<path style="fill:#FFE473;" d="M408.487,411.826c0,28.891-23.422,52.313-52.313,52.313s-52.313-23.422-52.313-52.313
    c0-28.891,23.422-52.313,52.313-52.313S408.487,382.935,408.487,411.826z"/>
<path style="fill:#5D7EAC;" d="M311.652,146.19v19.271c0,6.753-4.766,12.566-11.388,13.891l-35.322,7.064
    c-2.459,8.789-5.945,17.144-10.33,24.931l19.984,29.975c3.745,5.619,3.005,13.099-1.77,17.874l-13.627,13.627
    c-4.775,4.775-12.256,5.516-17.874,1.77l-29.975-19.984c-7.787,4.386-16.142,7.871-24.931,10.33l-7.064,35.322
    c-1.325,6.621-7.138,11.388-13.891,11.388h-19.271c-6.753,0-12.566-4.766-13.891-11.388l-7.064-35.322
    c-8.789-2.459-17.144-5.944-24.931-10.33L70.33,274.594c-5.619,3.745-13.099,3.005-17.874-1.77l-13.627-13.627
    c-4.775-4.775-5.516-12.256-1.77-17.874l19.984-29.975c-4.387-7.787-7.871-16.142-10.33-24.931l-35.322-7.064
    C4.766,178.028,0,172.215,0,165.462V146.19c0-6.753,4.766-12.566,11.388-13.891l35.322-7.064c2.46-8.789,5.944-17.144,10.33-24.931
    L37.057,70.329c-3.745-5.619-3.005-13.099,1.77-17.874l13.627-13.627c4.775-4.775,12.256-5.515,17.874-1.77l29.975,19.984
    c7.787-4.387,16.142-7.871,24.931-10.33l7.064-35.322C133.624,4.766,139.438,0,146.19,0h19.271c6.753,0,12.566,4.766,13.891,11.388
    l7.064,35.322c8.789,2.459,17.144,5.944,24.931,10.33l29.975-19.984c5.619-3.745,13.099-3.005,17.874,1.77l13.627,13.627
    c4.775,4.775,5.516,12.256,1.77,17.874l-19.984,29.975c4.386,7.787,7.871,16.142,10.33,24.931l35.322,7.064
    C306.886,133.624,311.652,139.438,311.652,146.19z"/>
<path style="fill:#809DED;" d="M235.965,155.826c0,44.259-35.88,80.139-80.139,80.139s-80.139-35.88-80.139-80.139
    s35.879-80.139,80.139-80.139S235.965,111.566,235.965,155.826z"/>
<path style="fill:#344966;" d="M202.574,155.826c0,25.818-20.93,46.748-46.748,46.748s-46.748-20.93-46.748-46.748
    s20.93-46.748,46.748-46.748S202.574,130.008,202.574,155.826z M356.174,381.774c-16.598,0-30.052,13.454-30.052,30.052
    s13.454,30.052,30.052,30.052s30.052-13.454,30.052-30.052S372.772,381.774,356.174,381.774z"/>
<path style="fill:#5D7EAC;" d="M171.409,155.826c0,20.353-13.01,37.659-31.165,44.078c-18.155-6.419-31.165-23.725-31.165-44.078
    s13.01-37.659,31.165-44.078C158.398,118.167,171.409,135.473,171.409,155.826z M343.374,384.634
    c-10.194,4.807-17.252,15.174-17.252,27.192c0,12.018,7.058,22.384,17.252,27.192c10.194-4.807,17.252-15.174,17.252-27.192
    C360.626,399.809,353.568,389.442,343.374,384.634z"/>

</svg>


                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Manufacturing</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail">Manufacturing Industry process flow differs from one to another as per Product type, method of Manufacturing and Selling. Batch Processing, Line Processing, Single Unit Manufacturing and Delivery, Manufacture and Install in projects etc</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
<circle style="fill:#FFA037;" cx="256" cy="256" r="256"/>
<circle style="fill:#FFC850;" cx="256" cy="256" r="173.714"/>
<path style="fill:#FF8C32;" d="M118.857,256c0-120.917,83.858-222.184,196.571-248.99C296.349,2.472,276.467,0,256,0
    C114.615,0,0,114.615,0,256c0,141.384,114.615,256,256,256c20.469,0,40.349-2.472,59.429-7.009
    C202.715,478.183,118.857,376.915,118.857,256z"/>
<path style="fill:#FFB23C;" d="M166.873,404.905C136.75,362.939,118.857,311.608,118.857,256s17.893-106.939,48.015-148.905
    C116.265,137.455,82.286,192.689,82.286,256S116.265,374.545,166.873,404.905z"/>
<path style="fill:#FFFFFF;" d="M430.535,145.464c-3.571-3.571-9.358-3.571-12.929,0l-52.193,52.189
    c-3.826,3.826-10.031,3.826-13.857,0l-1.283-1.283c-3.826-3.826-3.826-10.031,0-13.857l52.035-52.035
    c3.571-3.571,3.571-9.357,0-12.928c-3.571-3.571-9.358-3.571-12.929,0l-52.035,52.035c-3.826,3.826-10.031,3.826-13.857,0l0,0
    c-3.826-3.826-3.826-10.031,0-13.857l52.191-52.19c3.571-3.571,3.571-9.357,0-12.928c-3.571-3.571-9.358-3.571-12.929,0
    l-55.759,55.754c-8.651,8.647-13.759,19.656-14.018,30.309l-0.274,23.821c-0.029,2.52-1.097,4.915-2.951,6.622L117.361,365.75
    c-10.147,10.147-10.147,26.6,0,36.747s26.6,10.147,36.747,0l158.359-172.083c1.747-1.899,4.217-2.971,6.799-2.952l24.439,0.19
    c0.187,0,0.366,0.005,0.553,0.005c10.813,0,21.911-4.902,30.518-13.504l55.759-55.759
    C434.106,154.822,434.106,149.035,430.535,145.464z"/>
<path style="fill:#FAF0C3;" d="M269.682,225.577l-72.863,67.051l16.296,16.296c5.002,5.002,11.171,8.335,17.847,10.057
    l63.319-68.807L269.682,225.577z"/>
<path style="fill:#FFFFFF;" d="M130.811,112.566l253.934,253.934c10.147,10.147,10.147,26.6,0,36.747l0,0
    c-10.147,10.147-26.6,10.147-36.747,0l-61.653-61.653c-6.314-6.314-7.718-15.68-4.209-23.35c1.848-4.04,1.544-8.714-1.598-11.856
    l-10.394-10.394c-4.059-4.059-10.64-4.059-14.699,0l0,0c-8.118,8.118-21.28,8.118-29.398,0l-70.163-70.163
    c-52.089-52.089-47.176-91.744-39.981-110.32C118.255,109.439,126.207,107.961,130.811,112.566z"/>

</svg>



                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Food Industry</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail">
Food Industry divides into Food Stuff Trading and Cook and Serve as in Restaurants, Coffee Shops, Outlets, Industrial Catering etc…., so it requires a keen observation from Procurement to Delivery where Real Time Information is necessary.</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                            <div class="card-container img-rounded">
                                <div class="card-top">
                                    <div class="card-svg">
                                    <?xml version="1.0" encoding="iso-8859-1"?>
<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Generator: Adobe Illustrator 19.0.0, SVG Export Plug-In . SVG Version: 6.00 Build 0)  -->
<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     viewBox="0 0 60 60" style="enable-background:new 0 0 60 60;" xml:space="preserve">
<path style="fill:#F4E6CE;" d="M52.125,27.875L52.125,27.875c-1.167-1.167-3.076-1.167-4.243,0L31.757,44H4.037c-1.65,0-3,1.35-3,3
    c0,1.65,1.35,3,3,3h28c1.172,0,2.255-0.333,3.118-0.912l16.971-16.971C53.292,30.951,53.292,29.042,52.125,27.875z"/>
<polyline style="fill:none;stroke:#7F6E5D;stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;" points="1,53 36,53 59,30 
    "/>
<line style="fill:none;stroke:#7F6E5D;stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;" x1="59" y1="57" x2="46" y2="44"/>
<path style="fill:#CB8252;stroke:#7F6E5D;stroke-width:2;stroke-linecap:round;stroke-miterlimit:10;" d="M57.513,56H1v-3h54
    l2.655,2.655C57.783,55.783,57.692,56,57.513,56z"/>
<circle style="fill:#F29C1F;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" cx="17" cy="13" r="7"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="17" y1="6" x2="17" y2="3"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="17" y1="23" x2="17" y2="20"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="24" y1="13" x2="27" y2="13"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="7" y1="13" x2="10" y2="13"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="12.05" y1="8.05" x2="9.929" y2="5.929"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="24.071" y1="20.071" x2="21.95" y2="17.95"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="21.95" y1="8.05" x2="24.071" y2="5.929"/>
<line style="fill:none;stroke:#F0C419;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;" x1="9.929" y1="20.071" x2="12.05" y2="17.95"/>
<path style="fill:#81CCB8;stroke:#81CCB8;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" d="M38.966,7.914
    c-1.49-0.86-3.403-0.414-4.231,1.021c3.452-5.979,10.847-7.594,16.825-4.142s8.277,10.664,4.825,16.642
    c0.828-1.435,0.259-3.315-1.231-4.175c-1.49-0.86-3.37-0.395-4.198,1.04c0.828-1.435,0.292-3.295-1.198-4.156
    c-1.49-0.86-3.37-0.394-4.198,1.04c0.828-1.435,0.292-3.295-1.198-4.156s-3.37-0.394-4.198,1.04
    C40.992,10.634,40.456,8.774,38.966,7.914z"/>
<path style="fill:#546A79;" d="M31.757,44l0.741-0.741l14.128-27.806c0.25-0.492,0.054-1.095-0.438-1.345
    c-0.493-0.248-1.095-0.053-1.345,0.438l-14.734,29c-0.074,0.146-0.098,0.3-0.097,0.453H31.757z"/>

</svg>




                                </div>
                            </div>
                            <div class="card-bottom">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <h4 class="product-heading">Travel &amp; Tourism</h4>        
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <p class="product-detail">
Real time response with better options of Travel, Stay, Visa, Documentation and Other services as per the needs of clients, is the aim of all IATA or Non IATA Agents worldwide. All the services are buying from third parties, communicate and execute in time are the challenge.</p> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <img src="<%=contextPath%>/icons/gateway_logo.gif" class="img-responsive" style="transform: scale(0.7);">
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-image-container">
            <img src="<%=contextPath%>/icons/gateway_logo.gif" alt="">
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.2/TimelineMax.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.20.2/TweenMax.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/lettering.js/0.7.0/jquery.lettering.min.js"></script> -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.min.js"></script>
        <script type="text/javascript">
            var logoall=document.querySelectorAll('#svg-animation *');
   
            $(document).ready(function(){
               // logoTimeline.play();
               var logoall=document.querySelectorAll('#svg-animation *');
               //$(logoall).css('opacity','0');
               anime({
                  targets: 'logo-desktop-logo,.logo-table,.logo-table-opener,.logo-curtain-opener,.logo-curtain,.logo-cable-circle,.logo-desktop,.logo-mouse,.logo-bottomline,.logo-switchboard,.logo-lamp,.logo-mug,.logo-desktop-screen,.logo-penholder,.logo-desktop-screen,.logo-table-opener,.logo-bottom-bullet,.logo-lamp-bulb,.logo-dottedline',
                  strokeDashoffset: [anime.setDashoffset, 0],
                  strokeWidth:function(el){
                    return el.getAttribute('stroke-width');
                  },
                  fill:function(el){
                    return el.getAttribute('fill');
                  },

                  opacity:1,
                  duration: 5000,
                  easing:'easeInOutQuart',
                  direction:'alternate',
                  loop:true,
                  complete: function(anim) {
                    $('.svg-container img').css('opacity',1);
                  }
                });

                var owlquote=$("#quote-slider");
                owlquote.owlCarousel({
                    items:1,
                    itemsDesktop:[1000,1],
                    itemsDesktopSmall:[979,1],
                    itemsTablet:[767,1],
                    pagination:false,
                    transitionStyle:"fade",
                    navigation:false,
                    navigationText:["",""],
                    autoPlay:true
                });
                var owlproduct=$("#product-slider");
                owlproduct.owlCarousel({
                    items:1,
                    itemsDesktop:[1000,1],
                    itemsDesktopSmall:[979,1],
                    itemsTablet:[767,1],
                    pagination:false,
                    transitionStyle:"backSlide",
                    navigation:false,
                    navigationText:["",""],
                    autoPlay:3000,
                    stopOnHover:true
                });
                
            });
            
            
            function openNewWindow()
       	 {
       	 var url=document.URL;
       	     var reurl=url.split("login");
       	     
       	      var newWindow = window.open(reurl[0]+"login.jsp", "GatewayERP(i)",'resizable=0,scrollbars=0,'+
       	       'menubar=0,location=no,directories=0,fullscreen=0,channelmode=1,titlebar=0,statusbar=0,addressbar=0,width=1366,height=768'); 
       	       
       	     if (window.focus) {newWindow.focus()}
       	     return false;
       	 }
        </script>
    </body>
</html>