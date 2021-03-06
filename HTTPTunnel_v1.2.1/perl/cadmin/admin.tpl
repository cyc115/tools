<html>
<head>
<title>HTTPTunnel Client Administration</title>
<link rel="shortcut icon" href="client.ico" type="image/x-icon" />
<link type="text/css" rel="StyleSheet" href="tab.css" />
<script type="text/javascript" src="tabpane.js"></script>
<script type="text/javascript" src="overlib_mini.js"></script>
<script>
	function initAddPortmap() {
		var dialog=window.open('','portmap','height=210,width=385,dependent=yes,directories=no,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no');
		dialog.document.write(getPortmapHTML('Add','','','','','',-1));
		dialog.document.close();
	}

	function initAddUser() {
		var dialog=window.open('','user','height=130,width=385,dependent=yes,directories=no,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no');
		dialog.document.write(getUserHTML('Add','','',-1));
		dialog.document.close();
	}

	function initModPortmap() {
		var sel=document.adminform.d_PORTMAP;
		if (sel.selectedIndex==-1) return;
		var a=parsePortmap(sel.options[sel.selectedIndex].text);
		dialog=window.open('','portmap', 'height=210,width=385,dependent=yes,directories=no,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no');
		dialog.document.write(getPortmapHTML('Modify',a[2],a[3],a[4],a[5],a[6],sel.selectedIndex));
		dialog.document.close();
	}

	function initModUser() {
		var sel=document.adminform.d_SOCKS_USER;
		if (sel.selectedIndex==-1) return;
		var a=parseUser(sel.options[sel.selectedIndex].text);
		dialog=window.open('','user', 'height=130,width=385,dependent=yes,directories=no,location=no,menubar=no,resizable=yes,scrollbars=no,status=no,toolbar=no');
		dialog.document.write(getUserHTML('Modify',a[1],a[2],sel.selectedIndex));
		dialog.document.close();
	}

	function parsePortmap(s) {return s.match(/^(([^:]+):)?(\d+) -> ([^:]+):(\d+) \((.*)\)$/);}
	function parseUser(s) {return s.match(/^([^:]+):(.*)$/);}

	function removeSel(name) {
		var sel=document.adminform.elements[name];
		var i=sel.selectedIndex;
		if (i==-1) return;
		sel.options[i]=null;
		if (sel.length>i) sel.selectedIndex=i;
		else sel.selectedIndex=sel.length-1;
	}

	function cmpOptionsInt(a,b) {return (parseInt(a.value)-parseInt(b.value));}
	function cmpOptionsStr(a,b) {return a<b?-1:(a>b?1:0);}
	function addmodOption(isInt,name,idx,text,value) {
		var sel=document.adminform.elements[name];
		var a=new Array();var x=-1,i;
		for (i=0;i<sel.length;i++) a[i]=sel.options[i];
		a[idx==-1?a.length:idx]=new Option(text,value);
		a.sort(isInt?cmpOptionsInt:cmpOptionsStr);
		for (i=0;i<a.length;i++) {sel.options[i]=a[i];if (a[i].value==value) x=i;}
		sel.selectedIndex=x;
	}

	function ableSocks() {
		var i=!document.adminform.d_SOCKS_ENABLED.checked;
		document.adminform.d_SOCKS_PORT.disabled=i;
		document.adminform.d_SOCKS_IF.disabled=i;
		var r=document.adminform.d_SOCKS_AUTH;
		for (var x=0;x<r.length;x++) r[x].disabled=(r[x].className=="noinp")?true:i;
		document.adminform.d_SOCKS_USER.disabled=i;
		document.adminform.d_SOUSADD.disabled=i;
		document.adminform.d_SOUSDEL.disabled=i;
		document.adminform.d_SOUSMOD.disabled=i;
	}

	function ableSvr() {
		var i=!document.adminform.d_AUTH_TYPE[1].checked;
		document.adminform.d_AUTH_USER.disabled=i;
		document.adminform.d_AUTH_PASS.disabled=i;
		document.adminform.d_AUTH_PASSTHROUGH.disabled=i;
	}

	function ableID() {
		var i=!document.adminform.d_ID_ENABLE.checked;
		document.adminform.d_ID_TIMEOUT.disabled=i;
		document.adminform.d_ID_BANTIMEOUT.disabled=i;
		document.adminform.d_ID_MAXACCESS.disabled=i;
	}

	function ablePxy() {
		var i=!document.adminform.d_PROXY_AUTH_TYPE[1].checked;
		document.adminform.d_PROXY_AUTH_USER.disabled=i;
		document.adminform.d_PROXY_AUTH_PASS.disabled=i;
		document.adminform.d_PROXY_AUTH_PASSTHROUGH.disabled=i;
	}

	function ableCry() {
		var i=!document.adminform.d_ENCRYPTION.checked;
		document.adminform.d_ENCRYPTION_FALLBACKOK.disabled=i;
	}

	function ableAuth() {
		var r=document.adminform.d_SOCKS_AUTH;
		var idx=0;
		for (var x=0;x<r.length;x++) {
			if (r[x].checked) {idx=x;break;}
		}
		switch (idx)
		{
		case 0:
			document.getElementById('authtab').style.visibility="hidden";
			break;
		default:
			document.getElementById('authtab').style.visibility="visible";
			document.getElementById('authtab').tabPane.setSelectedIndex(x-1);
			break;
		}
	}

	function getUserHTML (action,user,pass,idx) {
		var ret='\
		<head><title>'+action+' User</title>\n\
		<link type="text/css" rel="StyleSheet" href="tab.css" />\n\
		<script>\n\
			function doAddUser() {\n\
				var i,lfo,rfo,sel;\n\
				lfo=document.pm;rfo=window.opener.document.adminform;sel=rfo.d_SOCKS_USER;\n\
				if (lfo.user.value == "") {alert("Please specify a username!");return;}\n\
				for(i=0;i<sel.length;i++){if (i!='+idx+' && sel.options[i].value==lfo.user.value) {alert("Username "+lfo.user.value+" already exists!");return;}}\n\
				window.opener.addmodOption(0,"d_SOCKS_USER",'+(idx==-1?'-1':idx)+', lfo.user.value+":"+lfo.pass.value, lfo.user.value);\n\
				window.close();\n\
			}\n\
		</'+'script></head><body onLoad="document.pm.user.focus()" style="background:ThreeDFace;margin-right:30px;"><form name="pm">\n\
		<div class="input-pane"><table border=0 cellpadding=0 cellspacing=3 width=100%>\n\
		<tr><th colspan=2>'+action+' User</th></tr>\n\
		<tr><td>Username:</td><td><input name="user" style="width:100px" value="'+user+'"></td></tr>\n\
		<tr><td>Password:</td><td><input name="pass" style="width:100px" value="'+pass+'"></td></tr>\n\
		<tr><td colspan=2 align="center"><input type="submit" value="OK" onClick="doAddUser();return false;" style="width:70">\n\
		<input type="button" value="Cancel" onClick="window.close()" style="width:70"></td></tr>\n\
		</table></div></form></body>';
		return ret;
	}

	function getPortmapHTML (action,lif,lport,rname,rport,desc,idx) {
		var ret='\
		<head><title>'+action+' Portmapping</title>\n\
		<link type="text/css" rel="StyleSheet" href="tab.css" />\n\
		<script type="text/javascript" src="overlib_mini.js"></'+'script>\n\
		<script>\n\
			function doAddPortmap() {\n\
				var i,lfo,rfo,sel;\n\
				var msg="";\n\
				lfo=document.pm;rfo=window.opener.document.adminform;sel=rfo.d_PORTMAP;\n\
				lfo.lport.value=lfo.lport.value.replace(/\\s/g,"");\n\
				lfo.lif.value=lfo.lif.value.replace(/\\s/g,"");\n\
				lfo.rport.value=lfo.rport.value.replace(/\\s/g,"");\n\
				lfo.rname.value=lfo.rname.value.replace(/\\s/g,"");\n\
				if (isNaN(parseInt(lfo.lport.value)) || parseInt(lfo.lport.value)<=0)\n\
					msg+="Please specify a numeric port number to listen on!\\n";\n\
				if (lfo.lif.value!="" && !lfo.lif.value.match(/^\\d+\\.\\d+\\.\\d+\\.\\d+$/))\n\
					msg+="Local interface must be left blank or in the form \\"x.x.x.x\\"\\n";\n\
				if (isNaN(parseInt(lfo.rport.value)) || parseInt(lfo.rport.value)<=0)\n\
					msg+="Please specify a numeric port number to connect to!\\n";\n\
				if (lfo.rname.value == "")\n\
					msg+="Please specify a server to connect to!\\n";\n\
				if (lfo.desc.value == "")\n\
					msg+="Please specify a description!\\n";\n\
				if (msg) {alert(msg);return;}\n\
				for(i=0;i<sel.length;i++){if (i!='+idx+' && sel.options[i].value==lfo.lport.value) {alert("Port "+lfo.lport.value+" is already used by another portmapping!");return;}}\n\
				if (rfo.d_SOCKS_ENABLED.checked && lfo.lport.value==rfo.d_SOCKS_PORT.value) {alert("Port "+lfo.lport.value+" is already used by the SOCKS Proxy!");return;}\n\
				if (lfo.lport.value==rfo.d_ADMIN_PORT.value) {alert("Port "+lfo.lport.value+" is already used by the admin web interface!");return;}\n\	window.opener.addmodOption(1,"d_PORTMAP",'+(idx==-1?'-1':idx)+',(lfo.lif.value?lfo.lif.value+":":"")+lfo.lport.value+" -> "+lfo.rname.value+":"+lfo.rport.value+" ("+lfo.desc.value+")",lfo.lport.value);\n\
				window.close();\n\
			}\n\
		</'+'script></head><body onLoad="document.pm.lport.focus()" style="background:ThreeDFace;margin-right:30px;"><div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div><form name="pm">\n\
		<div class="input-pane"><table border=0 cellpadding=0 cellspacing=3 width=100%>\n\
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(\n\
		\'<b>Map port</b>:<br>port number on HTTPTunnel client.<br><b>on interface</b>:<br>If needed, the port can only be opened on a specific network interface. If this is not needed (the port will be open on all interfaces), leave blank.<br><b>to port, on server</b>:<br>Port number and server name of remote server.\', CAPTION, \'Portmapping Settings\');" onmouseout="return nd();"> '+action+' Portmapping</th></tr>\n\
		<tr><td>Map port:</td><td><input name="lport" style="width:50px" value="'+lport+'"></td></tr>\n\
		<tr><td>on interface:</td><td><input name="lif" style="width:100px" value="'+(lif?lif:"")+'"> (leave blank for all)</td></tr>\n\
		<tr><td>to port:</td><td><input name="rport" style="width:50px" value="'+rport+'"></td></tr>\n\
		<tr><td>on server:</td><td><input name="rname" style="width:100px" value="'+rname+'"></td></tr>\n\
		<tr><td>Description:</td><td><input name="desc" style="width:200px" value="'+desc+'"></td></tr>\n\
		<tr><td colspan=2 align="center"><input type="submit" value="OK" onClick="doAddPortmap();return false;" style="width:70">\n\
		<input type="button" value="Cancel" onClick="window.close()" style="width:70"></td></tr>\n\
		</table></div></form></body>';
		return ret;
	}

	// get a field value no matter what type of field it is
	function getValue(i) {
		var e=document.adminform.elements[i];
		var ret="";
		switch (e.type) {
		case "select-one":
		case "select-multiple":
			for (var i=0;i<e.length;i++) if (e.options[i].selected) ret+=(ret==""?"":"|")+e.options[i].value;
			break;
		case "checkbox":
			ret= e.checked?e.value:"";
			break;
		default:
			if (e[0] && e[0].type=="radio") {for (var i=0;i<e.length;i++) if (e[i].checked) {ret=e[i].value;break;}}
			else ret=e.value;
		}
		return ret;
	}
	
	function trim(i) {
		document.adminform.elements[i].value=getValue(i).replace(/\s/g,"");
	}
	
	function push(arr,msg,i) {
		arr.push(msg);
		if (i) document.adminform.elements[i].className="marked";
	}

	function clearMarks() {
		var i;
		for (i=0;i<document.adminform.elements.length;i++)
			if (document.adminform.elements[i].type=="text") document.adminform.elements[i].className="";
	}

	function submitForm () {
		var i,sel,s,a,f;
		f=document.adminform;
		// check form here ***************************************
		clearMarks();
		var warnings=new Array();
		var errors= new Array();

		// check tab1 *****************
		trim("d_SOCKS_PORT");trim("d_ADMIN_PORT");trim("d_SOCKS_IF");
		trim("d_LDAP_SERVER");trim("d_LDAP_PORT");trim("d_MYSQL_SERVER");trim("d_MYSQL_PORT");
		trim("d_MYSQL_USER");trim("d_MYSQL_DB");trim("d_SEC_IP");

		// do we have any ports open?
		if (f.d_PORTMAP.length<1 && !getValue('d_SOCKS_ENABLED')) {
			if (!f.d_ADMIN_PORT.value) push(errors,"No open server ports configured","");
			else push(warnings,"No open server ports configured except admin web interface","");
		}
		if (getValue('d_SOCKS_ENABLED')) {
			//check SOCKS port
			if (isNaN(parseInt(f.d_SOCKS_PORT.value)) || parseInt(f.d_SOCKS_PORT.value)<=0)
				push(errors,"Please specify a numeric SOCKS proxy listen port","d_SOCKS_PORT");
			else {
				for(i=0;i<f.d_PORTMAP.length;i++) 
					if (f.d_PORTMAP.options[i].value==f.d_SOCKS_PORT.value)
						push(errors,"SOCKS proxy listen port "+f.d_SOCKS_PORT.value+" is already used by a portmapping","d_SOCKS_PORT");
			}
			if (f.d_ADMIN_PORT.value && f.d_ADMIN_PORT.value==f.d_SOCKS_PORT.value)
				push(errors,"SOCKS proxy listen port is already used by the admin web interface","d_SOCKS_PORT");
			//check SOCKS interface
			if (f.d_SOCKS_IF.value && !f.d_SOCKS_IF.value.match(/^\d+\.\d+\.\d+\.\d+$/))
				push(errors,"SOCKS proxy interface must be left blank or in the form \"x.x.x.x\"","d_SOCKS_IF");
			//check SOCKS Authentication
			switch (getValue("d_SOCKS_AUTH")) {
			case "1":
				//check Fixed User List
				if (f.d_SOCKS_USER.length<1)
					push(warnings,"SOCKS authentication is set to use the fixed user list, but no users are configured","");
				break;
			case "2":
				// check LDAP
				if (!f.d_LDAP_SERVER.value)	push(errors,"Please specify an LDAP server name","d_LDAP_SERVER");
				if (isNaN(parseInt(f.d_LDAP_PORT.value)) || parseInt(f.d_LDAP_PORT.value)<=0)
					push(errors,"Please specify a numeric LDAP service port number","d_LDAP_PORT");
				if (!f.d_LDAP_FILTER.value)	push(errors,"Please specify an LDAP filter","d_LDAP_FILTER");
				break;
			case "3":
				// check MySQL
				if (!f.d_MYSQL_SERVER.value) push(errors,"Please specify a MySQL server name","d_MYSQL_SERVER");
				if (isNaN(parseInt(f.d_MYSQL_PORT.value)) || parseInt(f.d_MYSQL_PORT.value)<=0)
					push(errors,"Please specify a numeric MySQL service port number","d_MYSQL_PORT");
				if (!f.d_MYSQL_DB.value) push(errors,"Please specify a MySQL database name","d_MYSQL_DB");
				if (!f.d_MYSQL_QUERY.value) push(errors,"Please specify a MySQL query","d_MYSQL_QUERY");
				break;
			}
		}		
		// check SECIP
		if (f.d_SEC_IP.value && !f.d_SEC_IP.value.match(/((^|,)\d+\.\d+\.\d+\.\d+(\/\d+)?)+$/))
			push(errors,"Limit access to IPs must be in the format x.x.x.x[/x][,...]","d_SEC_IP");

		// check tab2 *****************
		trim("d_SERVER");trim("d_PORT");trim("d_URL");
		trim("d_PROXY_SERVER");trim("d_PROXY_PORT");

		if (!f.d_SERVER.value) push(errors,"Please specify a HTTPTunnel server name","d_SERVER");
		if (isNaN(parseInt(f.d_PORT.value)) || parseInt(f.d_PORT.value)<=0)
			push(errors,"Please specify a numeric HTTPTunnel server port number","d_PORT");
		if (f.d_URL.value.charAt(0)!="/") f.d_URL.value="/"+f.d_URL.value;

		if (getValue("d_AUTH_TYPE")=="basic" && !f.d_AUTH_USER.value)
			push(errors,"When authenticating against the HTTPTunnel server, a user name must be supplied","d_AUTH_USER");

		if (f.d_PROXY_SERVER.value) {
			if (isNaN(parseInt(f.d_PROXY_PORT.value)) || parseInt(f.d_PROXY_PORT.value)<=0)
				push(errors,"Please specify a numeric HTTP proxy port number","d_PROXY_PORT");
			if (getValue("d_PROXY_AUTH_TYPE")=="basic" && !f.d_PROXY_AUTH_USER.value)
				push(errors,"When authenticating against the HTTP proxy, a user name must be supplied","d_PROXY_AUTH_USER");
		}

		// check tab3 *****************
		trim("d_LOGLEVEL");trim("d_MAXLOGSIZE");trim("d_MAXLOGS");

		if (isNaN(parseInt(f.d_LOGLEVEL.value)) || parseInt(f.d_LOGLEVEL.value)<0)
			push(errors,"Please specify a numeric loglevel","d_LOGLEVEL");
		if (parseInt(f.d_LOGLEVEL.value)>0) {
			if (!f.d_LOGFILE.value) push(errors,"Please specify a log filename","d_LOGFILE");
			if (isNaN(parseInt(f.d_MAXLOGSIZE.value)) || parseInt(f.d_MAXLOGSIZE.value)<=0)
				push(errors,"Please specify a numeric maximum logfile size","d_MAXLOGSIZE");
			if (parseInt(f.d_MAXLOGSIZE.value)<100000)
				push(warnings,"Maximum logfile size should be at least 100 kbytes","");
			if (f.d_MAXLOGS.value && (isNaN(parseInt(f.d_MAXLOGSIZE.value)) || parseInt(f.d_MAXLOGSIZE.value)<0))
				push(errors,"Please specify a numeric number of logfiles to keep or leave empty","d_MAXLOGS");
		}

		// check tab4 *****************
		trim("d_DATA_SEND_THRESHHOLD");trim("d_DATA_SEND_DELAY");trim("d_DATA_SEND_MAXSIMCONN");
		trim("d_DATA_SEND_RETRYCOUNT");trim("d_DATA_SEQUENCE_WRAP");trim("d_OUTSOCKET_TIMEOUT");
		trim("d_THREADS");trim("d_MAXTHREADS");
		trim("d_ADMIN_IP");

		if (isNaN(parseInt(f.d_DATA_SEND_THRESHHOLD.value)) || parseInt(f.d_DATA_SEND_THRESHHOLD.value)<0)
			push(errors,"Please specify a numeric outbound queue threshhold size","d_DATA_SEND_THRESHHOLD");
		if (isNaN(parseInt(f.d_DATA_SEND_DELAY.value)) || parseInt(f.d_DATA_SEND_DELAY.value)<0)
			push(errors,"Please specify a numeric data send delay in milliseconds","d_DATA_SEND_DELAY");
		if (isNaN(parseInt(f.d_DATA_SEND_MAXSIMCONN.value)) || parseInt(f.d_DATA_SEND_MAXSIMCONN.value)<1)
			push(errors,"Please specify a maximum number of outbound data connections greater or equal to 1","d_DATA_SEND_MAXSIMCONN");
		if (isNaN(parseInt(f.d_DATA_SEND_RETRYCOUNT.value)) || parseInt(f.d_DATA_SEND_RETRYCOUNT.value)<0)
			push(errors,"Please specify a maximum number retires when sending data","d_DATA_SEND_RETRYCOUNT");
		if (isNaN(parseInt(f.d_DATA_SEQUENCE_WRAP.value)) || parseInt(f.d_DATA_SEQUENCE_WRAP.value)<0)
			push(errors,"Please specify a numeric data sequence wraparound value","d_DATA_SEQUENCE_WRAP");
		if (isNaN(parseInt(f.d_OUTSOCKET_TIMEOUT.value)) || parseInt(f.d_OUTSOCKET_TIMEOUT.value)<0)
			push(errors,"Please specify a numeric timeout value for outbound data connections","d_OUTSOCKET_TIMEOUT");

		if (isNaN(parseInt(f.d_THREADS.value)) || parseInt(f.d_THREADS.value)<0)
			push(errors,"Please specify a constant number of worker threads","d_THREADS");
		if (isNaN(parseInt(f.d_MAXTHREADS.value)) || parseInt(f.d_MAXTHREADS.value)<0)
			push(errors,"Please specify a maximum number of simultaneous connections","d_MAXTHREADS");
		else if (!isNaN(parseInt(f.d_MAXTHREADS.value)) && parseInt(f.d_MAXTHREADS.value)>0 && parseInt(f.d_MAXTHREADS.value)<parseInt(f.d_THREADS.value))
			push(errors,"The maximum number of simultaneous connections must be greater or equal to the constant number of worker threads","d_MAXTHREADS");

		if (getValue('d_ID_ENABLE')) {
			if (isNaN(parseInt(f.d_ID_MAXACCESS.value)) || parseInt(f.d_ID_MAXACCESS.value)<1)
				push(errors,"Please specify the maximum amount of login attempts","d_ID_MAXACCESS");
			if (isNaN(parseInt(f.d_ID_TIMEOUT.value)) || parseInt(f.d_ID_TIMEOUT.value)<1)
				push(errors,"Please specify a valid Intrusion Detection interval in seconds","d_ID_TIMEOUT");
			if (isNaN(parseInt(f.d_ID_BANTIMEOUT.value)) || parseInt(f.d_ID_BANTIMEOUT.value)<1)
				push(errors,"Please specify a valid client ban period in seconds","d_ID_BANTIMEOUT");
		}

		if (f.d_ADMIN_PORT.value) {
			if (isNaN(parseInt(f.d_ADMIN_PORT.value)) || parseInt(f.d_ADMIN_PORT.value)<=0)
				push(errors,"Please specify a numeric admin web interface port","d_ADMIN_PORT");
			else {
				for(i=0;i<f.d_PORTMAP.length;i++) 
					if (f.d_PORTMAP.options[i].value==f.d_ADMIN_PORT.value)
						push(errors,"The admin web interface port "+f.d_ADMIN_PORT.value+" is already used by a portmapping","d_ADMIN_PORT");
			}
			if (f.d_ADMIN_IP.value && !f.d_ADMIN_IP.value.match(/((^|,)\d+\.\d+\.\d+\.\d+(\/\d+)?)+$/))
				push(errors,"Limit access to IPs for admin web interface must be in the format x.x.x.x[/x][,...]","d_ADMIN_IP");
			if (!f.d_ADMIN_AUTH_USER.value)
				push(warnings,"The admin web interface does not require login","");
			else if (!f.d_ADMIN_AUTH_PASS.value)
				push(warnings,"The admin web interface login does not have a password set","");
		} else push(warnings,"You are about to disable the admin web interface","");

		if (errors.length) {
			alert ("ERRORS occurred while validating your input:\n\n"+errors.join("\n"));
			return false;
		}

		// transfer values to hidden fields **********************
		s="";sel=f.d_PORTMAP;
		for (i=0;i<sel.length;i++) {
			if (sel.options[i].text=="") continue;
			a=parsePortmap(sel.options[i].text);
			s+=(s==""?"":"\n")+(a[2]?a[2]+":":"")+a[3]+"\t"+a[4]+"\t"+a[5]+"\t"+a[6];
		}
		f.PORTMAP.value=s;
		f.SOCKS_ENABLED.value=getValue('d_SOCKS_ENABLED');
		f.SOCKS_PORT.value=getValue('d_SOCKS_PORT');
		f.SOCKS_IF.value=getValue('d_SOCKS_IF');
		f.SOCKS_AUTH.value=getValue('d_SOCKS_AUTH');
		s="";sel=f.d_SOCKS_USER;
		for (i=0;i<sel.length;i++) {
			if (sel.options[i].text=="") continue;
			s+=(s==""?"":"\n")+sel.options[i].text;
		}
		f.SOCKS_USER.value=s;
		f.SERVER.value=getValue('d_SERVER');
		f.PORT.value=getValue('d_PORT');
		f.URL.value=getValue('d_URL');
		f.AUTH_TYPE.value=getValue('d_AUTH_TYPE');
		f.AUTH_USER.value=getValue('d_AUTH_USER');
		f.AUTH_PASS.value=getValue('d_AUTH_PASS');
		f.AUTH_PASSTHROUGH.value=getValue('d_AUTH_PASSTHROUGH');
		f.DNS_RESOLUTION.value=getValue('d_DNS_RESOLUTION');
		f.PROXY_SERVER.value=getValue('d_PROXY_SERVER');
		f.PROXY_PORT.value=getValue('d_PROXY_PORT');
		f.PROXY_AUTH_TYPE.value=getValue('d_PROXY_AUTH_TYPE');
		f.PROXY_AUTH_USER.value=getValue('d_PROXY_AUTH_USER');
		f.PROXY_AUTH_PASS.value=getValue('d_PROXY_AUTH_PASS');
		f.PROXY_AUTH_PASSTHROUGH.value=getValue('d_PROXY_AUTH_PASSTHROUGH');
		f.LOGLEVEL.value=getValue('d_LOGLEVEL');
		f.LOGFILE.value=getValue('d_LOGFILE');
		f.MAXLOGSIZE.value=getValue('d_MAXLOGSIZE');
		f.MAXLOGS.value=getValue('d_MAXLOGS');
		f.DATA_SEND_THRESHHOLD.value=getValue('d_DATA_SEND_THRESHHOLD');
		f.DATA_SEND_DELAY.value=getValue('d_DATA_SEND_DELAY');
		f.DATA_SEND_MAXSIMCONN.value=getValue('d_DATA_SEND_MAXSIMCONN');
		f.DATA_SEND_RETRYCOUNT.value=getValue('d_DATA_SEND_RETRYCOUNT');
		f.DATA_SEQUENCE_WRAP.value=getValue('d_DATA_SEQUENCE_WRAP');
		f.OUTSOCKET_TIMEOUT.value=getValue('d_OUTSOCKET_TIMEOUT');
		f.ENABLE_ZLIB.value=getValue('d_ENABLE_ZLIB');
		f.ENCRYPTION.value=getValue('d_ENCRYPTION');
		f.ENCRYPTION_FALLBACKOK.value=getValue('d_ENCRYPTION_FALLBACKOK');
		f.THREADS.value=getValue('d_THREADS');
		f.MAXTHREADS.value=getValue('d_MAXTHREADS');
		f.ID_ENABLE.value=getValue('d_ID_ENABLE');
		f.ID_TIMEOUT.value=getValue('d_ID_TIMEOUT');
		f.ID_BANTIMEOUT.value=getValue('d_ID_BANTIMEOUT');
		f.ID_MAXACCESS.value=getValue('d_ID_MAXACCESS');
		f.ADMIN_PORT.value=getValue('d_ADMIN_PORT');
		f.ADMIN_IP.value=getValue('d_ADMIN_IP');
		f.ADMIN_AUTH_USER.value=getValue('d_ADMIN_AUTH_USER');
		f.ADMIN_AUTH_PASS.value=getValue('d_ADMIN_AUTH_PASS');
		f.LDAP_SERVER.value=getValue('d_LDAP_SERVER');
		f.LDAP_PORT.value=getValue('d_LDAP_PORT');
		f.LDAP_USER.value=getValue('d_LDAP_USER');
		f.LDAP_PASS.value=getValue('d_LDAP_PASS');
		f.LDAP_BASE.value=getValue('d_LDAP_BASE');
		f.LDAP_FILTER.value=getValue('d_LDAP_FILTER');
		f.MYSQL_SERVER.value=getValue('d_MYSQL_SERVER');
		f.MYSQL_PORT.value=getValue('d_MYSQL_PORT');
		f.MYSQL_USER.value=getValue('d_MYSQL_USER');
		f.MYSQL_PASS.value=getValue('d_MYSQL_PASS');
		f.MYSQL_DB.value=getValue('d_MYSQL_DB');
		f.MYSQL_QUERY.value=getValue('d_MYSQL_QUERY');
		f.SEC_IP.value=getValue('d_SEC_IP');

		return confirm(
		(warnings.length?("WARNING !!\n- "+warnings.join("\n- ")+"\n\n"):"")+
		"Would you "+(warnings.length?"still ":"")+"like to save your changes?\n\n"+
		"Please note: Saving your changes will cause the HTTPTunnel client\n"+
		"to be restarted, thereby disconnecting all currently connected\n"+
		"clients");
	}

	function refreshStatus() {
		window.frames["stats"].location.reload()
	}

	function hidePl() {
		document.getElementById('movie').style.visibility='hidden';
	}
	function showPl() {
		document.getElementById('movie').style.visibility='visible';
	}
