class VehicleResponse {
  final bool success;
  final int code;
  final String message;
  final List<Category> result;

  VehicleResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  // fromJson method for the ApiResponse class
  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
      success: json['success'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      result: (json['result'] as List<dynamic>)
          .map(
              (category) => Category.fromJson(category as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Category {
  final String category;
  final List<CatValue> values;
  String image;

  Category(
      {required this.category,
      required this.values,
      this.image = 'assets/categories/general_info.svg'});

  // fromJson method for the Category class
  factory Category.fromJson(Map<String, dynamic> json) {
    Category cat = Category(
      category: json['category'] as String,
      values: (json['values'] as List<dynamic>)
          .map((value) => CatValue.fromJson(value as Map<String, dynamic>))
          .toList(),
    );

    cat.image = _mapImageFromCategory(cat.category);

    return cat;
  }
  

  static String _mapImageFromCategory(String value) {
    if (value.isEmpty) return 'assets/categories/general_info.svg';

    if (value.toLowerCase() == 'general'.toLowerCase()) {
      return 'assets/categories/general_info.svg';
    } else if (value.toLowerCase() == 'engine'.toLowerCase()) {
      return 'assets/categories/engine.svg';
    } else if (value.toLowerCase() == 'mechanical / battery'.toLowerCase()) {
      return 'assets/categories/mechanical_battery.svg';
    } else if (value.toLowerCase() ==
        'mechanical / transmission'.toLowerCase()) {
      return 'assets/categories/transmission.svg';
    } else if (value.toLowerCase() == 'interior / seat'.toLowerCase()) {
      return 'assets/categories/interior_seat.svg';
    } else if (value.toLowerCase() == 'exterior / body'.toLowerCase()) {
      return 'assets/categories/exterior_body.svg';
    } else if (value.toLowerCase() == 'exterior / dimension'.toLowerCase()) {
      return 'assets/categories/exterior_dimension.svg';
    } else if (value.toLowerCase() == 'mechanical / drivetrain'.toLowerCase()) {
      return 'assets/categories/general_info.svg';
    } else if (value.toLowerCase() == 'exterior / wheel tire'.toLowerCase()) {
      return 'assets/categories/wheel.svg';
    } else if (value.toLowerCase() == 'mechanical / brake'.toLowerCase()) {
      return 'assets/categories/brake.svg';
    } else if (value.toLowerCase() == 'Exterior / Bus'.toLowerCase()) {
      return 'assets/categories/general_info.svg';
    } else if (value.toLowerCase() == 'exterior / trailer'.toLowerCase()) {
      return 'assets/categories/general_info.svg';
    } else if (value.toLowerCase() ==
        'mechanical / battery / charger'.toLowerCase()) {
      return 'assets/categories/transmission.svg';
    } else if (value.toLowerCase() ==
        'passive safety system / air bag location'.toLowerCase()) {
      return 'assets/categories/air_bag.svg';
    } else if (value.toLowerCase() == 'Interior'.toLowerCase()) {
      return 'assets/categories/Interior.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / Maintaining Safe Distance'.toLowerCase()) {
      return 'assets/categories/active_safety_safe_distance.svg';
    } else if (value.toLowerCase() == 'Active Safety System'.toLowerCase()) {
      return 'assets/categories/active_safety.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / Backing Up and Parking'.toLowerCase()) {
      return 'assets/categories/backing_up_parking.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / Lighting Technologies'.toLowerCase()) {
      return 'assets/categories/lighting_technology.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / Lane and Side Assist'.toLowerCase()) {
      return 'assets/categories/lane_side_assist.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / Forward Collision Prevention'.toLowerCase()) {
      return 'assets/categories/collision_prevention.svg';
    } else if (value.toLowerCase() ==
        'Active Safety System / 911 Notification'.toLowerCase()) {
      return 'assets/categories/notif_911.svg';
    } else if (value.toLowerCase() == 'Passive Safety System'.toLowerCase()) {
      return 'assets/categories/passive_safety_system.svg';
    } else {
      return 'assets/categories/general_info.svg';
    }
  }
}

class CatValue {
  final String key;
  final String? value;

  CatValue({required this.key, this.value});

  // fromJson method for the Value class
  factory CatValue.fromJson(Map<String, dynamic> json) {
    return CatValue(
      key: json['key'] as String,
      value: json['value'] as String?,
    );
  }
}
