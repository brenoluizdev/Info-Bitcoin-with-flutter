// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:info_bitcoin/pages/HomeScreen/controller/homePage_controller.dart';
import 'package:info_bitcoin/pages/custom/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = HomePageController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InfoBitcoin',
          style: TextStyle(
              fontFamily: 'Bebas', fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        foregroundColor: Colors.orangeAccent,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/details');
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSearchInput(
                      controller: controller.searchController,
                      hintText: 'Pesquisar...',
                      prefixIcon: const Icon(Icons.search, size: 30.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Image.asset(
                      'assets/icons/bitcoin.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: controller.cryptoData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Erro ao carregar dados: ${snapshot.error}'),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhuma criptomoeda encontrada.'));
                    }

                    if (controller.allCryptos.isEmpty && snapshot.data != null) {
                      controller.allCryptos = snapshot.data!;
                      controller.filteredCryptos.value = List.from(controller.allCryptos);
                    }

                    return ValueListenableBuilder<List<dynamic>>(
                      valueListenable: controller.filteredCryptos,
                      builder: (context, filteredCryptos, child) {
                        return ListView.builder(
                          itemCount: filteredCryptos.length,
                          itemBuilder: (context, index) {
                            var crypto = filteredCryptos[index];
                            return ListTile(
                              title: Text(crypto['name']),
                              subtitle: Text('Preço: \$${crypto['current_price']}'),
                              leading: Image.network(
                                crypto['image'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
