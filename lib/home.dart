import 'package:flutter/material.dart';
// import 'package:myportfolio/header.dart'; // Removed as content is integrated directly
import 'package:myportfolio/MiddleScreen.dart';
import 'package:myportfolio/footerscreen.dart';
import 'package:myportfolio/skills_screen.dart';
import 'package:myportfolio/experience_screen.dart';
import 'package:myportfolio/my_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Added for social icons
import 'package:url_launcher/url_launcher.dart'; // Added for url_launcher

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // GlobalKeys for navigating to different sections
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _summaryKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Show section near the top
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        elevation: 0,
        leading: const _LogoLeading(),
        title: null,
        actions: [
          if (isDesktop) ...[
            TextButton(
                onPressed: () => _scrollToSection(_projectsKey),
                child: const Text("About me")),
            TextButton(
                onPressed: () => _scrollToSection(_skillsKey),
                child: const Text("Skills")),
            TextButton(
                onPressed: () => _scrollToSection(_projectsKey),
                child: const Text("Portfolio")),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                onPressed: () => _scrollToSection(_contactKey),
                child: const Text("CONTACT ME"),
              ),
            ),
          ],
          // Always show menu button for drawer access
          IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _menuController,
                color: Theme.of(context).iconTheme.color),
            onPressed: () async {
              if (_menuController.status == AnimationStatus.completed) {
                _scaffoldKey.currentState?.closeEndDrawer();
              } else {
                _scaffoldKey.currentState?.openEndDrawer();
              }
            },
            tooltip: 'Menu',
          ),
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      onEndDrawerChanged: (isOpened) {
        if (isOpened) {
          _menuController.forward();
        } else {
          _menuController.reverse();
        }
      },
      endDrawer: MyDrawer(
        scrollToProjects: () => _scrollToSection(_projectsKey),
        scrollToSkills: () => _scrollToSection(_skillsKey),
        scrollToExperience: () => _scrollToSection(_experienceKey),
        scrollToContact: () => _scrollToSection(_contactKey),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _HeroSection(),
            Container(key: _summaryKey, child: const _SummarySection()),
            Container(key: _projectsKey, child: MiddleScreen()),
            Container(key: _skillsKey, child: SkillsScreen()),
            Container(key: _experienceKey, child: ExperienceScreen()),
            Container(key: _contactKey, child: FooterScreen()),
          ],
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            'Results-driven Mobile Engineer with a strong Computer Science foundation and proven experience delivering 15+ mobile applications with 95% user satisfaction and 30% fewer bugs. Skilled at collaborating in cross-functional teams, consistently delivering projects ahead of schedule and to high quality. Committed to building secure, reliable, and innovative mobile solutions that drive business success.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

