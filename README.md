
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
## 🧨  레벨별 트러블 슈팅
###### 아래는 핵심 위주로 작성하였습니다 [블로그에서 더보기](https://velog.io/@sy0201/posts?q=%ED%8F%AC%EC%BC%93%EB%AA%AC)

<details>
<summary>1️⃣ Lv1 UI</summary>
<div markdown="1">
<br>

**문제발생** <br>
layoutSubviews에서 profileImg.layer.cornerRadius를 설정해도 동작하지 않는 문제가 발생하였습다.
검색해보니 뷰 계층이 올바르게 업데이트되기 전에 레이아웃을 그려주는 부분이 호출되는 문제라고 찾았습니다.

**해결방법** <br>
공식문서를 보다 layoutSubviews를 직접 호출하면 안된다는 내용을 확인하였고, 다른 함수 중 `func draw()`를 알게 되었습니다. 해당 메서드는 뷰의 커스텀 렌더링을 수행하기 위해 호출된다고 합니다. 
하지만 오히려 `draw()`메서드를 사용하면 오히려 불필요한 작업을 추가하기 때문에 피하는것이 좋다는 글을 보게되었습니다. 하지만 해당 메서드에서 작성시 이상없이 ConerRadius가 적용되었고, 과제 제출 기간의 압박으로 우선 되는 부분에 적용하는것으로 끝냈습니다. 정확한 문제인 뷰 계층의 업데이트 순서를 확인하고 수정하고 리팩토링이 필요합니다.
```swift
override func draw(_ rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
}
```
 <br>
</div>
</details>

<details>
<summary>:two: Lv2 연락처 추가화면 구현</summary>
<div markdown="2">
<br>

**문제발생** <br>
과제 내용에는 이름과 전화번호 입력칸을 UITextView로 제안되어있었습니다. UITextView는 긴 내용을 입력하는것으로 알고 있었습니다.
이름과 연락처 부분은 한줄이면 작성이 가능하였고, UITextField를 사용하는것이 맞지 않을까? 하는 고민이 생겼습니다.

**해결방법** <br>
1. 전화번호 입력시 하이픈도 자동으로 입력되도록 기능을 추가할 생각이었고, 2. 입력수 제한도 넣을 예정이었습니다. 3. 그리고 placeholder를 사용하여 사용자가 어떤걸 입력해야하는지 알려주고싶었습니다.
<br> 이러한 고민 끝에 UITextField를 사용하기로 결정하였습니다. 이를 계기로 UITextView와 UITextField의 차이점도 다시한번 짚어볼수 있었고, 왜 해당 기능(UI 컴포넌트)을 사용했는지 이유를 찾아보고 공부하게되었습니다.

| **특징** | **UITextField** | **UITextView** |
|------------------------|-----------------------------------------------------------|-------------------------------------------------------|
| **기본 목적**          | 단일 줄 입력                                               | 여러 줄 입력                                           |
| **내장 UI/기능**       | 기본적으로 `placeholder` 지원, 키보드 바로 닫힘             | `placeholder` 기본 미지원, 키보드 계속 열림           |
| **사용자 경험**        | 간단하고 실시간 입력 제어 가능                              | 여러 줄 입력에 적합하나 실시간 입력 제어는 불편        |
| **실시간 데이터 제어** | `shouldChangeCharactersIn` 델리게이트로 실시간 데이터 제어 가능 | 별도 로직 구현이 필요, 실시간 제어 복잡               |
| **포커스 및 키보드 동작** | 키보드가 기본적으로 한 줄 입력에 최적화됨                   | 여러 줄 입력을 위해 키보드 크기가 조정됨               |
| **주요 사용 사례**     | 사용자 이름, 전화번호 등 단일 줄 데이터 입력                 | 메모, 설명 등 여러 줄 데이터 입력                      |

 <br>
</div>
</details>

<details>
<summary>:three: Lv3 네비게이션 바</summary>
<div markdown="3">
<br>

**문제발생** <br>
리스트 화면에서 프로필 추가화면으로 PushViewController를 통해 화면 전환시 NavigationBar는 어디에서 설정해야하는지 고민되었습니다.
예를 들어 리스트 화면에서 프로필 추가화면으로 Push될때 NavigationBar의 Title이 잘못 표시되는 문제가 생겼습니다.

