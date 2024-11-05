# 계산기

## 작업 기간

24.10.29

## 필수 구현

- [더하기, 빼기, 나누기, 곱하기 연산을 수행할 수 있는 Calculator Class 생성](https://github.com/sy0201/TST/pull/1#issue-2620111606)
- [생성한 Class 를 Protocol로 업데이트 & 예외처리 상황 구현](https://github.com/sy0201/TST/pull/3#issue-2620224805)
- ["나머지 연산" 기능 추가](https://github.com/sy0201/TST/pull/5#issue-2620824940)

## 폴더 구조

```bash
├── Calculator_SiyeonPark.playground
│   ├── Contents.swift
│   ├── Sources
│   │   └── Calculator
│   │       ├── Calculator.swift
│   │       ├── Class
│   │       │   ├── AddOperation.swift
│   │       │   ├── DivideOperation.swift
│   │       │   ├── MultiplyOperation.swift
│   │       │   └── SubtractOperation.swift
│   │       └── Protocol
│   │           └── ArithmeticProtocol.swift
│   ├── contents.xcplayground
│   └── playground.xcworkspace
│       ├── contents.xcworkspacedata
│       └── xcuserdata
│           └── siyeonpark.xcuserdatad
│               └── UserInterfaceState.xcuserstate
└── README.md
```

## 커밋 컨벤션

- [INIT] : 초기
- [ADD] : 파일 추가
- [RENAME] : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우
- [REMOVE] : 파일을 삭제하는 작업만 수행한 경우
- [FEAT] : 기능 추가
- [DELETE] : 기능 삭제
- [UPDATE] : 기능 수정
- [FIX] : 버그 수정
- [REFACTOR] : 리팩토링
- [STYLE] : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
- [DOCS] : 문서 (문서 추가(Add), 수정, 삭제)
- [CHORE] : 기타 변경사항 (빌드 스크립트 수정, 에셋 추가 등)
- [DESIGN] : 사용자 UI 디자인 변경
- [HOTFIX] : 급하게 치명적인 버그를 고쳐야하는 경우
- [COMMENT] : 필요한 주석 추가 및 변경
- [TEST] : 테스트 추가, 테스트 리팩토링(프로덕션 코드 변경 X)

## PR 컨벤션

1. 신규 내용
2. 변경 내용
3. 이슈 / 고민사항 

## [계산기를 Playground에서 만들면서 생긴 트러블 슈팅](https://velog.io/@sy0201/%EA%B3%BC%EC%A0%9C1-%EA%B3%84%EC%82%B0%EA%B8%B0-%ED%8A%B8%EB%9F%AC%EB%B8%94%EC%8A%88%ED%8C%85)
