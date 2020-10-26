//
//  MoneyModel.swift
//  Utils
//

import Foundation

/// Представляет деньги как два целых числа - копейки (дробная часть) и рубли (целая часть)
struct MoneyModel {
    /// Целая часть
    let decimal: Int
    /// Дробная часть
    let digit: Int

    /// Создает модель денег
    ///
    /// **Внимание!!!**
    ///
    /// Этот инициаллизатор ни чем не защищен, так что если вы передадите в копейках число > 100, то сами виноваты
    ///
    /// - Parameters:
    ///   - decimal: Рубли
    ///   - digit: Копейки
    init(decimal: Int, digit: Int) {
        self.decimal = decimal
        self.digit = digit
    }

    /// Иницаллизирует деньги из строкового представления дробного числа
    ///
    /// **Внимание!!!**
    ///
    /// Ожидается, что между челой и дробной частью стоит `.`
    ///
    /// Если в строке будет записано к примеру `10` то будет создано число `decial: 10 digit: 0`
    /// Если в строке будет записано к примеру `10.00` то будет как в предыдущем варианте
    /// Если в строке будет записано к примеру `10.01` то будет создано число `decimal: 10 digit: 1`
    /// Если в строке будет записано к примеру `10.100` то вернется `nil`
    /// Если в строке будет записано `10.00.00` то вернется `nil`
    /// Если в строке будет записано не число, то вернется `nil`
    ///
    /// - Parameter value: Строка в которой лежит дробное число
    init?(value: String) {
        let numbers = value.split(separator: ".")
        guard
            numbers.count >= 1,
            numbers.count <= 2
        else {
            return nil
        }

        if numbers.count == 1 {

            guard let decimal = Int(numbers[0]) else { return nil }

            self.decimal = decimal
            self.digit = 0

            return
        }

        // На этом этапе у нас в любом случае 2 элемента в массиве
        // Потому что чуть выше мы поставили условие либо 1 либо 2
        // А на предыдущем шаге проверили 1 или нет

        guard
            let decimal = Int(numbers[0]),
            let digit = Int(numbers[1]),
            digit < 100
        else {
            print("Cant convert String to MoneyModel: \(value)")
            return nil
        }

        self.decimal = decimal
        self.digit = digit
    }

    func add(_ money: MoneyModel) -> MoneyModel {
        var resultDigit = money.digit + self.digit
        var resultDecial = money.decimal + self.decimal

        if resultDigit >= 100 {
            resultDecial += resultDigit / 100
            resultDigit = resultDigit % 100
        }

        return .init(decimal: resultDecial, digit: resultDigit)
    }
}

extension MoneyModel {
    /// Конвертирует модель в строку вида `рубли.копейки`
    /// Если digit == 0 то вернет просто `рубли`
    func asString() -> String {

        let digitPart = self.digit == 0 ? "" : ".\(self.digit)"

        return "\(self.decimal)\(digitPart)"
    }
}
