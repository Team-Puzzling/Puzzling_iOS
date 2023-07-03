
# 꾸준하고 간편한 프로젝트 회고 기록 장려 서비스, PUZZLING 🧩



<br><br>
##  🫶 PUZZLING iOS Developers
<img src="https://github.com/Team-Puzzling/Puzzling_iOS/assets/48792069/41dae135-36d7-43f6-8463-48c8fd84a462" width="200"> | <img src="https://github.com/Team-Puzzling/Puzzling_iOS/assets/48792069/41dae135-36d7-43f6-8463-48c8fd84a462" width="200"> | <img src="https://github.com/Team-Puzzling/Puzzling_iOS/assets/48792069/41dae135-36d7-43f6-8463-48c8fd84a462" width="200"> | <img src="https://github.com/Team-Puzzling/Puzzling_iOS/assets/48792069/41dae135-36d7-43f6-8463-48c8fd84a462" width="200"> |
:---------:|:----------:|:---------:|:---------:|
권 정 | 김민주 | 심규보 | 천성우 |
[kj9470](https://github.com/kj9470) | [frohsch](https://github.com/frohsch) | [PecanPiePOS](https://github.com/PecanPiePOS) | [cjs1399](https://github.com/cjs1399) |
<br>

## 💻 Development Environment

<img src ="https://img.shields.io/badge/Swift-5.5-orange?logo=swift" height="30"> <img src ="https://img.shields.io/badge/Xcode-14.3-blue?logo=xcode" height="30"> <img src ="https://img.shields.io/badge/iOS-16.0-white.svg" height="30">

<br>

## 📖 Using Library

라이브러리 | 사용 목적 | Management Tool
:---------:|:----------:|:---------:
Moya | 서버 통신 | SPM
SnapKit | UI Layout | SPM
Then | UI 선언 | SPM
Lottie | 스플래쉬 화면 | SPM
fsCalendar | 캘린더 구현 | SPM
Realm | 데이터 관리 | SPM
KakaoOpenSDK | 카카오 소셜로그인 | SPM

<br>

## 📝 Code Convention

<details>
<summary> 🌤️ 네이밍 </summary>
<div markdown="1">

### ⛅️ **클래스, 구조체**

- **UpperCamelCase** 사용

```swift
// - example

struct MyTicketResponseDTO {
}

class UserInfo {
}
```

### ⛅️ **함수**

- **lowerCamelCase** 사용하고 동사로 시작

```swift
// - example

private func setDataBind() {
}
```

### ⛅️ **뷰 전환**

- pop, push, present, dismiss
- 동사 + To + 목적지 뷰 (다음에 보일 뷰)
- dismiss는 dismiss + 현재 뷰

```swift
// - example pop, push, present

popToFirstViewController()
pushToFirstViewController()
presentToFirstViewController()

dismissFirstViewController()
```

### ⛅️ **register**

- register + 목적어

```swift
// - example

registerXib()
registerCell()
```

### ⛅️ **서버 통신**

- 서비스함수명 + WithAPI

```swift
// - example

fetchListWithAPI()

requestListWithAPI()
```

fetch는 무조건 성공

request는 실패할 수도 있는 요청

### ⛅️ **애니메이션**

- 동사원형 + 목적어 + WithAnimation

```swift
showButtonsWithAnimation()
```

### ⛅️ **델리게이트**

delegate 메서드는 프로토콜명으로 네임스페이스를 구분

**좋은 예:**

```swift
protocol UserCellDelegate {
  func userCellDidSetProfileImage(_ cell: UserCell)
  func userCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}

protocol UITableViewDelegate {
	func tableview( ....) 
	func tableview...
}

protocol JunhoViewDelegate {
	func junhoViewTouched()
	func junhoViewScrolled()
}
```

Delegate 앞쪽에 있는 단어를 중심으로 메서드 네이밍하기

**나쁜 예:**

```swift
protocol UserCellDelegate {
	// userCellDidSetProfileImage() 가 옳음
  func didSetProfileImage()
  func followPressed(user: User)

  // `UserCell`이라는 클래스가 존재할 경우 컴파일 에러 발생  (userCell 로 해주자)
  func UserCell(_ cell: UserCell, didTapFollowButtonWith user: User)
}
```

함수 이름 앞에는 되도록이면 `get` 을 붙이지 않습니다.

### ⛅️ **변수, 상수**

- **lowerCamelCase** 사용

```swift
let userName: String
```

### ⛅️ **열거형**

- 각 case 에는 **lowerCamelCase** 사용

```swift
enum UserType {
	case viewDeveloper
	case serverDeveloper
}
```

### ⛅️ **약어**

약어로 시작하는 경우 소문자로 표기, 그 외에는 항상 대문자

```swift
// 좋은 예:
let userID: Int?
let html: String?
let websiteURL: URL?
let urlString: String?
```

```swift
// 나쁜 예:
let userId: Int?
let HTML: String?
let websiteUrl: NSURL?
let URLString: String?
```

### ⛅️ **기타 네이밍**

```swift
setUI() : @IBOutlet 속성 설정
setLayout() : 레이아웃 관련 코드
setDataBind() : 배열 항목 세팅. 컬렉션뷰 에서 리스트 초기 세팅할때
setAddTarget() : addtarget 모음
setDelegate() : delegate, datasource 모음
setCollectionView() : 컬렉션뷰 관련 세팅
setTableView() : 테이블뷰 관련 세팅
initCell() : 셀 데이터 초기화
registerXib() : 셀 xib 등록.
setNotification() : NotificationCenter addObserver 모음

헷갈린다? set을 쓰세요 ^^

```
</details>

<details>
<summary> 🌤️ 코드 레이아웃 </summary>
<div markdown="1">

### ⛅️ **들여쓰기 및 띄어쓰기**

- 들여쓰기에는 탭(tab) 대신 **4개의 space**를 사용합니다.
- 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
    
    `let names: [String: String]?`
    
    `let name: String`
    
- 연산자 오버로딩 함수 정의에서는 연산자와 괄호 사이에 한 칸 띄어씁니다.
    
    `func ** (lhs: Int, rhs: Int)`
    

### ⛅️ **줄바꿈**

- 함수를 호출하는 코드가 최대 길이를 초과하는 경우에는 파라미터 이름을 기준으로 줄바꿈합니다.
**파라미터가 3개 이상이면 줄바꿈하도록!!**
    
    **단, 파라미터에 클로저가 2개 이상 존재하는 경우에는 무조건 내려쓰기합니다.**
    
    ```swift
    UIView.animate(
      withDuration: 0.25,
      animations: {
        // doSomething()
      },
      completion: { finished in
        // doSomething()
      }
    )
    ```
    
- `if let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.
    
    ```swift
    if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female {
      // ...
    }
    ```
    
- `guard let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다. `else`는 마지막 줄에 붙여쓰기
    
    ```swift
    guard let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female else { return }
    
    guard let self = self 
    else { return } (X)
    
    guard let self = self else { return } (O)

    ```
- else 구문이 길 시 줄바꿈
  

### ⛅️ **빈 줄**

- 클래스 선언 다음에 , extension 다음에 한 줄 띄어주기
- 빈 줄에는 공백이 포함되지 않도록 합니다.  ( 띄어쓰기 쓸데없이 넣지 말기 )
- 모든 파일은 빈 줄로 끝나도록 합니다. ( 끝에 엔터 하나 넣기)
- MARK 구문 위와 아래에는 공백이 필요합니다.
    
    ```swift
    // MARK: Layout
    
    override func layoutSubviews() {
      // doSomething()
    }
    
    // MARK: Actions
    
    override func menuButtonDidTap() {
      // doSomething()
    }
    ```
    

### ⛅️ **임포트**

모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.

```swift
import UIKit

import Moya
import SnapKit
import SwiftyColor
import Then
```

```swift
import UIKit

import SwiftyColor
import SwiftyImage
import JunhoKit
import Then
import URLNavigator
```

</details>


<details>
<summary> 🌤️ 클로저 </summary>
<div markdown="1">

- 파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.
    
    **좋은 예:**
    
    ```
    let completionBlock: (() -> Void)?
    ```
    
    **나쁜 예:**
    
    `let completionBlock: (() -> ())? let completionBlock: ((Void) -> (Void))?`
    
- Closure 정의시 파라미터에는 괄호를 사용하지 않습니다.
    
    **좋은 예:**
    
    ```swift
    { operation, responseObject in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    { (operation, responseObject) in
      // doSomething()
    }
    ```
    
- Closure 정의시 가능한 경우 타입 정의를 생략합니다.
    
    **좋은 예:**
    
    ```swift
    ...,
    completion: { finished in
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    ...,
    completion: { (finished: Bool) -> Void in
      // doSomething()
    }
    
    completion: { data -> Void in
      // doSomething()
    } (X)
    ```
    
- Closure 호출시 또다른 유일한 Closure를 마지막 파라미터로 받는 경우, 파라미터 이름을 생략합니다.
    
    **좋은 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5) {
      // doSomething()
    }
    ```
    
    **나쁜 예:**
    
    ```swift
    UIView.animate(withDuration: 0.5, animations: { () -> Void in
      // doSomething()
    })
    ```
    
</details>

<details>
<summary> 🌤️ 주석 </summary>
<div markdown="1">

코드는 가능하면 자체적으로 문서가 되어야 하므로, 코드와 함께 있는 인라인(inline) 주석은 피한다.

### ⛅️ **MARK 주석**

```swift
// MARK: - UI Components

