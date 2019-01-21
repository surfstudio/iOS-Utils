//
//  LocalStorage.swift
//  Utils
//
//  Created by Anton Dryakhlykh on 21/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

final public class LocalStorage {

    // MARK: - Constants

    private static let manager = FileManager.default
    private static let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInitiated
        return operationQueue
    }()

    // MARK: - Initialization and deinitialization

    private init() { }

    // MARK: - Static helpers

    static public func load<T: Codable>(fileName: String, as type: T.Type) -> T? {
        var entity: T?

        let semaphore = DispatchSemaphore(value: 0)

        operationQueue.addOperation {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path),
                let data = manager.contents(atPath: url.path)
            else {
                semaphore.signal()
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            entity = try? decoder.decode(type, from: data)

            semaphore.signal()
        }

        semaphore.wait()

        return entity
    }

    static public func store<T: Codable>(object: T, as fileName: String) {
        operationQueue.addOperation {
            guard
                let url = url(for: fileName),
                let data = try? JSONEncoder().encode(object)
            else {
                return
            }

            if manager.fileExists(atPath: url.path) {
                try? manager.removeItem(at: url)
            }

            manager.createFile(atPath: url.path, contents: data, attributes: nil)
        }
    }

    static public func remove(fileName: String) {
        operationQueue.addOperation {
            guard
                let url = url(for: fileName),
                manager.fileExists(atPath: url.path)
            else {
                return
            }

            try? manager.removeItem(at: url)
        }
    }

    // MARK: - Private helpers

    private static func url(for fileName: String) -> URL? {
        return manager.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName, isDirectory: false)
    }
}
