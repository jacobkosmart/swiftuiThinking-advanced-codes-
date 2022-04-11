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

The matchedGeometryEffect allows us to animate geometric shapes on the screen and specifically allows us to more on shape into another shape. So how we do it is actually create two different shapes on the screen and then we tell the system that these two shapes are the same shape

```swift
struct MatchedGeometryEffectBootCamp: View {
// MARK: -  PROPERTY
@State private var isClicked: Bool = false
@Namespace private var namespace
// MARK: -  BODY
var body: some View {
VStack {
if !isClicked {
  RoundedRectangle(cornerRadius: 25.0)
    .matchedGeometryEffect(id: "rectangle", in: namespace)
    .frame(width: 100, height: 100)
}

Spacer()
if isClicked {
  RoundedRectangle(cornerRadius: 25.0)
    .matchedGeometryEffect(id: "rectangle", in: namespace)
    .frame(width: 300, height: 200)
}

} //: VSTACK
.frame(maxWidth: .infinity, maxHeight: .infinity)
.background(Color.red)
.onTapGesture {
withAnimation(.easeInOut) {
  isClicked.toggle()
}
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162106699-5e55a15b-5f48-433f-a369-a955e0967836.gif">

```swift
struct MatchedGeometryEffectExample2: View {

let categories: [String] = ["Home", "Popular", "Saved"]
@State private var selected: String = "Home"
@Namespace private var namespace2

var body: some View {
HStack {
ForEach(categories, id: \.self) { category in
ZStack {
  if selected == category  {
    RoundedRectangle(cornerRadius: 10.0)
      .fill(Color.red)
      .matchedGeometryEffect(id: "category_background", in: namespace2)
      .frame(width: 40, height: 2)
      .offset(y: 20)
  }
  Text(category)
    .foregroundColor(selected == category ? .red : .black)
  }
  .frame(maxWidth: .infinity)
  .frame(height: 55)
  .onTapGesture {
    withAnimation(.spring()) {
      selected = category
    }
  }
} //: LOOP
} //: HSTACK
.padding()
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162109531-b0f47e0d-d388-4f10-a326-1575b5b5dec4.gif">

## 05.Shapes, Curves, AnimateableData

### Custom Straight lines

By default SwiftUI actually comes with a bunch of shapes out of the box like rectangles rounded rectangles circles. By building custom and unique UI designs eventually you'll run into a point where actually need a custom shape.

SwiftUI by actually drawing the shape from point to point on a path

```swift
// MARK: -  VIEW
struct CustomShapesBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
ZStack {
  Triangle()
    // .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
    // .trim(from: 0, to: 0.5)
    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [10]))
    .foregroundColor(.blue)
    .frame(width: 300, height: 300)
} //: ZSTACK
}
}

// MARK: -  CUSTOM SHAPE
struct Triangle: Shape {

func path(in rect: CGRect) -> Path {
Path { path in
  path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Set Starting point
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
  path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
  path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
}
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162120819-b382eaa0-b629-4de5-a3ab-d5363fbefb1a.png">

```swift
// MARK: -  VIEW
struct CustomShapesBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
ZStack {

Image("pic")
  .resizable()
  .scaledToFill()
  .frame(width: 300, height: 300)
  .clipShape(
    Triangle()
      .rotation(Angle(degrees: 180))
  )
} //: ZSTACK
}
}

// MARK: -  CUSTOM SHAPE
struct Triangle: Shape {

func path(in rect: CGRect) -> Path {
  Path { path in
    path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Set Starting point
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
  }
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162121268-25c1e46a-5ca2-42b6-8fba-d68b016effd9.png">

```swift
// MARK: -  VIEW
struct CustomShapesBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
  ZStack {

    Diamond()
      .frame(width: 300, height: 300)
  } //: ZSTACK
}
}

// MARK: -  CUSTOM SHAPE


struct Diamond: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
  let horizontalOffset: CGFloat = rect.width * 0.2
  path.move(to: CGPoint(x: rect.midX, y: rect.minY))
  path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
  path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
  path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
  path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162121962-f086cb7e-14b3-4823-8a63-c7ace0dc0eab.png">

```swift
// MARK: -  VIEW
struct CustomShapesBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
ZStack {

  Trapezoid()
    .frame(width: 300, height: 150)
} //: ZSTACK
}
}

// MARK: -  CUSTOM SHAPE
struct Trapezoid: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
  let horizontalOffset: CGFloat = rect.width * 0.2
  path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY ))
  path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
  path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
  path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
}
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162123901-bc29502d-1211-41c0-ad76-f21265766943.png">

### Custom Curve Lines

Curves and arcs could be a little tricky to implement. To do that, arcs which is basically just a regular symmetrical curve and then quad curves which are a little more advanced and possibly more useful because they can connect two points and create an automatic curve between those two points

```swift
/ MARK: -  VIEW
struct CustomCurvesBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
  ArcSample()
    .stroke(lineWidth: 5)
    .frame(width: 200, height: 200)
}
}

// MARK: -  PREVIEW
struct CustomCurvesBootCamp_Previews: PreviewProvider {
static var previews: some View {
  CustomCurvesBootCamp()
}
}

// MARK: -  CUSTOM SHAPE
struct ArcSample: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
  path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
  path.addArc(
    center: CGPoint(x: rect.midX, y: rect.midY),
    radius: rect.height / 2,
    startAngle: Angle(degrees: 0),
    endAngle: Angle(degrees: 40),
    clockwise: true)
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162659981-51fd2830-f5c5-4565-9583-a9e4f95eaa79.png">

```swift
// MARK: -  VIEW
struct CustomCurvesBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
  ShapeWithArc()
    .frame(width: 200, height: 200)
    // .rotationEffect(Angle(degrees: 90))
}
}

