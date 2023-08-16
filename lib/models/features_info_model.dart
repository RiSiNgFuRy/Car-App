class Features {
  String? type;
  String? engine;
  String? material;
  String? brakes;
  String? mileage;
  String? topSpeed;
  String? numberOfSeats;

  Features(
      {this.type,
        this.engine,
        this.material,
        this.brakes,
        this.mileage,
        this.topSpeed,
        this.numberOfSeats});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    engine = json['engine'];
    material = json['material'];
    brakes = json['brakes'];
    mileage = json['mileage'];
    topSpeed = json['topSpeed'];
    numberOfSeats = json['numberOfSeats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['engine'] = this.engine;
    data['material'] = this.material;
    data['brakes'] = this.brakes;
    data['mileage'] = this.mileage;
    data['topSpeed'] = this.topSpeed;
    data['numberOfSeats'] = this.numberOfSeats;
    return data;
  }
}