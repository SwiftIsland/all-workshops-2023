import SwiftUI

private let outlineGradient = LinearGradient(colors: [.white, .clear, .white, .clear, .white], startPoint: .topLeading, endPoint: .bottomTrailing)


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
    }
}

private enum PlayState {
    case NothingSelected
    case Loading
    case Playing
}

private struct PlainSoundCarouselView: View {
    let Rows = [
          GridItem(.flexible()),
      ]
    
    let images = ["1", "2", "3", "4", "5", "6", "7"]
    let moods = ["Ethereal", "Jazz", "Adventure", "Social", "Energy", "Peace", "Escape"]
    
    @State private var selectedMood = 1
    
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
                            SoundCardView(imageName: images[index], title: moods[index])
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
                .frame(height: 340)
                //            .background(.red)
                Spacer()
                Spacer()
               
                
                // Now Playing Bar
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill()
                        .frame(width: 340, height: 60)
                    
                    Image(images[selectedMood])
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
                    
                    HStack() {
                        Image(systemName: "pause.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14)
                            .foregroundColor(.white)
                        Spacer()
                        Text(moods[selectedMood])
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .padding()
                    
                }
                .padding()
                .padding(.bottom, 12)
                
                
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    PlainSoundCarouselView()
}
