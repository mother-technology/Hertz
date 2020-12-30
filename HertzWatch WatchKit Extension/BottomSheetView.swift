import SwiftUI

private enum Constants {
    static let radius: CGFloat = 35
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    @GestureState private var translation: CGFloat = 0
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        _isOpen = isOpen
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: Constants.radius)
                    .fill(Color.secondary)
                    .frame(
                        width: Constants.indicatorWidth,
                        height: Constants.indicatorHeight
                    ).onTapGesture {
                        isOpen.toggle()
                    }
                    .padding()
                    .opacity(isOpen ? 1 : Double(100 - max(offset + translation, 0)) / 100.0)

                content
                    .opacity(isOpen ? 1 : Double(100 - max(offset + translation, 0)) / 100.0)
            }
            .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
            .background(
                Color.black
                    .clipShape(RoundedRectangle(cornerRadius: 35), style: FillStyle(antialiased: true))
                    .ignoresSafeArea(edges: .bottom)
            )
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(offset + translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        state = value.translation.height
                    }.onEnded { value in
                        let snapDistance = maxHeight * Constants.snapRatio
                        guard abs(value.translation.height) > snapDistance else {
                            return
                        }
                        isOpen = value.translation.height < 0
                    }
            )
        }
    }
}