</script>
</head>
<body style="background:ThreeDFace" onLoad="ableSocks();ableAuth();ableSvr();ablePxy();ableCry();ableID();">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<form name="adminform" action="admin_save.tpl" method="POST">
<input type="hidden" name="d_action" value="save">
<h1><img src="cpanel.png"> HTTPTunnel Client Administration</h1>
<%if @globalstatus>0%>
	<table class="warning">
	<tr><td colspan=2><b>HTTPTunnel client startup messages:</b></td></tr>
	<%eval $i=-1%>
	<%loop%>
	    <%if ++$i>=@globalstatus%>
	        <%break%>
	    <%end%>
		<tr><td> - </td><td><%$globalstatus[$i]%></td></tr>
	<%end%>
	</table>
<%end%>
<div id="mainpane" class="tab-pane" style="width: 600px">
   <div class="tab-page">
      <h2 class="tab">Tunnel Client</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'Ports that the HTTPTunnel client should listen on and forward network traffic to a specified destination.', CAPTION, 'Portmapping Proxy Settings');" onmouseout="return nd();"> Portmapping Proxy</th></tr>
		<tr><td colspan=2>
			<select name="d_PORTMAP" size=10 style="width:475;float:left">
<%eval $i=-1%>
<%eval @pm=split(/\n/,$cfg->{PORTMAP})%>
<%loop%>
    <%if ++$i>=@pm || $pm[$i] eq ""%>
        <%break%>
    <%end%>
	<%eval $pm[$i]=~m/^(\S+?)\s+(\S+?)\s+(\S+?)\s+(.+)$/; $_i0=$1; $_i1=$2; $_i2=$3; $_i3=$4;%>
    <%if $_i2 ne "S"%>
		<option value="<%$_i0%>"><%$_i0%> -> <%$_i1%>:<%$_i2%> (<%$_i3%>)</option>
	<%end%>
