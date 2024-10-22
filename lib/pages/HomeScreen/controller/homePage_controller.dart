// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:info_bitcoin/Services/crypto_service.dart';

class HomePageController {
  final TextEditingController searchController = TextEditingController();
  late Future<List<dynamic>> cryptoData;
  List<dynamic> allCryptos = [];
  ValueNotifier<List<dynamic>> filteredCryptos = ValueNotifier([]);

  HomePageController() {
    cryptoData = CryptoService().getCryptos();
    searchController.addListener(_filterCryptos);
  }

  void dispose() {
    searchController.removeListener(_filterCryptos);
    searchController.dispose();
    filteredCryptos.dispose();
  }

  void _filterCryptos() {
    final query = searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      filteredCryptos.value = allCryptos;
    } else {
      filteredCryptos.value = allCryptos.where((crypto) {
        final cryptoName = crypto['name'].toLowerCase().trim();
        return cryptoName.contains(query);
      }).toList();
    }
  }
}
