# Service utils

## Содержание

- [StringAttributes](#stringattributes) - упрощение работы с `NSAttributedString`
- [BrightSide](#brightside) - позволяет определить наличие root на девайсе.
- [VibrationFeedbackManager](#vibrationfeedbackmanager) - позволяет воспроизвести вибрацию на устройстве.
- [QueryStringBuilder](#querystringbuilder) - построение строки с параметрами из словаря
- [RouteMeasurer](#routemeasurer) - вычисление расстояния между двумя координатами
- [SettingsRouter](#settingsrouter) - позволяет выполнить переход в настройки приложения/устройства
- [AdvancedNavigationStackManagement](#advancednavigationstackmanagement) - расширенная версия методов push/pop у UINavigationController
- [WordDeclinationSelector](#worddeclinationselector) - позволяет получить нужное склонение слова
- [LocalStorage](#localstorage) – утилита для сохранения / удаления / загрузки `Codable` моделей данных в файловую систему
- [GeolocationService](#geolocationservice) – сервис для определения геопозиции пользователя
- [SecurityService](#securityservice)  -  сервис для шифрования и сохранения в keychain/inMemory секретных данных
- [MailSender](#mailsender) - утилита для посылки email сообщений (либо через `MFMailComposeController`, либо через стандартное приложение почты)
- [MoneyModel](#moneymodel) - структура для работы с деньгами
- [MapRoutingService](#maproutingservice) - сервис для построения маршрутов и отображения точек в сторонних навигационных приложениях

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