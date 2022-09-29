[![GitHubActions Build Status](https://github.com/surfstudio/iOS-Utils/workflows/CI/badge.svg)](https://github.com/surfstudio/iOS-Utils/actions)
[![codecov](https://codecov.io/gh/surfstudio/iOS-Utils/branch/master/graph/badge.svg)](https://codecov.io/gh/surfstudio/iOS-Utils)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/SurfUtils.svg?style=flat)](https://cocoapods.org/pods/SurfUtils)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-blue.svg)](https://github.com/apple/swift-package-manager)
# iOS-Utils

Utils collection for iOS-development. Each utility is a small and frequently used piece of logic or UI component.

[![iOS-Utils](https://i.ibb.co/vsGyFx7/Group-48095987.png)](https://github.com/surfstudio/iOS-Utils)

## About

В повседневной работе часто применяются одни и те же устоявшиеся решения, участки логики. Именно они и вынесены в данную библиотеку: проверенные временем решения, охватывающие весь спектр разработки - от небольших хелперов или оберток над системными API, до полноценных UI-компонентов.

## Installation

#### CocoaPods

Для добавления всех утилит, добавьте в свой Podfile следующую строку, затем запустите `pod install`

```ruby
pod 'SurfUtils'
```

Для установки конкретной утилиты $UTIL_NAME необходимо добавить следующий код в ваш `Podfile`, затем запустить `pod install`

```ruby
pod 'SurfUtils/$UTIL_NAME$'
```

#### Swift Package Manager

- В XCode пройдите в `File > Add Packages...`
- Введите URL репозитория `https://github.com/surfstudio/iOS-Utils.git`

## Features

- Различные UI-компоненты и утилиты, завязанные на UIKit - [документация](TechDocs/uikit_utils.md)
- Хелперы, небольшие утилиты и сервисы - [документация](TechDocs/services_utils.md)

Самое полезное и наиболее часто используемое:

- [StringAttributes](TechDocs/services_utils.md#stringattributes) - упрощение работы с `NSAttributedString`
- [KeyboardPresentable](TechDocs/uikit_utils.md#keyboardpresentable) - семейство протоколов для упрощения работы с клавиатурой и сокращения количества одинакового кода
- [SkeletonView](TechDocs/uikit_utils.md#skeletonview) - cпециальная кастомная View для создания skeleton loader'ов
- [XibView](TechDocs/uikit_utils.md#xibview) - для работы UIView + xib
- [CommonButton](TechDocs/uikit_utils.md#commonbutton) - Базовый класс для кнопки
- [UIDevice](TechDocs/uikit_utils.md#uidevice) – набор вспомогательных методов для определения типа девайса 
- [UIStyle](TechDocs/uikit_utils.md#uistyle) – класс для удобной работы с разными стилями UIView наследников
- [LoadingView](TechDocs/uikit_utils.md#loadingview) - набор классов и протоколов для удобного отображения загрузочных состояний с шиммерами

## Example

Все вышеперечисленное можно увидеть в Example-проекте. Для его корректного запуска и конфигурации скачайте репозиторий и выполните команду `make init` перед тем как его запустить.

## Changelog

Список всех изменений можно посмотреть в этом [файле](./CHANGELOG.md).

## License

[MIT License](./LICENSE)