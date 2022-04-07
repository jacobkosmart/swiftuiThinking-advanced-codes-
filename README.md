## SwiftUI Thinking Advanced code 모음

## 👉 [강의 채널 바로가기](https://www.youtube.com/playlist?list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y)

---

## 01.ViewModifiers

You actually use view modifiers all the time. Every time you call .font, .foregroundColor, .backgroundColor those are actually view modifiers

They take the current view they add a modifier and then return a modifiedView. All viewModifier is basically taking the current content adding something to it and then returning it back to the view

So, by creating custom viewModifier you can actually stack a bunch of regular modifiers together to create a really unique and custom formatting. The most important is probably reusability cause by using custom viewModifiers you can really control how we want all views in your app to look and we can get all of those views to refer back to a single source of truth for how that button or that view should look

```swift
// MARK: -  CUSTOM VIEWMODIFIER
struct DefaultButtonViewModifier: ViewModifier {
let backgroundColor: Color

func body(content: Content) -> some View {
content
  .foregroundColor(.white)
  .frame(height: 55)
  .frame(maxWidth: .infinity)
  .background(backgroundColor)
  .shadow(radius: 10)
  .padding()
}
}

// MARK: -  VIEW
struct ViewModifierBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
VStack {
  Text("Hello")
    .modifier(DefaultButtonViewModifier(backgroundColor: .orange))
    .font(.headline)

  Text("Hello, world")
    .withDefaultButtonFormatting(backgroundColor: .green)
    .font(.subheadline)

  // ViewModifier -> Extension 사용
  Text("Hello!!")
    .withDefaultButtonFormatting()
    .font(.title)

} //: VSTACK
}
}

// MARK: -  EXTENSION
extension View {
func withDefaultButtonFormatting(backgroundColor: Color = .blue)-> some View {
modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
}
}
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/161881772-79c1e9f9-7b25-4eea-a5a2-94c3cd4ef9c3.png">

## 02.Custom ButtonStyle

Especially in more advanced production apps you actually want to customize

```swift
import SwiftUI

// MARK: -  VIEW
struct ButtonStyleBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
Button {

} label: {
  Text("Click me")
    .font(.headline)
    .foregroundColor(.white)
    .frame(height: 55)
    .frame(maxWidth: .infinity)
    .background(Color.blue.cornerRadius(10))
    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10.0)
}
// .buttonStyle(PlainButtonStyle())
// .buttonStyle(PressableStyle())
.withPressableStyle()
.padding(40)
}
}

// MARK: -  VIEWMODIFIER
struct PressableStyle: ButtonStyle {

let scaledAmount: CGFloat

// set default scaleAmount
init(scaledAmount: CGFloat) {
self.scaledAmount = scaledAmount
}

func makeBody(configuration: Configuration) -> some View {
configuration.label
  .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
  .opacity(configuration.isPressed ? 0.9 : 1.0)
  .brightness(configuration.isPressed ? 0.05 : 0)
}
}

// MARK: -  EXTENSTION
extension View {
func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
self.buttonStyle(PressableStyle(scaledAmount: scaledAmount))
}
}
```

  <img height="350"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/161889180-89343105-3cda-41a4-af26-fda89545e68b.gif">

## 03.AnyTransition

You are going to want to add some custom animations and transitions and really customize how things come on and off of the screen to really create a beautiful user experience. You can actually totally customize and create your transitions.

```swift
import SwiftUI

// MARK: -  VIEW
struct AnyTransitionBootCamp: View {
// MARK: -  PROPERTY
@State private var showRectangle: Bool = false
// MARK: -  BODY
var body: some View {
VStack {
Spacer()

if showRectangle {
  RoundedRectangle(cornerRadius: 25)
    .frame(width: 250, height: 350)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .transition(.rotaing(rotation: 1080))
}

Spacer()
Text("Click Me!")
  .withDefaultButtonFormatting()
  .padding(.horizontal, 40)
  .onTapGesture {
    withAnimation(.easeInOut(duration: 3.0)) {
      showRectangle.toggle()
    }
  }
} //: VSTACK
}
}

