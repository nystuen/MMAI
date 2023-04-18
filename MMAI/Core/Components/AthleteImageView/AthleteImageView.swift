import SwiftUI

struct AthleteImageView: View {
    let athlete: Athlete?
    let athleteType: AthleteType?
    
    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .theme.background, location: 0.5),
            .init(color: .clear, location: 0.98)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack(spacing: 8) {
            if let athleteType = athleteType {
                Text("\(athleteType == .red ? "Red" : "Blue") athlete")
                    .foregroundColor(athleteType == .red ? .theme.red : .theme.blue)
            }
            ZStack(alignment: .bottom) {
                if let image = athlete?.image, let url = URL(string: image) {
                    CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            defaultImage
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                //.offset(y: 30)
                                .mask(gradient)
                        default:
                            defaultImage
                        }
                    }
                } else {
                    defaultImage
                }
                
                if let name = athlete?.name {
                    Text(name)
                        .padding(.bottom, 20)
                        .shadow(color: .black.opacity(0.8), radius: 10)
                        .foregroundColor(.theme.text)
                        .opacity(athlete == nil ? 0.8 : 1)
                }
            }
        }
    }
}

struct AthleteImageView_Previews: PreviewProvider {
    static var previews: some View {
        dev.athleteImage
    }
}

extension AthleteImageView {
    var defaultImage: some View {
        Image("mmai_athlete")
            .resizable()
            .scaledToFit()
            .offset(y: 30)
            .mask(gradient)
    }
}
