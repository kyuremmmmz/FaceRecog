class Aimodel {
  final num distance;
  final String? message;

  Aimodel({required this.distance, required this.message});
  
  factory Aimodel.fromJson(Map<String, dynamic> json) {
    return Aimodel(
      distance: json['distance'],
      message: json['message'],
    );
  }
}
