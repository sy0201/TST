
# 💫 TS_Poke_RxSwift_MVVM
> 프로젝트 기간: 24.12.23 ~ 25.01.06

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

> * UICollectionView를 활용하여 복잡한 레이아웃을 구현합니다.
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

## ✏️ 필수 기능 구현
:heavy_check_mark: NetworkManager 구현
<br>
:heavy_check_mark: MVVM 아키텍처 구현
<br>
:heavy_check_mark: CollectionViewCell 탭시 MainVC -> DetailVC로 화면 전환 구현
<br>
:heavy_check_mark: DetailVC에서 포켓몬 정보 보여주기 구현
<br>
:heavy_check_mark: 무한 스크롤 구현
<br>

## ✏️ 도전 기능 구현
:heavy_check_mark: Observable, Subject, Relay 차이를 공부하고, ViewModel에서 Relay를 활용
<br>
:heavy_check_mark: Kingfisher 활용
<br>

<a id="트러블-슈팅"></a>
## 🧨  기능별 트러블 슈팅
###### 아래는 핵심 위주로 작성하였습니다 [블로그에서 더보기](https://velog.io/@sy0201/posts?q=%ED%8F%AC%EC%BC%93%EB%AA%AC)

<details>
<summary>1️⃣ ViewModel 분리 및 의존성 관리</summary>
<div markdown="1">
<br>

**배경 및 문제 상황** <br>
PokeViewModel 하나로 모든 로직(포켓몬 리스트 및 상세 정보)을 처리하던 구조에서 MainViewModel과 DetailViewModel로 분리하여 각각의 역할을 명확히 하고자 했습니다.
그러나 ViewModel 분리 이후, MainViewController에서 두 개의 ViewModel(MainViewModel, DetailViewModel)을 동시에 주입받게 되면서 아래와 같은 문제가 발생했습니다:

의존성 혼란: MainVC에서 DetailVC로 화면 전환 시 어떤 ViewModel을 주입해야 하는지 모호해졌습니다.
SRP 위반 가능성: MainViewController에서 DetailViewModel을 직접 다루는 방식은 단일 책임 원칙(SRP)을 벗어날 위험이 있었습니다.

**문제 원인** <br>
하나의 ViewController가 두 개 이상의 ViewModel을 사용하는 구조는 의존성 흐름이 복잡해지고 관리가 어려워질 수 있습니다.
MainViewController → MainViewModel → PokeRepository 및 DetailViewController → DetailViewModel → PokeRepository라는 명확한 의존성 흐름을 설계하지 못했습니다.
두 ViewModel의 역할이 구분되었음에도 불구하고 DetailViewModel을 MainViewController에서 직접 참조하여 책임 분리가 제대로 이루어지지 않았습니다.

**문제 해결 과정** <br>
1. 의존성 흐름 재정의
- ViewModel 간 직접 참조를 제거하고, ViewController와 ViewModel 간의 1:1 매칭 구조를 유지했습니다.
2. 책임 분리
- MainViewModel: 포켓몬 리스트 로드, 페이징, 새로고침 등 리스트 관련 로직 담당.
- DetailViewModel: 포켓몬 상세 정보 로드만 책임.
3. 의존성 주입 흐름 정리
- MainViewController는 MainViewModel만 주입받습니다.
- DetailViewController는 DetailViewModel만 주입받습니다.
- MainViewModel이 createDetailViewModel(for:) 메서드를 통해 필요한 DetailViewModel을 생성하도록 했습니다.

**최종 코드**<br>
```swift
final class MainViewModel {
    private let repository: PokeRepositoryProtocol

    init(repository: PokeRepositoryProtocol) {
        self.repository = repository
    }

    func createDetailViewModel(for id: Int) -> DetailViewModel {
        return DetailViewModel(repository: repository, pokemonID: id)
    }
}
```

```swift
final class DetailViewModel {
    private let repository: PokeRepositoryProtocol
    private let disposeBag = DisposeBag()
    private let pokemonID: Int
    
    let pokeDetail = PublishRelay<PokeDetail>()
    
    init(repository: PokeRepositoryProtocol, pokemonID: Int) {
        self.repository = repository
        self.pokemonID = pokemonID
    }
    
    func loadPokeDetail() {
        repository.fetchPokeDetail(id: pokemonID)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] detail in
                self?.pokeDetail.accept(detail)
            }, onFailure: { error in
                print("Error loading poke detail: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
```
**결론 및 교훈** <br>
- MainViewController는 MainViewModel과만 바인딩, DetailViewController는 DetailViewModel과만 바인딩하도록 하여 관리의 용이성을 높였습니다.
- ViewModel 생성은 필요할 때 상위 ViewModel에서 처리하여 ViewController의 의존성을 최소화했습니다.
- ViewController와 ViewModel 간의 1:1 매칭을 유지하여 SRP를 준수하고 코드 복잡도를 줄였습니다

 <br>
</div>
</details>

<details>
<summary>:two: ViewModel의 PublishRelay VS BehaviorRelay </summary>
<div markdown="2">
<br>

**배경 및 고민 상황** <br>
저는 처음에 BehaviorRelayfor pokeList및 pokeDetail속성을 사용했습니다.
왜냐하면 넷플릭스 클론 코딩 강의에서는 PublishRelay를 사용하였기때문에 BehaviorRelay과 PublishRelay에 대해 궁금점이 생겼습니다.

**문제 해결 과정** <br>
BehaviorRelay와 PublishRelay를 먼저 비교해본 후 처음 코드 작성시에는 BehaviorRelay를 사용하였습니다. 그 이유는 pokeList와 같이 뷰에 지속적으로 표시되는 데이터 스트림에 적합하다고 판단하였기 때문입니다. 하지만 단순하게 UI처리만을 위해 PublishRelay 최종 결정하게 되었습니다.

| 특성               | BehaviorRelay                                     | PublishRelay                                  |
|--------------------|--------------------------------------------------|-----------------------------------------------|
| **최신 값 유지**     | 최신 값을 유지하고 새로운 구독자에게 전달           | 최신 값은 유지되지 않음, 새로운 이벤트만 전달    |
| **초기값 설정**      | 초기값을 설정해야 함                              | 초기값 설정 필요 없음                         |
| **상태 저장**        | 지속적으로 사용 가능한 상태 저장 데이터를 유지   | 상태 저장 기능 없음                          |
| **불필요한 업데이트**| 상태 저장 특성으로 불필요한 업데이트 발생 가능    | 불필요한 업데이트 없음                       |
| **이벤트 전송**      | 새로운 이벤트와 최신 값을 구독자에게 전달         | 새로운 이벤트만 전송                         |
| **적합한 용도**      | 상태 저장 데이터 흐름, 지속적인 상태 관리 필요   | 단방향 데이터 흐름, 최신 데이터만 중요할 때 적합  |
| **오버헤드**         | 상태 저장으로 인해 오버헤드 발생 가능             | 가볍고 최신 상태만 유지하여 오버헤드 방지      |


**결론 및 교훈** <br>
특정 데이터 흐름의 요구사항에 맞는 적절한 릴레이 유형( PublishRelayvs. BehaviorRelay)을 선택하는 것이 중요하는 것을 깨달았습니다. 각각의 특성을 확인하고 장단점을 알게되면 구현을 단순화하고 성능을 향상시킬 수 있다는 점을 배웠습니다.

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
## 📕 회고<br>
UnitTest
