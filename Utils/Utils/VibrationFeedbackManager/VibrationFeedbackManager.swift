//
//  VibrationFeedbackManager.swift
//  Utils
//
//  Created by Pavel Marinchenko on 9/10/18.
//  Copyright © 2018 Surf. All rights reserved.
//

import AudioToolbox

/**
 *
 * Util for managing user feedback actions.
 *
 * Util has some methods for playing vibrations. You can play feedback by event type.
 * While you call feedback action the class autodetects user device type and plays correct vibrations.
 *
 * By default apple mobile devices has a few different vibration feedback systems.
 * - Default vibrations available for all apple devices.
 * - Taptic Engine 1.0 available for iPhone 6s and above.
 * - Haptic Feedback (or taptic engine 2.0) available for iPhone 7 and above.
 *
 */
public final class VibrationFeedbackManager {

    // MARK: - Constants

    private struct SoundID {
      static let peek = 1519
      static let pop = 1520
      static let cancelled = 1521
      static let tryagain = 1102
      static let failed = 1107
    }

    // MARK: - Enums

    public enum VibrationFeedbackEventType {
        case tap
        case error
        case cancelled
    }

    /// supports by anything devices
    fileprivate enum DefaultVibrationType {
        case standard
        case alert
    }

    /// supports by iphone 6s and above (taptic engine)
    fileprivate enum TapticEngineVibrationType {
        case peek
        case pop
        case cancelled
        case tryagain
        case failed
    }

    /// supports by iphone 7/7s and above (haptic feedback)
    fileprivate enum HapticFeedbackVibrationType {
        case success
        case warning
        case error

        case light
        case medium
        case heavy

        case selection
    }

    // MARK: - Internal Methods

    public static func playVibrationFeedbackBy(event: VibrationFeedbackEventType) {
        switch event {
        case .tap:
            if UIDevice.current.hasHapticFeedback {
                playHapticFeedbackBy(type: .medium)
            } else if UIDevice.current.hasTapticEngine {
                playTapticFeedbackBy(type: .peek)
            }
        case .error:
            if UIDevice.current.hasHapticFeedback {
                playHapticFeedbackBy(type: .error)
            } else if UIDevice.current.hasTapticEngine {
                playTapticFeedbackBy(type: .cancelled)
            } else {
                playDefaultFeedbackBy(type: .standard)
            }
        case .cancelled:
            if UIDevice.current.hasHapticFeedback {
                playHapticFeedbackBy(type: .warning)
            } else if UIDevice.current.hasTapticEngine {
                playTapticFeedbackBy(type: .cancelled)
            }
        }
    }

}

// MARK: - Private methods

private extension VibrationFeedbackManager {
    static func playDefaultFeedbackBy(type: DefaultVibrationType) {
        switch type {
        case .standard:
            let standard = SystemSoundID(kSystemSoundID_Vibrate)
            AudioServicesPlaySystemSound(standard)
        case .alert:
            let alert = SystemSoundID(1011)
            AudioServicesPlaySystemSound(alert)
        }
    }

    static func playTapticFeedbackBy(type: TapticEngineVibrationType) {
        switch type {
        case .peek:
            let peek = SystemSoundID(SoundID.peek)
            AudioServicesPlaySystemSound(peek)
        case .pop:
            let pop = SystemSoundID(SoundID.pop)
            AudioServicesPlaySystemSound(pop)
        case .cancelled:
            let cancelled = SystemSoundID(SoundID.cancelled)
            AudioServicesPlaySystemSound(cancelled)
        case .tryagain:
            let tryagain = SystemSoundID(SoundID.tryagain)
            AudioServicesPlaySystemSound(tryagain)
        case .failed:
            let failed = SystemSoundID(SoundID.failed)
            AudioServicesPlaySystemSound(failed)
        }
    }

    static func playHapticFeedbackBy(type: HapticFeedbackVibrationType) {
        switch type {
        case .success:
            let hapticNotification = UINotificationFeedbackGenerator()
            hapticNotification.prepare()
            hapticNotification.notificationOccurred(.success)
        case .warning:
            let hapticNotification = UINotificationFeedbackGenerator()
            hapticNotification.prepare()
            hapticNotification.notificationOccurred(.warning)
        case .error:
            let hapticNotification = UINotificationFeedbackGenerator()
            hapticNotification.prepare()
            hapticNotification.notificationOccurred(.error)

        case .light:
            let hapticLightFeedback = UIImpactFeedbackGenerator(style: .light)
            hapticLightFeedback.prepare()
            hapticLightFeedback.impactOccurred()
        case .medium:
            let hapticLightFeedback = UIImpactFeedbackGenerator(style: .medium)
            hapticLightFeedback.prepare()
            hapticLightFeedback.impactOccurred()
        case .heavy:
            let hapticLightFeedback = UIImpactFeedbackGenerator(style: .heavy)
            hapticLightFeedback.prepare()
            hapticLightFeedback.impactOccurred()

        case .selection:
            let selectionFeedback = UISelectionFeedbackGenerator()
            selectionFeedback.prepare()
            selectionFeedback.selectionChanged()
        }
    }
}
