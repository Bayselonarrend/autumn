Перем Элементы;

Процедура ПриРазворачиванииАннотации(ОпределениеАннотации, ПодчиненныеАннотации, ТипВладельцаСвойств, Свойство) Экспорт

	Аннотация = РаботаСАннотациями.НайтиАннотацию(ПодчиненныеАннотации, "Пластилин");
	Аннотация.Параметры[1].Значение = Элементы;
	
КонецПроцедуры

&Аннотация("КонструкторМассива")
&Пластилин(Значение = "КонструкторМассива", Блестяшка = "")
Процедура ПриСозданииОбъекта(Значение = "", &Повторяемый Элемент = Неопределено)
	Элементы = Элемент;
КонецПроцедуры