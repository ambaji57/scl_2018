function showcontent(){
	var sel = "" ;
	$("#result").html("");
	$('#check :checked').each(function(){
		var dic = $(this).val();
		$.post("CGIURL/SHMT/generate.cgi",{word:$("#word").val(),dic:dic},
		function(data){
		   sel = data;
		   $("#result").append(data);
		});
	});
//alert (sel);
}
