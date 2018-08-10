[![codebeat badge](https://codebeat.co/badges/c2deb19a-3be3-4dd8-aa3d-886e0f361bea)](https://codebeat.co/projects/github-com-surfstudio-ios-utils-master)
[![Build Status](https://travis-ci.org/surfstudio/iOS-Utils.svg?branch=master)](https://travis-ci.org/surfstudio/iOS-Utils)
# iOS-Utils

Этот репозиторий содержит коллекцию утилит, каждая из которых находится в отдельной `pod subspec`. 
Обновление версии любой утилиты означает обновление версии всего репозитория.

## Как установить

Для установки любой из утилит необходимо добавить следующий код в ваш `Podfile`

```Ruby
pod 'Surf-Utils/$UTIL_NAME$' :git => "https://github.com/surfstudio/iOS-Utils.git"
```

## Список утилит

- [StringAttributes](#stringattributes) - упрощение работы с `NSAttributedString`


## Утилиты

### StringAttributes

Утилита для упрощения работы с `NSAttributedString`

Пример:
```Swift
let attrString = "Awesome attributed srting".with(attributes: [.kern(9), lineHeight(20)])
```
## Версионирование

В качестве принципа версионирования используется [Семантическое версионирования (Semantic Versioning)](https://semver.org/).

Если вкратце, то версии обозначаются в формате `x.y.z` где
- х мажорный номер версии. Поднимается только в случае мажорных обновлений (изменения в интерфейсах, добавление новой функциональности, добавление новой утилиты)
- y минорный номер версии. Поднимается только в случае минорных обновлений (изменения в имплементации, не влияющие на интерфейсы)
- z минорный номер версии. Поднимается в случае незначительных багфиксов и т.п.
