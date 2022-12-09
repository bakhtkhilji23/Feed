import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class SearchTextFieldWithButton extends StatelessWidget {
  const SearchTextFieldWithButton({
    Key? key,
    required this.formKey,
    required this.onSubmit,
    required this.controller,
    required this.dateChosen,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final void Function() onSubmit;
  final bool dateChosen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'search_field'.tr(),
                hintText: 'search_hint'.tr(),
                prefixIcon: const Icon(IconlyLight.search),
              ),
              validator: (v) {
                if ((v == null || v == '') && (dateChosen == false)) {
                  return 'Words are required';
                }
                return null;
              },
              onFieldSubmitted: (v) => onSubmit(),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(IconlyLight.search),
            label: Text('search'.tr()),
          ),
        ),
      ],
    );
  }
}
