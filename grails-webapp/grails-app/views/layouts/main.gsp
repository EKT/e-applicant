<html>
    <head>
        <title><g:layoutTitle default="EKTApplicationTracker" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'selectlist.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon_ekt.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="boxover" />
        <g:javascript library="jquery-1.5.1" />
        <g:javascript library="selectlist" />
        <g:javascript library="md5" />
        <g:javascript library="jcap" />
    </head>
    <body>
    	<div style="padding: 10px">
    		<div><img src="${request.getContextPath()}/images/menu_head.gif"/></div>
    		<div><img style="width:730px; height:18px" src="${request.getContextPath()}/images/menu_red_bar.gif"/></div>
    		<div><img style="width:747px; height:30px" src="${request.getContextPath()}/images/menu_white_bar.gif"/></div>

        	
        	<g:layoutBody />
        	
        	<div style="clear: both; width:730px; height:18px; background-image: url(${request.getContextPath()}/images/menu_red_bar_730.gif); color: #fff";>Copyright © ΕΚΤ</div>
        
        
        	<!-- Google analytics -->
        	<script type="text/javascript">
				var _gaq = _gaq || [];
				_gaq.push(['_setAccount', 'UA-2014480-39']);
				_gaq.push(['_trackPageview']);
				(function() {
					var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
					ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
					var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })();
			</script>
        </div>
    </body>
</html>