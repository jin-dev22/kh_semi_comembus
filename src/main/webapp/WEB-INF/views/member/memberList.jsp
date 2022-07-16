<%@page import="kh.semi.comembus.member.model.dto.MemberExt"%>
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
    	String jobCode = request.getParameter("searchJobCode");
    	String gatheringYN = request.getParameter("searchGatheringYN");
    	String keyword = request.getParameter("searchKeyword");
    %>
    <!-- 멤버스 검색 폼 시작 -->
    <!-- <section id="membusList-container"> -->
        <h2>멤버스 찾기</h2>
        <div id="search-container">
            <!-- <label for="searchType">직무분야</label>  -->
            <form action="<%=request.getContextPath()%>/membus/search" method="get">
                <select id="search-jobCode" onchange="changeSelected('searchJobcode', this.value)">
                    <option value="ALL" <%= "ALL".equals(jobCode)? "selected" : "" %>>직무분야</option>
                    <option value="PL" <%= "PL".equals(jobCode)? "selected" : "" %>>기획</option>
                    <option value="DG" <%= "DG".equals(jobCode)? "selected" : "" %>>디자인</option>
                    <option value="FE" <%= "FE".equals(jobCode)? "selected" : "" %>>프론트엔드</option>
                    <option value="BE"  <%= "BE".equals(jobCode)? "selected" : "" %>>백엔드</option>		
                </select>
                <input type="hidden" name="searchJobcode" value="ALL"/>
                <select id="search-getheringYN" onchange="changeSelected('searchGatheringYN', this.value)">
                    <option value="ALL" <%= "ALL".equals(gatheringYN)? "selected" : "" %>>모임</option>
                    <option value="Y" <%= "Y".equals(gatheringYN)? "selected" : "" %>>진행중</option>
                    <option value="N" <%= "N".equals(gatheringYN)? "selected" : "" %>>없음</option>
                </select>
                <input type="hidden" name="searchGatheringYN" value="ALL"/>               
                <input type="text" name="searchKeyword" size="25" placeholder="닉네임"/>             
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
    		MemberExt mem = (MemberExt) m;
    		String nickName = mem.getNickName();
    		JobCode jobcode = mem.getJobCode();
    		int gatheringCnt = mem.getGetheringCnt();
    %>
        <div id="membusProfile-container">
            <div class="profile-box">
                <div class="profile-row">
                    <span class="profile-badge"><%=nickName.charAt(0) %></span>
                    <span class="profile-nickName"><%=nickName %></span>
                </div>
                <span class="profile-jobName"></span>
                <p class="gathringYN">진행중인 모임이 <%= gatheringCnt > 0? gatheringCnt+"개 있습니다.": "없습니다."%></p>
                <button class="btn-showProfile" onclick="viewMembusProfile('<%= mem.getMemberId()%>')">더보기</button>
            </div>
        </div>
     <%
     	} 
     }
     %>
    <!-- 멤버스 리스트 끝 -->
    <!-- 페이지바 시작 -->
   	<div id="pagebar">
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