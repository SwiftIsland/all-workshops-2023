import SwiftUI

private let outlineGradient = LinearGradient(colors: [.white, .clear, .white, .clear, .white], startPoint: .topLeading, endPoint: .bottomTrailing)

private enum PlayState: CaseIterable {
    case unselected, loading, playing
    
    var blur: Double {
        switch self {
        case .unselected : 0
        case .loading : 10
        case .playing : 0
        }
    }
    
    var offsetY: Double {
        switch self {
        case .unselected : 0
        case .loading : 0
        case .playing : 500
        }
    }
    
    var scale: Double {
        switch self {
        case .unselected : 1
        case .loading : 1
        case .playing : 0
        }
    }
    
    var offsetYImage: Double {
        switch self {
        case .unselected : 0
        case .loading : -200
        case .playing : 0
        }
    }
    
    var opacityImage: Double {
        switch self {
        case .unselected : 1
        case .loading : 0
        case .playing : 1
        }
    }
    
    var scaleImage: Double {
        switch self {
        case .unselected : 1
        case .loading : 0
        case .playing : 1
        }
    }
}

private struct PlayButton: View {
    @Binding var isSelected: Bool
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
                .frame(width: 80)
                .opacity(0.6)
                .blendMode(.overlay)
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 80)
                .opacity(0.5)
            Circle()
                .stroke(lineWidth: 1.0)
                .fill(outlineGradient)
                .frame(width: 80)
                .opacity(0.5)
            
            Image(systemName: isSelected ? "pause.fill" : "play.fill")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.white)
                .blendMode(.overlay)
        }
    }
}

private struct SoundCardView : View {
    
    var imageName : String
    var title : String
    
    let width : CGFloat = 320
    let height : CGFloat = 280
    
    @State var isSelected : Bool = false
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .overlay(
                    Rectangle()
                        .fill(LinearGradient(colors: [.black, .clear, .clear, .clear], startPoint: .bottom, endPoint: .top))
                        .opacity(0.4)
                )
            
                .overlay(
                    VStack() {
                        Spacer()
                        HStack() {
                            Text(title)
                                .font(.title)
                                .bold()
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                )
                .overlay(
                    PlayButton(isSelected: $isSelected)
                )
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2.0)
                .fill(outlineGradient)
                .frame(width: width, height: height)
                .blendMode(.overlay)
            
        }
        .frame(width: width, height: height)
        .mask(
            RoundedRectangle(cornerRadius: 16)
                .fill()
                .frame(width: width, height: height)
        )
        .shadow(radius: 6)
        .onTapGesture {
            isSelected = true
        }
        .phaseAnimator(PlayState.allCases, trigger: isSelected) { content, phase in
            content
                .scaleEffect(phase.scale)
                .blur(radius: phase.blur)
                .offset(y: phase.offsetY)
        }
    }
}

private struct AnimatedSoundCarouselView: View {
    let Rows = [
        GridItem(.flexible()),
    ]
    
    let images = ["1", "2", "3", "4", "5", "6", "7"]
    let moods = ["Ethereal", "Jazz", "Adventure", "Social", "Energy", "Peace", "Escape"]
    
    @State private var selectedMood : Int?
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                HStack {
                    Text("Moods")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.bottom, -16)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: Rows, content: {
                        ForEach(0...images.count-1, id:\.self) { index in
                            SoundCardView(imageName: images[index], title: moods[index], isSelected: selectedMood == index)
                                .padding()
                                .padding(.leading, index == 0 ? 0 : -12)
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded({ _ in
                                            selectedMood = index
                                        })
                                )
                        }
                    })
                }
                .scrollIndicators(.hidden)
                .scrollClipDisabled()
                .frame(height: 340)
                Spacer()
                Spacer()
                // Now Playing Bar
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill()
                        .frame(width: 340, height: 60)
                    
                    Image(images[selectedMood ?? 00])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 340, height: 60)
                        .opacity(0.8)
                        .mask(
                            RoundedRectangle(cornerRadius: 12)
                                .fill()
                                .frame(width: 340, height: 60)
                        )
                        .mask(
                            LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
                        )
                    
                        .phaseAnimator(PlayState.allCases, trigger: selectedMood) { content, phase in
                            content
                                .scaleEffect(phase.scaleImage)
                                .blur(radius: phase.blur)
                                .offset(y: phase.offsetYImage)
                                .opacity(phase.opacityImage)
                        }
                    
                    HStack() {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14)
                            .foregroundColor(.white)
                        Spacer()
                        Text(moods[selectedMood ?? 0])
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .padding()
                    
                }
                .opacity((selectedMood != nil) ? 1 : 0)
                .offset(y: (selectedMood != nil) ? 0 : 300)
                .animation(.easeInOut(duration: 0.3).delay(0.4), value: selectedMood)
                .clipped()
                .padding()
                .padding(.bottom, 12)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    AnimatedSoundCarouselView()
}
