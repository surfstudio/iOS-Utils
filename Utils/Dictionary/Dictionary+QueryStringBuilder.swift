//
//  Dictionary+QueryStringBuilder.swift
//  Utils
//
//  Created by Chausov Alexander on 25/12/2018.
//  Copyright © 2018 Surf. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {

    /// Method allows you convert [String: Any] object into query string like "key1=value1&key3=true&key2=2.15"
    public func toQueryString() -> String? {
        let items = queryItems()
        let components = URLComponents(queryItems: items)
        return components.query
    }

    // MARK: - Private Methods

    /// Support methods to convert elements of dictionary into URLQueryItem array
    private func queryItems() -> [URLQueryItem] {
        return self.map { (element) -> URLQueryItem in
            let (key, value) = element
            let string = "\(value)"
            return URLQueryItem(name: key, value: string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) )
        }
    }

}

// MARK: - URLComponents

private extension URLComponents {

    /// Support init for toQueryString() method
    init(queryItems: [URLQueryItem]) {
        self.init()
        self.queryItems = queryItems
    }

}
