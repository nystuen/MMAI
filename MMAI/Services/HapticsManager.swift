import SwiftUI

class HapticsManager {
  static func vibrate(withIntensity intensity: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: intensity)
    generator.impactOccurred()
  }
  
  static func vibrate(withIntensity intensity: CGFloat = 0.5) {
    let generator = UIImpactFeedbackGenerator()
    generator.impactOccurred(intensity: intensity)
  }
  
  static func vibrate(withFeedback feedback: UINotificationFeedbackGenerator.FeedbackType = .warning) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(feedback)
  }
}
