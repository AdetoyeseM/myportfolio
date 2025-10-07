// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback scrollToProjects;
  final VoidCallback scrollToSkills;
  final VoidCallback scrollToExperience;
  final VoidCallback scrollToContact;

  const MyDrawer({
    Key? key,
    required this.scrollToProjects,
    required this.scrollToSkills,
    required this.scrollToExperience,
    required this.scrollToContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Theme.of(context).iconTheme.color, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              children: [
                _MenuItem(label: 'About me', onTap: () { scrollToProjects(); Navigator.pop(context); }),
                const SizedBox(height: 40),
                _MenuItem(label: 'Skills', onTap: () { scrollToSkills(); Navigator.pop(context); }),
                const SizedBox(height: 40),
                _MenuItem(label: 'Portfolio', onTap: () { scrollToProjects(); Navigator.pop(context); }),
                const SizedBox(height: 40),
                const Divider(),
                const SizedBox(height: 16),
                _MenuItem(label: 'CONTACT ME', onTap: () { scrollToContact(); Navigator.pop(context); }, isEmphasis: true),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SocialIconDrawer(icon: FontAwesomeIcons.at, url: 'mailto:adetoyesematthew97@gmail.com'),
                    SizedBox(width: 20),
                    _SocialIconDrawer(icon: FontAwesomeIcons.github, url: 'https://github.com/AdetoyeseMatthew'),
                    SizedBox(width: 20),
                    _SocialIconDrawer(icon: FontAwesomeIcons.linkedinIn, url: 'https://www.linkedin.com/in/adetoyesematthew/'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isEmphasis;
  const _MenuItem({Key? key, required this.label, required this.onTap, this.isEmphasis = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle base = Theme.of(context).textTheme.headlineSmall ?? const TextStyle(fontSize: 20);
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: Text(
            label,
            style: base.copyWith(
              fontWeight: isEmphasis ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: isEmphasis ? 0.5 : 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIconDrawer extends StatelessWidget {
  final IconData icon;
  final String url;
  const _SocialIconDrawer({Key? key, required this.icon, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(url),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
        ),
        child: Icon(icon, size: 18, color: Theme.of(context).iconTheme.color),
      ),
    );
  }
}
