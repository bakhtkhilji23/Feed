import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SelectProfileImageWidget extends StatefulWidget {
  const SelectProfileImageWidget({
    Key? key,
    required this.onSelect,
    required this.onDelete,
  }) : super(key: key);

  final ValueChanged<File> onSelect;
  final VoidCallback onDelete;

  @override
  State<SelectProfileImageWidget> createState() =>
      _SelectProfileImageWidgetState();
}

class _SelectProfileImageWidgetState extends State<SelectProfileImageWidget> {
  AssetEntity? image;
  File? file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.width * 0.40,
      child: Stack(
        children: [
          if (image == null)
            Center(
              child: InkWell(
                onTap: () async {
                  {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                    final result = await AssetPicker.pickAssets(
                      context,
                      pickerConfig: AssetPickerConfig(
                        maxAssets: 1,
                        selectPredicate: (context, asset, boolValue) =>
                            asset.type == AssetType.image,
                        pickerTheme: ThemeData.from(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.white,
                            secondary: WPConfig.primaryColor,
                          ),
                          textTheme: const TextTheme(
                            bodyText1: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                    if (result != null) {
                      debugPrint('Image is null ${image == null}');
                      image = result.first;
                      file = await image!.file;
                      widget.onSelect(file!);
                    }
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.image_rounded,
                      color: WPConfig.primaryColor,
                      size: 40,
                    ),
                    SizedBox(height: 12),
                    Text('Gallery'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
