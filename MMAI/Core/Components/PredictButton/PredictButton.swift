import SwiftUI

struct ProgressButton: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        Button(action: {
            self.isLoading = true
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .animation(.easeInOut(duration: 0.5), value: isLoading)

            } else {
                Text("Predict")
                    .foregroundColor(.theme.background)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 12)
                    .background(Color.theme.red)
                    .cornerRadius(16)
                    .font(.headline)
                    .animation(.easeInOut(duration: 0.5), value: isLoading)
            }
        }
    }
}