// MARK: -  PREVIEW
struct CustomCurvesBootCamp_Previews: PreviewProvider {
static var previews: some View {
  CustomCurvesBootCamp()
}
}

// MARK: -  CUSTOM SHAPE
struct ShapeWithArc: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
  // top left
  path.move(to: CGPoint(x: rect.minX, y: rect.minY))

  // top right
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

  // mid right
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

  // bottom
  // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
  path.addArc(
    center: CGPoint(x: rect.midX, y: rect.midY),
    radius: rect.height / 2,
    startAngle: Angle(degrees: 0),
    endAngle: Angle(degrees: 180),
    clockwise: false)

  // mid left
  path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162660796-8a9a7f3a-834f-46b0-a746-0f0c4beec565.png">

- Quad curve

<img width="322" alt="image" src="https://user-images.githubusercontent.com/28912774/162661177-a661876c-2849-4b88-8e38-9e63fb70704f.png">

```swift
// MARK: -  VIEW
struct CustomCurvesBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
  QuadSample()
    .frame(width: 200, height: 200)
}
}

// MARK: -  PREVIEW
struct CustomCurvesBootCamp_Previews: PreviewProvider {
static var previews: some View {
  CustomCurvesBootCamp()
}
}

// MARK: -  CUSTOM SHAPE
struct QuadSample: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
  path.move(to: .zero)
  path.addQuadCurve(
    to: CGPoint(x: rect.maxX, y: rect.maxY),
    control: CGPoint(x: rect.minX, y: rect.maxY))
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162661462-f1d5036f-274e-42f5-864d-d3b6fd18b947.png">

```swift
// MARK: -  VIEW
struct CustomCurvesBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
WaterShape()
  .fill(LinearGradient(
    gradient: Gradient(colors: [Color.blue, Color.cyan]),
    startPoint: .topTrailing,
    endPoint: .bottomTrailing))
  .ignoresSafeArea()
}
}

// MARK: -  PREVIEW
struct CustomCurvesBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		CustomCurvesBootCamp()
	}
}

// MARK: -  CUSTOM SHAPE
struct WaterShape: Shape {
func path(in rect: CGRect) -> Path {
Path { path in
path.move(to: CGPoint(x: rect.minX, y: rect.midY))

path.addQuadCurve(
  to: CGPoint(x: rect.midX, y: rect.midY),
  control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))

path.addQuadCurve(
  to: CGPoint(x: rect.maxX, y: rect.midY),
  control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60))

path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162662232-4c2e418b-8beb-45bf-8c25-b15ce718e1f1.png">

### Custom animated Lines

```swift
// MARK: -  VIEW
struct AnimatableDataBootCamp: View {
// MARK: -  PROPERTY
@State private var animate: Bool = false
// MARK: -  BODY
var body: some View {
ZStack {
  // RoundedRectangle(cornerRadius: animate ? 60 : 0)
  RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
    .frame(width: 250, height: 250)
} //: ZSTACK
.onAppear {
  withAnimation(Animation.linear(duration: 2.0).repeatForever()) {
    animate.toggle()
  }
}
}
}

// MARK: -  PREVIEW
struct AnimatableDataBootCamp_Previews: PreviewProvider {
static var previews: some View {
  AnimatableDataBootCamp()
}
}

// MARK: -  CUSTOM SHAPE
struct RectangleWithSingleCornerAnimation: Shape {

var cornerRadius: CGFloat
var animatableData: CGFloat {
  get { cornerRadius }
  set { cornerRadius = newValue }
}

func path(in rect: CGRect) -> Path {
Path { path in
  path.move(to: .zero)
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
  path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))

  path.addArc(
    center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
    radius: cornerRadius,
    startAngle: Angle(degrees: 0),
    endAngle: Angle(degrees: 360),
    clockwise: false)
  path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY ))
  path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162670153-3b9e980a-b728-41e8-9347-9ed742d45c0b.gif">

```swift
// MARK: -  VIEW
struct AnimatableDataBootCamp: View {
// MARK: -  PROPERTY
@State private var animate: Bool = false
// MARK: -  BODY
var body: some View {
ZStack {
  Pacman(offsetAmount: animate ? 20 : 0)
    .frame(width: 250, height: 250)
} //: ZSTACK
.onAppear {
  withAnimation(Animation.easeInOut.repeatForever()) {
    animate.toggle()
  }
}
}
}

// MARK: -  PREVIEW
struct AnimatableDataBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		AnimatableDataBootCamp()
	}
}

// MARK: -  CUSTOM SHAPE

struct Pacman: Shape {

var offsetAmount: Double
var animatableData: Double {
get { offsetAmount }
set { offsetAmount = newValue }
}

func path(in rect: CGRect) -> Path {
Path { path in
  path.move(to: CGPoint(x: rect.midX, y: rect.midY))
  path.addArc(
    center: CGPoint(x: rect.midX, y: rect.midY),
    radius: rect.height / 2,
    startAngle: Angle(degrees: offsetAmount),
    endAngle: Angle(degrees: 360 - offsetAmount),
    clockwise: false)
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162670869-790846d4-ba2b-468d-aea1-f11f47e31f39.gif">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

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
