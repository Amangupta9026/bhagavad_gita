import 'package:flutter/cupertino.dart';

import '../../utils/file_collection.dart';

class SearchItemTextField extends StatelessWidget {
  const SearchItemTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      decoration: InputDecoration(
        filled: true,
        hintText: "Search courses",
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          width: 52,
          height: 40,
          child: const Icon(
            CupertinoIcons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