<%end%>
			</select>
			<input type="button" value="Add" onClick="initAddPortmap()" style="width:70"><br>
			<input type="button" value="Remove" onClick="removeSel('d_PORTMAP')" style="width:70"><br>
			<input type="button" value="Modify" onClick="initModPortmap()" style="width:70"><br>
		</td></tr>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Listen on interface</b>:<br>Specify the interface address the SOCKS proxy should listen on. Leave blank for all.<br><b>Please note:</b> When using SOCKS4 with authentication enabled, users can only log in if the password for this user is empty.', CAPTION, 'SOCKS (v4 and v5) Server Settings');" onmouseout="return nd();"> SOCKS Proxy</th></tr>
		<tr><td valign="top">
			<table border=0 cellpadding=0 cellspacing=0 width=100%>
			<tr><td colspan=2>
				<input type="checkbox" name="d_SOCKS_ENABLED" value="1" <%$cfg->{SOCKS_ENABLED}?"checked ":""%>style="margin-right:10px" onClick="ableSocks()">Enable SOCKS (v4 and v5) Proxy</td></tr>
			<tr><td>SOCKS proxy listen port:</td>
				<td style="text-align:right;padding-top:3px"><input style="width:50px" name="d_SOCKS_PORT" value="<%$cfg->{SOCKS_PORT}%>"></td></tr>
			<tr><td>Listen on interface:</td>
				<td style="text-align:right;padding-bottom:3px">
				<input style="width:100px" name="d_SOCKS_IF" value="<%$cfg->{SOCKS_IF}%>"></td></tr>
			<tr><th colspan=2>Authentication</th></tr>
			<tr><td colspan=2>
				<input type="radio" name="d_SOCKS_AUTH" style="vertical-align:middle;margin-right:10px" onClick="ableAuth()" value="0"<%$cfg->{SOCKS_AUTH}==0?" checked":""%>>No authentication<br>
				<input type="radio" name="d_SOCKS_AUTH" style="vertical-align:middle;margin-right:10px" onClick="ableAuth()" value="1"<%$cfg->{SOCKS_AUTH}==1?" checked":""%>>Fixed User list<br>
				<input type="radio" name="d_SOCKS_AUTH" style="vertical-align:middle;margin-right:10px" onClick="ableAuth()" value="2"<%($cfg->{MOD_LDAP_AVAILABLE} && $cfg->{SOCKS_AUTH}==2)?" checked":""%><%$cfg->{MOD_LDAP_AVAILABLE}?"":" class='noinp'"%>>LDAP<%$cfg->{MOD_LDAP_AVAILABLE}?"":" - <font color=red>Module not installed</font>"%><br>
				<input type="radio" name="d_SOCKS_AUTH" style="vertical-align:middle;margin-right:10px" onClick="ableAuth()" value="3"<%($cfg->{MOD_MYSQL_AVAILABLE} && $cfg->{SOCKS_AUTH}==3)?" checked":""%><%$cfg->{MOD_MYSQL_AVAILABLE}?"":" class='noinp'"%>>MySQL<%$cfg->{MOD_MYSQL_AVAILABLE}?"":" - <font color=red>Module not installed</font>"%>
			</td></tr></table>
		</td><td valign=top>
		<div id="authtab" class="tab-pane" style="width: 350">
			<div class="tab-page">
			<h2 class="tab">User List</h2>
			<table border=0 cellpadding=0 cellspacing=0 width="100%">
				<tr><th>Fixed User List Authentication Settings</th></tr>
				<tr><td style="padding-top:3px">
				<select name="d_SOCKS_USER" size=6 style="width:200;float:left">
