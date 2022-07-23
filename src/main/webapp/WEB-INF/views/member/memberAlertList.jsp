<%@page import="kh.semi.comembus.alert.model.dto.AlertExt"%>
<%@page import="kh.semi.comembus.common.ComembusUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kh.semi.comembus.community.model.dto.Community"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/membusPage.css">

<%
 List<AlertExt> alerts = (List<AlertExt>) request.getAttribute("alerts");
%>
<div class="profile-row part-3">
			<div class="subtitle">아직 확인하지 않은 알림이 있습니다.</div>
			<div class="coBoard-list">
				<%if(alerts != null && !alerts.isEmpty()){
					for(AlertExt al : alerts){
				%>
				<%-- 게시글 종류에 따라 url다르게 작성. --%>
				<div class="coBoard">
					<%if(al.getReplNo() != 0) {%><%-- /comembus/community/communityView?co_type=Q&no=203  --%>
						<span class="link-to-origin" 
							onclick="moveToOrigin('<%= request.getContextPath()%>/community/communityView?co_type=<%=al.getCoType()%>&no=<%=al.getCoNo()%>', '<%=al.getAlertNo()%>')">
								<%= al.getContent() %>
						</span>
					<%} else{%><%-- /comembus/gathering/projectView?psNo=74  --%>
						<span class="link-to-origin" 
						onclick="moveToOrigin('<%= request.getContextPath()%>/gathering/projectView?psNo=<%=al.getPsNo()%>', '<%=al.getAlertNo()%>')">
							<%= al.getContent() %>
						</span>
					<%} %>
				</div>
				<%  }%>
				<div class="pagebar"><%= request.getAttribute("pagebar")%></div>
				<%}else{
				%>
				<div class="empty-content">새로운 알림이 없습니다.</div>
				<%} %>
			</div>
		</div>
<form name="linkFrm" action="<%= request.getContextPath() %>/alerts" method="POST">
<input type="hidden" name="alertNo" value=""/>
<input type="hidden" name="originUrl" value=""/>
</form>
<script>
function moveToOrigin(originUrl, alertNo){
	const frm = document.linkFrm;
	frm.alertNo.value = alertNo;
	frm.originUrl.value = originUrl;

	frm.submit();
}

</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>