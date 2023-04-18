import SwiftUI


struct AthleteImagePreview: View {
    let imageUrl: String
    let athleteType: AthleteType
    let isSearchView: Bool
    @State private var animate = false
    
    var body: some View {
        ZStack {
            cornerColor
            GeometryReader { geo in
                ZStack {
                    if !athleteHasImage(imageUrl) {
                        athleteDefaultImage
                    } else {
                        CachedAsyncImage(url: URL(string: imageUrl), urlCache: .imageCache, transaction: Transaction(animation: .easeIn)) { phase in
                            switch phase {
                            case .empty:
                                athleteDefaultImage
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            default:
                                athleteDefaultImage
                            }
                        }
                    }
                }
                .frame(width: geo.size.width * 0.9)
                .frame(width: geo.size.width, height: geo.size.height)
                .offset(y: geo.size.height / 7.5)
            }
        }
        .clipShape(Circle())
        .shadow(color: .black.opacity(0.05), radius: 20)
    }
}

struct AthleteImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            dev.athleteImageView
        }
    }
}

extension AthleteImagePreview {
    private var cornerColor: some View {
        (athleteType == .red ? Color.theme.red : Color.theme.blue)
            .opacity(0.02)
    }
    
    private func athleteHasImage(_ url: String) -> Bool {
        !url.contains("imgur")
    }
    
    private var athleteDefaultImage: some View {
        Image("mmai_athlete")
            .resizable()
            .scaledToFit()
    }
}
