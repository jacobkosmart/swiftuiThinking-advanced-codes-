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

## 06.Generics

```swift
// MARK: -  MODEL
struct StringModel {
let info: String?

func removeInfo() -> StringModel {
  StringModel(info: nil)
}
}

// generic any type
struct GenericModel<T> {

let info: T?
func removeInfo() -> GenericModel {
  GenericModel(info: nil)
}
}

// MARK: -  VIEWMODEL
class GenericsViewModel: ObservableObject {
// MARK: -  PROPERTY
@Published var stringModel = StringModel(info: "Hi World!")

@Published var genericStringModel = GenericModel(info: "Hello, world")
@Published var genericBoolModel = GenericModel(info: true)
// MARK: -  INIT

// MARK: -  FUNCTION
func removeData() {
  stringModel = stringModel.removeInfo()
  genericStringModel = genericStringModel.removeInfo()
  genericBoolModel = genericBoolModel.removeInfo()
}
}

// MARK: -  VIEW
struct GenericsBootCamp: View {
// MARK: -  PROPERTY
@StateObject private var vm = GenericsViewModel()
// MARK: -  BODY
var body: some View {
VStack {
  GenericView(content: Text("custom content"), title: "new View")

  Text(vm.stringModel.info ?? "No data")
  Text(vm.genericStringModel.info ?? "No data")
  Text(vm.genericBoolModel.info?.description ?? "No data")
    .onTapGesture {
      vm.removeData()
    }
} //: VSTACK
}
}

struct GenericView<T:View>: View {
let content: T
let title: String

var body: some View {
  VStack {
    Text(title)
    content
  }
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162681169-8754750c-52bd-4bb2-a058-4ef5a0cadbcc.png">

## 07.ViewBuilder

We can use a view builder to create closures in which we can create custom child views. In order to use the view builder and get the most out of it we actually use the view builder alongside generic types

```swift
import SwiftUI

// MARK: -  VIEW
struct ViewBuilderBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
  VStack {
    HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
    HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
    Spacer()
  } //: VSTACK
}
}

