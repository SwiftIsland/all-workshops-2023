import SwiftUI

struct SprungRedCube: View {
    @State var animate : Bool = false
    
    var body: some View {
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .frame(width: 40, height: 40)
                    .padding()
                    .offset(x: animate ? 270 : 20)
                Spacer()
            }
        }
        .padding()
        .onAppear(perform: {
            withAnimation(.bouncy(duration: 0.55, extraBounce: 0.2).repeatForever(autoreverses: true)) {
                animate = true
            }
        })
    }
}
#Preview {
    SprungRedCube()
}
