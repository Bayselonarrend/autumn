Перем _Поделка;
Перем _Рефлектор;

Процедура РазвернутьАннотацииСвойства(Свойство, ТипВладельцаСвойства) Экспорт

	ОпределенияАннотаций = _Поделка.ПолучитьОпределенияАннотаций();
	Аннотации = Свойство.Аннотации;
	НакопленныеАннотации = Свойство.Аннотации.СкопироватьКолонки();

	РазвернутьАннотации(ОпределенияАннотаций, Аннотации, НакопленныеАннотации, Строка(ТипВладельцаСвойства));

	Свойство.Аннотации = НакопленныеАннотации;
	
КонецПроцедуры

Процедура РазвернутьАннотацииСвойств(Свойства, ТипВладельцаСвойств) Экспорт

	Для Каждого Свойство Из Свойства Цикл
		РазвернутьАннотацииСвойства(Свойство, ТипВладельцаСвойств);
	КонецЦикла;

КонецПроцедуры

Процедура РазвернутьАннотации(
	ОпределенияАннотаций,
	Аннотации,
	НакопленныеАннотации,
	ИмяТипаАннотации,
	УровеньВложенности = 1
)
	
	Для Каждого Аннотация Из Аннотации Цикл

		НоваяАннотация = НакопленныеАннотации.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяАннотация, Аннотация);

		ОпределениеАннотации = ОпределенияАннотаций.Получить(НРег(Аннотация.Имя));

		Если ОпределениеАннотации = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		// Проверяем только аннотации на самом верхнем уровне вложенности, 
		// т.к. остальные проверяются при регистрации аннотации.
		Если УровеньВложенности = 1 Тогда
			ОпределениеАннотации.Проверить(Аннотация, ИмяТипаАннотации);
			
			ПараметрыКонструктора = Новый Массив;
			Для Каждого Параметр Из ОпределениеАннотации.Параметры() Цикл
				ЗначениеПараметра = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, Параметр.Имя, Параметр.ЗначениеПоУмолчанию, Истина);
				ПараметрыКонструктора.Добавить(ЗначениеПараметра);
			КонецЦикла;

			ОбъектАннотации = Новый(ОпределениеАннотации.ИмяТипаАннотации(), ПараметрыКонструктора);
			Если _Рефлектор.МетодСуществует(ОбъектАннотации, "ПриРазворачиванииАннотации") Тогда
				ОбъектАннотации.ПриРазворачиванииАннотации(ОпределениеАннотации);
			КонецЕсли;
		КонецЕсли;
		
		Если НРег(Аннотация.Имя) <> НРег("Аннотация") Тогда
			РазвернутьАннотации(
				ОпределенияАннотаций,
				ОпределениеАннотации.Аннотации(),
				НакопленныеАннотации,
				ИмяТипаАннотации,
				УровеньВложенности + 1
			);

			Продолжить;
		КонецЕсли;

		ТипЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, "Тип", Неопределено, Истина);
		Если ТипЖелудя <> Неопределено Тогда
			// Проверим, что корневая аннотация была добавлена на уровне выше
			Если РаботаСАннотациями.НайтиАннотацию(НакопленныеАннотации, ТипЖелудя) = Неопределено Тогда

				ОпределениеАннотацииТипаЖелудя = ОпределенияАннотаций.Получить(НРег(ТипЖелудя));
				
				НоваяАннотация = НакопленныеАннотации.Добавить();
				НоваяАннотация.Имя = НРег(ТипЖелудя);
				НоваяАннотация.Параметры = Аннотация.Параметры.СкопироватьКолонки();
				
				Для Каждого ПараметрМетодаАннотации Из ОпределениеАннотацииТипаЖелудя.Параметры() Цикл
					Если НРег(ПараметрМетодаАннотации.Имя) = НРег("Значение") Тогда
						// Корневое "значение" не добавляем, т.к. оно может быть переопределено в фабрике желудей
						Продолжить;
					КонецЕсли;
					ПараметрЗначение = НоваяАннотация.Параметры.Добавить();
					ПараметрЗначение.Имя = ПараметрМетодаАннотации.Имя;
					Если ПараметрМетодаАннотации.ЕстьЗначениеПоУмолчанию Тогда
						ПараметрЗначение.Значение = ПараметрМетодаАннотации.Значение;
					КонецЕсли;
					// todo: Значение параметра?
				КонецЦикла;

			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры

&Желудь
Процедура ПриСозданииОбъекта(&Пластилин Поделка)
	_Поделка = Поделка;
	_Рефлектор = Новый Рефлектор();
КонецПроцедуры
