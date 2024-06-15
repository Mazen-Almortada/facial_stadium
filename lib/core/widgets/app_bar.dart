import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(80);

  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final Widget? drawerBuilder;
  final Function()? onTapLeading;

  const CustomAppBar(
      {super.key,
      this.title,
      this.drawerBuilder,
      this.leading,
      this.onTapLeading,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title,
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        leading: GestureDetector(onTap: onTapLeading, child: leading),
        actions: [drawerBuilder ?? const SizedBox()]);
  }
}