**해결방법** <br>
- NavigationBar 코드 작성 위치 문제 :  각 화면에 해당하는 NavigationBar는 각 ViewController에 작성해주어야했습니다. <br> ViewController는 각각 독립적이기 때문에 해당 관련 설정을 작성해주지 않으면 이전화면의 설정이 유지될 가능성이 있었기 때문입니다. 
- 
```swift
// 리스트화면에서의 NavigationBar 설정
func setupNavigationBar() {
        // UINavigationBarAppearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명한 기본 배경 설정
        appearance.backgroundColor = .white        // 원하는 배경색으로 설정
        appearance.shadowColor = nil               // 밑줄(쉐도우) 제거
        appearance.shadowImage = UIImage()         // 쉐도우 이미지 제거
        
        // 네비게이션 바에 appearance 적용
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 왼쪽 바 버튼 설정
        let navLeftItem = UIBarButtonItem(title: "Back",
                                          style: .plain,
                                          target: self,
                                          action: nil)
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "추가",
                                           style: .plain,
                                           target: self,
                                           action: #selector(addButtonTapped))
        navRightItem.tintColor = .gray
        navigationItem.backBarButtonItem = navLeftItem
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "친구 목록"
    }

// 프로필 추가화면에서의 NavigationBar 설정
func setupNavigationBar() {
        // 오른쪽 바 버튼 설정
        let navRightItem = UIBarButtonItem(title: "적용",
                                           style: .plain,
                                           target: self,
                                           action: #selector(applyButtonTapped))
        navigationItem.rightBarButtonItem = navRightItem
        navigationItem.title = "연락처 추가"
    }
```
 <br>
</div>
</details>

<details>
<summary>:four: Lv4 API</summary>
<div markdown="4">
<br>

**문제발생** <br>
기존에는 네트워크 서비스를 싱글톤 패턴으로 작성하고, ViewModel에서 바로 호출하여 API 요청을 처리하도록 코드를 작성하였습니다.
이때 문제는 비즈니스 로직과 네트워크 호출이 섞여있어서 코드작성한 나조차 너무 헷갈렸고 복잡하게 느껴졌습니다. 
그리고 싱글톤 패턴은 단 하나의 인스턴스만 생성되고 공유되도록 설계된 패턴이라고 공부했는데 이걸 남용하게 되는 문제가 생겼습니다.
<br>
그래서 NetworkService파일은 순수한 포켓몬 네트워크 요청을 처리하는 로직을 담당하도록 작성했고, Repository는 데이터를 관리하고 포켓몬 네트워크 로직을 호출한 결과를 가공해서 사용할 수 있도록 파일 분리를 하였습니다.
이 과정에서도 정확한 책임과 역할에 대한 이해가 부족해서 약간 혼재되었고, 코드도 중복되어 프로필 이미지를 호출할때 중복호출하는 문제와 프로필이미지를 저장하는곳과 불러오는 곳이 달라 이미지가 안뜨는 문제가 발생하였습니다.

**해결방법** <br>
중복된 코드와 로직을 제거하여 랜덤 프로필 이미지 생성시 네트워크를 호출하고, 정상적으로 API호출을 확인 할 수 있었습니다.
NetworkService: 순수한 네트워크 요청 및 응답 처리.
Repository: 데이터를 관리하고 가공하여 비즈니스 로직을 적용

이렇게 수정하고나니 NetworkService와 Repository의 역할이 명확해져 코드의 가독성과 유지보수성이 향상되었고, 프로필 이미지를 호출하는 곳을 간소화 하여 정상적으로 호출되고, 저장하는곳과 호출하는 곳을 ViewModel을 통해 관리하도록 하였습니다. 
아직 테스트코드를 작성해본적은 없지만 테스트에 매우 용이하다고 하여 꼭 적용해보고싶습니다.

 <br>
</div>
</details>

<details>
<summary>:five: Lv5 CoreData</summary>
<div markdown="5">
<br>

**문제발생** <br>
앱에서 연락처를 저장한 후, 다시 빌드하거나 앱을 재시작했을 때 이름과 연락처 정보는 정상적으로 표시되지만, 이미지가 표시되지 않는 문제가 발생하였다.

**해결방법** <br>
갈피를 못잡다가 튜터님들 방문 후에 어디서 문제가 되는지 검토하게되었다!
1. 이미지 저장방식의 문제
2. 이미지 경로 관리 문제
3. 이미지 로드시 호출 위치 문제<br>
이렇게 총 3개의 문제로 간추릴 수 있었다.
포켓몬 API에서 String으로 이미지데이터를 주고 있기때문에 받아오면 되었습니다. 그러나 파일이 많아지면서 중간에 PNG로 받아왔다가 image에 넣기 위해서 다시 UIImage로 변환해주고 중복된 코드와 불필요한 코드가 많았습니다. 그런 과정에서 url이 유실되었습니다. Lv4 해결 방법처럼 저장하는곳과 호출하는 곳을 ViewModel을 통해 관리하도록 하였습니다.

<img width="1185" alt="스크린샷 2024-12-12 07 59 11" src="https://github.com/user-attachments/assets/f6e1a82e-721b-4802-9c32-faf10d3d076f" />

 <br>
</div>
</details>
<br>

<a id="회고"></a>
## 📕 회고
추가하고 싶은게 너무너무 많았다. 하지만 필수구현이 제일 중요하고 급하기때문에 일정에 급급하게 작성한게 아쉬웠다..
네트워크 연결 상태 체크, 연락처가 없는 경우, 연락처 삭제 등 좀더 사용자가 편한 완성도 있는 앱을 위해 추가추가할 예정이다.
그리고 비즈니스로직을 머리로 그리거나 실제 그림을 그리고 코드를 작성하면 더 편리할것 같다는 생각을 하게되었다!
