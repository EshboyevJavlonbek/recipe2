import 'package:recipe/core/client.dart';

import '../model/top_chef_model.dart';
import '../model/top_chef_model_small.dart';

class ChefRepository {
  ChefRepository({required this.client});

  final ApiClient client;
  List<TopChefModelSmall> topChefs = [];

  List<TopChefModel> mostViewedChefs = [];
  List<TopChefModel> mostLikedChefs = [];
  List<TopChefModel> newChefs = [];

  Future<List<TopChefModelSmall>> fetchTopChefsForHome({int? limit}) async {
    var rawChef = await client.fetchTopChefsForHome(limit: limit);
    topChefs = rawChef.map((chef) => TopChefModelSmall.fromJson(chef)).toList();
    return topChefs;
  }

  Future<List<TopChefModel>> fetchMostViewedChefs() async {
    var rawMostViewedChefs = await client.genericGetRequest<List<dynamic>>(
      '/top-chefs/list',
      queryParams: {"Order": "Date", "Limit": 2, "Descending": false},
    );
    mostViewedChefs = rawMostViewedChefs.map((chef) => TopChefModel.fromJson(chef)).toList();
    return mostViewedChefs;
  }

  Future<List<TopChefModel>> fetchMostLikedChefs() async {
    var rawMostLikedChefs = await client.genericGetRequest<List<dynamic>>(
      '/top-chefs/list',
      queryParams: {"Limit": 2},
    );
    mostLikedChefs = rawMostLikedChefs.map((chef) => TopChefModel.fromJson(chef)).toList();
    return mostLikedChefs;
  }

  Future<List<TopChefModel>> fetchNewChefs() async {
    var rawNewChefs = await client.genericGetRequest<List<dynamic>>(
      '/top-chefs/list',
      queryParams: {"Order": "Date", "Limit": 2},
    );
    newChefs = rawNewChefs.map((chef)=> TopChefModel.fromJson(chef)).toList();
    return newChefs;
  }
}