// MARK: - View Life Cycle

// MARK: - Initializer

// MARK: - Properties  -> setUI

// MARK: - Layout Helper  -> setLayout

// MARK: - Methods     -> registerXib, assignDelegate 등

// MARK: - @objc Methods

// MARK: Actions       -> ex) MenuButtonDidTap

// MARK: - Network
> 네트워크 목적을 가진 함수들
```

```
// MARK: - Properties

// MARK: - @IBOutlet Properties

// MARK: - @IBAction Properties

// MARK: - View Life Cycle

// MARK: - Methods
> setUI, registerXib, assignDelegate 등

// MARK: - @objc Methods

// MARK: - Network
> 네트워크 목적을 가진 함수들
```

### ⛅️ **퀵헬프 주석**

커스텀 메서드, 프로토콜, 클래스의 경우에 퀵헬프 주석 달기

```swift
/// (서머리 부분)
/// (디스크립션 부분)
class MyClass {
    let myProperty: Int

    init(myProperty: Int) {
        self.myProperty = myProperty
    }
}

/**summary
(서머리 부분)
> (디스크립션 부분)

- parameters:
    - property: 프로퍼티
- throws: 오류가 발생하면 customError의 한 케이스를 throw
- returns: "\\(name)는 ~" String
*/
func printProperty(property: Int) {
        print(property)
    }

