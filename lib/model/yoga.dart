class YogaCourse {
  final String name;
  final String image;
  final List<YogaPose> scheduled;

  YogaCourse({
    required this.name,
    required this.image,
    required this.scheduled,
  });

  factory YogaCourse.fromJson(Map<String, dynamic> json) {
    List<YogaPose> poses = [];
    if (json['scheduled'] != null) {
      poses = List.from(json['scheduled'])
          .map((poseJson) => YogaPose.fromJson(poseJson))
          .toList();
    }

    return YogaCourse(
      name: json['name'],
      image: json['image'],
      scheduled: poses,
    );
  }
}

class YogaPose {
  final String sanskritName;
  final String englishName;
  final String description;
  final String time;
  final String image;
  final String benefits;
  final String variations;
  final String category;
  final String target;
  final String steps;

  YogaPose({
    required this.sanskritName,
    required this.englishName,
    required this.description,
    required this.time,
    required this.image,
    required this.benefits,
    required this.variations,
    required this.category,
    required this.target,
    required this.steps,
  });

  factory YogaPose.fromJson(Map<String, dynamic> json) {
    return YogaPose(
      sanskritName: json['sanskrit_name'],
      englishName: json['english_name'],
      description: json['description'],
      time: json['time'],
      image: json['image'],
      benefits: json['benefits'],
      variations: json['variations'],
      category: json['category'],
      target: json['target'],
      steps: json['steps'],
    );
  }
}
