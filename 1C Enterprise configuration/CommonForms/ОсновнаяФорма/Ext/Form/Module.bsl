
#Область ОбработчикиСобытийФормы

&НаКлиенте
Асинх Процедура ПриОткрытии(Отказ)
	
	// Получение текста макета HTML.
	ТекстМакета = ТекстМакета("МакетReact");  
	
	// Создание файла из макета, содержащего код JavaScript.
	ИмяВременногоФайлаJs = ПолучитьИмяВременногоФайла("js");
	
	ОсновнойJavaScript = ДанныеМакета("ОсновнойJavaScript");
	Обещание = ОсновнойJavaScript.ЗаписатьАсинх(ИмяВременногоФайлаJs);
	Результат = Ждать Обещание;
	
	// Получение текста макета содержащего стили.
	ТекстСтилей = ТекстМакета("ОсновнойCSS");  

	// Редактируем текст макета и загружаем в поле HTML.
	ПолеHTML = СтрШаблон(ТекстМакета, ИмяВременногоФайлаJs, ТекстСтилей); 	
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПолеHTMLДокументСформирован(Элемент)
	
	Если НЕ Элементы.ПолеHTML.Документ.readyState = "complete" Тогда
		Возврат;
 	КонецЕсли;
	
	ОкноHTML = Элементы.ПолеHTML.Документ.defaultView; 
	Если ОкноHTML = Неопределено Тогда
	    Возврат;
	КонецЕсли; 
	
	МассивПродаж = ДанныеПродаж(); 
	Для каждого Продажа Из МассивПродаж Цикл
		
		//AddItem (id, name, data1, data2, data3, data4, data5)
		ОкноHTML.AddItem(
			Продажа.ИдентификаторСчетФактуры, 
			Продажа.ИдентификаторСчетФактуры, 
			Строка(Формат(Продажа.ДатаПокупки, "ДФ=dd.MM.yyyy")) 
				+ " " + Строка(Формат(Продажа.ВремяПокупки, "ДФ=ЧЧ:мм:сс; ДЛФ=D")),
			Продажа.Город + " (" + Продажа.Филиал + ")", 
			Продажа.ВидНоменклатуры,
			Продажа.ВидОплаты, 
			Продажа.Сумма
		);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ТекстМакета(ИмяМакета) 

	Возврат ПолучитьОбщийМакет(ИмяМакета).ПолучитьТекст();

КонецФункции                             

&НаСервереБезКонтекста
Функция ДанныеМакета(ИмяМакета) 

	Возврат ПолучитьОбщийМакет(ИмяМакета);

КонецФункции   

&НаСервереБезКонтекста
Функция ДанныеПродаж()
	
	МассивПродаж = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ДанныеПродаж.ИдентификаторСчетФактуры КАК ИдентификаторСчетФактуры,
		|	ДанныеПродаж.ДатаПокупки КАК ДатаПокупки,
		|	ДанныеПродаж.ВремяПокупки КАК ВремяПокупки,
		|	ДанныеПродаж.Город КАК Город,
		|	ДанныеПродаж.Филиал КАК Филиал,
		|	ДанныеПродаж.ВидНоменклатуры КАК ВидНоменклатуры,
		|	ДанныеПродаж.ВидОплаты КАК ВидОплаты,
		|	ДанныеПродаж.Сумма КАК Сумма
		|ИЗ
		|	РегистрСведений.ДанныеПродаж КАК ДанныеПродаж"; 
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		ДанныеПродаж = Новый Структура("ИдентификаторСчетФактуры, ДатаПокупки, ВремяПокупки, Город, Филиал, ВидНоменклатуры, ВидОплаты, Сумма");
		ЗаполнитьЗначенияСвойств(ДанныеПродаж, Выборка);
		
		МассивПродаж.Добавить(ДанныеПродаж);
		
	КонецЦикла;
	
	Возврат МассивПродаж;
	
КонецФункции

#КонецОбласти