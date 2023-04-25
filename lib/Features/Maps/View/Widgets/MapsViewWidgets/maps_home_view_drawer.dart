import 'package:flutter/material.dart';

import '../../../../../Core/Utils/Constants/color_constants.dart';
import '../../../../../Core/Widgets/custom_text.dart';

class MapsHomeViewDrawer extends StatelessWidget {
  final double width, height;
  const MapsHomeViewDrawer(
      {super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.7,
      child: Drawer(
        backgroundColor: ColorConstants.backGroundColor1,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            _drawerHeader(),
            const SizedBox(height: 10),
            _listTile(icon: Icons.card_giftcard_outlined, title: 'Free Riders'),
            _listTile(icon: Icons.credit_card_outlined, title: 'Payments'),
            _listTile(icon: Icons.history, title: 'Ride History'),
            _listTile(icon: Icons.contact_support_outlined, title: 'Support'),
            _listTile(icon: Icons.info_outline, title: 'About'),
          ],
        ),
      ),
    );
  }

  Widget _drawerHeader() {
    return SizedBox(
      height: height * 0.2,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 15, offset: Offset(0.7, 0.7))],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/userIcon.png',
              height: 60,
              width: 60,
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomText(
                  text: 'Mahmoud Ibrahim',
                  fontSize: 20,
                ),
                SizedBox(height: 5),
                CustomText(
                  text: 'View Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon),
      title: CustomText(
        text: title,
        fontSize: 16,
      ),
    );
  }
}