// Responsive hero section implementing desktop/tablet/mobile layouts
class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isMobile = width < 800;
        final bool isDesktop =
            !isMobile; // Everything else (tablets, laptops, desktops)

        if (isDesktop) {
          return SizedBox(
            height: 680,
            child: Stack(
              children: [
                // Black right panel background
                Positioned.fill(
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                // Oval-shaped profile image
                Positioned(
                  right: 40,
                  top: 50,
                  bottom: 50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/newProfile.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Light grey left panel with curved edge (overlapping)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ClipPath(
                    clipper: _CurvedClipper(),
                    child: Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo in top left
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "M.A.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Main content
                            Text(
                              "Hi, I am",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Matthew Adetoyese",
                              style: TextStyle(
                                fontSize: 48,
      color: Colors.black,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Mobile Application Developer",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 48),
                            // Social icons
                            Row(
                              children: [
                                _SocialButton(
                                  icon: FontAwesomeIcons.at,
                                  url: "mailto:adetoyesematthew97@gmail.com",
                                ),
                                const SizedBox(width: 16),
                                _SocialButton(
                                  icon: FontAwesomeIcons.github,
                                  url: "https://github.com/AdetoyeseMatthew",
                                ),
                                const SizedBox(width: 16),
                                _SocialButton(
                                  icon: FontAwesomeIcons.linkedinIn,
                                  url:
                                      "https://www.linkedin.com/in/adetoyesematthew/",
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Mobile: verbatim design with diagonal overlay
        if (isMobile) {
          final double screenH = MediaQuery.of(context).size.height;
          return SizedBox(
            height: screenH * 0.9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Theme.of(context).scaffoldBackgroundColor),
                Positioned.fill(
                  child: Image.asset(
                    'assets/newProfile.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 120,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: _MobileClipper(),
                    child: Container(
                      height: 260,
                      width: double.infinity,
                      color: Theme.of(context).cardColor.withOpacity(0.85),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Hi, I am",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                  const SizedBox(height: 8),
                                  Text("Matthew Adetoyese", // per mockup label
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 8),
                                  Text("Software Engineer",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right :32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  _SocialIcon(
                                      icon: FontAwesomeIcons.at,
                                      url: "mailto:adetoyesematthew97@gmail.com"),
                                  SizedBox(height: 16),
                                  _SocialIcon(
                                      icon: FontAwesomeIcons.github,
                                      url: "https://github.com/AdetoyeseMatthew"),
                                  SizedBox(height: 16),
                                  _SocialIcon(
                                      icon: FontAwesomeIcons.linkedinIn,
                                      url:
                                          "https://www.linkedin.com/in/adetoyesematthew/"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Fallback for desktop (should not reach here)
        return SizedBox(
          height: 680,
          child: Center(
            child: Text("Desktop layout error"),
          ),
        );
      },
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({Key? key, required this.icon, required this.url})
      : super(key: key);
  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovering
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.4)),
          ),
          child: Icon(widget.icon,
              size: 18, color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }
}

// Mobile clipper that doesn't clip social icons
class _MobileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    
    // Start from top-left
    path.moveTo(0, 0);
    
    // Go to top-right with gentle curve
    path.lineTo(size.width * 0.95, 0);
    
    // Create a gentle curve to the right edge (not too aggressive)
    path.quadraticBezierTo(
      size.width * 0.98, size.height * 0.0,
      size.width * 0.96, size.height * 0.0,
    );
    
    // Continue with gentle curve (leaving space for social icons)
    path.quadraticBezierTo(
      size.width * 0.94, size.height * 0.4,
      size.width * 0.92, size.height * 0.6,
    );
    
    // Gentle curve back in (preserving social icon space)
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.8,
      size.width * 0.88, size.height * 0.9,
    );
    
    // Finish with gentle curve (ensuring social icons are visible)
    path.quadraticBezierTo(
      size.width * 0.85, size.height,
      size.width * 0.8, size.height,
    );
    
    // Go to bottom-left
    path.lineTo(0, size.height);
    
    // Close the path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Curved clipper for seamless left panel
class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    
    // Start from top-left
    path.moveTo(0, 0);
    
    // Go to top-right with slight curve
    path.lineTo(size.width * 0.95, 0);
    
    // Create a smooth curve to the right edge
    path.quadraticBezierTo(
      size.width * 0.98, size.height * 0.1,
      size.width * 0.96, size.height * 0.2,
    );
    
    // Continue the curve down
    path.quadraticBezierTo(
      size.width * 0.94, size.height * 0.4,
      size.width * 0.92, size.height * 0.6,
    );
    
    // Curve back in
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.8,
      size.width * 0.88, size.height * 0.95,
    );
    
    // Finish the curve to bottom-right
    path.quadraticBezierTo(
      size.width * 0.85, size.height,
      size.width * 0.82, size.height,
    );
    
    // Go to bottom-left
    path.lineTo(0, size.height);
    
    // Close the path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Social button widget matching the design
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialButton({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(url)),
          borderRadius: BorderRadius.circular(4),
          child: Center(
            child: FaIcon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoLeading extends StatelessWidget {
  const _LogoLeading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
