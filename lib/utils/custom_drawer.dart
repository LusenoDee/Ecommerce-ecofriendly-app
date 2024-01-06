import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // shop tile
          Column(
            children: [
              // drawer header logo
              DrawerHeader(
                child: Icon(Icons.shopping_bag_rounded,
                    size: 60,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              MyListTile(
                icon: Icons.home,
                onTap: () {},
                text: 'Shop',
              ),

              // cart tile
              MyListTile(
                icon: Icons.shopping_cart_checkout_rounded,
                onTap: () {
                  Navigator.pop(context);
                 // Navigator.pushNamed(context, '/cart_page');

                },
                text: 'Products',
              ),
            ],
          ),

          // exit shop tile
          MyListTile(
            icon: Icons.exit_to_app_outlined,
            onTap: () {},
            text: 'Exit Shop',
          ),

          // logout ile if need be
        ],
      ),
    );
  }
}
class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
 MyListTile({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
