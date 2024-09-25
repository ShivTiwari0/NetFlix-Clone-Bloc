class MovieModel {
  final String? name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final String? status;
  final int? runtime;
  final String? premiered;
  final String? officialSite;
  final Rating? rating;
  final Network? network;
  final Imagee? image; // Parsing the nested Image object
  final String? summary;

  MovieModel({
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.premiered,
    this.officialSite,
    this.rating,
    this.network,
    this.image,
    this.summary,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Parse the nested 'show' object
    final show = json['show'] as Map<String, dynamic>?;

    return MovieModel(
      name: show?['name'] as String?,
      type: show?['type'] as String?,
      language: show?['language'] as String?,
      genres: (show?['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: show?['status'] as String?,
      runtime: show?['runtime'] as int?,
      premiered: show?['premiered'] as String?,
      officialSite: show?['officialSite'] as String?,
      rating: show?['rating'] != null ? Rating.fromJson(show!['rating']) : null,
      network: show?['network'] != null ? Network.fromJson(show!['network']) : null,
      image: show?['image'] != null ? Imagee.fromJson(show!['image']) : null, // Properly handling the image field
      summary: show?['summary'] as String?,
    );
  }
}
class Imagee {
  final String? medium;
  final String? original;

  Imagee({
    this.medium,
    this.original,
  });

  factory Imagee.fromJson(Map<String, dynamic> json) {
    return Imagee(
      medium: json['medium'] as String?,
      original: json['original'] as String?,
    );
  }
}

class Network {
  final String? name;
  final Country? country;

  Network({
    this.name,
    this.country,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      name: json['name'] as String?,
      country: json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }
}

class Country {
  final String? name;
  final String? code;
  final String? timezone;

  Country({
    this.name,
    this.code,
    this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String?,
      code: json['code'] as String?,
      timezone: json['timezone'] as String?,
    );
  }
}

class Rating {
  final double? average;

  Rating({
    this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: (json['average'] as num?)?.toDouble(),
    );
  }
}