<%eval $i=-1%>
<%eval @pm=split(/\n/,$cfg->{SOCKS_USER})%>
<%loop%>
    <%if ++$i>=@pm || $pm[$i] eq ""%>
        <%break%>
    <%end%>
	<%eval @pm1=split(/:/,$pm[$i])%>
		<option value="<%$pm1[0]%>"><%$pm1[0]%>:<%$pm1[1]%></option>
<%end%>
				</select>
				<input type="button" value="Add" name="d_SOUSADD" onClick="initAddUser()" style="width:70"><br>
				<input type="button" value="Remove" name="d_SOUSDEL" onClick="removeSel('d_SOCKS_USER')" style="width:70"><br>
				<input type="button" value="Modify" name="d_SOUSMOD" onClick="initModUser()" style="width:70"><br>
				</td></tr></table>
			</div>
			<div class="tab-page">
			<h2 class="tab">LDAP</h2>
			<table border=0 cellpadding=0 cellspacing=0 width=100%>
				<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Filter</b>:<br>This is the query that is sent to the LDAP server. If the query returns any entries, authentication is successful. The character sequences \'\\u\' and \'\\p\' are replaced by the username and password provided by the SOCKS client. Example of a filter:<br>(&(uid=\\u) (pass=\\p))', CAPTION, 'LDAP Authentication Settings');" onmouseout="return nd();"> LDAP Authentication</th></tr>
				<tr><td style="padding-top:3px">Server:</td><td style="padding-top:3px"><input name="d_LDAP_SERVER" style="width:200px" value="<%$cfg->{LDAP_SERVER}%>"></td></tr>
				<tr><td>Port:</td><td><input name="d_LDAP_PORT" style="width:50px" value="<%$cfg->{LDAP_PORT}?$cfg->{LDAP_PORT}:"389"%>"> (standard: 389)</td></tr>
				<tr><td>Username / Password:</td><td>
					<input name="d_LDAP_USER" style="width:98px" value="<%$cfg->{LDAP_USER}%>">
					<input name="d_LDAP_PASS" style="width:98px" value="<%$cfg->{LDAP_PASS}%>"></td></tr>
				<tr><td>Base DN:</td><td><input name="d_LDAP_BASE" style="width:200px" value="<%$cfg->{LDAP_BASE}%>"></td></tr>
				<tr><td>Filter:</td><td><input name="d_LDAP_FILTER" style="width:200px" value="<%$cfg->{LDAP_FILTER}%>"></td></tr>
				</table>
			</div>
			<div class="tab-page">
			<h2 class="tab">MySQL</h2>
			<table border=0 cellpadding=0 cellspacing=0 width=100%>
				<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Query</b>:<br>This is the query that is sent to the MySQL server. If the query returns any entries, authentication is successful. The character sequences \'\\u\' and \'\\p\' are replaced by the username and password provided by the SOCKS client. Example of a query:<br>SELECT * FROM users WHERE uid=\'\\u\' AND pass=PASSWORD(\'\\p\')', CAPTION, 'MySQL Authentication Settings');" onmouseout="return nd();"> MySQL Authentication</th></tr>
				<tr><td style="padding-top:3px">Server:</td><td style="padding-top:3px"><input name="d_MYSQL_SERVER" style="width:200px" value="<%$cfg->{MYSQL_SERVER}%>"></td></tr>
				<tr><td>Port:</td><td><input name="d_MYSQL_PORT" style="width:50px" value="<%$cfg->{MYSQL_PORT}?$cfg->{MYSQL_PORT}:"3306"%>"> (standard: 3306)</td></tr>
				<tr><td>Username / Password:</td><td>
					<input name="d_MYSQL_USER" style="width:98px" value="<%$cfg->{MYSQL_USER}%>">
					<input name="d_MYSQL_PASS" style="width:98px" value="<%$cfg->{MYSQL_PASS}%>"></td></tr>
				<tr><td>Database:</td><td><input name="d_MYSQL_DB" style="width:200px" value="<%$cfg->{MYSQL_DB}%>"></td></tr>
				<tr><td>Query:</td><td><input name="d_MYSQL_QUERY" style="width:200px" value="<%$cfg->{MYSQL_QUERY}%>"></td></tr>
				</table>
			</div>
		</div>
		</td></tr>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'Should unknown internet addresses be resolved by the HTTPTunnel client, server or both? \'On Tunnel Server\' should work in most cases.', CAPTION, 'DNS Name Resolution Options');" onmouseout="return nd();"> DNS Name Resolution</th></tr>
		<tr><td colspan=2>
			<input type="radio" name="d_DNS_RESOLUTION" style="vertical-align:middle;margin-right:10px" value="0"<%$cfg->{DNS_RESOLUTION}==0?" checked":""%>>On Tunnel Server
			<input type="radio" name="d_DNS_RESOLUTION" style="vertical-align:middle;margin-right:10px" value="1"<%$cfg->{DNS_RESOLUTION}==1?" checked":""%>>On Tunnel Client
			<input type="radio" name="d_DNS_RESOLUTION" style="vertical-align:middle;margin-right:10px" value="2"<%$cfg->{DNS_RESOLUTION}==2?" checked":""%>>First Client then Server
		</td></tr>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Limit access to IPs</b><br>A comma delimited list of IP adresses (netmask can be supplied) that are allowed to access the HTTPTunnel client, e.g. 127.0.0.1,10.0.0.0/8<br>Leave blank for no restrictions.<br>', CAPTION, 'Security Settings');" onmouseout="return nd();"> Security</th></tr>
		<tr><td colspan=2>Limit access to IPs: <input name="d_SEC_IP" style="width:200px" value="<%$cfg->{SEC_IP}%>"></td></tr>
		</table>
   </div>
	<div class="tab-page">
		<h2 class="tab">Tunnel Server</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th colspan=5><img src="info.gif" onmouseover="return overlib(
