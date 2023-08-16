# Changelog

## 13.2.0 - [Backward compatibility для lineHeight атрибута StringAttributes](https://github.com/surfstudio/iOS-Utils/releases/tag/13.2.0)

- В StringAttributes добавлен параметр `oldLineHeight`
- Работает как предыдущий параметр `lineHeight` (устанавливает `paragraphStyle.lineSpacing` как разницу между переданным значением и `font.lineHeight`, только `font` находит среди других переданных к применению атрибутов)

## 13.1.0 - [Правки проекта, AttributedString updates](https://github.com/surfstudio/iOS-Utils/releases/tag/13.1.0)

- Добавлен параметр `paragraphSpacing` в `AttributedString`
- Правки проекта, добавлен Example проект
- Удалена утилита `OTPField`

> Закрыт [issue](https://github.com/surfstudio/iOS-Utils/issues/91)

## 13.0.0 - [MapRoutingService и правки для StringAttributes](https://github.com/surfstudio/iOS-Utils/releases/tag/13.0.0)

В новой версии появилась утилита MapRoutingService, которая позволяет получить список приложений для работы с навигацией, установленных на устройстве пользователя, а также отобразить точку/построить маршрут до заданной точки в одном из них. (ссылка на PR)

Но самая важная правка в StringAttributes. Изменения коснулись атрибута lineHeight, отвечающего за высоту строки:

- раньше необходимо было задачть два параметра - font и lineHeight из фигмы, на основе которых задавалось расстояние между строками (lineSpacing)
- теперь достаточно только одного - lineHeight из той же фигмы, на основе которого будет задаваться
	- либо lineHeightMultiple как соотношение paragraph.lineHeightMultiple = lineHeight / font.lineHeight, если среди других атрибутов строки будет передан font
	- либо minimumLineHeight и maximumLineHeight, если font среди других атрибутов передаваться не будет

#### Обратите внимание!

Поясню проблемы при миграции на примере. У нас есть текст, кегль шрифта например 16, системная font.lineHeight его при этом равняется 18, а нам нужно чтобы она была 20. Мы передавали атрибут .lineHeight(20, font). Теперь достаточно только .lineHeight(20), с условием что атрибут .font(...) будет передан отдельно, что обычно и бывает. Проблема:

- при старом подходе, когда атрибут задавал межстрочное расстояние, высота одной строки всегда равнялась 18. Двух - 38 (20+18), трех 58... то есть lineHeight * (кол-во строк - 1) + font.lineHeight. Но фигма работает по другому, она тупо умножает lineHeight на кол-во строк
- новый подход будет работать так, как работают размеры в фигме - кол-во строк умножить на параметр атрибута lineHeight

В силу чего ваш дизайн может поехать, простите) Варианта два:

- при миграции явно указывать lineSpacing, чтобы остаться со старым вариантом layout-а
- перейти на новый подход, отладить и жить дальше в шоколаде, зная что высоты текстовых контейнеров у вас будут один-в-один как фигме)

## 12.1.0 - [Обновление UIDevice](https://github.com/surfstudio/iOS-Utils/releases/tag/12.1.0)

Сборка с обновлениями для утилиты UIDevice. В сборку вошли

- LayoutHelper iPad support
- Поправить issue с Device

Фактически, переходим на собственную поддержку и развитие не поддерживаемой более библиотеки [Device](https://github.com/Ekhoo/Device)

## 11.1.0 - [Поддержка SPM и baseLine в StringBuilder](https://github.com/surfstudio/iOS-Utils/releases/tag/11.1.0)

- Добавлена возможность установить Bundle вне функции в методах загрузки View.
- Добавлена поддержка SPM, но только для iOS и для всех утилит сразу (то есть можно подключить все утилиты сразу через SPM, по отдельности пока нет возможности)
- Для CI добавлена проверка корректности поддержки SPM
- В StringAttribute добавлен параметр baselineOffset
- В StringBuilder добавлена функция .add в для добавления NSAttributedString