import SwiftUI

struct PlainRedCube: View {
    
    @State var animate : Bool = false
    
    var body: some View {
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .frame(width: 40, height: 40)
                    .padding()
                    .offset(x: animate ? 290 : 0)
                Spacer()
            }
        }
        .padding()
        .onAppear(perform: {
            withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: true)) {
                animate = true
            }
        })
    }
}

#Preview {
    PlainRedCube()
}