'Specifying the <b>URL</b> is only required when using the PHP server. This should be the path to the PHP script on the server (e.g. /tunnel.php5).<br><b>Please note</b>: When using the SOCKS username/password for authentication with the HTTPTunnel server, the SOCKS authentication is only passed through for the primary (incoming) data connection. The outgoing data connections will use the given Username and Password. This is, because outgoing data connections are shared between all connections.', CAPTION, 'HTTPTunnel Server Settings');" onmouseout="return nd();"> HTTPTunnel Server</th></tr>
		<tr><td>
			<table border=0 cellpadding=0 cellspacing=0>
			<tr><td>Server:</td><td><input name="d_SERVER" style="width:200px" value="<%$cfg->{SERVER}%>"></td>
				<td style="width:40px"></td>
				<td>Authentication:</td><td>
				<input type="radio" name="d_AUTH_TYPE" onClick="ableSvr();" value="none"<%$cfg->{AUTH_TYPE} eq "none"?" checked":""%>> None
				<input type="radio" name="d_AUTH_TYPE" onClick="ableSvr();" value="basic"<%$cfg->{AUTH_TYPE} eq "basic"?" checked":""%>> Basic</td></tr>
			<tr><td>Port:</td><td><input name="d_PORT" style="width:50px" value="<%$cfg->{PORT}?$cfg->{PORT}:"80"%>"></td>
				<td></td>
				<td>Username:</td><td><input name="d_AUTH_USER" style="width:100px" value="<%$cfg->{AUTH_USER}%>"></tr>
			<tr><td>URL:</td><td><input name="d_URL" style="width:200px" value="<%$cfg->{URL}%>"></td>
				<td></td>
				<td>Password:</td><td><input name="d_AUTH_PASS" style="width:100px" value="<%$cfg->{AUTH_PASS}%>"></tr>
			<tr><td colspan=3></td><td colspan=2>
				<input type="checkbox" name="d_AUTH_PASSTHROUGH" value="1" style="margin-right:10px"<%$cfg->{AUTH_PASSTHROUGH} eq "1"?" checked":""%>>Use SOCKS username/password</td></tr>
			</table></td></tr>
		<tr><th colspan=5><img src="info.gif" onmouseover="return overlib(
