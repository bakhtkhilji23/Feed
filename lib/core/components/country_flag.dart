import 'package:flutter/material.dart';

import 'network_image.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({
    Key? key,
    required this.countryCode,
  }) : super(key: key);

  final String countryCode;

  @override
  Widget build(BuildContext context) {
    final url = 'https://countryflagsapi.com/png/$countryCode';
    return SizedBox(
      width: 50,
      height: 50,
      child: NetworkImageWithLoader(
        url,
        fit: BoxFit.contain,
        radius: 4,
      ),
    );
  }
}
