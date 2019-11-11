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
 * - Haptic Feedback (taptic engine 2.0) available for iPhone 7 and above.
 *
 */
public final class VibrationFeedbackManager {

    // MARK: - Constants

    // ids -> http://iphonedevwiki.net/index.php/AudioServices
    private struct SoundID {
        static let peek = 1519
        static let pop = 1520
        static let cancelled = 1521
        static let tryagain = 1102
        static let failed = 1107

        static let standard = kSystemSoundID_Vibrate
        static let alert = 1011
    }

    // MARK: - Enums

    public enum Event {
        case tap
        case error
        case cancelled
    }

    /// supports by anything devices
    public enum DefaultVibrationType {
        case standard
        case alert

        /// returns relevant instance of sound id
        var systemSound: SystemSoundID {
            switch self {
            case .standard: return SystemSoundID(SoundID.standard)
            case .alert: return SystemSoundID(SoundID.alert)
            }
        }
    }

    /// supports by iphone 6s and above (taptic engine)
    public enum TapticEngineVibrationType {
        case peek
        case pop
        case cancelled
        case tryagain
        case failed

        /// returns relevant instance of sound id
        var systemSound: SystemSoundID {
            switch self {
            case .peek: return SystemSoundID(SoundID.peek)
            case .pop: return SystemSoundID(SoundID.pop)
            case .cancelled: return SystemSoundID(SoundID.cancelled)
            case .tryagain: return SystemSoundID(SoundID.tryagain)
            case .failed: return SystemSoundID(SoundID.failed)
            }
        }
    }

    /// supports by iphone 7/7s and above (haptic feedback)
    public enum HapticFeedbackVibrationType {
        case success
        case warning
        case error

        case light
        case medium
        case heavy

        case selection
    }

    // MARK: - Internal Methods

    public static func playVibrationFeedbackBy(event: Event) {
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

    public static func playVibrationFeedback(default: DefaultVibrationType,
                                             taptic: TapticEngineVibrationType,
                                             haptic: HapticFeedbackVibrationType) {
        if UIDevice.current.hasHapticFeedback {
            playHapticFeedbackBy(type: haptic)
        } else if UIDevice.current.hasTapticEngine {
            playTapticFeedbackBy(type: taptic)
        } else {
            playDefaultFeedbackBy(type: `default`)
        }
    }

    public static func playDefaultFeedbackBy(type: DefaultVibrationType) {
        AudioServicesPlaySystemSound(type.systemSound)
    }

    public static func playTapticFeedbackBy(type: TapticEngineVibrationType) {
        AudioServicesPlaySystemSound(type.systemSound)
    }

    public static func playHapticFeedbackBy(type: HapticFeedbackVibrationType) {
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
