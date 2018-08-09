# iOS-Utils

Этот репоиторий содержит коллекцию утилит, каждая из которых находится в отдельной `pod subspec`. 
Обновление версии любой утилиты означает обновление версии всего репозитория.

## Как установить

Для установки любой из утилит необходимо добавить следующий код в ваш `Podfile`

`pod 'Surf-Utils/$UTIL_NAME$' :git => "https://github.com/surfstudio/iOS-Utils.git"`

## Список утилит

- [StringAttributes](#stringattributes)


## Утилиты

### StringAttributes

Утилита для упрощения работы с `NSAttributedString`

Пример:
```Swift
let attrString = "Awesome attributed srting".with(attributes: [.kern(9), lineHeight(20)])
```
