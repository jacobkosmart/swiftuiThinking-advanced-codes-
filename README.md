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

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 02.ButtonStyle

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

## 03.AnyTransition

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

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
