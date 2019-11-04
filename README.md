[![codebeat badge](https://codebeat.co/badges/c2deb19a-3be3-4dd8-aa3d-886e0f361bea)](https://codebeat.co/projects/github-com-surfstudio-ios-utils-master)
[![Build Status](https://travis-ci.org/surfstudio/iOS-Utils.svg?branch=master)](https://travis-ci.org/surfstudio/iOS-Utils)
# iOS-Utils

Этот репозиторий содержит коллекцию утилит, каждая из которых находится в отдельной `pod subspec`.
Обновление версии любой утилиты означает обновление версии всего репозитория.

## Как установить

Для установки любой из утилит необходимо добавить следующий код в ваш `Podfile`

```Ruby
pod 'SurfUtils/$UTIL_NAME$', :git => "https://github.com/surfstudio/iOS-Utils.git"
```

## Список утилит

- [StringAttributes](#stringattributes) - упрощение работы с `NSAttributedString`
- [BrightSide](#brightside) - позволяет определить наличие root на девайсе.
- [VibrationFeedbackManager](#vibrationfeedbackmanager) - позволяет воспроизвести вибрацию на устройстве.
- [QueryStringBuilder](#querystringbuilder) - построение строки с параметрами из словаря
- [BlurBuilder](#blurbuilder) - упрощение работы с blur-эффектом
- [RouteMeasurer](#routemeasurer) - вычисление расстояния между двумя координатами
- [SettingsRouter](#settingsrouter) - позволяет выполнить переход в настройки приложения/устройства
- [AdvancedNavigationStackManagement](#advancednavigationstackmanagement) - расширенная версия методов push/pop у UINavigationController
- [WordDeclinationSelector](#worddeclinationselector) - позволяет получить нужное склонение слова
- [ItemsScrollManager](#itemsscrollmanager) - менеджер для поэлементного скролла карусели
- [KeyboardPresentable](#keyboardpresentable) - семейство протоколов для упрощения работы с клавиатурой и сокращения количества одинакового кода
- [SkeletonView](#skeletonview) - cпециальная кастомная View для создания skeleton loader'ов
- [OTPField](#otpfield) - кастомный филд для работы с One Time Password 
- [XibView](#xibview) - для работы UIView + xib
- [UIImageExtensions](#uiimageextensions) - набор часто используемых extensions для UIImage
- [CommonButton](#commonbutton) - Базовый класс для кнопки

## Утилиты

### StringAttributes

Утилита для упрощения работы с `NSAttributedString`

Пример:
```Swift
let attrString = "Awesome attributed srting".with(attributes: [.kern(9), lineHeight(20)])
```

### BrightSide

Утилита позволяет определить наличие root на устройстве.

Пример:
```Swift
if BrightSide.isBright() {
    print("Девайс чист как белый лист")
} else {
    print("На девайсе получен root доступ")
}
```

### VibrationFeedbackManager

Утилита для воспроизведения вибраций с поддержкой taptic engine (1.0/2.0). Автоматически определяет тип девайса и вызывает корректный тип вибрации.

Пример:
```Swift
/// воспроизвести вибрацию по событию error
VibrationFeedbackManager.playVibrationFeedbackBy(event: .error)
```

### QueryStringBuilder

Утилита позволяет построить строку типа "key1=value1&key2=2.15&key3=true", в виде которой обычно представляются параметры GET запроса, из словаря [String: Any].

Пример:
```Swift
let dict: [String: Any] = ["key1": "value1", "key2": 2.15, "key3": true]
let queryString = dict.toQueryString()
```

### BlurBuilder

Утилита для упрощения добавления стандартного блюра на какое-либо View, позволяет управлять стилем и цветом блюра.

Пример:
```Swift
bluredView.addBlur(color: UIColor.white.withAlphaComponent(0.1), style: .light)
```

### RouteMeasurer

Утилита для вычисления расстояния между двумя точками, как напрямую, так и с учетом возможного маршрута. Помимо прочего, предоставляет метод для форматирования результата.

Пример:
```Swift
RouteMeasurer.calculateDistance(between: firstCoordinate, and: secondCoordinate) { (distance) in
    guard let distance = distance else {
        return
    }
    let formattedDistance = RouteMeasurer.formatDistance(distance, meterPattern: "м", kilometrPatter: "км"))
}
```

### SettingsRouter

Утилита для упрощения перехода к настройкам приложения или к конкретному разделу настроек устройства.

Пример:
```Swift
SettingsRouter.openDeviceSettings()
```

### AdvancedNavigationStackManagement

Данная утилита предоставляет возможность вызова методов push и pop у UINavigationController с последующим вызывом completion-замыкания после завершения действия.

Пример:
```Swift
navigationController?.pushViewController(controller, animated: true, completion: {
    print("do something else")
})
```

### WordDeclinationSelector

Утилита, позволяющая получить верное склонение слова в зависимости от числа элементов.

Пример:
```Swift
let correctForm = WordDeclinationSelector.declineWord(for: 6, from: WordDeclensions("день", "дня", "дней"))
```

### ItemsScrollManager

Утилита для так называемого "порционного скролла".
Очень часто в проекте необходимо реализовать так называемую "карусель", где представлены некоторые элементы, просматривать которые можно посредством горизонтального скролла. При этом очень часто требуется, чтобы после скролла такой карусели она автоматически подскралливалась к какому-либо элементу, а не застывала на полпути, обрезая элементы в карусели.
Данная утилита предназначена для того, чтобы в левой части экрана всегда находилось начало какого-либо элемента.

Пример:
```Swift
// Создаем менеджер, указывая ширину ячейки карусели, расстояние между ячейками, а также отступы для секции UICollectionView с каруселью
scrollManager = ItemsScrollManager(cellWidth: 200,
                                   cellOffset: 10,
                                   insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))

// При этом необходимо помнить о том, что отступы для секции UICollectionView необходимо установить самому, к примеру:
let flowLayout = UICollectionViewFlowLayout()
flowLayout.scrollDirection = .horizontal
flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
collectionView.setCollectionViewLayout(flowLayout, animated: false)

// После чего необходимо добавить вызовы следующих методов в методы UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollManager?.setTargetContentOffset(targetContentOffset, for: scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollManager?.setBeginDraggingOffset(scrollView.contentOffset.x)
    }

}
```

### KeyboardPresentable

Семейство протоколов, цель которых - сократить кол-во одинаковых действий при работе с клавиатурой. В ходе данных работ выполняется, как правило, ряд действий, код которых идентичен в большинстве случаев - подписка на нотификации, отписывание от них, извлечение параметров из нотификации, таких как высота клавиатуры или время анимации. Данное семейство взаимосвязанных протоколов написано с целью сокращения количества одинакового кода.
Основной протокол - KeyboardObservable. Его вполне достаточно для работы, так как он позволяет инкапсулировать логику по подписыванию/отписыванию от нотификации, а при переопределении оставшихся двух методов - получить объект Notification из нотификации в чистом виде.
Для более простого извлечения параметров из нотификации создано еще два протокола:
- CommonKeyboardPresentable: позволяет получить информацию о высоте клавиатуры и времени анимации. При этом его методы не будут вызваны, если не удастся извлечь из нотификации высоту клавиатуры, а при невозможности извлечения времени анимации - будет использовано дефолтное значение.
- FullKeyboardPresentable: позволяет получить полную информацию о параметрах клавиатуры в виде структуры KeyboardInfo:
```Swift
public struct KeyboardInfo {
    var frameBegin: CGRect?
    var animationCurve: UInt?
    var animationDuration: Double?
    var frameEnd: CGRect?
}
```

Пример:
```Swift
// Рассмотрим необходимые действия для применения на примере CommonKeyboardPresentable
// Во-первых, необходимо объявить, что используемый ViewController реализует протокол KeyboardObservable
final class ViewController: UIViewController, KeyboardObservable {
    ...
}

// Для подписки на нотификации появления/сокрытия клавиатуры необходимо вызывать:
subscribeOnKeyboardNotifications()

// Для отписывания от нотификаций появления/сокрытия клавиатуры необходимо вызывать:
unsubscribeFromKeyboardNotifications()

// Во-вторых, необходимо объявить, что используемый ViewController реализует протокол CommonKeyboardPresentable
// В результате появления/сокрытия клавиатуры будут вызываться методы этого протокола, в которые приходят такие параметры, как высота клавиатуры и время анимации
extension ViewController: CommonKeyboardPresentable {

    func keyboardWillBeShown(keyboardHeight: CGFloat, duration: TimeInterval) {
        // do something useful
    }

    func keyboardWillBeHidden(duration: TimeInterval) {
        // do something useful
    }

}
```

### SkeletonView

Специальная кастомная View для создания skeleton loader'ов.
Вместе с самой view поставляются enum'ы для ее конфигурации и extension на UIView для создания масок.
Сценарий работы с SkeletonView:
1. Добавляем в нужное нам место view типа SkeletonView
2. Добавляем внутрь SkeletonView вьюхи, которые хотим использовать для анимации загрузки
3. Во ViewController'e кастомизируем SkeletonView(возможности по кастомизации ниже) и запускаем анимацию,
установив .shimmering = true

Возможности кастомизации:
```Swift
// Устанавливаем какие view(разрешены только subview данного skeletonView) должны участвовать в анимации(по умолчанию все subviews)
skeletonView.maskingViews = [view1, view2]

// Направление в котором бегает шиммер(по умолчанию - вправо)
skeletonView.direction = .left

// Цвет, которым закрашиваются эти самые maskingViews
skeletonView.gradientBackgroundColor = UIColor.red

// Цвет бегающего по ним шиммера
skeletonView.gradientMovingColor = UIColor.green

// Отношение ширины шиммера к ширине view. Допустимы значения в диапазоне [0.0, 1.0]
skeletonView.shimmerRatio = 0.7

// Длительность одного пробега шиммера в секундах
skeletonView.movingAnimationDuration = 1.0

// Длительность задержки между шагами анимации в секундах
skeletonView.delayBetweenAnimationLoops = 1.0
```

### OTPField

Кастомный филд для ввода OTP (One Time Password), который поддерживает Secure Code Autofill начиная с iOS 12.
Можно использовать как из Storyboard так и из кода.
Алгоритм работы:
1. Добавить из кода или xib
2. Установить стиль цифр через объект `DigitFieldStyle`
3. Установить стиль отображения ошибки через объект `OTPFieldStyle`
4. Применить стиль для `OTPField` с помощью метода `set(style:)`
5. Установить количество символов методом `setDigits(count:)`
6. Установить размер цифр методом `setDigit(size:)`
7. Установить расстояние между цифрами методом `setBetween(space:)`
8. Дернуть блок для обработки результата `didCodeEnter`

```Swift

        let otpField = OTPField()
        otpField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(otpField)

        NSLayoutConstraint.activate([
            otpField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            otpField.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0)
        ])

        let digitStyle = DigitFieldStyle(font: UIFont.boldSystemFont(ofSize: 34.0), activeTextColor: .green, inactiveTextColor: .gray, errorTextColor: .red, activeBottomLineColor: .green, inactiveBottomLineColor: .gray, errorBottomLineColor: .red)

        let style = OTPFieldStyle(digitStyle: digitStyle, errorTextColor: .red, errorFont: UIFont.italicSystemFont(ofSize: 17.0))

        otpField.setDigits(count: 4)

        otpField.set(style: style)

        otpField.setDigit(size: CGSize(width: 32.0, height: 32.0))

        otpField.setBetween(space: 6.0)

        otpField.didCodeEnter = { code in
            self.auth(
                code: code,
                success: {
                    print("success")
                },
                error: {
                    otpField.showError(message: "Ошибка")
                    otpField.clear()
                }
            )
        }
```

### XibView

Утилита для использования .xib + UIView. Работает в коде через конструктор и в сторибордах.
Алгоритм:
1. Необходимо создать файлы – View.swift и View.xib.
2. У View.xib указать View.swift у FileOwner
3. Во View.swift в конструкторе вызвать метод xibSetup.

Пример:
```Swift
override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
}
```

### UIImageExtensions

Набор часто используемых extensions для работы с UIImage

* Инициализатор позволяющий создать картинку с заданным цветом и размером 

  ```swift
  convenience init?(color: UIColor?, size: CGSize = CGSize(width: 1, height: 1))
  ```

* Метод **mask** – позволяет сделать картинку с заданным цветом или изменить параметры альфы у цвета картинки 

  ```swift
  func mask(with color: UIColor) -> UIImage 
  func mask(with alpha: CGFloat) -> UIImage
  ```

### CommonButton

Базовый класс для UIButton. Упрощает работу с доступными у класса UIButton параметрами. 

Базовые возможности: 

* Устанавливать бекграунд у кнопки для массива состояний
* Устанавливать цвет тайтла кнопки для массива состояний
* Устанавливать значения для border у кнопки
* Изменять cornerRadius
* Увеличивать область нажатия у кнопки
* Устанавливать значение тайтла для всех состояний сразу
* Устанавливать значение картинки кнопки для всех состояний сразу

## Версионирование

В качестве принципа версионирования используется [Семантическое версионирования (Semantic Versioning)](https://semver.org/).

Если вкратце, то версии обозначаются в формате `x.y.z` где
- х мажорный номер версии. Поднимается только в случае мажорных обновлений (изменения в интерфейсах, добавление новой функциональности, добавление новой утилиты)
- y минорный номер версии. Поднимается только в случае минорных обновлений (изменения в имплементации, не влияющие на интерфейсы)
- z минорный номер версии. Поднимается в случае незначительных багфиксов и т.п.
