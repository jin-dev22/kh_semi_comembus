<%@page import="kh.semi.comembus.member.model.dto.JobCode"%>
<%@page import="kh.semi.comembus.member.model.dto.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <style>
        .profile-box{
            width: 150px;
            height: 150px;
            background-color: #FFE69A;
            border-radius: 5px;
        }
        .profile-badge{
            display: inline-block;
            width: 50px;
            height: 50px;
            background-color: fff;
            border-radius: 50%;
        }
    </style>
    <%
    	List<Member> memberList = (List<Member>)request.getAttribute("memberList");
    	
    %>
    <!-- 멤버스 검색 폼 시작 -->
    <!-- <section id="membusList-container"> -->
        <h2>멤버스 찾기</h2>
        <div id="search-container">
            <!-- <label for="searchType">직무분야</label>  -->
            <form action="<%=request.getContextPath()%>/서블릿url매핑주소">
                <select id="search-jobCode">
                    <option value="ALL" selected>직무분야</option>
                    <option value="PL">기획</option>
                    <option value="DG">디자인</option>
                    <option value="FE">프론트엔드</option>
                    <option value="BE" >백엔드</option>		
                </select>
                <select id="search-getheringYN">
                    <option value="ALL" selected>모임</option>
                    <option value="Y">진행중</option>
                    <option value="N">없음</option>
                </select>
                <div id="search-nickName" class="search-type">
                    <input type="hidden" name="searchType" value="member_name"/>
                    <input type="text" name="searchKeyword" size="25" placeholder="닉네임"/>
                </div>
                <button type="submit">검색</button>			
            </form>	
        </div>
    <!-- 멤버스 검색 폼 끝 -->
    <!-- 멤버스 리스트 시작 -->
    <%
    	if(memberList == null && memberList.isEmpty()){
    %>
    	<div>검색 결과가 없습니다.</div>
    <%} else {
    	for(Member m : memberList){
    		String nickName = m.getNickName();
    		JobCode jobcode = m.getJobCode();
    		
    %>
        <div id="membusProfile-container">
            <div class="profile-box">
                <div class="profile-row">
                    <span class="profile-badge"><%=nickName.charAt(0) %></span>
                    <span class="profile-nickName"><%=nickName %></span>
                </div>
                <span class="profile-jobName"></span>
                <p class="gethringYN">진행중인 모임이 <%=1 %>개 있습니다.</p>
                <button class="btn-showProfile" onclick="">더보기</button>
            </div>
        </div>
     <%
     	} 
     }
     %>
    <!-- 멤버스 리스트 끝 -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>