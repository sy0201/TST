
# 💫 TS_PoketMonContact
> 프로젝트 기간: 24.12.09 ~ 24.12.12

## 📖 목차
1. [🍀 소개](#소개)
2. [🛠️ 기술 스택](#기술-스택)
3. [💻 동작 화면](#동작-화면)
4. [🧨 트러블 슈팅](#트러블-슈팅)
5. [📕 회고](#회고)
<br>

<a id="소개"></a>
## 🍀 소개
### :zap: 랜덤 포켓몬 이미지를 불러오고, 연락처를 저장하는 앱입니다.

> * 네트워크 통신을 이용해서 서버에서 랜덤 포켓몬 이미지를 불러오고, 연락처를 저장하는 앱을 개발합니다.
> * CoreData 방식, UserDefaults 방식으로 연락처 데이터(이름/전화번호/프로필이미지)를 디스크에 실제 저장하도록 구현합니다.
> * 메인화면으로 돌아왔을 때, 방금 저장한 연락처 데이터가 보여야합니다. View Lifecycle을 활용합니다.
<br>

<a id="기술-스택"></a>
## 🛠️ 기술 스택

`MVVM`
- ViewModel이 Model과 View 사이의 중재자 역할로 의존성 주입이 용이하고 추후 유닛 테스트를 효율적으로 사용할 수 있어 사용하였습니다.
  
`Alamofire`
- 네트워크 요청을 쉽게 만들수 있고 관련 코드가 간결하기 위해 사용하였습니다

`CoreData`
- 로컬 데이터 저장을 위한 프레임워크로 프로필을 저장하고 관리하기 위해 사용하였습니다

`Kingfisher`
- 이미지 로딩 및 캐싱을 쉽게 처리할 수 있어 사용하였습니다
<br>

## :computer: 개발 환경
> * Xcode 15.4
> * Swift 5
> * iOS 15 이상
<br>

<a id="동작-화면"></a>
# 📱 동작 화면

## 💫 필수 기능

|기본 UI|연락처 추가화면|네비게이션 바|API|CoreData|
|--------|--------|--------|--------|--------|
|![기본 UI](https://github.com/user-attachments/assets/4140d63f-19fc-4dbb-ab60-d6a48dc24326)|![연락처 추가화면](https://github.com/user-attachments/assets/b62b61ec-4e1d-4825-81b1-005c0a60ef0f)|![상단 네비게이션 바](https://github.com/user-attachments/assets/2164f6ca-da24-4049-9e94-4df8c119ffbc)|![API](https://github.com/user-attachments/assets/5334869c-b50e-48ba-a92f-03d764341f28)|![CorData](https://github.com/user-attachments/assets/2cc01647-fd09-4d98-b88c-e516035f65ed)|
<br>

## :pushpin: 필수 구현

- :heavy_check_mark: UI 구현
- :heavy_check_mark: 연락처 추가화면을 구현
- :heavy_check_mark: 상단 네비게이션 바 영역을 구현
- :heavy_check_mark: API 연결
- :heavy_check_mark: CoreData 방식, UserDefaults 방식 모두 구현

## ✏️ 도전 구현
- :heavy_check_mark: 항상 이름 순으로 정렬
- :heavy_check_mark: UITableViewCell 을 클릭했을 때도 PhoneBookViewController 페이지로 이동
- :heavy_check_mark: 연락처 편집 페이지에서, 실제로 기기 디스크 데이터에 Update 가 일어나도록 구현
<br>

<a id="트러블-슈팅"></a>
## 🧨  기능별 트러블 슈팅
###### 아래는 핵심 위주로 작성하였습니다 [블로그에서 더보기](https://velog.io/@sy0201/posts?q=%ED%8F%AC%EC%BC%93%EB%AA%AC)

<details>
<summary>1️⃣ ViewModel 나누기</summary>
<div markdown="1">
<br>

**문제발생** <br>
ViewModel을 나눌때 문제가 발생하였습다.

**해결방법** <br>

 <br>
</div>
</details>

<details>
<summary>:two: DetailViewController 화면전환 </summary>
<div markdown="2">
<br>

**문제발생** <br>
RxCocoa

**해결방법** <br>
해결방법 작성하기

 <br>
</div>
</details>

<details>
<summary>:three: 무한 스크롤 구현 </summary>
<div markdown="3">
<br>

**문제발생** <br>
리스트 화면에서 프로필 추가화면으로 PushViewController를 통해 화면 전환시 NavigationBar는 어디에서 설정해야하는지 고민되었습니다.
예를 들어 리스트 화면에서 프로필 추가화면으로 Push될때 NavigationBar의 Title이 잘못 표시되는 문제가 생겼습니다.

**해결방법** <br>
해결방법 작성하기

 <br>
</div>
</details>
<br>

<a id="회고"></a>
## 📕 회고
UnitTest