```

- 참고 :

</details>

<details>
<summary> 🌤️ 프로그래밍 권장사항 </summary>
<div markdown="1">

### ⛅️ **Type Annotation 사용**

**좋은 예:**

```swift
let name: String = "철수"
let height: Float = "10.0"
```

**나쁜 예:**

```swift
let name = "철수"
let height = "10.0"
```

### ⛅️ **UICollectionViewDelegate, UICollectionViewDatsource 등 시스템 프로토콜**

프로토콜을 적용할 때에는 extension을 만들어서 관련된 메서드를 모아둡니다.

**좋은 예**:

```swift
final class MyViewController: UIViewController {
  // ...
}

// MARK: - UITableViewDataSource

extension MyViewController: UITableViewDataSource {
  // ...
}

// MARK: - UITableViewDelegate

extension MyViewController: UITableViewDelegate {
  // ...
}
```

**나쁜 예:**

```swift
final class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  // ...
}

// 프로토콜 여러개를 한곳에 몰아서 때려넣지 말자!
```

</details>


<details>
<summary> 🌤️ 기타규칙 </summary>
<div markdown="1">

- `self` 는 최대한 사용을 지양 → `**알잘딱깔센 self…**`
- `viewDidLoad()` 에서는 함수호출만
- delegate 지정, UI관련 설정 등등 모두 함수와 역할에 따라서 extension 으로 빼기
- 필요없는 주석 및 Mark 구문들 제거
- `deinit{}` 모든 뷰컨에서 활성화
- `guard let` 으로 unwrapping 할 시, nil 가능성이 높은 경우에는 `else{}` 안에 `print()` 해서 디버깅하기 쉽게 만들기
- `return` 사용시 두 줄 이상 코드가 있을 시, 한 줄 띄고 `return` 사용
    
    ```swift
    func fetchFalse() -> Bool {
    		return false
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
    		guard let data else { return false }
    		
    		return true
    } (O)
    
    func isDataValid(data: Data?) -> Bool {
    		guard let data else {
    				return false 
    		}
    		return true
    } (X)
    ```
    
- 강제 언래핑 금지 (!)

</details>

<br>

##  🐈 Git & GitHub Strategy

<details>
<summary> 🐱 Git Flow </summary>
<div markdown="1">

```
  1. 작업 폴더를 만들고 
	git init
	git remote add upstream [레포 주소]
	git remote add origin [레포 주소]

2. local main 에서 upstream을 풀 받고, origin develop 에 올려준다
	git switch main
	git pull upstream develop
	git push origin develop -> 안 됨.?
