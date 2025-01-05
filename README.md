
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

> * UICollectionView를 활용하여 복잡한 레이아웃을 구현합니다.
> * RestAPI를 활용합니다.
> * RxSwift를 이용하여 Observer Pattern 및 비동기 프로그래밍을 공부합니다.
> * MVVM 아키텍처를 활용하여 ViewModel, View를 바인딩합니다.
<br>

<a id="기술-스택"></a>
## 🛠️ 기술 스택

`MVVM`
- ViewModel이 Model과 View 사이의 중재자 역할로 의존성 주입이 용이하고 추후 유닛 테스트를 효율적으로 사용할 수 있어 사용하였습니다.
  
`Moya`
- 네트워크 요청을 쉽게 만들수 있고 관련 코드가 간결하기 위해 사용하였습니다

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

## ✏️ 도전 기능 구현
- :heavy_check_mark: Observable, Subject, Relay 차이를 공부하고, ViewModel에서 Relay를 활용
- :heavy_check_mark: Kingfisher 활용
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
