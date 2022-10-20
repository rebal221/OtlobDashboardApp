class FoodWidgetModel {
  String name = '';
  double price = 0.0;
  double count = 0.0;

  FoodWidgetModel(this.name);
  FoodWidgetModel.info(
      {required this.name, required this.price, required this.count});

  String foodAsString() {
    return name;
  }
}
