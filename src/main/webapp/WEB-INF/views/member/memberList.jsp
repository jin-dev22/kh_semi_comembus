<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
<%@page import="kh.semi.comembus.member.model.dto.JobCode"%>
<%@page import="kh.semi.comembus.member.model.dto.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/membusPage.css">
    <%
    	List<Member> memberList = (List<Member>)request.getAttribute("memberList");
    	String jobCode = request.getParameter("searchJobcode");
    	String gatheringYN = request.getParameter("searchGatheringYN");
    	String keyword = request.getParameter("searchKeyword");
    	
    	System.out.println("@listjsp>>"+jobCode +"/"+gatheringYN+"/"+keyword);
    %>
    <!-- 멤버스 검색 폼 시작 -->
    <!-- <section id="membusList-container"> -->
        <h2>멤버스 찾기</h2>
        <div id="search-container">
            <!-- <label for="searchType">직무분야</label> select선택란에 바로 표시하기 위해 라벨 사용안함 -->
            <form action="<%=request.getContextPath()%>/membus/search" method="get">
                <select id="search-jobCode" onchange="changeSelected('searchJobcode', this.value)">
                    <option value="ALL" <%= "ALL".equals(jobCode)? "selected" : "" %>>직무분야</option>
                    <option value="PL" <%= "PL".equals(jobCode)? "selected" : "" %>>기획</option>
                    <option value="DG" <%= "DG".equals(jobCode)? "selected" : "" %>>디자인</option>
                    <option value="FE" <%= "FE".equals(jobCode)? "selected" : "" %>>프론트엔드</option>
                    <option value="BE"  <%= "BE".equals(jobCode)? "selected" : "" %>>백엔드</option>		
                </select>
                <input type="hidden" name="searchJobcode" value="<%= jobCode != null? jobCode : "ALL"%>"/>
                <select id="search-getheringYN" onchange="changeSelected('searchGatheringYN', this.value)">
                    <option value="ALL" <%= "ALL".equals(gatheringYN)? "selected" : "" %>>모임</option>
                    <option value="Y" <%= "Y".equals(gatheringYN)? "selected" : "" %>>진행중</option>
                    <option value="N" <%= "N".equals(gatheringYN)? "selected" : "" %>>없음</option>
                </select>
                <input type="hidden" name="searchGatheringYN" value="<%= gatheringYN != null? gatheringYN : "ALL"%>"/>               
                <input type="text" name="searchKeyword" size="25" placeholder="닉네임"  value="<%= keyword != null? keyword : ""%>"/>             
                <button type="submit">검색</button>			
            </form>	
        </div>
    <!-- 멤버스 검색 폼 끝 -->
    <!-- 멤버스 리스트 시작 -->
    <div id="membusProfile-container">
    <%
    	if(memberList != null && !memberList.isEmpty()){
    	for(Member m : memberList){
    		MemberExt mem = (MemberExt) m;
    		String nickName = mem.getNickName();
    		String jobName = mem.getJobName();
    		int gatheringCnt = mem.getGetheringCnt();
    %>
            <div class="profile-box">
                <div class="profile-row">
                    <span class="profile-badge"><b><%=nickName.charAt(0) %></b></span>
                    <span class="profile-nickName"><%=nickName %></span>
                </div>
                <div class="profile-jobName"><%= jobName %></div>
                <p class="gathringYN">진행중인 모임이 <%= gatheringCnt > 0? gatheringCnt+"개 있습니다.": "없습니다."%></p>
                <button class="btn-showProfile" onclick="viewMembusProfile('<%= mem.getMemberId()%>')">더보기</button>
            </div>
  	<% } 
    }else {
    %>
    	<div>검색 결과가 없습니다.</div>
     <%   
     }
     %>
    </div>
    <!-- 멤버스 리스트 끝 -->
    <!-- 페이지바 시작 -->
   	<div class="pagebar">
   	 <%=request.getAttribute("pagebar") %>
   	</div>
    <!-- 페이지바 끝 -->
    <script>
     /**
      * select에서onchange발생시 호출. 숨겨진 input에 사용자 입력값 전달
      */
    	function changeSelected(inputName, value){
            // console.log(inputName, value);
    		const hiddenInput = document.querySelector(`[name="\${inputName}"]`);
    		//console.log(hiddenInput);
    		hiddenInput.value = value;
    		console.log("selected: ",hiddenInput.value);
    	}
     
     /**
     * 멤버 아이디값으로 get요청
     */
     	function viewMembusProfile(memberId){
     		location.href = `<%= request.getContextPath()%>/membus/profile?memberId=\${memberId}`;
     	}
    </script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>