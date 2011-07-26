document.observe("dom:loaded", function() {
	
	noticeDiv = $("notice");
	if( noticeDiv == null )
		return false;
	
	setTimeout( fade, 2000);
});

function fade() {
	noticeDiv.fade({duration: 2.0, from: 1, to: 0});
}