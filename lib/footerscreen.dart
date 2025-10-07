// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:flutter/services.dart'; // Import for Clipboard
// import 'package:myportfolio/theme/app_colors.dart'; // Removed AppColors import
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Added for social icons
import 'package:url_launcher/url_launcher.dart'; // Added for launching URLs

class FooterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Got a Project? Let's Talk.",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).textTheme.headlineSmall?.color,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          AnimatedContactButton(email: "adetoyesematthew97@gmail.com"),
          const SizedBox(height: 50),
          Container(
            height: 1,
            width: isMobile(context) ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.4,
            color: Theme.of(context).dividerColor,
          ),
          const SizedBox(height: 30),
          SocialAccountsFooter(), // New widget for footer social accounts
          const SizedBox(height: 20),
          Text(
            "© ${DateTime.now().year} Adept.ng. All rights reserved.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AnimatedContactButton extends StatefulWidget {
  final String email;

  const AnimatedContactButton({Key? key, required this.email}) : super(key: key);

  @override
  State<AnimatedContactButton> createState() => _AnimatedContactButtonState();
}

class _AnimatedContactButtonState extends State<AnimatedContactButton> {
  bool _isHovering = false;
  bool _isCopied = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.email));
    setState(() {
      _isCopied = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isCopied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: _copyToClipboard,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration( 
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(_isHovering ? 0.8 : 0.5)),
            borderRadius: BorderRadius.circular(8.0),
            color: _isHovering ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Text(
            _isCopied ? "Copied!" : widget.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class SocialAccountsFooter extends StatelessWidget {
  const SocialAccountsFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIconFooter(icon: FontAwesomeIcons.twitter, url: "https://twitter.com/_Adepto"),
        const SizedBox(width: 20),
        SocialIconFooter(icon: FontAwesomeIcons.github, url: "https://github.com/AdetoyeseMatthew"),
        const SizedBox(width: 20),
        SocialIconFooter(icon: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/in/adetoyesematthew/"),
        const SizedBox(width: 20),
        SocialIconFooter(icon: FontAwesomeIcons.facebookF, url: "https://web.facebook.com/matthew.adetoyese"),
      ],
    );
  }
}

class SocialIconFooter extends StatefulWidget {
  final IconData icon;
  final String url;

  const SocialIconFooter({Key? key, required this.icon, required this.url}) : super(key: key);

  @override
  State<SocialIconFooter> createState() => _SocialIconFooterState();
}

class _SocialIconFooterState extends State<SocialIconFooter> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => launch(widget.url),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: _isHovering ? 1.2 : 1.0,
          child: Icon(
            widget.icon,
            color: Theme.of(context).iconTheme.color,
            size: 24,
          ),
        ),
      ),
    );
  }
}
