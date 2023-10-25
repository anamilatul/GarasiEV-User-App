import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';

class SearchBrand extends StatefulWidget {
  const SearchBrand({super.key});

  @override
  State<SearchBrand> createState() => _SearchBrandState();
}

class _SearchBrandState extends State<SearchBrand> {
  TextEditingController _searchController = TextEditingController();
  List filteredDataMenu = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        elevation: 1,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          onChanged: (query) {
            // modelCategory.search(query);
          },
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: poppinsRegular.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorResources.black,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.clear,
              size: 20,
              color: ColorResources.black,
            ),
            onPressed: () {
              _searchController.clear();
              // modelCategory.clearSearch();
            },
          ),
        ],
      ),
      body: Center(child: Text("data")),
    );
  }
}
