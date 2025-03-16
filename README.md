# iOS LoginSystem

## 프로젝트 개요
이 프로젝트는 사용자가 회원가입을 하고, 회원가입된 정보를 Core Data에 저장하는 기능을 구현하는 iOS 애플리케이션입니다. 
사용자가 입력한 이메일, 비밀번호, 닉네임 정보를 검증하고, 유효한 경우 이를 Core Data와 Keychain에 저장하며, 이메일 중복 검사를 포함한 에러 처리가 이루어집니다.

## 주요 기능

* **회원가입**: 이메일, 비밀번호, 닉네임을 입력받아 회원가입을 진행합니다.
* **이메일 중복 검사**: Core Data를 통해 이메일이 이미 존재하는지 체크합니다.
* **비밀번호 Keychain 저장**: 비밀번호는 Keychain에 안전하게 저장됩니다.
* **회원가입 성공 후 화면 전환**: 회원가입이 성공하면 로그인 화면으로 전환됩니다.
* **유효성 검사**: 이메일 형식, 비밀번호 길이, 비밀번호 확인 일치를 검사하여 유효성 검사를 합니다.

## 기술 스택

* **언어**: Swift
* **프레임워크**: UIKit, RxSwift
* **데이터 저장**: Core Data, UserDefaults, Keychain
* **패턴**: MVVM (Model-View-ViewModel)


## 폴더 구조
```
├── Docs
│   └── pull_request_template.md
└── LoginSystem_ParkSiYeon
    ├── LoginSystem_ParkSiYeon
    │   ├── CoreData
    │   │   └── UserInfoCoreData.xcdatamodeld
    │   │       └── UserInfoCoreData.xcdatamodel
    │   │           └── contents
    │   ├── Error
    │   │   ├── CoreDataError.swift
    │   │   ├── KeyChainError.swift
    │   │   └── SignUpError.swift
    │   ├── LoginSystem_ParkSiYeon.entitlements
    │   ├── New Group
    │   │   └── Screen
    │   │       ├── Login
    │   │       └── Start
    │   │           └── ViewModel
    │   ├── Resource
    │   │   ├── Assets.xcassets
    │   │   │   ├── AccentColor.colorset
    │   │   │   │   └── Contents.json
    │   │   │   ├── AppIcon.appiconset
    │   │   │   │   └── Contents.json
    │   │   │   ├── Colors
    │   │   │   │   ├── BackgroundGray.colorset
    │   │   │   │   │   └── Contents.json
    │   │   │   │   ├── BorderGray.colorset
    │   │   │   │   │   └── Contents.json
    │   │   │   │   ├── Contents.json
    │   │   │   │   └── PrimaryGray.colorset
    │   │   │   │       └── Contents.json
    │   │   │   └── Contents.json
    │   │   └── Base.lproj
    │   │       └── LaunchScreen.storyboard
    │   ├── Screen
    │   │   ├── LoginSuccess
    │   │   │   ├── LoginSuccessView.swift
    │   │   │   ├── LoginSuccessViewController.swift
    │   │   │   └── LoginSuccessViewModel
    │   │   │       └── LoginSuccessViewModel.swift
    │   │   ├── SignUp
    │   │   │   ├── Helper
    │   │   │   │   ├── CustomInputTextField.swift
    │   │   │   │   ├── CustomInputView.swift
    │   │   │   │   └── InputType.swift
    │   │   │   ├── SignUpView.swift
    │   │   │   ├── SignUpViewController.swift
    │   │   │   └── ViewModel
    │   │   │       └── SignUpViewModel.swift
    │   │   └── Start
    │   │       ├── StartView.swift
    │   │       ├── StartViewController.swift
    │   │       └── ViewModel
    │   │           └── StartViewModel.swift
    │   ├── Support
    │   │   ├── AppDelegate.swift
    │   │   ├── Info.plist
    │   │   └── SceneDelegate.swift
    │   └── Utils
    │       ├── Extensions
    │       │   ├── String+Extension.swift
    │       │   ├── UIColor+Extension.swift
    │       │   ├── UIStackView+Extension.swift
    │       │   └── UIView+Extension.swift
    │       ├── Helpers
    │       │   └── KeyChainHelper.swift
    │       └── Managers
    │           ├── UserDefaultsManager.swift
    │           └── UserInfoCoreDataManager.swift
    ├── LoginSystem_ParkSiYeon.xcodeproj
    │   ├── project.pbxproj
    │   ├── project.xcworkspace
    │   │   ├── contents.xcworkspacedata
    │   │   ├── xcshareddata
    │   │   │   ├── IDEWorkspaceChecks.plist
    │   │   │   ├── WorkspaceSettings.xcsettings
    │   │   │   └── swiftpm
    │   │   │       ├── Package.resolved
    │   │   │       └── configuration
    │   │   └── xcuserdata
    │   │       └── siyeonpark.xcuserdatad
    │   │           ├── UserInterfaceState.xcuserstate
    │   │           └── WorkspaceSettings.xcsettings
    │   └── xcuserdata
    │       └── siyeonpark.xcuserdatad
    │           ├── xcdebugger
    │           │   └── Breakpoints_v2.xcbkptlist
    │           └── xcschemes
    │               └── xcschememanagement.plist
    └── LoginSystem_ParkSiYeonTests
        ├── CoreDataManagerTests.swift
        ├── LoginSystem_ParkSiYeonTests.swift
        ├── Mock
        │   ├── MockCoreDataManager.swift
        │   └── MockUserDefaultsManager.swift
        └── UserDefaultsManagerTests.swift

```
