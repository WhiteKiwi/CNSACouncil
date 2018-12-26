<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNSACouncil.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
    <!-- Top Image -->
    <img src="/assets/img/main-banner.png" style="width: 100%;" />

    <!-- Main - Notice & Projects -->
    <div class="container-fluid main-contents row color-black">
        <!-- Notice -->
        <div class="float-left col-md-6" style="padding-left: 60px;">
            <hr class="hr-black" />
            <h3>Recent Notice</h3>
            <br />

            <% var notices = CNSACouncil.Managers.NoticeManager.GetNoticesByNoticeAt(5);

                foreach (var notice in notices) { %>
            <div class="w-100 content-div">
                <a href="/Notice.aspx?id=<%= notice.ID %>" class="content-link notice">
                    <h5 class="float-left"><%= notice.Title %></h5>
                </a>
                <h5 class="float-right content-sub"><%= notice.NoticeAt.ToString("yyyy-MM-dd") %></h5>
            </div>
            <br />
            <% } %>
        </div>

        <!-- Projects -->
        <div class="float-right col-md-6" style="padding-left: 30px;">
            <hr class="hr-black" />
            <h3>Projects</h3>
            <br />

            <% var projects = CNSACouncil.Managers.ProjectManager.GetProjectsByStartAt(5);

                foreach (var project in projects) {
                    bool isEnd = project.State == 1;
            %>
            <div class="w-100 content-div">
                <a href="/Project.aspx?id=<%= project.ID %>&state=<%= project.State %>" class="content-link project">
                    <h5 class="float-left"><%= project.Title %> (<%= project.StartAt.ToString("yyyy-MM-dd") %> ~ <%= isEnd ? project.EndAt.ToString("yyyy-MM-dd") : "" %>)</h5>
                </a>
                <h5 class="float-right content-sub color-<%= isEnd ? "gold" : "black" %>"><%= isEnd ? "진행 완료" : "진행중" %></h5>
            </div>
            <br />
            <% } %>
        </div>
    </div>

    <!-- Hot Issuse -->
    <div class="container-fluid float-none" style="padding: 60px;">
        <hr class="hr-red" />
        <h3 class="color-red">Hot Issues</h3>
        <br />
        <% var petitions = CNSACouncil.Managers.PetitionManager.GetPetitionsByAgrees(2);
            foreach (var petition in petitions) { %>
        <div class="petition-box">
            <div class="row">
                <div class="col-md-7 color-black">
                    <h3 class="petition-box-title"><b><%= petition.Title.Length > 18 ? petition.Title.Substring(0, 18) + "..." : petition.Title %></b></h3>
                    <br />
                    <a href="/Petition.aspx?order=best&id=<%= petition.ID %>" class="petition-link" style="text-decoration: none;">
                        <h5 class="petition-box-content"><%= petition.Content.Replace("<br/>", " ").Length > 170 ? petition.Content.Replace("<br/>", " ").Substring(0, 170) + "..." : petition.Content %></h5>
                    </a>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-4 color-black">
                    <br>
                    <h6>등록인 :  <%= petition.UserID.Substring(0, 2) + "****" %></h6>
                    <h6 class="color-gold">동의 인원 :  <%= petition.Agrees %>명</h6>
                    <h6 class="right-date">등록 기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %></h6>
                    <h6>&nbsp;~ <%= petition.PetitionAt.AddDays(30).ToString("yyyy-MM-dd") %></h6>
                    <br />
                    <a href="/Petition.aspx?order=best&id=<%= petition.ID %>" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
                </div>
            </div>
        </div>
        <br />
        <% } %>
    </div>

    <!-- Comming Soon -->
    <div class="text-center container" id="AboutUs"  style="font-size: 11pt;">
        <!-- 회장단 소개 -->
        <div class="container department">회장단</div>
        <br />
        <br />

        <!-- 장지훈 소개 -->
        <div class="float-left w-50" style="padding-left: 15%;">
            <img class="photo1" src="/assets/img/about-us/WhiteKiwi.jpg" /><br />
            <span class="name">장지훈 </span><span class="position">창의 위원장</span>
            <br />
            <span>학생회실에서 삽니다</span><br />
            <span>이상한 아이디어를 많이 냅니다</span><br />
            <span class="delete-line">두 번 생각하면 괜찮은 아이디어</span>
        </div>
        <!-- 문민기 소개 -->
        <div class="float-right w-50" style="padding-right: 15%;">
            <img class="photo1" src="/assets/img/about-us/민문기.jpg" /><br />
            <span class="name">문민기 </span><span class="position">창의 부위원장</span>
            <br />
            <span>허접 쓰레기입니다</span><br />
            <span>그러나 개선의 여지가 보입니다</span><br />
            <span>아, 뭐 그렇다고요</span><br />
            <span class="delete-line">본인이 작성했습니다</span>
        </div>
        <div class="clearfix"></div>
        <br />
        <br />
        
        <!-- 학술부 소개 -->
        <div class="container department">학술부</div>
        <br />
        <br />
        <!-- 윤진규 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/윤찐규.jpg" style="object-position: top;" /><br />
            <span class="name">윤진규 </span><span class="position">학술부장</span>
            <br />
            <span>안그래 보이지만</span><br />
            <span>먹을 것에 잘 넘어갑니다</span><br />
            <span>신기하죠?</span>
        </div>
        <!-- 석기범 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/기석범.jpeg" /><br />
            <span class="name">석기범 </span><span class="position">면학차장</span>
            <br />
            <span>머리가 좋은 것 같지만</span><br />
            <span>좋지 않습니다</span><br />
            <span class="delete-line">실제로 좋지 않습니다</span>
        </div>
        <!-- 조유진 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/유진1.jpg" /><br />
            <span class="name">조유진 </span><span class="position">연구차장</span>
            <br />
            <span>YOLO를 모토로</span><br />
            <span>살아가고 있습니다</span><br />
            <span>불닭을 좋아하는</span><br />
            <span>찍먹파입니다</span>
        </div>
        <!-- 황수빈 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/황수우빈.jpg" /><br />
            <span class="name">황수빈 </span><span class="position">면학차장</span>
            <br />
            <span>상은이의 이상함을</span><br />
            <span>통제할 수 있는 유일한 1인</span><span class="delete-line">(과연?)</span><br />
            <span>기획서 지어내기의</span><br />
            <span>달인이 되어가고 있는 중</span>
        </div>
        <!-- 이상은 소개 -->
        <div class="float-right" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/이상한.jpg" /><br />
            <span class="name">이상은 </span><span class="position">연구차장</span>
            <br />
            <span>이상은이라 그런지 이상함</span><br />
            <span>학생회에서 귀여움과 깜직함과</span><br />
            <span>사랑스러움을 담당함</span><br />
            <span>이상은이 적은거 아님</span><br />
            <span>모두가 인정함</span><br />
            <span class="delete-line">본인이 작성했습니다</span>
        </div>
        <div class="clearfix"></div>
        <br />
        <br />

        <!-- 총무부 소개 -->
        <div class="container department">총무부</div>
        <br />
        <br />
        <!-- 유찬종 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/찬즈옹.jpeg" /><br />
            <span class="name">유찬종 </span><span class="position">총무부장</span>
            <br />
            <span>학생회 2년차</span><br />
            <span>팩트를 잘 날립니다</span><br />
            <span class="delete-line">아픕니다</span>
        </div>
        <!-- 최소정 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/ㅇㅇ의 상품.jpg" /><br />
            <span class="name">최소정 </span><span class="position">IT차장</span>
            <br />
            <span>IT 차장입니다</span><br />
            <span>디자인 노예입니다</span><br />
            <span class="delete-line">다 잘합니다</span>
        </div>
        <!-- 윤새얀 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/윤스애얀.jpg" /><br />
            <span class="name">윤새얀 </span><span class="position">행정차장</span>
            <br />
            <span>한국어를 잘 합니다</span><br />
            <span>하지만, 이름은</span><br />
            <span>잘 못외웁니다</span><br />
            <span>이해 바랍니다 ㅎㅎ</span>
        </div>
        <!-- 홍민우 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/호호홍.jpg" /><br />
            <span class="name">홍민우 </span><span class="position">IT차장</span>
            <br />
            <span>학생회에서 섹시 캐릭터 담당</span><br />
            <span>얼굴부터 뉴런까지 섹시함</span><br />
            <span>먹을 것을 보면 환장함</span><br />
            <span class="delete-line">안하던 일도 ㅎ...</span>
        </div>
        <!-- 곽지원 소개 -->
        <div class="float-right" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/갓지원.jpg" /><br />
            <span class="name">곽지원 </span><span class="position">행정차장</span>
            <br />
            <span>칭찬해주면 좋아합니다</span><br />
            <span class="delete-line">많이 못해줘서 죄송합니다</span>
        </div>
        <div class="clearfix"></div>
        <br />
        <br />

        <!-- 기획부 소개 -->
        <div class="container department">기획부</div>
        <br />
        <br />
        <!-- 조성종 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/Chosungjooooong.jpg" /><br />
            <span class="name">조성종 </span><span class="position">기획부장</span>
            <br />
            <span>아이디어가 톡톡 터집니다</span><br />
            <span class="delete-line">진짜로 터집니다</span>
        </div>
        <!-- 오유진 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/유진5.jpg" /><br />
            <span class="name">오유진 </span><span class="position">체육차장</span>
            <br />
            <span>학생회에서 제일 정상입니다</span><br />
            <span>정말입니다</span><br />
            <span>초콜릿 좋아해요 초콜릿 주세요</span><br />
            <span class="delete-line">학생회 간식이 일주일만에</span><br />
            <span class="delete-line">증발하게 만든 주범</span>
        </div>
        <!-- 박민석 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/뱅크.jpg" /><br />
            <span class="name">박민석 </span><span class="position">문화차장</span>
            <br />
            <span>기획부 아이디어 뱅크입니다</span><br />
            <span class="delete-line">저축은 안됩니다</span>
        </div>
        <!-- 강정현 소개 -->
        <div class="float-left" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/강강강강강.png" /><br />
            <span class="name">강정현 </span><span class="position">체육차장</span>
            <br />
            <span>닭강정에 대한</span><br />
            <span>애정은 전혀 없음</span><br />
            <span>브이라인 유지 실패</span><br />
            <span>학생회 분위기 총 책임자</span>
        </div>
        <!-- 유지혜 소개 -->
        <div class="float-right" style="width: 20%;">
            <img class="photo1" src="/assets/img/about-us/갓갓갓갓갓.jpg" /><br />
            <span class="name">유지혜 </span><span class="position">문화차장</span>
            <br />
            <span>학생회의 실세</span><br />
            <span>기획부장 자리를 노리고 있습니다</span><br />
            <span class="delete-line">탈환에 성공했습니다</span>
        </div>
        <div class="clearfix"></div>
        <br />

    </div>
    <div class="clearfix"></div>
    <br />
    <br />
    <br />

    <!-- Navbar - About us Active by scroll -->
    <script>
        var element_position = $('#AboutUs').offset().top;
        var screen_height = $(window).height();
        var activation_offset = 0.5;//determines how far up the the page the element needs to be before triggering the function
        var activation_point = element_position - (screen_height * activation_offset);
        var max_scroll_height = $('body').height() - screen_height - 5;//-5 for a little bit of buffer

        //Does something when user scrolls to it OR
        //Does it when user has reached the bottom of the page and hasn't triggered the function yet
        $(window).on('scroll', function () {
            var y_scroll_pos = window.pageYOffset;

            var element_in_view = y_scroll_pos > activation_point;
            var has_reached_bottom_of_page = max_scroll_height <= y_scroll_pos && !element_in_view;

            if (element_in_view || has_reached_bottom_of_page) {
                $('#nav1').removeClass("active");
                $('#nav5').addClass("active");
            } else {
                $('#nav1').addClass("active");
                $('#nav5').removeClass("active");
            }
        });
    </script>

    <!-- Navbar - HOME -->
    <script>
        document.getElementById("nav1").classList.add("active");
    </script>
</asp:Content>
