import SwiftUI

struct YourRedCube: View {
    
    @State var animate : Bool = false
    
    var body: some View {
        VStack {
            HStack() {
                Rectangle()
                    .fill(.red)
                    .frame(width: 40, height: 40)
                    .padding()
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    PlainRedCube()
}