// MARK: -  EXTENSTION
struct HeaderViewRegular: View {
let title: String
let description: String?
let iconName: String?

var body: some View {
  VStack(alignment: .leading, spacing: 10) {
    Text(title)
      .font(.largeTitle)
      .fontWeight(.semibold)

    if let description = description {
      Text(description)
        .font(.callout)
    }
    if let iconName = iconName {
      Image(systemName: iconName)
    }

    RoundedRectangle(cornerRadius: 5)
      .frame(height: 2)

  } //: VSTACK
  .frame(maxWidth: .infinity, alignment: .leading)
  .padding()
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162866055-e663de21-5d81-496f-b528-0e3cc658389d.png">

Above method here is kind of getting annoying and not super efficient because we have custom logic for this description we've custom logic for this icon name what if we wanted to have 10 icons or more. So with this method we can actually just customize and add whatever we want into this view

If you want to be able to customize this view and put whatever we want inside of it we really need to pass a view into the view

To use @ViewBuilder to make customize aspects in Views

```swift
// MARK: -  VIEW
struct ViewBuilderBootCamp: View {
// MARK: -  PROPERTY

// MARK: -  BODY
var body: some View {
VStack {
HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)

HeaderViewGeneric(title: "Generic Tilte") {
  HStack {
    Text("Hi")
    Image(systemName: "heart.fill")
  } //: HSTACK
}

CustomHStack {
  Text("Hi 1")
  Text("Hi 2")
}
HStack {
  Text("Hi 3")
  Text("Hi 4")
}
Spacer()
} //: VSTACK
}
}

// MARK: -  EXTENSTION
struct HeaderViewRegular: View {
let title: String
let description: String?
let iconName: String?

var body: some View {
VStack(alignment: .leading, spacing: 10) {
  Text(title)
    .font(.largeTitle)
    .fontWeight(.semibold)

  if let description = description {
    Text(description)
      .font(.callout)
  }
  if let iconName = iconName {
    Image(systemName: iconName)
  }

  RoundedRectangle(cornerRadius: 5)
    .frame(height: 2)

} //: VSTACK
.frame(maxWidth: .infinity, alignment: .leading)
.padding()
}
}

struct HeaderViewGeneric<Content:View>: View {

let title: String
let content: Content

init(title: String, @ViewBuilder content: () -> Content) {
self.title = title
self.content = content()
}

var body: some View {
VStack(alignment: .leading, spacing: 10) {
  Text(title)
    .font(.largeTitle)
    .fontWeight(.semibold)

  content

  // if let description = description {
  // 	Text(description)
  // 		.font(.callout)
  // }
  // if let iconName = iconName {
  // 	Image(systemName: iconName)
  // }
  //
  RoundedRectangle(cornerRadius: 5)
    .frame(height: 2)
} //: VSTACK
.frame(maxWidth: .infinity, alignment: .leading)
.padding()
}
}

struct CustomHStack<Content:View>: View {
let content: Content

init(@ViewBuilder content: () -> Content) {
  self.content = content()
}
var body: some View {
  HStack {
    content
  }
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162870856-86673c80-2311-471c-bf7c-575ca22de0b7.png">

We can use @ViewBuilder instead of using it inside the init and we can actually just declare custom variables with the view builder attribute

```swift
struct LocalViewBuilder: View {
enum ViewType {
  case one, two, three
}
let type: ViewType

@ViewBuilder  private var headerSection: some View {
  switch type {
  case .one:
    viewOne
  case .two:
    viewTwo
  case .three:
    viewThree
  }
  // if type == .one {
  // 	viewOne
  // } else if type == .two {
  // 	viewTwo
  // } else if type == .three {
  // 	viewThree
  // }
}

private var viewOne: some View {
  Text("One!")
}
private var viewTwo: some View {
  VStack {
    Text("Two")
    Image(systemName: "heart.fill")
  }
}
private var viewThree: some View {
  Image(systemName: "heart.fill")
}
var body: some View {
  VStack {
    headerSection
  } //: VSTACK
}

}
/ MARK: -  PREVIEW
struct ViewBuilderBootCamp_Previews: PreviewProvider {
static var previews: some View {
  // ViewBuilderBootCamp()
  LocalViewBuilder(type: .one)
	}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162871041-deb52cf2-b165-4a56-898c-da875802e471.png">

## 08.PreferenceKey

Once, you start building custom SwiftUI components you will run into situations where the preference key will come in handy the most common example of a preference key is actually the title in the navigation bar

So, SwiftUI if you use the regular navigation view you probably set the title for that navigation view within the child view of that screen and what you may have realized is that when we are setting the title in a navigation view, we are actually updating the parent title from a child view

In SwiftUI, normally data flows from parent views down to child views and the only way we can get it to flow back is if we use a binding. But you probably noticed that when you're setting the title on a navigation view there is no binding we just set the title as a string and it updates the parent view and that's because behind the scenes it is using a preference key.

```swift
struct PreferenceKeyBootCamp: View {
// MARK: -  PROPERTY
@State  private var text: String = "Hellow world!"
// MARK: -  BODY
var body: some View {
NavigationView {
  VStack {
    SecondaryScreen(text: text)
      .navigationTitle("Navigation Title")

  } //: VSTACK
} //: NAVIGATION
.onPreferenceChange(CustomTiltePreferenceKey.self) { value in
  self.text = value
}
}
}

// MARK: -  PREVIEW
struct PreferenceKeyBootCamp_Previews: PreviewProvider {
static var previews: some View {
  PreferenceKeyBootCamp()
}
}

struct SecondaryScreen: View {
let text: String
@State private var newValue: String = ""

var body: some View {
Text(text)
  .onAppear(perform: getDataFromDatabase)
  .customTitle(newValue)
}

func getDataFromDatabase() {
// download fake data
DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
  self.newValue = "New Value From DB"
}
}
}

extension View {
func customTitle(_ text: String) -> some View {
    preference(key: CustomTiltePreferenceKey.self, value: text)
}
}

struct CustomTiltePreferenceKey: PreferenceKey {

static var defaultValue: String = ""

static func reduce(value: inout String, nextValue: () -> String) {
  value = nextValue()
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162882892-533c0333-5078-4075-a4c3-5a72544738ee.gif">

```swift
import SwiftUI

struct GeometryPreferenceBootCamp: View {
// MARK: -  PROPERTY
@State private var rectSize: CGSize = .zero
// MARK: -  BODY
var body: some View {
VStack(spacing: 50) {
Text("Hello")
  .frame(width: rectSize.width, height: rectSize.height)
  .background(Color.blue)


HStack {
  Rectangle()

  GeometryReader { geo in
    Rectangle()
      .updateRectangleGeoSize(geo.size)
  }

  Rectangle()
}
.frame(height: 55)
} //: VSTACK
.onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
self.rectSize = value
}
}
}

// MARK: -  PREVIEW
struct GeometryPreferenceBootCamp_Previews: PreviewProvider {
static var previews: some View {
  GeometryPreferenceBootCamp()
}
}

extension View {
func updateRectangleGeoSize(_ size: CGSize) -> some View {
  preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
}
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
static var defaultValue: CGSize = .zero

static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
  value = nextValue()
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162884412-89e53d52-f176-4ed5-b2a5-0cc9d77c1ec0.png">

```swift
import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
static var defaultValue: CGFloat = 0
static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
  value = nextValue()
}
}

extension View {
func onScrollViewoffsetChnaged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
self
.background(
GeometryReader { geo in
      Text("")
        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
    }
  )
.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
action(value)
}
}
}

struct ScrollViewOffsetPreferenceBootCamp: View {

let title: String = "New title here!!!"
@State private var scrollViewOffset: CGFloat = 0

var body: some View {
ScrollView {
VStack {
titleLayer
  .opacity(Double(scrollViewOffset) / 63.0)
  .onScrollViewoffsetChnaged { value in
    self.scrollViewOffset = value
  }


contentLayer

} //: VSTACK
.padding()
} //: SCROLL
.overlay(Text("\(scrollViewOffset)"))

.overlay(
navBarLayer
.opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
, alignment: .top
)
}
}

struct ScrollViewOffsetPreferenceBootCamp_Previews: PreviewProvider {
static var previews: some View {
ScrollViewOffsetPreferenceBootCamp()
}
}

extension ScrollViewOffsetPreferenceBootCamp {
private var titleLayer: some View {
Text(title)
  .font(.largeTitle)
  .fontWeight(.semibold)
  .frame(maxWidth: .infinity, alignment: .leading)
}

private var contentLayer: some View {
ForEach(0..<100) { _ in
  RoundedRectangle(cornerRadius: 10)
    .fill(Color.red.opacity(0.3))
    .frame(width: 300, height: 300)
} //: LOOP
}

private var navBarLayer: some View {
Text(title)
  .font(.headline)
  .frame(maxWidth: .infinity)
  .frame(height: 55)
  .background(Color.blue)

}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162886805-fb7d50b1-4f10-4ecf-94d4-eb53c4d5604e.gif">

## 09.Custom TabView

There are majority of apps use either a tab bar or a navigation view and those two components in SwiftUI are not that customizable. Actually, model our custom tab view based off of apple's API for the default tab view

The majority of features in Custom TabView

- Generics

- ViewBuilder

- PreferenceKey

- MatchedGeometryEffect

```swift
// General style tabView
import SwiftUI

struct AppTabBarView: View {
// MARK: -  PROPERTY
@State private var selection: String = "home"
// MARK: -  BODY
var body: some View {
TabView(selection: $selection) {
Color.red
  .tabItem {
    Image(systemName: "house")
    Text("Home")
  }

Color.blue
  .tabItem {
    Image(systemName: "heart")
    Text("Favorite")
  }

Color.orange
  .tabItem {
    Image(systemName: "person")
    Text("Profile")
  }
}
}
}

// MARK: -  PREVIEW
struct AppTabBarView_Previews: PreviewProvider {
static var previews: some View {
  AppTabBarView()
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/162891635-aedb5e07-328c-49ba-a7e5-7bed32046ff2.gif">

```swift
// in TabBarItem
import Foundation
import SwiftUI

// struct TabBarItem: Hashable {
// 	let iconName: String
// 	let title: String
// 	let color: Color
// }

// Model is handy when you don't know the actual data tat you're going to get
// TabBar specifically we actually have all that data in our code
// We have all of the data already it will actually be easier to make this tab bar item and enum instead of struct

enum TabBarItem: Hashable {
	case home, favorites, profile, messages

	var iconName: String {
		switch self {
		case .home: return "house"
		case .favorites: return "heart"
		case .profile: return "person"
		case .messages: return "message"
		}
	}

	var title: String {
		switch self {
		case .home: return "Home"
		case .favorites: return "Favorites"
		case .profile: return "Profile"
		case .messages: return "Messages"
		}
	}

	var color: Color {
		switch self {
		case .home: return Color.red
		case .favorites: return Color.blue
		case .profile: return Color.green
		case .messages: return Color.orange
		}
	}
}


```

```swift
// in TabBarItemsPreferenceKey
import Foundation
import SwiftUI

// MARK: -  Create PreferenceKey
struct TabBarItemsPreferenceKey: PreferenceKey {

static var defaultValue: [TabBarItem] = []

static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
  value += nextValue()
}
}

// MARK: -  ViewModifier
struct TabBarItemViewModifier: ViewModifier {

let tab: TabBarItem
@Binding var selection: TabBarItem

func body(content: Content) -> some View {
  content
    .opacity(selection == tab ? 1.0 : 0.0)
    .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
}
}

// MARK: -  Extenstion
extension View {
func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
  self
    .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
}
}

```

```swift
// in CustomTabBarContainerView
import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {

@Binding var selection: TabBarItem
let content: Content
@State private var tabs: [TabBarItem] = []

init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
  self._selection = selection
  self.content = content()
}

var body: some View {
  ZStack(alignment: .bottom) {
      content
      .ignoresSafeArea()
    CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
    } //: ZSTACK
  .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
    self.tabs = value
  }
}
}

struct CustomTabBarContainerView_Previews: PreviewProvider {

static let tabs: [TabBarItem] = [
  .home, .favorites, .profile, .messages
]

static var previews: some View {
  CustomTabBarContainerView(selection: .constant(tabs.first!)) {
    Color.red
  }
}
}

```

```swift
// in CustomTabBarView
import SwiftUI

// MARK: -  VIEW
struct CustomTabBarView: View {
// MARK: -  PROPERTY
let tabs: [TabBarItem]
@Binding  var selection: TabBarItem
@Namespace private var namespace
@State var localSelection: TabBarItem

// MARK: -  BODY
var body: some View {
// tabBarVersion1
tabBarVersion2
  .onChange(of: selection) { newValue in
    withAnimation(.easeInOut) {
      localSelection = newValue
    }
  }
}
}

// MARK: -  PREVIEW
struct CustomTabBarView_Previews: PreviewProvider {

static let tabs: [TabBarItem] = [
.home, .favorites, .profile
]
static var previews: some View {
VStack {
  Spacer()
  CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
}
}
}

// MARK: -  EXTENSTION
extension CustomTabBarView {
private func tabView(tab: TabBarItem) -> some View {
VStack {
Image(systemName: tab.iconName)
  .font(.subheadline)
Text(tab.title)
  .font(.system(size: 10, weight: .semibold, design: .rounded))
} //: VSTACK
.foregroundColor(selection == tab ? tab.color : Color.gray)
.padding(.vertical, 8)
.frame(maxWidth: .infinity)
.background(selection == tab ? tab.color.opacity(0.2) : Color.clear)
.cornerRadius(10)
}

private var tabBarVersion1: some View {
HStack {
ForEach(tabs, id: \.self) { tab in
  tabView(tab: tab)
    .onTapGesture {
      switchToTab(tab: tab)
    }
}
} //: HSTACK
.padding(6)
.background(Color.white.ignoresSafeArea(edges: .bottom))
}

private func switchToTab(tab: TabBarItem) {
selection = tab
}
}

// tabBarVersion2
extension CustomTabBarView {
private func tabView2(tab: TabBarItem) -> some View {
VStack {
Image(systemName: tab.iconName)
  .font(.subheadline)
Text(tab.title)
  .font(.system(size: 10, weight: .semibold, design: .rounded))
} //: VSTACK
.foregroundColor(localSelection == tab ? tab.color : Color.gray)
.padding(.vertical, 8)
.frame(maxWidth: .infinity)
.background(
ZStack {
  if localSelection == tab {
    RoundedRectangle(cornerRadius: 10)
      .fill(tab.color.opacity(0.2))
      .matchedGeometryEffect(id: "background_rectangle", in: namespace)
  }
} //: ZSTACK
)
}

private var tabBarVersion2: some View {
HStack {
ForEach(tabs, id: \.self) { tab in
  tabView2(tab: tab)
    .onTapGesture {
      switchToTab(tab: tab)
    }
}
} //: HSTACK
.padding(6)
.background(Color.white.ignoresSafeArea(edges: .bottom))
.cornerRadius(10)
.shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
.padding(.horizontal)
}

}
```

```swift
import SwiftUI

struct AppTabBarView: View {
// MARK: -  PROPERTY
@State private var selection: String = "home"
@State private var tabSelection: TabBarItem = .home
// MARK: -  BODY
var body: some View {
CustomTabBarContainerView(selection: $tabSelection) {
  Color.blue
    .tabBarItem(tab: .home, selection: $tabSelection)

  Color.red
    .tabBarItem(tab: .favorites, selection: $tabSelection)

  Color.green
    .tabBarItem(tab: .profile, selection: $tabSelection)

  Color.orange
    .tabBarItem(tab: .messages, selection: $tabSelection)
}
}
}

// MARK: -  PREVIEW
struct AppTabBarView_Previews: PreviewProvider {
static var previews: some View {
  AppTabBarView()
}
}

// MARK: -  EXTENSTION
extension AppTabBarView {
private var defaultTabView: some View {
TabView(selection: $selection) {
Color.red
  .tabItem {
    Image(systemName: "house")
    Text("Home")
  }

Color.blue
  .tabItem {
    Image(systemName: "heart")
    Text("Favorite")
  }

Color.orange
  .tabItem {
    Image(systemName: "person")
    Text("Profile")
  }
} //: TAB
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163075767-f6d5f204-2f35-4265-9ea4-54cec5590527.gif">

## 10.Custom NavigationView

The default NavigationView comes with swiftUI is not that customizable. But you could build a custom Nav View and Bar are actually create wrappers and wrap them around the default navigation view and link

But on the screen it's going to appear like we're using our own custom navigationView. To be possible by using ViewBuilders and PreferenceKeys

```swift
// Default NavigationView in Apple's API
struct AppNavBarView: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
NavigationView {
ZStack {
Color.green.ignoresSafeArea()

NavigationLink(destination: Text("Destination")
                .navigationTitle("Title 2")
                .navigationBarBackButtonHidden(false)) {
  Text("Navigate")
}
}
.navigationTitle("Nav title here")
} //: NAVIGATION
}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163079814-9674f807-377c-4aab-8fdc-50731deefee0.gif">

```swift
// in CustomNavBarTitlePreferenceKey
import Foundation
import SwiftUI

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
	static var defaultValue: String = ""

	static func reduce(value: inout String, nextValue: () -> String) {
		value = nextValue()
	}
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
	static var defaultValue: String? = nil

	static func reduce(value: inout String?, nextValue: () -> String?) {
		value = nextValue()
	}
}
struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
	static var defaultValue: Bool = false

	static func reduce(value: inout Bool, nextValue: () -> Bool) {
		value = nextValue()
	}
}

extension View {
	func customNavigationTile(_ title: String) -> some View {
		self
			.preference(key: CustomNavBarTitilePreferenceKey.self, value: title)
	}

	func customNavigationSubtitle(_ subtitle: String?) -> some View {
		self
			.preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
	}

	func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
		self
			.preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
	}

	// combine above three functions
	func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
		self
			.customNavigationTile(title)
			.customNavigationSubtitle(subtitle)
			.customNavigationBarBackButtonHidden(backButtonHidden)
	}
}

```

```swift
// in CustomNavLink
struct CustomNavLink<Label:View, Destination:View>: View {
let destination: Destination
let label: Label

init(destination: Destination, @ViewBuilder label: () -> Label) {
self.destination = destination
self.label = label()
}

var body: some View {

NavigationLink(
  destination:
    CustomNavBarContainerView(content: {
      destination
    }).navigationBarHidden(true)){
  label
}
}
}

struct CustomNavLink_Previews: PreviewProvider {
static var previews: some View {
CustomNavView {
  CustomNavLink(
    destination: Text("Destination")) {
      Text("Click Me")
    }
}
}
}

```

```swift
// in CustomNavBarContainerView
// MARK: -  VIEW
struct CustomNavBarContainerView<Content: View>: View {
// MARK: -  PROPERTY
let content: Content
@State private var showBackButton: Bool = true
@State private var title: String = ""
@State private var subtitle: String? = nil

init(@ViewBuilder content: () -> Content) {
  self.content = content()
}
// MARK: -  BODY
var body: some View {
  VStack (spacing: 0) {
    CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  .onPreferenceChange(CustomNavBarTitilePreferenceKey.self) { value in
    self.title = value
  }
  .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self) { value in
    self.subtitle = value
  }
  .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { value in
    self.showBackButton = !value
  }
}
}

// MARK: -  PREVIEW
struct CustomNavBarContainerView_Previews: PreviewProvider {
static var previews: some View {
CustomNavBarContainerView {
ZStack {
  Color.green.ignoresSafeArea()

  Text("Hello")
    .foregroundColor(.white)
    .customNavigationTile("New Title")
    .customNavigationSubtitle("subtitle")
    .customNavigationBarBackButtonHidden(true)
}
}
}
}

```

```swift
// in CustomNavBarView
// MARK: -  VIEW
struct CustomNavBarView: View {
// MARK: -  PROPERTY
@Environment(\.presentationMode) var presentationMode
let  showBackButton: Bool
let title: String
let subtitle: String?
// MARK: -  BODY
var body: some View {
HStack {
  if showBackButton {
    backButton
  }
  Spacer()
  titleSection
  Spacer()
  if showBackButton {
    backButton
      .opacity(0)
  }

} //: HSTACK
.padding()
.accentColor(.white)
.foregroundColor(.white)
.font(.headline)
.background(Color.blue.ignoresSafeArea(edges: .top))
}
}

// MARK: -  PREVIEW
struct CustomNavBarView_Previews: PreviewProvider {
static var previews: some View {
VStack {
  CustomNavBarView(showBackButton: true, title: "Title here", subtitle: "Subtitle goes here")
  Spacer()
}
}
}

extension CustomNavBarView {
private var backButton: some View {
Button {
  presentationMode.wrappedValue.dismiss()
} label: {
  Image(systemName: "chevron.left")
}
}

private var titleSection: some View {
VStack (spacing: 4) {
  Text(title)
    .font(.title)
    .fontWeight(.semibold)
  if let subtitle = subtitle {
    Text(subtitle)
  }

} //: VSTACK
}
}

```

```swift
// in CustomNavView
struct CustomNavView<Content:View>: View {
// MARK: -  PROPERTY
let content: Content

init(@ViewBuilder content: () -> Content) {
self.content = content()
}
// MARK: -  BODY
var body: some View {
NavigationView {
  CustomNavBarContainerView {
    content
  }
  .navigationBarHidden(true)
} //: NAVIGATION
.navigationViewStyle(.stack)
}
}

// MARK: -  PREVIEW
struct CustomNavView_Previews: PreviewProvider {
static var previews: some View {
CustomNavView {
  Color.red.ignoresSafeArea()
}
}
}

// enable drag back gesture in CustomNavBar
extension UINavigationController {
open override func viewDidLoad() {
  super.viewDidLoad()
  interactivePopGestureRecognizer?.delegate = nil
}
}

```

```swift
struct AppNavBarView: View {
// MARK: -  BODY
var body: some View {
CustomNavView {
ZStack {
Color.orange.ignoresSafeArea()

CustomNavLink(destination:
              Text("Destination")
              .customNavigationTile("Second Screen")
              .customNavigationSubtitle("Sibtitle should be showing!!")
) {
Text("Navigate")
}
} //: ZSTACK
.customNavBarItems(title: "New Title!", subtitle: nil, backButtonHidden: true)
}
}
}

// MARK: -  PREVIEW
struct AppNavBarView_Previews: PreviewProvider {
static var previews: some View {
AppNavBarView()
}
}

// MARK: -  EXTENSTION
extension AppNavBarView {
private var defaultNavView: some View {
NavigationView {
ZStack {
Color.green.ignoresSafeArea()

NavigationLink(destination: Text("Destination")
              .navigationTitle("Title 2")
              .navigationBarBackButtonHidden(false)) {
Text("Navigate")
}
}
.navigationTitle("Nav title here")
} //: NAVIGATION
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163092451-f8434a2e-a70b-46f4-abf9-e8d98277bd2f.gif">

## 11.UIViewRepresentable

UIViewRepresentable is the simple wrapper that we can use to take UIKit components and put them into SwiftUI. There are still a lot of components un UIKit that are not available or not as customizable in SwiftUI

Occasionally, you might want to take a UIKit component and then put it in your SwiftUI APP. If you do run into a situation we want to convert an object like how to get a UIKit object onto the screen and how to interact between the UIKit and SwiftUI objects

```swift
// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootCamp: View {
// MARK: -  PROPERTY
// MARK: -  BODY
var body: some View {
  VStack {
    Text("Hello")
    BasicUIViewRepresentable()
  } //: VSTACK
}
}

// MARK: -  PREVIEW
struct UIViewRepresentableBootCamp_Previews: PreviewProvider {
static var previews: some View {
  UIViewRepresentableBootCamp()
}
}

struct BasicUIViewRepresentable: UIViewRepresentable {

func makeUIView(context: Context) -> some UIView {
  let view = UIView()
  view.backgroundColor = .red
  return view
}

func updateUIView(_ uiView: UIViewType, context: Context) {

}
}
```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163110062-0c9d1a10-9a2b-4f10-862a-8a4f1c0bf23a.png">

```swift
import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootCamp: View {
// MARK: -  PROPERTY
@State private var text: String = ""
// MARK: -  BODY
var body: some View {
VStack {
Text(text)

HStack {
  Text("SwiftUI:")
  TextField("Type here..", text: $text)
    .frame(height: 55)
    .background(Color.gray.opacity(0.2))
}

HStack {
  Text("UIKit")
  UITextFieldViewRepresentable(text: $text)
    .updatePlaceholder("New Placeholder")
    .frame(height: 55)
    .background(Color.gray.opacity(0.2))
}

} //: VSTACK
}
}

// MARK: -  PREVIEW
struct UIViewRepresentableBootCamp_Previews: PreviewProvider {
static var previews: some View {
  UIViewRepresentableBootCamp()
}
}

struct UITextFieldViewRepresentable: UIViewRepresentable {

@Binding var text: String
var placeholder: String
let placeholderColor: UIColor

init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
  self._text = text
  self.placeholder = placeholder
  self.placeholderColor = placeholderColor
}

func makeUIView(context: Context) -> UITextField {
  let textfield = getTextField()
  textfield.delegate = context.coordinator
  return textfield
}

// send data from SwiftUI to UIKit
func updateUIView(_ uiView: UITextField, context: Context) {
  uiView.text = text
}

private func getTextField() -> UITextField {
  let textfield = UITextField(frame: .zero)
  let placeholder = NSAttributedString(
    string: placeholder,
    attributes: [
      .foregroundColor : placeholderColor
    ])
  textfield.attributedPlaceholder = placeholder
  // textfield.delegate
  return textfield
}

func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
  var viewRepresentable = self
  viewRepresentable.placeholder = text
  return viewRepresentable
}

// Send data from UIKit to SwiftUI
func makeCoordinator() ->Coordinator {
  return Coordinator(text: $text)
}

class Coordinator: NSObject, UITextFieldDelegate {

  @Binding var text: String

  init(text: Binding<String>) {
    self._text = text
  }
  func textFieldDidChangeSelection(_ textField: UITextField) {
    text = textField.text ?? ""
  }
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163114998-e1cb8466-7368-4a47-9d58-4e750b8d421b.gif">

## 12.UIViewControllerRepresentable

UIViewRepresentable used to take a view in UIKit convert it into SwiftUI. The only difference between UIViewRepresentable and UIViewControllerRepresentable to control entire controller. Controller essentially a screen and UIKit instead of just a sub view

```swift
struct UIViewControllerRepresentableBootCamp: View {
// MARK: -  PROPERTY
@State private var showScreen: Bool = false
// MARK: -  BODY
var body: some View {
VStack {
  Text("Hi")

  Button {
    showScreen.toggle()
  } label: {
    Text("Click Here")
  }
  .sheet(isPresented: $showScreen) {
    BasicUIViewControllerRepresentalbe(lableText: "New Screen!!")
  }
}
}
}

// MARK: -  PREVIEW
struct UIViewControllerRepresentableBootCamp_Previews: PreviewProvider {
static var previews: some View {
  UIViewControllerRepresentableBootCamp()
}
}

// MARK: -  UIViewControllerRepresentable
struct BasicUIViewControllerRepresentalbe: UIViewControllerRepresentable {

let lableText: String

func makeUIViewController(context: Context) -> some UIViewController {
  let vc = MyFirstViewController()
  vc.lableText = lableText
  return vc
}

func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

}
}

class MyFirstViewController: UIViewController {

var lableText: String = "Starting value"
override func viewDidLoad() {
  super.viewDidLoad()

  view.backgroundColor = .blue

  let label = UILabel()
  label.text = lableText
  label.textColor = UIColor.white

  view.addSubview(label)
  label.frame = view.frame
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163118011-4a47b3ee-eaf1-4ad8-8f09-19e35bde5054.gif">

### Example of UIImagePickerController move to SwiftUI

```swift
struct UIViewControllerRepresentableBootCamp: View {
// MARK: -  PROPERTY
@State private var showScreen: Bool = false
@State private var image: UIImage? = nil
// MARK: -  BODY
var body: some View {
VStack {
Text("Hi")

if let image = image {
  Image(uiImage: image)
    .resizable()
    .scaledToFit()
    .frame(width: 200, height: 200)
}

Button {
  showScreen.toggle()
} label: {
  Text("Click Here")
}
.sheet(isPresented: $showScreen) {
  UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
}
}
}
}

// MARK: -  PREVIEW
struct UIViewControllerRepresentableBootCamp_Previews: PreviewProvider {
static var previews: some View {
  UIViewControllerRepresentableBootCamp()
}
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
@Binding var image: UIImage?
@Binding var showScreen: Bool

func makeUIViewController(context: Context) -> UIImagePickerController {
  let vc = UIImagePickerController()
  vc.allowsEditing = false
  vc.delegate = context.coordinator
  return vc
}

// from SwiftUI to UIKit
func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

}

// from UIKit to SwiftUI
func makeCoordinator() -> Coordinator {
return Coordinator(image: $image, showScreen: $showScreen)
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
@Binding var image: UIImage?
@Binding var showScreen: Bool

init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
  self._image = image
  self._showScreen = showScreen
}
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  guard let newImage = info[.originalImage] as? UIImage else { return }
  image = newImage
  showScreen = false
}
}
}

```

  <img height="300"  alt="스크린샷" src="https://user-images.githubusercontent.com/28912774/163120560-59cbab78-abcd-4d58-8c29-a29a4d84eddb.gif">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

  <img height="300"  alt="스크린샷" src="">

```swift

```

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

```swift

```

  <img height="350"  alt="스크린샷" src="">

```swift

```

  <img height="350"  alt="스크린샷" src="">

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
