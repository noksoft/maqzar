
jQuery(document).ready(
   function($){
	$("#tabCapitales").click(function(){
		$("#captcap").show("slide",700);
		$("#mdodin").hide();
		$("#socinv").hide();
		$("#captefvo").hide();
	});
	$("#tabMdodin").click(function(){
		$("#captcap").hide();
		$("#mdodin").show("slide",700);
		$("#captefvo").hide();
		$("#socinv").hide();
	});
	$("#tabEfvo").click(function(){
		$("#mdodin").hide();
		$("#captefvo").show("slide",700);
		$("#socinv").hide();
		$("#captcap").hide();
	});
	$("#tabSocInv").click(function(){
		$("#captefvo").hide();
		$("#socinv").show("slide",700);
		$("#captcap").hide();
		$("#mdodin").hide();
	});	
});