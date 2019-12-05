/* Much thanks to Peter-Paul Koch and his extensive information at http://www.quirksmode.org */

var bugRiddenCrashPronePieceOfJunk = (
	navigator.userAgent.indexOf('MSIE 5') != -1
	&&
	navigator.userAgent.indexOf('Mac') != -1
);

var W3CDOM = (!bugRiddenCrashPronePieceOfJunk &&
	document.getElementsByTagName && document.createElement);

/* Execute functions onload */
window.onload = initialize;

function initialize()
{
	//get IE version
	var browser = '';
	if (document.all)
	{
		detect = navigator.userAgent.toLowerCase();
		if (checkItLocal('msie'))
		{
			browser = "IE "
			browser += detect.substr(placeOfDetect + thestring.length,3);
			//document.title = browser + ' - ' + document.title;
		}
	}

	if (browser != 'IE 5.0') // IE 5.0 Win hides all floats and most long code examples when we run this script
		createTOC();
}

function createTOC()
{
	if (top.bugRiddenCrashPronePieceOfJunk) return;
	var x = document.body.childNodes;
/*	var y = document.createElement('div');
	y.id = 'toc';*/
	var y = document.getElementById('toc');	//get <div id="toc" />
	if (!y) return;
/*	var a = y.appendChild(document.createElement('span'));
	a.onclick = showhideTOC;
	a.innerHTML = 'Contents';*/
	var z = y.appendChild(document.createElement('div'));
/*	z.onclick = showhideTOC;*/
	var toBeTOCced = new Array();
	for (var i=0;i<x.length;i++)
	{
		if (x[i].nodeName.indexOf('H') != -1)
			toBeTOCced.push(x[i])
	}

	if (toBeTOCced.length < 2) return;

	for (var i=0;i<toBeTOCced.length;i++)
	{
		if (toBeTOCced[i].nodeName == 'H2') continue;	/* skip the h2 */
		var tmp = document.createElement('a');
		tmp.innerHTML = toBeTOCced[i].innerHTML;
		tmp.href = '#link' + i;
		tmp.className = 'page';
		z.appendChild(tmp);
		if (toBeTOCced[i].nodeName == 'H4')
			tmp.className += ' indent';
		if (toBeTOCced[i].nodeName == 'H5')
			tmp.className += ' indent2';
		var tmp2 = document.createElement('a');
		tmp2.id = 'link' + i;
/*		if (toBeTOCced[i].nodeName == 'H2')
		{
			tmp.innerHTML = 'Top';
			tmp.href = '#top';
			tmp2.id = 'top';
		}*/
		toBeTOCced[i].parentNode.insertBefore(tmp2,toBeTOCced[i]);
	}
	/*document.body.insertBefore(y,document.body.childNodes[2]);*/
}

/*var TOCstate = 'none';

function showhideTOC()
{
	TOCstate = (TOCstate == 'none') ? 'block' : 'none';
	document.getElementById('toc').lastChild.style.display = TOCstate;

}*/

function checkItLocal(string)
{
	placeOfDetect = detect.indexOf(string) + 1;
	thestring = string;
	return placeOfDetect;
}
