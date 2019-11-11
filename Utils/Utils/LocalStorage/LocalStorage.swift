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

    public enum Error: Swift.Error, Equatable {
        /// Load method error
        ///
        /// - fileNotExist: file does not exist
        /// - cannotDecode: JSONDecoder can't decode data
        public enum Load: Swift.Error, Equatable {
            case fileNotExist
            case cannotDecode
        }

        /// Store method error
        ///
        /// - fileNameNotExist: file with given name does not exist
        /// - fileNotExist: file does not exist
        /// - cannotEncode: JSONEncoder can't encode data
        /// - cannotUpdate: file manager can't remove previous file with given filename
        public enum Store: Swift.Error, Equatable {
            case fileNameNotExist
            case cannotEncode
            case cannotUpdate
        }

        /// Remove method error
        ///
        /// - fileNotExist: file does not exist
        /// - cannotRemove: file manager can't remove previous file with given filename
        public enum Remove: Swift.Error, Equatable {
            case fileNotExist
            case cannotRemove
        }
    }

    // MARK: - Constants

    /// Default dispatch queue with .userItitiated qos
    public static let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    /// Default filemanager
    private static let manager = FileManager.default

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
    static public func load<T: Codable>(fileName: String, as type: T.Type, dispatchQueue: DispatchQueue = dispatchQueue) throws -> T? {

        var entity: T?
        var error: Swift.Error?

        dispatchQueue.sync {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path),
                let data = manager.contents(atPath: url.path)
            else {
                error = Error.Load.fileNotExist
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                entity = try decoder.decode(type, from: data)
            } catch _ {
                error = Error.Load.cannotDecode
            }
        }

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
    static public func store<T: Codable>(object: T, as fileName: String, dispatchQueue: DispatchQueue = dispatchQueue) throws {
        var error: Swift.Error?

        guard
            let url = url(for: fileName)
        else {
            throw Error.Store.fileNameNotExist
        }

        dispatchQueue.sync {
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
        }

        if let error = error {
            throw error
        }
    }

    /// Remove file from disk
    ///
    /// - Parameters:
    ///   - fileName: filename given on store operation
    ///   - operationQueue: custom operationQueue (.userInitiated qos by default)
    static public func remove(fileName: String, dispatchQueue: DispatchQueue = dispatchQueue) throws {

        var error: Swift.Error?

        dispatchQueue.sync {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path)
            else {
                error = Error.Remove.fileNotExist
                return
            }

            do {
                try manager.removeItem(at: url)
            } catch _ {
                error = Error.Remove.cannotRemove
            }
        }

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
