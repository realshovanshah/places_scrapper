import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

import "package:google_place/google_place.dart";

import 'keys.dart';
import "models.dart";

const kPlacesUrl = "https://maps.googleapis.com/maps/api/place";

const restaurantList = [
// "China Town Restaurant",
// "Korean Kitchen Picnic",
// "Irish Pub",
// "Momo Karma",
// "Buddha Bar",
// "Vivi Kathmandu",
// "Oscar Bar & Grill",
// "Carpe Diem Lounge & Bakery",
// // "Devalaya", not found
// "Villa Everest",
// "Bawarchi Restro",
// "Ashram Restaurant",
// "Bota Momo",
// "Sierra kathmandu",
"Momotarou Japanese",
"Samrat Cafe",
"Dhokaima Cafe",
"Bajeko Sekuwa",
"Dhokaima Cafe",
"Firefly Restro Bar",
"Cafe Luwak",
"Funko Tandoori Cafe",
"Social Cafe",
  "Kastha Vista",
  "The Old Alley",
  "Cafe de Tukche",
  "Cafe Soma",
  "House of Wings",
  "Fresh Farms",
  "Tropical Rest",
  "Chicken Station",
];

Future<void> main(List<String> arguments) async {
//  for (var restaurant in restaurantList) {
//    await addRestaurantToCsv(restaurant);
//   }
  final restaurant = await getPlace('Himalayan Java');
  print(restaurant);
}

Future<void> addRestaurantToCsv(String restaurant) async {
  print("Scraping $restaurant");
  final restaurantData = await getPlace(restaurant);
  final formattedValue =
      '"${restaurantData.name}","${restaurantData.place_id}", "${restaurantData.plus_code?.global_code}", "${restaurantData.formatted_address}", "${restaurantData.formatted_phone_number}", "${restaurantData.opening_hours?.weekday_text}", "${restaurantData.geometry?.location.toString()}", "${restaurantData.website}", "${restaurantData.photos?.map((e) => imageUrl(e.photo_reference ?? "", kMapsApi) + "\n").toList().toString()}", "${PriceLevel.values[(restaurantData.price_level ?? -1) + 1].toString().split(".").last}", "${restaurantData.rating}", "${restaurantData.types.toString()}", "${restaurantData.reviews.toString()}", "${restaurantData.user_ratings_total}"';
  appendToFile(formattedValue);
}

Future<Restaurant> getPlace(input) async {
  sleep(Duration(seconds: 1));
  var googlePlace = GooglePlace(kPlacesAPi);
  var result = (await googlePlace.autocomplete.get(input))!.predictions;
  final Iterable<String?> placeId = result!.map((e) => e.placeId);
  return getDetails(
      placeId.firstWhere((element) => element != null, orElse: () => null));
}

/*
POSSIBLE DETAIL FIELDS ARE:
[address_components, adr_address, business_status, formatted_address, formatted_phone_number, geometry, icon, 
icon_background_color, icon_mask_base_uri, international_phone_number, name, opening_hours, photos, place_id, 
plus_code, price_level, rating, reference, reviews, types, url, user_ratings_total, utc_offset, vicinity, website]
*/
Future<Restaurant> getDetails(String? placeId) async {
  print('Fetching Details..');
  try {
    final response = (await http.get(Uri.parse(
            "$kPlacesUrl/details/json?place_id=$placeId&key=$kMapsApi")))
        .body;
    final responseMap = jsonDecode(response)["result"] as Map<String, dynamic>;
    print(jsonDecode(response)["result"].toString());
    return Restaurant.fromMap(responseMap);
  } catch (e, stk) {
    print("Error during the network call $e, $stk");
    return Future.error("Error during the network call");
  }
}

String imageUrl(String photoRef, String apiKey) =>
    "$kPlacesUrl/photo?maxwidth=1000&photo_reference=$photoRef&key=$apiKey";

/*format: place_id, plus_code, formatted_address, formatted_phone_number, name, opening_hours, geometry, website, photos, price_level, rating, types, reviews, user_ratings_total*/
void appendToFile(String data) {
  print('Appending to CSV');
  var file = File("file.csv");
  var sink = file.openWrite(mode: FileMode.append);
  sink.write("\n$data");
  sink.close();
}