'<b>Server</b>:<br>Name of the proxy server. Leave blank if no proxy should be used.<br><b>Please note</b>: When using the SOCKS username/password for authentication with the HTTP proxy server, the SOCKS authentication is only passed through for the primary (incoming) data connection. The outgoing data connections will use the given Username and Password. This is, because outgoing data connections are shared between all connections.', CAPTION, 'HTTP Proxy Server Settings');" onmouseout="return nd();"> HTTP Proxy Server</th></tr>
		<tr><td>
			<table border=0 cellpadding=0 cellspacing=0>
			<tr><td>Server:</td><td><input name="d_PROXY_SERVER" style="width:200px" value="<%$cfg->{PROXY_SERVER}%>"></td>
				<td style="width:40px"></td>
				<td>Authentication:</td><td>
				<input type="radio" name="d_PROXY_AUTH_TYPE" onClick="ablePxy();" value="none"<%$cfg->{PROXY_AUTH_TYPE} eq "none"?" checked":""%>> None
				<input type="radio" name="d_PROXY_AUTH_TYPE" onClick="ablePxy();" value="basic"<%$cfg->{PROXY_AUTH_TYPE} eq "basic"?" checked":""%>> Basic</td></tr>
			<tr><td>Port:</td><td><input name="d_PROXY_PORT" style="width:50px" value="<%$cfg->{PROXY_PORT}?$cfg->{PROXY_PORT}:"80"%>"></td>
				<td></td>
				<td>Username:</td><td><input name="d_PROXY_AUTH_USER" style="width:100px" value="<%$cfg->{PROXY_AUTH_USER}%>"></tr>
			<tr><td colspan=3></td>
				<td>Password:</td><td><input name="d_PROXY_AUTH_PASS" style="width:100px" value="<%$cfg->{PROXY_AUTH_PASS}%>"></tr>
			<tr><td colspan=3></td><td colspan=2>
				<input type="checkbox" name="d_PROXY_AUTH_PASSTHROUGH" value="1" style="margin-right:10px"<%$cfg->{PROXY_AUTH_PASSTHROUGH} eq "1"?" checked":""%>>Use SOCKS username/password</td></tr>
			</table></td></tr>
		</table>
	</div>
   <div class="tab-page">
      <h2 class="tab">Logging</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Loglevel</b>:<br>- 0 = no logging<br>- 1 = log errors<br>- 2 = log connects/disconnects and warnings<br>- 3 = log data<br>- 4 = debug (not recommended)<br><b>Maximum logfile size</b>: After the logfile exceeds the specified size, it will be renamed, packed (if the appropriate modules are installed) and a new logfile is opened<br><b>Maximum number of logfiles to keep</b><br>The maximum number of old logfiles to keep. Leave empty for unlimited.', CAPTION, 'Logfile and Loglevel Settings');" onmouseout="return nd();"> Logfile and Loglevel</th></tr>
		<td>Loglevel:</td><td width=90%><input name="d_LOGLEVEL" style="width:50px" value="<%$cfg->{LOGLEVEL}%>"></td></tr>
		<td>Logfilename:</td><td><input name="d_LOGFILE" style="width:200px" value="<%$cfg->{LOGFILE}%>"></td></tr>
		<td>Maximum logfile size:</td><td><input name="d_MAXLOGSIZE" style="width:100px" value="<%$cfg->{MAXLOGSIZE}%>"> bytes</td></tr>
		<td>Maximum number of logfiles to keep:</td><td><input name="d_MAXLOGS" style="width:50px" value="<%$cfg->{MAXLOGS}%>"></td></tr>
		</table>
   </div>
   <div class="tab-page">
      <h2 class="tab">Advanced</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Outbound queue threshhold</b>, <b>Delay before sending</b>:<br>when tunneling outbound data to the server, the outbound connection is triggered by two events:<br>- either the outbound queue exceeds [Outbound queue threshhold] bytes<br>- or the last incoming data from the client is [Delay before sending data] milliseconds old<br>The size of the threshhold also has influence on the size of the requests sent to the server. So, if your server or proxy has problems with the size of the requests, decrease this value. (default: 10000 and 100)<br><b>Maximum simultaneous outbound connections</b>:<br>when tunneling large amounts of outbound data, the tunnel client will try to connect to the server multiple times simultaneously. This number controls the maximum amount of simultaneous connections for outbound data. Setting this value to a large number may increase tunnel performance when sending large amounts of data, but may also cause problems on the server (connection refused, etc.). The default is 3. If you experience problems, set this value to 1.<br><b>Maximum retries</b><br>How many times should the tunnel client try to send out data if an error occurrs? The default is 5. If you have problems with unreliable proxies, increase this number<br><b>Sequence wraparound</b><br>Sent data is sequenced with sequence numbers. If we have long connections, these numbers get relatively large. At what value should we wrap around? The default is 999.<br><b>Timeout</b><br>Socket timeout value in seconds for outbound data connections. The default is 2.', CAPTION,'Outbound Tunnel Options', WIDTH, 500);" onmouseout="return nd();"> Outbound Tunnel</th></tr>
		<tr><td>Outbound queue threshhold:</td><td width=90%><input name="d_DATA_SEND_THRESHHOLD" style="width:50px" value="<%$cfg->{DATA_SEND_THRESHHOLD}%>"> bytes</td></tr>
		<tr><td>Delay before sending data:</td><td width=90%><input name="d_DATA_SEND_DELAY" style="width:50px" value="<%$cfg->{DATA_SEND_DELAY}%>"> msecs</td></tr>
		<tr><td>Maximum simultaneous outbound connections:</td><td width=90%><input name="d_DATA_SEND_MAXSIMCONN" style="width:50px" value="<%$cfg->{DATA_SEND_MAXSIMCONN}%>"></td></tr>
		<tr><td>Maximum retries for sending outbound data:</td><td width=90%><input name="d_DATA_SEND_RETRYCOUNT" style="width:50px" value="<%$cfg->{DATA_SEND_RETRYCOUNT}%>"></td></tr>
		<tr><td>Data sequence wraparound value:</td><td width=90%><input name="d_DATA_SEQUENCE_WRAP" style="width:50px" value="<%$cfg->{DATA_SEQUENCE_WRAP}%>"></td></tr>
		<tr><td>Timeout value for outbound sockets:</td><td width=90%><input name="d_OUTSOCKET_TIMEOUT" style="width:50px" value="<%$cfg->{OUTSOCKET_TIMEOUT}%>"> secs</td></tr>
		
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib(
'<b>Constant number of worker threads</b><br>At program startup, the HTTPTunnel client initializes the specified number of permanent threads that listen for incoming connections.<br><b>Maximum number of simultaneous connections</b><br>defines the maximum number of simultaneous client connection this HTTPTunnel client can process. <b>Please note</b>: This number must be greater or equal to the constant number of worker threads of 0 for unlimited!', CAPTION,'Scalability Options');" onmouseout="return nd();"> Scalability</th></tr>
		<tr><td>Constant number of worker threads:</td><td width=90%><input name="d_THREADS" style="width:50px" value="<%$cfg->{THREADS}%>"></td></tr>
		<tr><td>Maximum number of simultaneous connections:</td><td width=90%><input name="d_MAXTHREADS" style="width:50px" value="<%$cfg->{MAXTHREADS}%>"></td></tr>

		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib('<b>Compress tunnel traffic</b>:<br>Should network traffic be compressed using Zlib compression? Please note: If the HTTPTunnel server does not support compression, all network traffic will automatically be uncompressed.<br><b>Encrypt tunnel traffic</b>:<br>Should network traffic be encrypted? Please note: If the HTTPTunnel server does not support encryption, an unencrypted connection will only be established if <b>Allow unencrypted connections</b> is checked.', CAPTION,'Tunnel Traffic Options');" onmouseout="return nd();"> Tunnel Traffic</th></tr>
		<tr><td colspan=2><input type="checkbox" name="d_ENABLE_ZLIB" value="1" style="margin-right:10px"<%($cfg->{ENABLE_ZLIB} && $cfg->{MOD_ZLIB_AVAILABLE})?" checked":""%><%$cfg->{MOD_ZLIB_AVAILABLE}?"":" disabled"%>>Compress tunnel traffic<%$cfg->{MOD_ZLIB_AVAILABLE}?"":" - <font color=red>Module not installed</font>"%></td></tr>
		<tr><td><input type="checkbox" onClick="ableCry();" name="d_ENCRYPTION" value="1" style="margin-right:10px"<%($cfg->{ENCRYPTION} && $cfg->{MOD_RSA_AVAILABLE})?" checked":""%><%$cfg->{MOD_RSA_AVAILABLE}?"":" disabled"%>>Encrypt tunnel traffic<%$cfg->{MOD_RSA_AVAILABLE}?"":" - <font color=red>Module not installed</font>"%></td>
		<td><input type="checkbox" name="d_ENCRYPTION_FALLBACKOK" value="1" style="margin-right:10px"<%$cfg->{ENCRYPTION_FALLBACKOK}?" checked":""%>>Allow unencrypted connections</td>
		</tr>

		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib('For additional security, configure intrusion detection and countermeasures here.', CAPTION,'Intrusion Detection Options');" onmouseout="return nd();"> Intrusion Detection and Countermeasures</th></tr>
		<tr><td colspan=2><input type="checkbox" onClick="ableID();" name="d_ID_ENABLE" value="1" style="margin-right:10px"<%$cfg->{ID_ENABLE}?" checked":""%>>Enable Intrusion Detection</td></tr>
		<tr><td colspan=2>Ban client IP after <input name="d_ID_MAXACCESS" style="width:50px" value="<%$cfg->{ID_MAXACCESS}%>"> attempts to access the tunnel client with invalid credentials.</td></tr>
		<tr><td colspan=2>These attempts must have been within an interval of <input name="d_ID_TIMEOUT" style="width:50px" value="<%$cfg->{ID_TIMEOUT}%>"> seconds.</td></tr>
		<tr><td colspan=2>The client IP will stay banned for <input name="d_ID_BANTIMEOUT" style="width:50px" value="<%$cfg->{ID_BANTIMEOUT}%>"> seconds.</td></tr>
		<tr><th colspan=2><img src="info.gif" onmouseover="return overlib('<b>Port</b><br>The port the admin web interface should be accessible at.<br><b>Limit access to IPs</b><br>A comma delimited list of IP adresses (netmask can be supplied) that are allowed to access the admin interface, e.g. 127.0.0.1,10.0.0.0/8<br>Leave blank for no restrictions.<br>', CAPTION,'Admin Interface Options');" onmouseout="return nd();"> Admin Interface</th></tr>
		<tr><td>Port:</td><td width=90%><input name="d_ADMIN_PORT" style="width:50px" value="<%$cfg->{ADMIN_PORT}%>"></td></tr>
		<tr><td>Limit access to IPs:</td><td width=90%><input name="d_ADMIN_IP" style="width:200px" value="<%$cfg->{ADMIN_IP}%>"></td></tr>
		<tr><td>Username:</td><td width=90%><input name="d_ADMIN_AUTH_USER" style="width:100px" value="<%$cfg->{ADMIN_AUTH_USER}%>"></td></tr>
		<tr><td>Password:</td><td width=90%><input name="d_ADMIN_AUTH_PASS" style="width:100px" value="<%$cfg->{ADMIN_AUTH_PASS}%>"></td></tr>
		</table>
   </div>
   <div class="tab-page">
	  <h2 class="tab">Status</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th><img src="refresh.gif" onmouseover="return overlib(
