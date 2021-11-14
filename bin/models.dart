// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

enum PriceLevel{
  na,
  free,
  inExpensive,
  moderate,
  expensive,
  veryExpensive,
}

class Restaurant {
  final String? place_id;
  final PlusCode? plus_code;
  final String? formatted_address;
  final String? formatted_phone_number;
  final String? name;
  final OpeningHours? opening_hours;
  final Geometry? geometry;
  final String? website;
  final List<Photo>? photos;
  final int? price_level;
  final num rating;
  final List<String>? types;
  // the total no. of reviews/ratings of this place.
  final List<PlaceReview>? reviews;
  final int? user_ratings_total;

  Restaurant({required this.place_id, required this.plus_code, required this.formatted_address, required this.formatted_phone_number, required this.name, required this.opening_hours, required this.geometry, required this.website, required this.photos, required this.price_level, required this.rating, required this.types, required this.reviews, required this.user_ratings_total});


  Map<String, dynamic> toMap() {
    return {
      'place_id': place_id,
      'plus_code': plus_code?.toMap(),
      'formatted_address': formatted_address,
      'formatted_phone_number': formatted_phone_number,
      'name': name,
      'opening_hours': opening_hours?.toMap(),
      'geometry': geometry?.toMap(),
      'website': website,
      'photos': photos?.map((x) => x.toMap()).toList(),
      'price_level': price_level,
      'rating': rating,
      'types': types,
      'reviews': reviews?.map((x) => x.toMap()).toList(),
      'user_ratings_total': user_ratings_total,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      place_id: map['place_id'],
      plus_code: map.containsKey('plus_code') ? PlusCode.fromMap( map['plus_code'] ): null,
      formatted_address: map['formatted_address'],
      formatted_phone_number: map['formatted_phone_number'],
      name: map['name'],
      opening_hours: OpeningHours.fromMap(map['opening_hours']),
      geometry: Geometry.fromMap(map['geometry']),
      website: map['website'],
      photos: List<Photo>.from(map['photos']?.map((x) => Photo.fromMap(x))),
      price_level: map['price_level'],
      rating: map['rating'],
      types: List<String>.from(map['types']),
      reviews: List<PlaceReview>.from(map['reviews']?.map((x) => PlaceReview.fromMap(x))),
      user_ratings_total: map['user_ratings_total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) => Restaurant.fromMap(json.decode(source));

  @override
  String toString() => 'Restaurant(place_id: $place_id, plus_code: $plus_code, formatted_address: $formatted_address, formatted_phone_number: $formatted_phone_number, name: $name, opening_hours: $opening_hours, geometry: $geometry, website: $website, photos: $photos, price_level: $price_level, rating: $rating, types: $types, reviews: $reviews, user_ratings_total: $user_ratings_total)';
}

class Geometry {
  final Location? location;

  Geometry({required this.location});

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: Location.fromMap(map['location']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) => Geometry.fromMap(json.decode(source));

  @override
  String toString() => 'Geometry(location: $location)';
}

class Location {
  final double? lat;
  final double? lng;

  Location({required this.lat, required this.lng});

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));

  @override
  String toString() => 'Location(lat: $lat, lng: $lng)';
}

class OpeningHours {
  final bool? open_now;
  final List<OpenCloseValue>? periods;
  final List<String>? weekday_text;

  OpeningHours({required this.open_now, required this.periods, required this.weekday_text});

  Map<String, dynamic> toMap() {
    return {
      'open_now': open_now,
      'periods': periods?.map((x) => x.toMap()).toList(),
      'weekday_text': weekday_text,
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      open_now: map['open_now'],
      periods: List<OpenCloseValue>.from(map['periods']?.map((x) => OpenCloseValue.fromMap(x))),
      weekday_text: List<String>.from(map['weekday_text']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHours.fromJson(String source) => OpeningHours.fromMap(json.decode(source));

  @override
  String toString() => 'OpeningHours(open_now: $open_now, periods: $periods, weekday_text: $weekday_text)';
}

class OpenCloseValue {
  final DayTime? close;
  final Map? open;

  OpenCloseValue({required this.close, required this.open});

  Map<String, dynamic> toMap() {
    return {
      'close': close?.toMap(),
      'open': open,
    };
  }

  factory OpenCloseValue.fromMap(Map<String, dynamic> map) {
    return OpenCloseValue(
      close: map.containsKey('close')? DayTime.fromMap(map['close']):null,
      open: Map.from(map['open']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenCloseValue.fromJson(String source) => OpenCloseValue.fromMap(json.decode(source));

  @override
  String toString() => 'OpenCloseValue(close: $close, open: $open)';
}

class DayTime {
  final int? day;
  final String? time;

  DayTime({required this.day, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'time': time,
    };
  }

  factory DayTime.fromMap(Map<String, dynamic> map) {
    return DayTime(
      day: map['day'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DayTime.fromJson(String source) => DayTime.fromMap(json.decode(source));

  @override
  String toString() => 'DayTime(day: $day, time: $time)';
}

class Photo {
  final String? photo_reference;

  Photo(this.photo_reference);

  @override
  String toString() => '(photo_reference: $photo_reference)\n';

  Map<String, dynamic> toMap() {
    return {
      'photo_reference': photo_reference,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      map['photo_reference'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Photo.fromJson(String source) => Photo.fromMap(json.decode(source));
}

class PlaceReview {
  final String? author_name;
  final num rating;
  final String? relative_time_description;
  //second since epoch
  final int? time;
  final String? author_url;
  final String? language;
  final String? profile_photo_url;
  final String? text;

  PlaceReview({required this.author_name, required this.rating, required this.relative_time_description, required this.time, required this.author_url, required this.language, required this.profile_photo_url, required this.text});

  

  Map<String, dynamic> toMap() {
    return {
      'author_name': author_name,
      'rating': rating,
      'relative_time_description': relative_time_description,
      'time': time,
      'author_url': author_url,
      'language': language,
      'profile_photo_url': profile_photo_url,
      'text': text,
    };
  }

  factory PlaceReview.fromMap(Map<String, dynamic> map) {
    return PlaceReview(
      author_name: map['author_name'],
      rating: map['rating'],
      relative_time_description: map['relative_time_description'],
      time: map['time'],
      author_url: map['author_url'],
      language: map['language'],
      profile_photo_url: map['profile_photo_url'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceReview.fromJson(String source) => PlaceReview.fromMap(json.decode(source));

  @override
  String toString() => '(author_name: $author_name, rating: $rating, relative_time_description: $relative_time_description, time: $time, author_url: $author_url, language: $language, profile_photo_url: $profile_photo_url, text: $text)\n';
}

class PlusCode {
  final String? global_code;
  final String? compound_code;

  PlusCode({required this.global_code, required this.compound_code});

  

  Map<String, dynamic> toMap() {
    return {
      'global_code': global_code,
      'compound_code': compound_code,
    };
  }

  factory PlusCode.fromMap(Map<String, dynamic> map) {
    return PlusCode(
      global_code: map['global_code'],
      compound_code: map['compound_code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlusCode.fromJson(String source) => PlusCode.fromMap(json.decode(source));

  @override
  String toString() => 'PlusCode(global_code: $global_code, compound_code: $compound_code)';
}
