<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" href="/images/favicon.ico" />
<link rel="apple-touch-icon" href="/images/favicon.ico" />
<link rel="stylesheet" href="/css/style.css" />
<link rel="stylesheet" href="/css/admin/aside.css" />
<link rel="stylesheet" href="/css/admin/pagination.css" />
<link rel="stylesheet" href="/css/admin/payDelivery.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>Pet LiSe</title>
</head>
<body>
	<div class="container">
		<div id="asideMenu"></div>
		<main>
			<p>결제/배송 관리</p>
			<div>
				<div id="ordertitle">
					<button name="searchType1" value="all" <c:if test="${param.searchType1 == 'all' || param.searchType1 eq null || param.searchType1==''}">style="border-bottom: 3px solid var(--light-point);"</c:if>>전체주문내역</button>
					<button name="searchType1" value="wait" <c:if test="${param.searchType1 == 'wait'}">style="border-bottom: 3px solid var(--light-point);"</c:if>>배송처리대기(${waitCnt})</button>
					<button name="searchType1" value="finish" <c:if test="${param.searchType1 == 'finish'}">style="border-bottom: 3px solid var(--light-point);"</c:if>>배송처리완료</button>
					<button name="searchType1" value="cancel" <c:if test="${param.searchType1 == 'cancel'}">style="border-bottom: 3px solid var(--light-point);"</c:if>>주문취소내역</button>
				</div>
				<form action="adminorderlist" id="adminorderlist" method="post">
					<input type="hidden" id="searchType1" name="searchType1" value="${param.searchType1}"> 
					<input type="hidden" id="page" name="page" value="${param.page eq null?1:param.page}"> 
					<div class="categoryWrap">
						<div class="category">
							<div id="dropdown" class="dropdown">
								<div class="select">
									<span> 
									<c:if test="${param.searchType2 == '' || param.searchType2 eq null}">검색유형</c:if>
										${param.searchType2}
									</span>
								</div>
								<input type="hidden" id="searchType2" name="searchType2" value="${param.searchType2}" />
								<ul class="dropdown-menu">
									<li>전체</li>
									<li>구매회원ID</li>
									<li>회원닉네임</li>
									<li>실수령자</li>
									<li>배송지</li>
									<li>연락처</li>
								</ul>
							</div>
						</div>

					<c:choose>
						<c:when test="${param.keyword == '' || param.keyword eq null}">
							<input type="text" id="keyword" name="keyword" placeholder="검색어 입력" />
						</c:when>
						<c:otherwise>
							<input type="text" id="keyword" name="keyword" value="${param.keyword}" />
						</c:otherwise>
					</c:choose>
					<input type="submit" id="searchbtn" value="검색" />
					<button id="searchreturn">검색조건초기화</button>
					</div> <!-- categoryWrap -->
				</form>
				<div id="ordertable">
					<table id="orderlist">
						<thead>
							<tr>
								<th>주문코드</th>
								<th>구매회원ID</th>
								<th>구매회원닉네임</th>
								<th>실수령자이름</th>
								<th>주문상품수량</th>
								<th>총결제포인트</th>
								<th>구매일자</th>
								<th>처리상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${fn:length(response.list) < 1}">
								<tr>
									<td class="no_data_msg">
										<div>
											검색된 결과가 없습니다.
										</div>
									</td>
								</tr>
							</c:if>
							<c:forEach items="${response.list}" var="order">
								<tr class="list_tr">
									<td>${order.order_id}</td>
									<td>${order.user.email}</td>
									<td>${order.user.name}</td>
									<td>${order.name}</td>
									<td>2개</td>
									<td><fmt:formatNumber value="${order.total_payment}" pattern="#,###" />p</td>
									<td><fmt:parseDate value="${order.date}" var="reg"
											pattern="yyyy-MM-dd HH:mm:ss" /> <fmt:formatDate
											value="${reg}" pattern="yyyy-MM-dd HH:mm" /></td>
									<td>${order.status}</td>
								</tr>
								<tr class="orderinfo" style="border-bottom: 1px solid var(--light-point);">
									<td>
										<div id="grid_container">
											<div class="griditem">주문상세</div>
											<div class="griditem">배송정보</div>
											<div class="griditem">주문코드</div>
											<div class="griditem">${order.order_id}</div>
											<div class="griditem">실수령자 성함</div>
											<div class="griditem">${order.name}</div>
											<div class="griditem">주문상품</div>
											<div class="griditem" id="innergrid">
												<div class="innergriditem">상품명</div>
												<div class="innergriditem">상품가격</div>
												<div class="innergriditem">주문수량</div>
												<div class="innergriditem">총합</div>
												<c:forEach items="${order.orderproducts}" var="orderproduct">
													<div class="innergriditem">${orderproduct.product_name}</div>
													<div class="innergriditem"><fmt:formatNumber value="${orderproduct.product_price}" pattern="#,###" />p</div>
													<div class="innergriditem">${orderproduct.quantity}</div>
													<div class="innergriditem"><fmt:formatNumber value="${orderproduct.price_total}" pattern="#,###" />p</div>
												</c:forEach>
												<div class="innergriditem">배송비</div>
												<div class="innergriditem" style="grid-column: 2 / 4;"></div>
												<div class="innergriditem">3,000p</div>
												<div class="innergriditem">총 결제 포인트</div>
												<div class="innergriditem" style="grid-column: 2 / 4;"></div>
												<div class="innergriditem"><fmt:formatNumber value="${order.total_payment}" pattern="#,###" />p</div>
											</div>
											<div class="griditem">실수령자 연락처</div>
											<div class="griditem">${order.phone}</div>
											<div class="griditem">상품 배송지</div>
											<div class="griditem">${order.address}</div>
											<div class="griditem">배송요청사항</div>
											<div class="griditem">${order.require}</div>
											<div class="griditem">배송택배사</div>
											<div class="griditem">
												<c:choose>
													<c:when test="${order.delivery_com eq null || order.delivery_com == ''}">
														<input type="text" id="delivery_com" placeholder="택배사명입력" value="" >
													</c:when>
													<c:otherwise>
														<input type="text" id="delivery_com" placeholder="택배사명입력" value="${order.delivery_com}" readonly>
													</c:otherwise>
												</c:choose>
											</div>
											<div class="griditem">운송장번호</div>
											<div class="griditem">
												<c:choose>
													<c:when test="${order.delivery_id eq null || order.delivery_id == ''}">
														<input type="text" id="delivery_id" placeholder="운송장번호입력" value="" >
														<input type="button" id="updatedeliverybtn" class="deliverybtn" value="배송정보등록">
													</c:when>
													<c:otherwise>
														<input type="text" id="delivery_com" placeholder="택배사명입력" value="${order.delivery_id}" readonly>
														<input type="button" id="editdeliverybtn" class="deliverybtn" value="배송정보수정">
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div> <!-- OrderTable -->
				
				<div id="pagination" style="margin-top: 30px">
					<c:if test="${fn:length(response.list) != 0}">
						<div class="pagefirst"
							<c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
							<div class="prevArrow"></div>
							<div class="prevArrow" style="margin-left: -3px"></div>
						</div>
						<div class="prev" id="${response.pagination.startPage-1}"
							<c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
							<div class="prevArrow"></div>
						</div>

						<c:choose>
							<c:when test="${param.page eq null}">
								<c:forEach begin="1" end="${response.pagination.endPage}" varStatus="vs">
									<c:if test="${vs.index == 1}">
										<div class="pageNumber active">${vs.index}</div>
									</c:if>
									<c:if test="${vs.index != 1}">
										<div class="pageNumber">${vs.index}</div>
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<c:forEach begin="${response.pagination.startPage}"
									end="${response.pagination.endPage}" varStatus="vs">
									<c:if test="${vs.index == param.page}">
										<div class="pageNumber active">${vs.index}</div>
									</c:if>
									<c:if test="${vs.index != param.page}">
										<div class="pageNumber">${vs.index}</div>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>

						<div class="next" id="${response.pagination.startPage+10}"
							<c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
							<div class="nextArrow"></div>
						</div>
						<div class="pagelast" id="${response.pagination.totalPageCount}"
							<c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
							<div class="nextArrow"></div>
							<div class="nextArrow" style="margin-left: -6px"></div>
						</div>
					</c:if>
				</div><!-- pagination -->
				
			</div>
		</main>
	</div>

	<script src="/js/admin/aside.js"></script>
	<script src="/js/admin/shop/shopCategory_list.js"></script>
	<script src="/js/admin/shop/payDelivery.js"></script>
</body>
</html>
