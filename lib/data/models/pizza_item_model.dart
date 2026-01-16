
class PizzaItemModel {
  final String? id;
  final String cartItemId;
  final String name;
  final String description;
  final double basePrice;
  final String? icon;

  final List<PizzaItemModel> options;
  final List<PizzaItemModel> selectOptions;
  final int quantity;

  const PizzaItemModel({
    this.id,
    String? cartItemId,
    this.name = '',
    this.description = '',
    this.basePrice = 0.0,
    this.icon,
    this.options = const [],
    this.selectOptions = const [],
    this.quantity = 1,
  }) : cartItemId = cartItemId ?? '';

  PizzaItemModel copyWith({
    List<PizzaItemModel>? selectOptions,
    int? quantity,
  }) {
    return PizzaItemModel(
      id: id,
      cartItemId: cartItemId,
      name: name,
      description: description,
      basePrice: basePrice,
      icon: icon,
      options: options,
      selectOptions: selectOptions ?? this.selectOptions,
      quantity: quantity ?? this.quantity,
    );
  }

  PizzaItemModel cloneForCart() {
    return PizzaItemModel(
      id: id,
      cartItemId: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      description: description,
      basePrice: basePrice,
      icon: icon,
      quantity: 0,
      selectOptions: [],
      options: options,
    );
  }
  factory PizzaItemModel.fromJson(Map<String, dynamic> json) {
    return PizzaItemModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      basePrice: (json["basePrice"] ?? 0).toDouble(),
      icon: json["icon"],
      quantity: json["quantity"] ??0 ,
      options:
      (json["options"] as List<dynamic>?)
          ?.map((e) => PizzaItemModel.fromJson(e))
          .toList() ??
          [],
      selectOptions:
      (json["selectOptions"] as List<dynamic>?)
          ?.map((e) => PizzaItemModel.fromJson(e))
          .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "basePrice": basePrice,
      "icon": icon,
      "quantity": quantity,
      "options": options.map((e) => e.toJson()).toList(),
      "selectOptions": selectOptions.map((e) => e.toJson()).toList(),
    };
  }
}
