import SwiftUI

private let outlineGradient = LinearGradient(colors: [.white, .clear, .white, .clear, .white], startPoint: .topLeading, endPoint: .bottomTrailing)

private let brandPurple = Color(red: 0.73, green: 0.65, blue: 0.9)

private struct PlainNotificationView: View {
    
    @State private var showNotification = false
    
    var body: some View {
        
        ZStack {
            Button("Press Me") {
                showNotification = true
            }
            
            Rectangle()
                .fill()
                .opacity(showNotification ? 0.6 : 0)
            
            if (showNotification) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 36)
                        .fill(.ultraThinMaterial)
                        .frame(width: 320, height: 380)
                        .overlay(
                            LinearGradient(colors: [brandPurple, .clear], startPoint: .center, endPoint: .bottomTrailing).opacity(0.25)
                        )
                        .overlay (
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(lineWidth: 2.0)
                                .fill(outlineGradient)
                                .frame(width: 320, height: 380)
                        )
                    
                    VStack {
                        Text("New Mood")
                            .font(.title)
                            .bold()
                            .padding(.top, 32)
                        Text("Brand new sound.")
                            .font(.body)
                            .padding(.leading, 16)
                            .padding(.trailing, 16)
                        Spacer()
                        Image("newmusic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 220, height: 160)
                            .mask(
                                RoundedRectangle(cornerRadius: 14)
                                    .frame(width: 220, height: 160)
                            )
                        Spacer()
                        Button(action: {
                            showNotification = false
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .frame(width: 220, height: 44)
                                    .offset(y: 4)
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(brandPurple)
                                    .frame(width: 220, height: 44)
                                Text("Listen Now")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.black)
                            }
                        }).padding().padding(.bottom, 24)
                    }
                }
                .frame(width: 320, height: 380)
                .mask(RoundedRectangle(cornerRadius: 36)
                    .fill(.ultraThinMaterial)
                    .frame(width: 320, height: 380)
                )
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    PlainNotificationView()
}
