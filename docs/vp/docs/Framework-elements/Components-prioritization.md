# Приоритизация компонентов с общим алиасом

Но давайте будем честны. Когда мы говорим про Sex Pistols, то в первую очередь вспоминаем Сида Вишеса, и только потом уже Джонни Роттена и остальных. А какой у него получился алко-my-way, ух! Аннотация `&Верховный` подскажет "ОСени", кого вы считаете панком "по умолчанию":

```1c
// file: Классы/ДжонниРоттен.os

&Желудь
&Прозвище("Панк")
Процедура ПриСозданииОбъекта()
КонецПроцедуры

---
// file: Классы/СидВишес.os

&Верховный
&Желудь
&Прозвище("Панк")
Процедура ПриСозданииОбъекта()
КонецПроцедуры
```

Без аннотации `&Верховный` следующий код выдал бы ошибку, но с ней он прекрасно работает:

```1c
Панк = Поделка.НайтиЖелудь("Панк");

Ожидаем.Что(Панк).ИмеетТип("СидВишес");
```