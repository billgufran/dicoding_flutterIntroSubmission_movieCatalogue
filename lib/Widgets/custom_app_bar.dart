import 'package:flutter/material.dart';
import 'package:moviecatalogue/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;

  const CustomAppBar({Key? key, this.height = 60.0}) : super(key: key);

  @override
  Size get preferredSize {
    return Size.fromHeight(height!);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
      ),
      centerTitle: true,
      titleTextStyle: Theme.of(context).textTheme.headline1,
      title: const Text('Discover'),
      toolbarHeight: height!,
      backgroundColor: CustomColors.backgroundLightColor,
    );
  }
}