3. 레포에 이슈를 생성한다.  ( 이슈 템플릿에 맞춰서 )
	"[Prefix] 작업 목표"
	자기 라벨 + Prefix 라벨 선택
	ex) [Design] Weather View 디자인
	4. 이슈 번호 만들어진걸 확인하고 로컬에 feature/#이슈번호 브랜치를 판다
	git switch -c [브랜치명]
5. 작업 하기
	git add
	git commit
6. 충돌 해결 후 PR 올리기
	git pull upstream develop
		충돌이 났다면 크라켄으로 해결해주자!!
	git push origin [작업 브랜치명]
	코드리뷰 해쥬기
	approve 최소 한 명으로 제한 걸어놨음!!
7. 머지하기
8. 내 노트북의 작업공간으로 돌아오기
	git checkout develop (main)
	다시 2번부터 진행
  ```

</details>

<details>
<summary> 🐱 Issue Template </summary>
<div markdown="1">

```markup
## 🧩 이슈 요약
<!-- 이유에 대해 설명해주세요. -->
- 프로젝트 초기 세팅

## ✅ 체크 리스트
<!-- 해야 할 일을 적어주세요. -->
- [ ] 프로젝트 초기 세팅
```

</details>

<details>
<summary> 🐱 Pull Request Template </summary>
<div markdown="1">

```markup
## 💭 작업 배경
<!-- 아래 리스트를 지우고, 작업하게 된 배경을 적어주세요. -->
 - 작업 내용 1
 - 작업 내용 2

## 🌤️ PR POINT
<!-- 작업 내용 및 덧붙이고 싶은 내용이 있다면! -->

## 📸 스크린샷
<!-- 작업한 화면이 있다면 스크린 샷으로 첨부해주세요. -->

|    구현 내용    |   스크린샷   |
| :-------------: | :----------: |
| GIF | <img src = "" width ="250">|

## 🌈 관련 이슈
<!-- 작업한 이슈번호를 # 뒤에 붙여주세요. 수고했습니다~* -->
- Resolved: #
```

</details>

<details>
<summary> 🐱 Commit Convention & Template </summary>
<div markdown="1">

- [Prefix] #이슈번호 - 작업내용
```

#   [Feat]      : 새로운 기능 구현
#   [Fix]       : 버그, 오류 해결, 코드 수정
#   [Design]    : just 화면. 레이아웃 조정
#   [Merge]     : 머지, 충돌 해결
#   [Refactor]  : 프로덕션 코드 리팩토링
#   [Comment]   : 필요한 주석 추가 및 변경
#   [Docs]      : README나 WIKI 등의 문서 개정
#   [Chore]     : 빌드 태스트 업데이트, 패키지 매니저를 설정하는 경우(프로덕션 코드 변경 X)
#   [Setting]   : 초기 세팅
#   [Rename]    : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우
#   [Remove]    : 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우

#   [커밋 타입]   : 설명!!

# Commit Example!!
# [Feat]#1 - ~~기능 추가!
```

</details>

<br>

## 📂 Folder Architecture

<details>
<summary> 프로젝트 폴더 구조 </summary>
<div markdown="1">

```bash
├── 📁 Application
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── 📁 Data
│   ├── 📁 Data
│   └── 📁 DTO
├── 📁 Network
│   ├── 📁 APIService
│   └── 📁 Foundation
├── 📁 Presentation
│   ├── 📁 Common
│   └── 📁 Home
│       ├── 📁 Cell
│       ├── 📁 ViewController
│       └── 📁 View
├── 📁 Resource
│   ├── 📁 Font
│   └── 📁 AssetCatalog
│       ├── Image.xcassets
│       └── Color.xcassets
└── 📁 Util
    ├── 📁 Extension
    ├── 📁 Literals
    └── 📁 StyleGuide
        └── FontLevel
```
  
</details>

<br>
	
## 🌷 역할 분담
<details>
<summary> 🐸 정 </summary>
<div markdown="1">
</details>
	
<details>
<summary> 😼 민주 </summary>
<div markdown="1">
</details>
  
<details>
<summary> 🦊 규보 </summary>
<div markdown="1">
</details>
  
<details>
<summary> 🐰 성우 </summary>
<div markdown="1">
</details>
  
<br>
	
## 💭 프로젝트 회고
<details>
<summary> 📄 정 </summary>
<div markdown="1">
</details>
	
<details>
<summary> 📄 민주 </summary>
<div markdown="1">
</details>
  
<details>
<summary> 📄 규보 </summary>
<div markdown="1">
</details>
  
<details>
<summary> 📄 성우 </summary>
<div markdown="1">
</details>

