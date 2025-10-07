// Импортируем библиотеку Material Design для Flutter-приложений
import 'package:flutter/material.dart';

// Абстрактный интерфейс класса, определяющего поведение выбора элементов
abstract interface class Pickable {
  // Набор строковых значений меню (например, пункты выпадающего списка)
  Set<String> menu = {};

  // Набор динамических возвращаемых значений (результаты выборки)
  Set<dynamic> ret = {};

  // Метод для выбора одиночного элемента
  // Возвращает выбранный элемент или null, если ничего не выбрано
  String? pick(BuildContext bc) {
    return null;
  }

  // Метод для множественного выбора элементов
  // Если указан список начальных выборов (initialSelections),
  // возвращает выбранные элементы или null, если ничего не выбрано
  Set<String>? pickmany(BuildContext bc, [List<String>? initialSelections]) {
    return null;
  }
}