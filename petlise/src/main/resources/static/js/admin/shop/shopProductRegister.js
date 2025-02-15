$("#file1").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$("#fileimg1").attr("src", data.target.result).width(300);
			$("#fileimg1").attr("src", data.target.result).height(300);
			$("#fileimg1").css('border','2px solid var(--light-sub)');
			$("#fileimg1").css('border-radius','10px');
		}
		reader.readAsDataURL(this.files[0]);
	}
});

$("#file2").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$("#fileimg2").attr("src", data.target.result).width(300);
			$("#fileimg2").css('border','2px solid var(--light-sub)');
			$("#fileimg2").css('border-radius','10px');
		}
		reader.readAsDataURL(this.files[0]);
	}
});

$("#editButton").on("click",function(){
	if($("#pet_type").val()==""){		
		$("#alertmodal .modal_text").html("동물 카테고리를 확인해 주세요.");
		$("#alertmodal").css('display', 'block');
	}else if($("#product_categpry").val()==""){
		$("#alertmodal .modal_text").html("상품 카테고리를 확인해 주세요.");
		$("#alertmodal").css('display', 'block');		
	}else if($("#product_name").val()==""){
		$("#alertmodal .modal_text").html("상품명을 확인해 주세요.");
		$("#alertmodal").css('display', 'block');		
	}else if($("#product_price").val()==0 || $("#product_price").val()==""){
		$("#alertmodal .modal_text").html("상품가격을 확인해 주세요.");
		$("#alertmodal").css('display', 'block');
	}else if($("#product_quatity").val()==0 || $("#product_quatity").val()==""){
		$("#alertmodal .modal_text").html("상품재고수량을 확인해 주세요.");
		$("#alertmodal").css('display', 'block');
	}else if($("#product_regtime").val()==""){
		$("#alertmodal .modal_text").html("등록일자를 확인해 주세요.");
		$("#alertmodal").css('display', 'block');
	}else{
		$("#confirm_modal .modal_text").html(
			"<div>카테고리 : "+$("#pet_type").val()+" / "+$("#product_categpry").val()+"<br>"
			+"상품명 : "+$("#product_name").val()+"<br>"
			+"상품가격 : "+$("#product_price").val()+"Point <br>"
			+"상품을 등록하시겠습니까?</div>"
		);
		$("#confirm_modal").css('display', 'block');
	}
	
});

$(".createbtn").on('click', function(){
	$(this).parents(".modal").css('display', 'none');
	$.ajax({
		type : 'post',
		url : '/productsave',
		dataType : 'json',
		data : {
			pet_type : $("#pet_type").val(),
			category : $("#product_categpry").val(),
			reg_date : $("#product_regtime").val(),
			product_name : $("#product_name").val(),
			price : $("#product_price").val(),
			quatity :$("#product_quatity").val()
		},
		success : function(result) { // 결과 성공 콜백함수
		   	$("#okaymodal #pageinput").val(result.page);
		   	$("#okaymodal").css('display', 'block');
    	},
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	});//ajax end
});

//등록취소버튼
$("#cancelButton").on("click",function(){
	$("#cancel_modal").css('display', 'block');
	
	$(".golisthomebtn").on("click",function(){
		location.href = "/adminshoplist";
	});
});

//모달창 내의 취소버튼
$(".cancelbtn").on('click', function(){
	$(this).parents(".modal").css('display', 'none');
});

//등록 후 완료 버튼
$("#okaymodal .okaybtn").on('click', function(){
	$(this).parents(".modal").css('display', 'none');
	location.href = "/adminshoplist?page="+$("#okaymodal #pageinput").val();
});

//경고창 확인 버튼
$("#alertmodal .okaybtn").on('click', function(){
	$(this).parents(".modal").css('display', 'none');
});