// MARK: -  VIEWMODIFIER
struct RotateViewModifier: ViewModifier {
let rotation: Double
func body(content: Content) -> some View {
  content
    .rotationEffect(Angle(degrees: rotation))
    .offset(
      x: rotation != 0 ? UIScreen.main.bounds.width : 0,
      y: rotation != 0 ? UIScreen.main.bounds.height : 0)
}
}

// MARK: -  EXTENSION
extension AnyTransition {
static var rotaing: AnyTransition {
  return AnyTransition.modifier(
    active: RotateViewModifier(rotation: 180),
    identity: RotateViewModifier(rotation: 0))
}

static func rotaing(rotation: Double) -> AnyTransition {
  return AnyTransition.modifier(
    active: RotateViewModifier(rotation: rotation),
    identity: RotateViewModifier(rotation: 0))
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162103113-0cc7a886-948f-4509-b72c-366aaafd9307.gif">

- AnyTransition.asymmetric (insertion, removal)

```swift
import SwiftUI

// MARK: -  VIEW
struct AnyTransitionBootCamp: View {
// MARK: -  PROPERTY
@State private var showRectangle: Bool = false
// MARK: -  BODY
var body: some View {
VStack {
Spacer()

if showRectangle {
  RoundedRectangle(cornerRadius: 25)
    .frame(width: 250, height: 350)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .transition(.rotateOn)
}

Spacer()
Text("Click Me!")
  .withDefaultButtonFormatting()
  .padding(.horizontal, 40)
  .onTapGesture {
    withAnimation(.easeInOut) {
      showRectangle.toggle()
    }
  }
} //: VSTACK
}
}

// MARK: -  VIEWMODIFIER
struct RotateViewModifier: ViewModifier {
let rotation: Double
func body(content: Content) -> some View {
content
  .rotationEffect(Angle(degrees: rotation))
  .offset(
    x: rotation != 0 ? UIScreen.main.bounds.width : 0,
    y: rotation != 0 ? UIScreen.main.bounds.height : 0)
}
}

// MARK: -  EXTENSTION
extension AnyTransition {
static var rotaing: AnyTransition {
modifier(
  active: RotateViewModifier(rotation: 180),
  identity: RotateViewModifier(rotation: 0))
}

static func rotaing(rotation: Double) -> AnyTransition {
modifier(
  active: RotateViewModifier(rotation: rotation),
  identity: RotateViewModifier(rotation: 0))
}

static var rotateOn: AnyTransition {
asymmetric(
  insertion: .rotaing,
  removal: .move(edge: .leading))
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162103737-8e0f6e74-38cc-4651-bde9-a380f705f068.gif">

## 04.MatchedGeometryEffect

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 05.Shapes, Curves, AnimateableData

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 06.Generics

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 07.ViewBuilder

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 08.PreferenceKey

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 09.Custom TabView

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 10.Custom NavigationView

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 11.UIViewRepresentable

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 12.UIViewControllerRepresentable

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 13.Protocols

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 14.Dependency Injection

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 15.Unit Testing

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 16.UI Testing

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 17.Combine

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

### 18.Futures and Promises

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

### 19.CloudKit

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

---

<!-- <p align="center">
  <img height="350"  alt="스크린샷" src="">
</p> -->

<!-- README 한 줄에 여러 screenshoot 놓기 예제 -->
<!-- <p>
   <img height="350" alt="스크린샷" src="">
   <img height="350" alt="스크린샷" src="">
   <img height="350" alt="스크린샷" src="">
</p> -->

---

<!-- 🔶 🔷 📌 🔑 👉 -->

## 🗃 Reference

SwiftUI Continued Learning (Advanced Level) - [https://www.youtube.com/c/SwiftfulThinking](https://www.youtube.com/c/SwiftfulThinking)
