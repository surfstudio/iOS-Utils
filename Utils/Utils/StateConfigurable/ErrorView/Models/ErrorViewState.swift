//
//  ErrorViewState.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import Foundation

public enum ErrorViewState {
    case error
    case empty
}

extension ErrorViewState {
    var ss: String {
        switch self {

        case .error:
            return ""
        case .empty:
            return ""
        }
    }
}
