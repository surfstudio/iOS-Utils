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

## Как собрать проект

Проект использует [Bundler](https://bundler.io/). 

Перед стартом разработки необходимо вызвать `make init`. 

Также в проекте есть makefile, в котором есть небольшой набор полезных команд.

`make init` – загрузит и инициализирует все необходимые зависимости.

`make build` – соберет проект локально.

`make test` – выполнит прогон всех тестов.

`make format` – выполнит команду swiftlint autocorrect.

`make lint` – выполнит проверку swiftlint и предоставит отчет. 

`make pod`  – рекомендуется использовать эту команду для того, чтобы установить поды. И **не использовать** `pod install`

`make help` – выведет перечень доступных команд из makefile

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
- [LocalStorage](#localstorage) – утилита для сохранения / удаления / загрузки `Codable` моделей данных в файловую систему
- [GeolocationService](#geolocationservice) – сервис для определения геопозиции пользователя
- [UIDevice](#uidevice) – набор вспомогательных методов для определения типа девайса 
- [LayoutHelper](#layouthelper) – вспомогательный класс, для верстки под разные девайсы из IB
- [UIStyle](#uistyle) – класс для удобной работы с разными стилями UIView наследников
- [MailSender](#mailsender) - утилита для посылки email сообщений (либо через `MFMailComposeController`, либо через стандартное приложение почты)
- [LoadingView](#loadingview) - набор классов и протоколов для удобного отображения загрузочных состояний с шиммерами
- [SecurityService](#securityservice)  -  сервис для шифрования и сохранения в keychain/inMemory секретных данных
- [BeanPageControl](#beanPageControl) – page control с перетекающими индикаторами-бобами
- [TouchableControl](#touchablecontrol) – аналог кнопки с кастомизированным анимированием
- [CustomSwitch](#customswitch) – более гибкая реализация Switch ui элемента
- [MoneyModel](#moneymodel) - структура для работы с деньгами
- [MapRoutingService](#maproutingservice) - сервис для построения маршрутов и отображения точек в сторонних навигационных приложениях

## Утилиты

### StringAttributes

Утилита для упрощения работы с `NSAttributedString`

**Варианты использования:**

1. Для простых строк можно использовать метод `.with(attributes: [StringAttribute])`

Пример:
```Swift
let attrString = "Awesome attributed srting".with(attributes: [.kern(9), lineHeight(20)])
```

2. Для строк, где для разных участков текста необходим различный стиль, есть `StringBuilder`. 

Пример:
```Swift
let globalSttributes: [StringAttribute] = [
    .font(.systemFont(ofSize: 14)),
    .foregroundColor(.black)
]
let attributedString = StringBuilder(globalAttributes: globalSttributes)
    .add(.string("Title"))
    .add(.delimeterWithString(delimeter: .init(type: .space), string: "blue"), 
         with: [.foregroundColor(.blue)])
    .add(.delimeterWithString(delimeter: .init(type: .lineBreak), string: "Base style on new line"))
    .add(.delimeterWithString(delimeter: .init(type: .space), string: "last word with it's own style"), 
         with: [.font(.boldSystemFont(ofSize: 16)), .foregroundColor(.red)])
    .value
```

Возможные проблемы:

- при добавлении к `StringBuilder` только разделителя (`.add(.delimeter)`) (без указания шрифта как локально, так и в рамках текущего блока) может произойти потеря равнения параграфа по вертикали потому что для разделителя будет использоваться стандартный шрифт системы (лейбла). Для предотвращения данной проблемы желательно использование разделителей в паре с текстом (`.add(.delimeterWithString(...))`)

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
<details><summary>Примеры</summary>

![LeftToRight](Examples/skeleton1.gif)

![RightToLeftFaster](Examples/skeleton2.gif)

</details>

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

<details><summary>Примеры</summary>

![OTPField](Examples/otpField.gif)

</details>

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
  * Метод **drawInitials** – Рисует инициалы на картинке с заданным шрифтом и цветом текста
  
  
  ![](Pictures/initials.png)
  
  ```swift
  func drawInitials(firstname: String,
                    lastname: String,
                    font: UIFont,
                    textColor: UIColor) -> UIImage?
  ```
   * Метод **badgedImage** – Рисует бейдж на картинке 
   
   ![](Pictures/badge.png)
   
   ```swift
   func badgedImage(count: Int, dimension: CGFloat, strokeWidth: CGFloat, backgroundBadgeColor: UIColor) -> UIImage? 
   ``` 
   Рисует бейдж в правом верхнем углу с цифрой, используется, например, для непрочитанных уведомлений, можно конфигурировать размер бейджа, его фон и ширину прозрачной линии между картинкой и бейджом
    ```swift
   func badgedImage(_ badgeImage: UIImage, dimension: CGFloat) -> UIImage?
    ``` 
    Рисует бейдж с заданной картинкой в правом нижнем углу, можно конфигурировать размер бейджа
  

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

<details><summary>Примеры</summary>

![Common Button](Examples/commonButton.gif)

</details>

### LocalStorage

Утилита для сохранения / удаления / загрузки `Codable` моделей данных в файловую систему.

ВАЖНО: работает на синхронной очереди

Пример:
```Swift

// Модель должна быть Codable

struct Model: Codable {
    let id: Int
    let name: String
}

let model = Model(id: 2, name: "Ибрагим")

// Сохранение модели с необходимым названием файла

LocalStorage.store(object: model, as: "filename")

// Загрузка модели с указанием имени файла и типом модели

LocalStorage.load(fileName: "filename", as: Model.self)

// Удаление модели с указанием имени файла

LocalStorage.remove(fileName: Constants.newLocalPostFileName)
```

### GeolocationService

Сервис для определения геопозиции пользователя. Позволяет получить текущее местоположение пользователя и узнать статус доступа к сервисам геопозиции. Выполнен в виде сервиса, закрытого абстрактным протоколом, потому имеется возможность инжектить его в `Presenter` наравне с другими сервисами, а также покрыть его тестами, при необходимости.

Пример:
```Swift

// Создание сервиса:

let service = GeolocationService()

// Получение статуса доступа к сервисам геолокации:

service.requestAuthorization { result in
    switch result {
    case .success:
        // access is allowed
    case .denied:
        // user denied access to geolocation
    case .failure:
        // user doesn't gave permission on his geolocation in the system dialog
    case .requesting:
        // system dialog is currently displayed
    }
}

// Получение геопозиции пользователя:

service.getCurrentLocation { result in
    switch result {
    case .success(let location):
        // do something usefull with user location
    case .denied:
        // user denied access to geolocation
    case .error:
        // some error ocured
    }
}
```

### UIDevice

Набор вычисляемых проперти для определения размера экрана телефона. Данный набор утилит основывается на библиотеке [Device](https://github.com/Ekhoo/Device). Как и любая другая библиотека определяющая текущий телефон она требует поддержки в случае выхода новых, но эта библиотека была заброшена автором, поэтому мы добавили ее локально в папку UIDevice/Support и поддерживаем сами.

**Доступные методы:** 

`isSmallPhone` – возвращает `true`, если это телефон с размером экрана 5, 5c, 5s, SE

`isXPhone` – возвращает `true`, если это телефон версии X. Т.е. с челкой, большой safeArea и т.д.

`isNormalPhone` – возвращает `true`, если это телефон версии 6/7/8 или  '+'

`isPad` – возвращает `true`, если это iPad любой модели.

**Использование:**

```swift
guard UIDevice.isSmallPhone else {
    return
}
```

### LayoutHelper

Простой класс упрощающий верстку сложных экранов для разных типов девайсов. Например, если нам необходимо сделать разных отступ от верха экрана для разных типов устройств (X, 5s и обычный  7+), то нам придется притянуть аутлет с констрейнтом в код и прописать ему логику. С классом LayoutHelper теперь этого делать не надо. 

**Использование**

1. Унаследовать констрейнт в InterfaceBuilder от класса LayoutHelper.
2. На вкладке Attributes Inspector появится 3 вычисляемых проперти, которые можно задать для каждого типа экрана.
3. Типы экрана аналогичны методам из extension для UIDevice

### UIStyle

Класс и набор протоколов позволяющие удобно работать со стилями в приложение. 

`UIStyleProtocol` – протокол предоставляющий интерфейс любому наследнику UIView, к которому можно применить метод `apply`

`UIStyle` – джинерик класс отвечающий за настройку стиля для выбранного наследника UIView. 

`AttributableStyle` – вспомогательный протокол, который необходимо применять на класс UIStyle для того, чтобы была возможность вернуть массив атрибутов текущего стиля. 

**Использование**

```swift
/// Какой-либо класс наследник от UIView
class SomeView: UIView {}

/// Расширение, которое применяет стиль к своему инстенсу класса
extension SomeView {
    func apply(style: UIStyle<SomeView>) {
        style.apply(for: self)
    }
}

/// Класс стиля, который может содежрать в себе различные настройки и способы инициализации
final class SomeViewStyle: UIStyle<SomeView> {
    override func apply(for view: SomeView) {
        view.backgroundColor = .black
    }
}

/// Расширение на класс UIStyle, которое возвращает инстенс стиля
extension UIStyle {
    static var styleForSomeView: UIStyle<SomeView> {
        return SomeViewStyle()
    }
}

/// Применение
let someView = SomeView()
someView.apply(style: .styleForSomeView)

```

#### AnyStyle

В различных случаях может понадобиться возможность обернуть стиль в некий контейнер. Для этого есть класс AnyStyle. 

**Использование**: 

```swift
let anyStyle = AnyStyle(style: UIStyle.styleForSomeView)
anyStyle.apply(for: someView)
```
### LoadingView

Используется для упрощения работы с загрузочными состояними экрана на основе шиммеров. Позволяет формировать загрузочный экран из нескольких и даже разных блоков, блоком является кастомное View, выступающее в роли загрузочного элемента экрана, блоки можно дублировать сколько угодно раз, что может быть удобным для коллекций. 

`BaseLoadingView` - основная View, которая отвечает за отображение loading стейта, состоит из блоков и SkeletonView

`LoadingSubview` и `LoadingSubviewConfigurable` - протоколы, с помощью которых верстается LoadingSubview(блок)

`BaseLoadingViewBlock` - используется для инициализации и конфигурации LoadingSubview

`LoadingDataProvider` - протокол, формирующий блоки для loading стейта, применяется на UIViewController

**Использование**: 

Верстаем LoadingSubview, подписываем UIViewController под `LoadingDataProvider`, формируем блоки и инициализируем модель конфигурации `LoadingViewConfig`
```swift
extension viewController: LoadingDataProvider {
    func getBlocks() -> [LoadingViewBlock] {
        return [BaseLoadingViewBlock<CustomLoadingSubview>(model: .init()]
    }

    var config: LoadingViewConfig {
        return .init(placeholderColor: .gray)
    }
}
```
Инициализируем BaseLoadingView, передаем в метод configure наши блоки и конфиг, отображаем
```
let loadingView = BaseLoadingView(frame: view.bounds)
loadingView.configure(blocks: self.getBlocks(), config: self.config)
loadingView.setNeedAnimating(true)
loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

view.addSubview(loadingView)
view.stretch(loadingView)
view.bringSubviewToFront(loadingView)
```


### SecurityService 

Сервис, который умеет шифровать и сохранять в keychain/inMemory секретные данные по ключу, например по пину
Шифрование происходит по следующему принципу:
1. Берется SHA3.224 от пина
2. Генерируется криптостойкой случайное число на 32 бита - соль
3. Из битового представления соли получаем hex-string
4. Вставляется пин в соль - получаем ключ
5. Генерируется вектор инициаллизации - 4 бита
6. Шифруем наши данные алгоритмом Blowfish токены используя ключ.
7. Полученный шифротекст сохраняем в кейчейн
8. Ключ так же сохраняем в кейчейне

`PinCryptoBox` - отвечает за шифрование/дешифрование и сохранение/загрузку из стореджа, при инициализации принимает `SecureStore`, `HashProvider`, `SymmetricCryptoService` и ключи к соли, вектору инициализации, шифруемым данным и хешу.  Реализует протокол `CryptoBox`

`PinHackCryptoBox` - подобен `PinCryptoBox` , используется для обновления зашифрованных данных, его отличие в том, что он уже сам знает  откуда прочесть ключи и все остальное, ему нужно только получить данные. 

`HackWrapperCryptoBox` - обертка для хак-бокса, используется чтобы на лету подменять шифровальщик.

`BlowfishCryptoService` - шифрует данные алгоритмом Blowfish, передается в крипто-бокс.

`InMemorySecureStore` - класс для хранения данных в оперативной памяти телефона

`KeyChainSecureStore` - Инкапсулирует логику сохранения, загрузки и удаленния данных из keyChain, можно использовать отдельно от криптобоксов

`GenericPasswordQueryable` - создает query c kSecClassGenericPassword для keyChain, инжектится в  `KeyChainSecureStore` 

**Использование**: 
Для начала в проекте следует определить константы для криптобокса и для удобства использования можно написать подобный конфигуратор
```swift
import CryptoSwift 

struct PinCryptoBoxConfigurator {
    func produceClear() -> PinCryptoBox {
        return PinCryptoBox(secureStore: { Settings.shared.secureStorage },
                            hashProvider: SHA3(variant: .sha224),
                            cryptoService: BlowfishCryptoService(),
                            ivKey: Const.ivKey,
                            dataKey: Const.dataKey,
                            saltKey: Const.saltKey,
                            hashKey: Const.hashKey)
    }
}
```
Инициализируем сервис, шифруем и дешифруем
```swift
let cryptoService = PinCryptoBoxConfigurator().produceClear()
try? cryptoService.encrypt(data: token, auth: pin)
let token = try? cryptoService.decrypt(auth: pin) 
```
Для обновления данных используем HackCryptoBox
```swift
let cryptoService = PinCryptoBoxConfigurator().produceClear().hack()
```

### BeanPageControl

Page control с перетекающими индикаторами-бобами.

![](Pictures/beans1.gif)

![](Pictures/beans2.gif)

Набор кастомизируемых полей: 
- `count`
- `beanHeight`
- `inactiveBeanWidth`
- `activeBeanWidth`
- `padding`
- `beanCornerRadius`
- `beanActiveColor`
- `beanInactiveColor`

**Использование**

```swift
// Инициализация

let pageControl = BeanPageControl()
pageControlContainer.addSubview(pageControl)
pageControl.anchorCenter(to: pageControlContainer)
pageControl.activeBeanWidth = 100
pageControl.beanActiveColor = .yellow
self.pageControl = pageControl

// Обновление

adapter?.onChangePage = { [weak self] page, progress in
    self?.pageControl?.set(index: page, progress: progress)
}

```

### TouchableControl

Данный класс унаследован от стандартного UIControl. Позволяет принимать на вход различные UI элементы и, при нажатии на этот контрол,
анимировать их, иммтируя как бы нажатие на кнопку. То есть, по сути является аналагом кнопки с возможностью кастомизировать анимацию 
нажатия(затемнение или изменение цвета только некоторых элементов) 

**Доступные параметры:** 

`animatingViewsByAlpha` – сюда можно передать одну или несколько `UIView`, которые будут уменьшать `alpha` параметр, при
нажатии на контрол.

`onTouchUpInside`,  `onTouchCancel`, `onTouchDown` - блоки, для управления событий нажатия.

`touchAlphaValue` - параметр, типа `CGFloat`, определяющий на какое значени `alpha` будет изменяться элементы при нажатии

`normalDuration` - параметр, типа `TimeInterval`, определяющий в течение какого времени будет происходить затемнение

**Доступные методы:** 

`addChangeColor(to: UIView, normalColor: UIColor, touchedColor: UIColor)` - добавляет вью, у которой будет изменяться цвет при нажатии
на контрол

`clearControl()` - Для случаев, когда данный класс добавлен во вью, которая будет сама передана в него. 
Устонавливается в deinit ViewController'а с этой view

**Использование:**

```swift

class ViewController: UIViewController {

    @IBOutlet weak var someView: UIView!
    @IBOutlet weak var someLabel: UILabel!
    @IBOutlet weak var secondSomeLabel: UILabel!

    private let control = TouchableControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        control.translatesAutoresizingMaskIntoConstraints = false
        someView.addSubview(control)
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: someView.topAnchor),
            control.leftAnchor.constraint(equalTo: someView.leftAnchor),
            control.rightAnchor.constraint(equalTo: someView.rightAnchor),
            control.bottomAnchor.constraint(equalTo: someView.bottomAnchor)
        ])

        control.animatingViewsByAlpha = [someLabel]
        control.addChangeColor(to: someView, normalColor: someView.backgroundColor, touchedColor: .blue)
        control.addChangeColor(to: secondSomeLabel, initColor: secondSomeLabel.textColor, goalColor: .orange)

        control.onTouchUpInside = {
        }
        control.onTouchCancel = {
        }
        control.onTouchDown = {
        }
    }

    deinit {
        control.clearControl()
    }
}

```

### CustomSwitch

Гибкая реализация ui элемента switch.
1) Умеет адаптироваться под разный размер.
2) Есть возможность задать закругления и отсутпы.
3) Есть возможность задать градиент вместо цвета.
4) Гибко настраивается анимация.
5) Есть возможность добавить тень для бегунка.

`CustomSwitch` – непосредственно сам элемент.

`CustomSwitch.LayoutConfiguration` - содержит padding(отступ от бегунка до краев), spacing(отступ от бегунка до сторон в обоих состояниях) и cornerRatio самого свитча.

`CustomSwitch.ThumbConfiguration` - содержит cornerRatio и shadowConfiguration(CSShadowConfiguration) для самого бегунка.

`CustomSwitch.ColorsConfiguration` - содержит в себе параметры для конигурации цвета подложки(on и off) и бегунка. Все три параметра имеют тип CSColorConfiguration. Это протокол с одним методом - `applyColor(for view: UIView)` и имеющий уже две реализации: `CSSimpleColorConfiguration` и `CSGradientColorConfiguration`.

`CustomSwitch.AnimationsConfiguration` - содержит параметры для конфигурации анимации свитча(duration, delay, usingSpringWithDamping, initialSpringVelocity, options).

Для обработки изменения стейта можно использовать стандартный event valueChanged.

**Использование**

```swift
let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
customSwitch.layoutConfiguration = .init(padding: 1, spacing: 3, cornerRatio: 0.5)
customSwitch.colorsConfiguration = .init(offColorConfiguraion: CSSimpleColorConfiguration(color: .white),
                                         onColorConfiguraion: CSSimpleColorConfiguration(color: .green),
                                         thumbColorConfiguraion: CSGradientColorConfiguration(colors: [.lightGray, .yellow],
                                                                                              locations: [0, 1]))
customSwitch.thumbConfiguration = .init(cornerRatio: 0, shadowConfiguration: .init(color: .black, offset: CGSize(), radius: 5, oppacity: 0.1))
customSwitch.animationsConfiguration = .init(duration: 0.1, usingSpringWithDamping: 0.7)

customSwitch.setOn(true, animated: false)

// обработка

@IBAction func switchValueDidChange(_ sender: CustomSwitch) {
	print(sender.isOn)
}
```

### MailSender

Утилита для посылки email сообщений. Автоматически определяет через какой источник можно послать email.

**Алгоритм работы:**

- если можно, то открывает `MFMailComposeViewController`
- если можно, то перебрасывает пользователя в стандартное приложение почты
- иначе - показывает ошибку

Для того, чтобы интегрировать утилиту необходимо в инициализатор передать сущности, которые реализую следующие протоколы:

- `MailSenderErrorDisplaying` - сущность, которая будет отображать ошибку
- `MailSenderPayloadProvider` - сущность, которая вернет утилите payload со всей необходимой информацией для отсылания email-а
- `MailSenderRouterHelper` - сущность, которая умеет показывать, скрывать экраны (router)

#### Пример интеграции

```swift
final class ProjectMailSenderErrorDisplaying: MailSenderErrorDisplaying {

    func display(error: MailSenderError) {
        SnackService().showErrorMessage("There is an error while sending email")
    }

}

final class ProjectMailSenderPayloadProvider: MailSenderPayloadProvider {

    func getPayload() -> MapUtilPayload {
        let body = "Some info about app"
        return MapUtilPayload(
            recipient: "developer@project.com",
            subject: "Feedback",
            body: body
        )
    }

}

final class ProjectMailSenderRouterHelper: MailSenderRouterHelper {

    // MARK: - Private Properties

    private let router: Router

    // MARK: - Initializaion

    init(router: Router) {
        self.router = router
    }

    // MARK: - MailSenderRouterHelper

    func present(_ viewController: UIViewController) {
        router.present(viewController)
    }

    func dismiss() {
        router.dismissModule()
    }

}
```

Пример вызова описанной конфигурации:

```swift
let mailSender = MailSender(
    errorDisplaying: ProjectMailSenderErrorDisplaying(),
    payloadProvider: ProjectMailSenderPayloadProvider(),
    routerHelper: ProjectMailSenderRouterHelper(router: MainRouter())
)
mailSender.send()
```

### MoneyModel

Это структура для работы с деньгами:

```Swift
        print(MoneyModel(decimal: 10, digit: 0).asString()) // выведет -- "10"
        print(MoneyModel(decimal: 10, digit: 9).asString()) // выведет -- "10.09"
        print(MoneyModel(decimal: 10, digit: 99).asString()) // выведет -- "10.99"
```

### MapRoutingService

Сервис позволяет получить список приложений для работы с навигацией, установленных на устройстве пользователя, а также отобразить точку/построить маршрут до заданной точки в одном из них.

```swift
/// получение списка возможных приложений, которые можно отобразить для выбора пользователю
let apps = service.availableApplications

/// построение маршрута
service.buildRoute(to: point, in: app, onComplete: nil)
```

Для работы с сервисом требуется заинжектить в его конструктор небольшой объект, позволяющий понять информацию о текущей геопозиции пользователя. Его интерфейс выглядит следующим образом

```swift
public protocol MapRoutingLocationServiceInterface: AnyObject {
    /// Равно true, когда пользователь разрешил доступ к геопозиции
    var isLocationAccessAllowed: Bool { get }
    /// Равно true, когда пользователь разрешил использование точной геопозиции
    var isAllowedFullAccuracyLocation: Bool { get }
    /// Вовращает текущую геопозицию пользователя, если она известна,
    /// и nil во всех остальных случаях
    func getCurrentLocation(_ completion: @escaping ((CLLocationCoordinate2D?) -> Void))
}
```

Вы можете написать небольшую обертку поверх [GeolocationService](#geolocationservice), либо использовать вместо него сервис для работы с геопозицией из своего проекта.

## Версионирование

В качестве принципа версионирования используется [Семантическое версионирования (Semantic Versioning)](https://semver.org/).

Если вкратце, то версии обозначаются в формате `x.y.z` где
- х мажорный номер версии. Поднимается только в случае мажорных обновлений (изменения в интерфейсах, добавление новой функциональности, добавление новой утилиты)
- y минорный номер версии. Поднимается только в случае минорных обновлений (изменения в имплементации, не влияющие на интерфейсы)
- z минорный номер версии. Поднимается в случае незначительных багфиксов и т.п.
