import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../login/screen.login.dart';

part 'screen.profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Widget réutilisable pour l'entête de profil
class ProfileHeader extends StatelessWidget {
  final String userName;

  const ProfileHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.orange[100],
          child: const Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Widget réutilisable pour une section de profil
class ProfileSection extends StatelessWidget {
  final List<ProfileItemModel> items;

  const ProfileSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: items
            .map((item) => Column(
                  children: [
                    ProfileItemTile(item: item),
                    if (item != items.last)
                      Divider(
                        color: Colors.grey[300],
                        indent: 20,
                        endIndent: 20,
                        thickness: 0.5,
                      ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

// Widget réutilisable pour un élément individuel du profil
class ProfileItemTile extends StatelessWidget {
  final ProfileItemModel item;

  const ProfileItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon, color: item.iconColor ?? Colors.deepPurple),
      title: Text(
        item.label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Navigation selon l'item
        switch (item.label) {
          case 'Info Personnel':
            // context.pushNamed(CustomerPersonalInfoScreen.name);
            break;
          case 'Adresses':
            // context.pushNamed();
            break;
          case 'Mes Commandes':
            // context.pushNamed();
            break;
          case 'Mes Favoris':
            // context.pushNamed();
            break;
          case 'Notifications':
            // context.pushNamed();
            break;
          case 'Mes cartes':
            // context.pushNamed(
            //   CustomerCart.name
            // );
            break;
          case 'FAQs':
            // context.pushNamed(
            //   CustomerFAQs.name
            // );
            break;
          case 'Mes Feedback':
            // context.pushNamed();
            break;
          case 'Historique de retrait':
            // context.pushNamed();
            break;
          case 'Paramètres':
            // context.pushNamed(
            //   CustomerSettings.name
            // );
            break;
          case 'Se Déconnecter':
            context.pushNamed(LoginScreen.name);
            break;

          case 'Activer Mon Compte':
          // context.pushNamed();
        }
      },
    );
  }
}

class ProfileItemModel {
  final IconData icon;
  final String label;
  final Color? iconColor;

  ProfileItemModel({required this.icon, required this.label, this.iconColor});
}
