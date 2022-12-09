import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class ShootProfileImageWidget extends StatefulWidget {
  const ShootProfileImageWidget({
    Key? key,
    required this.onSelect,
    required this.onDelete,
  }) : super(key: key);

  final ValueChanged<File> onSelect;
  final VoidCallback onDelete;

  @override
  State<ShootProfileImageWidget> createState() =>
      _ShootProfileImageWidgetState();
}

class _ShootProfileImageWidgetState extends State<ShootProfileImageWidget> {
  AssetEntity? image;
  File? file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.width * 0.40,
      child: Stack(
        children: [
          Center(
            child: InkWell(
              onTap: () async {
                {
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                  final result = await CameraPicker.pickFromCamera(
                    context,
                    pickerConfig: CameraPickerConfig(
                      shouldDeletePreviewFile: true,
                      theme: ThemeData.from(
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
                    image = result;
                    file = await image!.file;
                    widget.onSelect(file!);
                  }
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.camera_alt_rounded,
                    color: WPConfig.primaryColor,
                    size: 40,
                  ),
                  SizedBox(height: 12),
                  Text('Camera'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
