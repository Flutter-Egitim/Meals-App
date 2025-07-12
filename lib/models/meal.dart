enum Complexity {
  simple, // basit
  challenging, // zorlayıcı
  hard, // zor
} // Bu enum meal'in zorluk derecesini temsil eder

enum Affordability {
  affordable, // karşılanabilir
  pricey, // biraz tuzlu
  luxurious, // lüks (pahallı)
} // Bu enum meal'in fiyat aralığını temsil eder

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients; // içindekiler
  final List<String> steps; // yapılış aşamaları
  final int duration; // yemeğin yapılma süresi
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id, // id bilgisi
    required this.categories, // meal'in ait olduğu kategoriler
    required this.title, // meal'in başlığı
    required this.imageUrl, // meal'in görseli
    required this.ingredients, // meal'in içindekiler
    required this.steps, // meal'in hazırlanma adımları
    required this.duration, // meal'in hazırlanma süresi
    required this.complexity, // meal'in zorluk derecesi
    required this.affordability, // meal'in fiyat aralığı
    required this.isGlutenFree, // meal'in glüten içermemesi durumu
    required this.isLactoseFree, // meal'in laktoz içermemesi durumu
    required this.isVegan, // meal'in vegan olması durumu
    required this.isVegetarian, // meal'in vejetaryen olması durumu
  });
}
