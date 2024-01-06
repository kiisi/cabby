import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool enableLocationAppbar;
  final Widget? mainAppBar;
  const CustomAppbar(
      {super.key, this.enableLocationAppbar = false, this.mainAppBar});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          if (enableLocationAppbar)
            Container(
              height: 56 + MediaQuery.of(context).padding.top,
              color: const Color(0xFFfe9900),
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 5,
                bottom: 10,
                left: 12,
                right: 12,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Location sharing disabled. Tap here to enable",
                      style: TextStyle(
                        color: Color(0xff2d0200),
                      ),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Enable",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          if (mainAppBar != null) mainAppBar!,
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 56);
}
