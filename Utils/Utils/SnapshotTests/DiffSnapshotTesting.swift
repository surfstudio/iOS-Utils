//
//  DiffSnapshotTesting.swift
//  SnapshotTests
//

import XCTest
import SnapshotTesting

//swiftlint:disable all
/// **ВАЖНО** Копипаст из либы с целью добавить возможность сохранения диффа в файловую систему
public enum DiffSnapshotTesting {
    /// Asserts that a given value matches a reference on disk.
    ///
    /// - Parameters:
    ///   - value: A value to compare against a reference.
    ///   - snapshotting: A strategy for serializing, deserializing, and comparing values.
    ///   - name: An optional description of the snapshot.
    ///   - recording: Whether or not to record a new reference.
    ///   - timeout: The amount of time a snapshot must be generated in.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - testName: The name of the test in which failure occurred. Defaults to the function name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    static func assertSnapshot<Value, Format>(
      matching value: @autoclosure () throws -> Value,
      as snapshotting: Snapshotting<Value, Format>,
      named name: String? = nil,
      record recording: Bool = false,
      timeout: TimeInterval = 5,
      file: StaticString = #file,
      testName: String = #function,
      line: UInt = #line
      ) {

      let failure = verifySnapshot(
        matching: try value(),
        as: snapshotting,
        named: name,
        record: recording,
        timeout: timeout,
        file: file,
        testName: testName,
        line: line
      )
      guard let message = failure else { return }
      XCTFail(message, file: file, line: line)
    }

    /// Asserts that a given value matches references on disk.
    ///
    /// - Parameters:
    ///   - value: A value to compare against a reference.
    ///   - snapshotting: A dictionary of names and strategies for serializing, deserializing, and comparing values.
    ///   - recording: Whether or not to record a new reference.
    ///   - timeout: The amount of time a snapshot must be generated in.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - testName: The name of the test in which failure occurred. Defaults to the function name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    static func assertSnapshots<Value, Format>(
      matching value: @autoclosure () throws -> Value,
      as strategies: [String: Snapshotting<Value, Format>],
      record recording: Bool = false,
      timeout: TimeInterval = 5,
      file: StaticString = #file,
      testName: String = #function,
      line: UInt = #line
      ) {

      try? strategies.forEach { name, strategy in
        assertSnapshot(
          matching: try value(),
          as: strategy,
          named: name,
          record: recording,
          timeout: timeout,
          file: file,
          testName: testName,
          line: line
        )
      }
    }

    /// Asserts that a given value matches references on disk.
    ///
    /// - Parameters:
    ///   - value: A value to compare against a reference.
    ///   - snapshotting: An array of strategies for serializing, deserializing, and comparing values.
    ///   - recording: Whether or not to record a new reference.
    ///   - timeout: The amount of time a snapshot must be generated in.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - testName: The name of the test in which failure occurred. Defaults to the function name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    static func assertSnapshots<Value, Format>(
      matching value: @autoclosure () throws -> Value,
      as strategies: [Snapshotting<Value, Format>],
      record recording: Bool = false,
      timeout: TimeInterval = 5,
      file: StaticString = #file,
      testName: String = #function,
      line: UInt = #line
      ) {

      try? strategies.forEach { strategy in
        assertSnapshot(
          matching: try value(),
          as: strategy,
          record: recording,
          timeout: timeout,
          file: file,
          testName: testName,
          line: line
        )
      }
    }

    /// Verifies that a given value matches a reference on disk.
    ///
    /// Third party snapshot assert helpers can be built on top of this function. Simply invoke `verifySnapshot` with your own arguments, and then invoke `XCTFail` with the string returned if it is non-`nil`. For example, if you want the snapshot directory to be determined by an environment variable, you can create your own assert helper like so:
    ///
    ///     public func myAssertSnapshot<Value, Format>(
    ///       matching value: @autoclosure () throws -> Value,
    ///       as snapshotting: Snapshotting<Value, Format>,
    ///       named name: String? = nil,
    ///       record recording: Bool = false,
    ///       timeout: TimeInterval = 5,
    ///       file: StaticString = #file,
    ///       testName: String = #function,
    ///       line: UInt = #line
    ///       ) {
    ///
    ///         let snapshotDirectory = ProcessInfo.processInfo.environment["SNAPSHOT_REFERENCE_DIR"]! + "/" + #file
    ///         let failure = verifySnapshot(
    ///           matching: value,
    ///           as: snapshotting,
    ///           named: name,
    ///           record: recording,
    ///           snapshotDirectory: snapshotDirectory,
    ///           timeout: timeout,
    ///           file: file,
    ///           testName: testName
    ///         )
    ///         guard let message = failure else { return }
    ///         XCTFail(message, file: file, line: line)
    ///     }
    ///
    /// - Parameters:
    ///   - value: A value to compare against a reference.
    ///   - snapshotting: A strategy for serializing, deserializing, and comparing values.
    ///   - name: An optional description of the snapshot.
    ///   - recording: Whether or not to record a new reference.
    ///   - snapshotDirectory: Optional directory to save snapshots. By default snapshots will be saved in a directory with the same name as the test file, and that directory will sit inside a directory `__Snapshots__` that sits next to your test file.
    ///   - timeout: The amount of time a snapshot must be generated in.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - testName: The name of the test in which failure occurred. Defaults to the function name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    /// - Returns: A failure message or, if the value matches, nil.
    static func verifySnapshot<Value, Format>(
      matching value: @autoclosure () throws -> Value,
      as snapshotting: Snapshotting<Value, Format>,
      named name: String? = nil,
      record recording: Bool = false,
      snapshotDirectory: String? = nil,
      timeout: TimeInterval = 5,
      file: StaticString = #file,
      testName: String = #function,
      line: UInt = #line
      )
      -> String? {

        let recording = recording || isRecording

        do {
          let fileUrl = URL(fileURLWithPath: "\(file)", isDirectory: false)
          let fileName = fileUrl.deletingPathExtension().lastPathComponent

          let snapshotDirectoryUrl = snapshotDirectory.map { URL(fileURLWithPath: $0, isDirectory: true) }
            ?? fileUrl
              .deletingLastPathComponent()
              .appendingPathComponent("__Snapshots__")
              .appendingPathComponent(fileName)

          let identifier: String
          if let name = name {
            identifier = sanitizePathComponent(name)
          } else {
            let counter = counterQueue.sync { () -> Int in
              let key = snapshotDirectoryUrl.appendingPathComponent(testName)
              counterMap[key, default: 0] += 1
              return counterMap[key]!
            }
            identifier = String(counter)
          }

          let testName = sanitizePathComponent(testName)
          let snapshotFileUrl = snapshotDirectoryUrl
            .appendingPathComponent("\(testName).\(identifier)")
            .appendingPathExtension(snapshotting.pathExtension ?? "")
          let fileManager = FileManager.default
          try fileManager.createDirectory(at: snapshotDirectoryUrl, withIntermediateDirectories: true)

          let tookSnapshot = XCTestExpectation(description: "Took snapshot")
          var optionalDiffable: Format?
          snapshotting.snapshot(try value()).run { b in
            optionalDiffable = b
            tookSnapshot.fulfill()
          }
          let result = XCTWaiter.wait(for: [tookSnapshot], timeout: timeout)
          switch result {
          case .completed:
            break
          case .timedOut:
            return """
              Exceeded timeout of \(timeout) seconds waiting for snapshot.

              This can happen when an asynchronously rendered view (like a web view) has not loaded. \
              Ensure that every subview of the view hierarchy has loaded to avoid timeouts, or, if a \
              timeout is unavoidable, consider setting the "timeout" parameter of "assertSnapshot" to \
              a higher value.
              """
          case .incorrectOrder, .invertedFulfillment, .interrupted:
            return "Couldn't snapshot value"
          @unknown default:
            return "Couldn't snapshot value"
          }

          guard var diffable = optionalDiffable else {
            return "Couldn't snapshot value"
          }

          guard !recording, fileManager.fileExists(atPath: snapshotFileUrl.path) else {
            try snapshotting.diffing.toData(diffable).write(to: snapshotFileUrl)
            return recording
              ? """
                Record mode is on. Turn record mode off and re-run "\(testName)" to test against the newly-recorded snapshot.

                open "\(snapshotFileUrl.path)"

                Recorded snapshot: …
                """
              : """
                No reference was found on disk. Automatically recorded snapshot: …

                open "\(snapshotFileUrl.path)"

                Re-run "\(testName)" to test against the newly-recorded snapshot.
                """
          }

          let data = try Data(contentsOf: snapshotFileUrl)
          let reference = snapshotting.diffing.fromData(data)

          #if os(iOS) || os(tvOS)
          // If the image generation fails for the diffable part use the reference
          if let localDiff = diffable as? UIImage, localDiff.size == .zero {
            diffable = reference
          }
          #endif

          guard let (failure, attachs) = snapshotting.diffing.diff(reference, diffable) else {
            return nil
          }

          var attachments = attachs

          let artifactsUrl = URL(
            fileURLWithPath: ProcessInfo.processInfo.environment["SNAPSHOT_ARTIFACTS"] ?? NSTemporaryDirectory(), isDirectory: true
          )
          let artifactsSubUrl = artifactsUrl.appendingPathComponent(fileName)
          try fileManager.createDirectory(at: artifactsSubUrl, withIntermediateDirectories: true)
          let failedSnapshotFileUrl = artifactsSubUrl.appendingPathComponent(snapshotFileUrl.lastPathComponent)

            if let refImage = reference as? UIImage, let artifactImage = diffable as? UIImage {
                let difference = diff(refImage, artifactImage)
                let finalImage = glue(ref: refImage, art: artifactImage, diff: difference)
                try finalImage.pngData()?.write(to: failedSnapshotFileUrl)
                let attachment = XCTAttachment(image: finalImage)
                attachment.name = "reference+failure+difference"
                attachments.append(attachment)
            } else {
                try snapshotting.diffing.toData(diffable).write(to: failedSnapshotFileUrl)
            }

          if !attachments.isEmpty {
            #if !os(Linux)
            if ProcessInfo.processInfo.environment.keys.contains("__XCODE_BUILT_PRODUCTS_DIR_PATHS") {
              XCTContext.runActivity(named: "Attached Failure Diff") { activity in
                attachments.forEach {
                  activity.add($0)
                }
              }
            }
            #endif
          }

          let diffMessage = diffTool
            .map { "\($0) \"\(snapshotFileUrl.path)\" \"\(failedSnapshotFileUrl.path)\"" }
            ?? "@\(minus)\n\"\(snapshotFileUrl.path)\"\n@\(plus)\n\"\(failedSnapshotFileUrl.path)\""
          return """
          Snapshot does not match reference.

          \(diffMessage)

          \(failure.trimmingCharacters(in: .whitespacesAndNewlines))
          """
        } catch {
          return error.localizedDescription
        }
    }

    // MARK: - Private

    private static let minus = "−"
    private static let plus = "+"
    private static let counterQueue = DispatchQueue(label: "co.pointfree.SnapshotTesting.counter")
    private static var counterMap: [URL: Int] = [:]

    private static func sanitizePathComponent(_ string: String) -> String {
      return string
        .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
        .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
    }

    private static func diff(_ old: UIImage, _ new: UIImage) -> UIImage {
      let width = max(old.size.width, new.size.width)
      let height = max(old.size.height, new.size.height)
      UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 0)
      new.draw(at: .zero)
      old.draw(at: .zero, blendMode: .difference, alpha: 1)
      let differenceImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      return differenceImage
    }

    private static func glue(ref: UIImage, art: UIImage, diff: UIImage) -> UIImage {
        let width = ref.size.width + art.size.width + diff.size.width
        let height = max(ref.size.height, art.size.height, diff.size.height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), true, 0)
        ref.draw(at: .zero)
        art.draw(at: .init(x: ref.size.width, y: .zero))
        diff.draw(at: .init(x: ref.size.width + art.size.width, y: .zero))
        let differenceImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return differenceImage
    }
}
//swiftlint:enable all