'Click here to refresh the status display');" onmouseout="return nd();" onClick="refreshStatus()"> Current HTTPTunnel Client Status</th></tr>
		<tr><td>
		<a href="stats.tpl" target="_new">Click here to open the current server status in a new window</a><br>
		<a href="log.tpl" target="_new">Click here to open the server log in a new window</a><br>
		<iframe name="stats" width=100% height=400 src="stats.tpl" border=0 frameborder=0></iframe>
		</td></tr>
		</table>
   </div>
   <div class="tab-page">
	  <h2 class="tab">About</h2>
		<table border=0 cellpadding=0 cellspacing=3 width=100%>
		<tr><th colspan=2>About HTTPTunnel</th></tr>
		<tr><td style="white-space:normal" valign=top width="100%"><h1>HTTPTunnel v<% REL_VERSION %></h1>
&copy;<% REL_YEAR %> by Sebastian Weber &lt;<a href="mailto:websersebastian@yahoo.de">webersebastian@yahoo.de</a>><br><br>
This software is licensed under the <a href="http://www.gnu.org/copyleft/gpl.html" target="_new">GNU general public license</a>
		</td><td align=right>
<a href="javascript:showPl()"><img src="logo.jpg" style="border:none"></a>
<table id="movie" cellspacing=0 cellpadding=0 style="position:absolute; width:240; visibility:hidden; left:344;top:22;z-index:1000; border:solid #949A9C 1px"><tr><td style="font-size:1px"><a href="javascript:hidePl()"><img src="bar.gif" style="margin:0px;padding:0px;border:none"></a></td></tr>
<tr><td height=180><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="240" height="180" id="3dlogo" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="3dlogo.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" /><embed src="3dlogo.swf" quality="high" bgcolor="#ffffff" width="240" height="180" name="3dlogo" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object></a></tr><td></table></td></tr>
		</table>
   </div>
   <center>
   <input type="button" value="Save" style="width:100px"
   onClick="if (submitForm()) document.adminform.submit()">
   <input type="button" value="Reset" style="width:100px"
   onClick="document.adminform.reset();ableSocks();ableAuth();ableSvr();ablePxy()">
   </center>
