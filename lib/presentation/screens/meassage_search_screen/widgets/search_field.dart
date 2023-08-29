import 'package:flutter/material.dart';
import 'package:hotspot/applications/provider/search_provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        Provider.of<GetallUsersProvider>(context, listen: false)
            .searchlist(value);
      },
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        labelText: 'Search',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            Provider.of<GetallUsersProvider>(context, listen: false)
                .searchlist('');
          },
        ),
      ),
    );
  }
}