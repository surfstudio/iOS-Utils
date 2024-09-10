//
//  LoadingDataProvider.swift
//  Utils
//
//  Created by Никита Гагаринов on 18.08.2020.
//  Copyright © 2020 Surf. All rights reserved.
//

public protocol LoadingDataProvider {
    var config: LoadingViewConfig { get }

    func getBlocks() -> [LoadingViewBlock]
}
