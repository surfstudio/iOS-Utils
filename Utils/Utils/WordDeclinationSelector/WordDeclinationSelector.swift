//
//  WordDeclinationConstructor.swift
//  Utils
//
//  Created by Александр Чаусов on 02/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import Foundation

/// An instance of this class is used to generate the correct word declination
/// for a number and contains all the available declensions.
public final class WordDeclinations {
    let singularNominative: String
    let genetiveSingular: String
    let genetivePlural: String

    /// Initialization of the class instance. You have to provide three word declensions.
    /// - Parameters:
    ///   - singularNominative: The word nominative case in the singular, for example "День"
    ///   - genetiveSingular: The word genitive in the singular, for example "Дня"
    ///   - genetivePlural: The word genitive in the plural, for example "Дней"
    init(_ singularNominative: String, _ genetiveSingular: String, _ genetivePlural: String) {
        self.singularNominative = singularNominative
        self.genetiveSingular = genetiveSingular
        self.genetivePlural = genetivePlural
    }
}

/// Class for select correct word declension for the passed number
public final class WordDeclinationSelector {

    /// This method is used to get correct declension of word for some number
    ///
    /// Example of usage:
    /// ```
    /// let correctForm = WordDeclinationSelector.declineWord(for: 6, from: WordDeclensions("день", "дня", "дней"))
    /// ```
    ///
    /// - Parameters:
    ///   - number: The number to which you want to find the declination.
    ///   - declensions: An instance of the word declinations.
    /// - Returns: Returns a word from the word declensions in the right form.
    public static func declineWord(for number: Int, from declensions: WordDeclinations) -> String {
        let ending = number % 100
        if (ending >= 11 && ending <= 19) {
            return declensions.genetivePlural
        }
        switch (ending % 10) {
        case 1:
            return declensions.singularNominative
        case 2, 3, 4:
            return declensions.genetiveSingular
        default:
            return declensions.genetivePlural
        }
    }

}
