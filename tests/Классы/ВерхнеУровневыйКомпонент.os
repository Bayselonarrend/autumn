Перем _КомпонентНижнегоУровня;

Функция КомпонентНижнегоУровня() Экспорт
	Возврат _КомпонентНижнегоУровня;
КонецФункции

&Компонент
Процедура ПриСозданииОбъекта(
	&Зависимость("КомпонентНижнегоУровня") КомпонентНижнегоУровня
)
	_КомпонентНижнегоУровня = КомпонентНижнегоУровня;
КонецПроцедуры