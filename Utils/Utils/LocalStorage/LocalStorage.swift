//
//  LocalStorage.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 21/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

/// Local storage based on filemanager uses cache directory
final public class LocalStorage {

    // MARK: - Enums

    public enum Error: Swift.Error {
        /// Load method error
        ///
        /// - fileNotExist: file does not exist
        /// - cannotDecode: JSONDecoder can't decode data
        public enum Load: Swift.Error {
            case fileNotExist
            case cannotDecode
        }

        /// Store method error
        ///
        /// - fileNameNotExist: file with given name does not exist
        /// - fileNotExist: file does not exist
        /// - cannotEncode: JSONEncoder can't encode data
        /// - cannotUpdate: file manager can't remove previous file with given filename
        public enum Store: Swift.Error {
            case fileNameNotExist
            case cannotEncode
            case cannotUpdate
        }

        /// Remove method error
        ///
        /// - fileNotExist: file does not exist
        /// - cannotRemove: file manager can't remove previous file with given filename
        public enum Remove: Swift.Error {
            case fileNotExist
            case cannotRemove
        }
    }

    // MARK: - Constants

    /// Default operation queue with .userItitiated qos
    public static let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInitiated
        return operationQueue
    }()
    /// Default filemanager
    private static let manager = FileManager.default
    /// Needs for wait result value for load method and catch errors in all methods
    private static let semaphore = DispatchSemaphore(value: 0)

    // MARK: - Initialization and deinitialization

    private init() { }

    // MARK: - Static helpers

    /// Load file from disk
    ///
    /// - Parameters:
    ///   - fileName: filename given on store operation
    ///   - type: type of Codable object
    ///   - operationQueue: custom operationQueue (.userInitiated qos by default)
    /// - Returns: value with given type
    static public func load<T: Codable>(fileName: String, as type: T.Type, operationQueue: OperationQueue = operationQueue) throws -> T? {

        var entity: T?
        var error: Swift.Error?

        operationQueue.addOperation {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path),
                let data = manager.contents(atPath: url.path)
            else {
                error = Error.Load.fileNotExist
                semaphore.signal()
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                entity = try decoder.decode(type, from: data)
            } catch _ {
                error = Error.Load.cannotDecode
            }

            semaphore.signal()
        }

        semaphore.wait()

        if let error = error {
            throw error
        }

        return entity
    }

    /// Store file on disk
    ///
    /// - Parameters:
    ///   - object: file for store
    ///   - fileName: file name for load operation
    ///   - operationQueue: custom operationQueue (.userInitiated qos by default)
    static public func store<T: Codable>(object: T, as fileName: String, operationQueue: OperationQueue = operationQueue) throws {
        var error: Swift.Error?

        guard
            let url = url(for: fileName)
        else {
            throw Error.Store.fileNameNotExist
        }

        operationQueue.addOperation {
            do {
                let data = try JSONEncoder().encode(object)

                if manager.fileExists(atPath: url.path) {
                    do {
                        try manager.removeItem(at: url)
                    } catch _ {
                        error = Error.Store.cannotUpdate
                    }
                }

                manager.createFile(atPath: url.path, contents: data, attributes: nil)
            } catch _ {
                error = Error.Store.cannotEncode
            }

            semaphore.signal()
        }

        semaphore.wait()

        if let error = error {
            throw error
        }
    }

    /// Remove file from disk
    ///
    /// - Parameters:
    ///   - fileName: filename given on store operation
    ///   - operationQueue: custom operationQueue (.userInitiated qos by default)
    static public func remove(fileName: String, operationQueue: OperationQueue = operationQueue) throws {

        var error: Swift.Error?

        operationQueue.addOperation {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path)
            else {
                error = Error.Remove.fileNotExist
                semaphore.signal()
                return
            }

            do {
                try manager.removeItem(at: url)
            } catch _ {
                error = Error.Remove.cannotRemove
            }

            semaphore.signal()
        }

        semaphore.wait()

        if let error = error {
            throw error
        }
    }

    // MARK: - Private helpers

    /// Get url from file system
    ///
    /// - Parameter fileName: given file name on store operation
    /// - Returns: URL in cache directory
    private static func url(for fileName: String) -> URL? {
        return manager.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName, isDirectory: false)
    }
}
