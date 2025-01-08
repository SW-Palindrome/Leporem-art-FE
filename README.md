목차

# 프로젝트 소개

> ☝️ 공예 전공 학생 및 신진작가의 판로 개척
✌️ 공예품 온라인 전시 공간 마련
🤟 K-공예품의 전통성 보존
> 

많은 대학교의 도예학과에서 도자기가 만들어지고 이들이 남아 방치되는 일이 많아진다고 합니다. 그래서 이러한 도자기들을 모아 공유를 하고 콘텐츠로써 활용을 할 수 있도록 하는 플랫폼을 만들어보고자 하였습니다.

접근성이 뛰어난 애플리케이션 환경으로 배포하고자 하였으며, 빠르게 배포하기 위한 크로스 플랫폼인 Flutter라는 기술을 사용하여 앱을 개발하였습니다.

또한, 빠른 개발 진행을 위해 팀원들 모두 친숙한 Django를 사용하여 백엔드 개발을 진행하였습니다.

# API 설계

Swagger를 통하여 API 명세를 관리하였다.

http://swagger.leporem.art:8080/

# 프로젝트 구현

## Jira / Confluence

- Jira를 통한 이슈 관리 및 2주 단위 스프린트 진행
- Confluence를 통한 데일리 스크럼, 스프린트 회고, 회의록 등 문서화 진행

## CI / CD

- Github Action을 통한 CI 설정: [Workflow 파일](https://github.com/SW-Palindrome/Leporem-art-BE/blob/main/.github/workflows/ci.yml)
- Github Action을 통한 CD 설정: [Workflow 파일](https://github.com/SW-Palindrome/Leporem-art-BE/blob/470362f162de0b334618cf856e5bb7ad0aed5bd6/.github/workflows/cd.yml), [Serverless 파일](https://github.com/SW-Palindrome/Leporem-art-BE/blob/470362f162de0b334618cf856e5bb7ad0aed5bd6/serverless.production.yml)

## 이슈 트래킹

- GlitchTip 사용 / Discord Webhook 알림

![image](https://github.com/user-attachments/assets/6d0258d8-5ae5-49bc-a73c-257488a0d73e)
![image](https://github.com/user-attachments/assets/28a58364-a04b-4abc-9ea2-942a65c02a4e)

## Firebase Cloud Messaging (FCM)

- 주문 접수, 채팅 등에 대한 알림을 전송
- 애플 → APN 인증 키를 발급받아 FCM 자체 API를 통해 푸시 알림 전송
- 안드로이드 → FCM 자체 내에서 지원

## Firebase Analytics

![image](https://github.com/user-attachments/assets/ba84c41b-5961-40a6-8bd2-21975ec13768)


- 모든 사용자 액션( 카카오 로그인을 눌렀는지, 애플 로그인을 눌렀는지, 비회원 로그인을 눌렀는지 등) 및 페이지 이동,스 크롤 행동 모두 태깅
- 4달 간 562명의 사용자, 4.8만 건의 이벤트를 통해 퍼널, 리텐션 분석을 통핸 기능 개선 진행

# 프로젝트 결과물

- 4개월 간 총 562건의 다운로드 수, 164명의 유저 수, 20명의 판매자 수 달성
- 상명대학교 세라믹디자인학과 온라인 졸업전시전 개최, 여러 개인 작가 전시전 개최
    - 총 20점의 작품 판매 등록

![image](https://github.com/user-attachments/assets/912ae603-b6c1-4069-93a7-f4d4a9299140)

![image](https://github.com/user-attachments/assets/cfa552da-d6bd-4623-8556-62d13b313973)


[SW-Palindrome](https://github.com/orgs/SW-Palindrome/repositories)

[공예쁨](https://leporem.art/)

[공예쁨 - Apps on Google Play](https://play.google.com/store/apps/details?id=com.palindrome.leporemart)

[‎공예쁨](https://apps.apple.com/kr/app/공예쁨/id6463696424)

# 학습 내용

- OAuth2(카카오, 애플) 로그인 적용
- Frontend의 MVVM 디자인 패턴(Flutter의 GetX)
- Frontend의 모킹 및 예외 데이터 처리
- [socket.io](http://socket.io) 기반 채팅 기능 개발
- Firebase Cloud Message 를 통한 푸시 알림 전송
- Firebase Analytics를 통한 사용자 행동 추적 및 퍼널 분석, 기능별 유저 리텐션 분석
- 2주 단위 12회 Sprint를 통한 지속적인 개선을 진행한 Agile Project
- React, React-helmet을 통한 랜딩 페이지 구현과 검색엔진최적화
