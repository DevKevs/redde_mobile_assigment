import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        width: 130,
        height: 50,
        child: Column(
          children: [
            Image.asset('assets/logo-redde.png', height: 25),
            Text(
              'Text Extractor',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal,
      centerTitle: true,
      elevation: 0,
    );
  }
}
