<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<style>
	div.modal-main {
		position: fixed;
		top:0;
		left:0;
		
		width:100%;
		height: 100%;
		
		overflow: auto;
		
		background-color: rgba(0,0,0,0.4);
		z-index:10;
		display: none;
	}
	
	div.modal-content {
		width: 80%;
		position:relative;
		margin:auto;
		top:300px;
		padding:0;	
		
	}
	
	div.modal-header{
		display: flex;
		justify-content: flex-end;
	}
	
	span.modal-close {
		cursor: pointer;
		float: right;
		font-size: 30px;
		font-weight: bold;
		color:black;
	}
	
	span.modal-close:hover, span.modal-close:focus {
		color:#000;
	}
</style>
<form method="POST" class="repl" action="${rootPath}/cs/comment/repl">
	<div class="row p-4">
		<div class="col-2">
			<input name="cs_c_p_id" id="cs_c_p_id" class="form-control" type="hidden" value="${REPLCOMMENT.cs_c_p_id}">
			<input name="cs_c_b_id" class="form-control" type="hidden" value="${REPLCOMMENT.cs_c_b_id}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</div>
		<div class="col-8">
			<input name="cs_c_subject" id="cs_c_subject" class="form-control" placeholder="댓글을 입력하세요">
		</div>
		<div class="col-2 d-flex justify-content-start">
			<button class="btn btn-primary mr-2 commentInsert btn-cmt-save">답변저장</button>
			<a href="${rootPath}/cs/comment"><button type="button" class="btn btn-success">목록으로</button></a>
		</div>
	</div>
</form>