</div>
<input type="hidden" name="PORTMAP">
<input type="hidden" name="SOCKS_ENABLED">
<input type="hidden" name="SOCKS_PORT">
<input type="hidden" name="SOCKS_IF">
<input type="hidden" name="SOCKS_AUTH">
<input type="hidden" name="SOCKS_USER">
<input type="hidden" name="SERVER">
<input type="hidden" name="PORT">
<input type="hidden" name="URL">
<input type="hidden" name="AUTH_TYPE">
<input type="hidden" name="AUTH_USER">
<input type="hidden" name="AUTH_PASS">
<input type="hidden" name="AUTH_PASSTHROUGH">
<input type="hidden" name="DNS_RESOLUTION">
<input type="hidden" name="PROXY_SERVER">
<input type="hidden" name="PROXY_PORT">
<input type="hidden" name="PROXY_AUTH_TYPE">
<input type="hidden" name="PROXY_AUTH_USER">
<input type="hidden" name="PROXY_AUTH_PASS">
<input type="hidden" name="PROXY_AUTH_PASSTHROUGH">
<input type="hidden" name="LOGLEVEL">
<input type="hidden" name="LOGFILE">
<input type="hidden" name="MAXLOGSIZE">
<input type="hidden" name="MAXLOGS">
<input type="hidden" name="DATA_SEND_THRESHHOLD">
<input type="hidden" name="DATA_SEND_DELAY">
<input type="hidden" name="DATA_SEND_MAXSIMCONN">
<input type="hidden" name="DATA_SEND_RETRYCOUNT">
<input type="hidden" name="DATA_SEQUENCE_WRAP">
<input type="hidden" name="OUTSOCKET_TIMEOUT">
<input type="hidden" name="ENABLE_ZLIB">
<input type="hidden" name="ENCRYPTION">
<input type="hidden" name="ENCRYPTION_FALLBACKOK">
<input type="hidden" name="THREADS">
<input type="hidden" name="MAXTHREADS">
<input type="hidden" name="ID_ENABLE">
<input type="hidden" name="ID_TIMEOUT">
<input type="hidden" name="ID_BANTIMEOUT">
<input type="hidden" name="ID_MAXACCESS">
<input type="hidden" name="ADMIN_PORT">
<input type="hidden" name="ADMIN_IP">
<input type="hidden" name="ADMIN_AUTH_USER">
<input type="hidden" name="ADMIN_AUTH_PASS">
<input type="hidden" name="LDAP_SERVER">
<input type="hidden" name="LDAP_PORT">
<input type="hidden" name="LDAP_USER">
<input type="hidden" name="LDAP_PASS">
<input type="hidden" name="LDAP_BASE">
<input type="hidden" name="LDAP_FILTER">
<input type="hidden" name="MYSQL_SERVER">
<input type="hidden" name="MYSQL_PORT">
<input type="hidden" name="MYSQL_USER">
<input type="hidden" name="MYSQL_PASS">
<input type="hidden" name="MYSQL_DB">
<input type="hidden" name="MYSQL_QUERY">
<input type="hidden" name="SEC_IP">
</form>
<script>setupAllTabs();</script>
</body>
</html>
