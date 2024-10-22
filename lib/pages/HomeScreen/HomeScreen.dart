// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:info_bitcoin/Services/crypto_service.dart';
import 'package:info_bitcoin/pages/custom/search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<dynamic>> _cryptoData;
  List<dynamic> _filteredCryptos = []; // Lista filtrada

  @override
  void initState() {
    super.initState();
    _cryptoData = CryptoService().getCryptos();  

    _searchController.addListener(_filterCryptos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCryptos);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCryptos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCryptos = _cryptoData.then((cryptos) {
        return cryptos.where((crypto) {
          final cryptoName = crypto['name'].toLowerCase();
          return cryptoName.contains(query);
        }).toList();
      }) as List;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: _searchController,
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
                  future: _cryptoData,
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

                    if (_filteredCryptos.isEmpty) {
                      _filteredCryptos = snapshot.data!;
                    }

                    return ListView.builder(
                      itemCount: _filteredCryptos.length,
                      itemBuilder: (context, index) {
                        var crypto = _filteredCryptos[index];
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
