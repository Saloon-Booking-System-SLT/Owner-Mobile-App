import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/booking/book_an_appoinment.dart';
import '../../widgets/home/bottom_nav_bar.dart';
import 'feedbacks.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MoreAppBar(),
      body: const MoreBody(),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class MoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoreAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'More',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MoreBody extends StatelessWidget {
  const MoreBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: const [
            SizedBox(height: 40),
            FeedbacksMenuItem(),
            SizedBox(height: 24),
            PromotionsMenuItem(),
            SizedBox(height: 24),
            BookAppoinment(),
          ],
        ),
      ),
    );
  }
}

class FeedbacksMenuItem extends StatelessWidget {
  const FeedbacksMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuItemWidget(
      icon: Icons.chat_bubble_outline,
      title: 'Feedbacks',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FeedbacksPage(),
          ),
        );
      },
    );
  }
}

class PromotionsMenuItem extends StatelessWidget {
  const PromotionsMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuItemWidget(
      icon: Icons.campaign_outlined,
      title: 'Promotions',
      onTap: () {
        // Navigate to Promotions page
      },
    );
  }
}
class BookAppoinment extends StatelessWidget {
  const BookAppoinment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuItemWidget(
      icon: Icons.my_library_books_outlined,
      title: 'Book An Appoinment',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BookAnAppointment(),
          ),
        );
      },
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            MenuIconContainer(icon: icon),
            const SizedBox(width: 16),
            MenuTitleText(title: title),
            const Spacer(),
            const MenuArrowIcon(),
          ],
        ),
      ),
    );
  }
}

class MenuIconContainer extends StatelessWidget {
  const MenuIconContainer({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF1565C0),
        size: 24,
      ),
    );
  }
}

class MenuTitleText extends StatelessWidget {
  const MenuTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}

class MenuArrowIcon extends StatelessWidget {
  const MenuArrowIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey.shade400,
      size: 18,
    );
  }
}