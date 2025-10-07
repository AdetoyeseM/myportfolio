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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
    _menuController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
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
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        elevation: 0,
        leading: const _LogoLeading(),
        title: null,
        actions: [
          if (isDesktop) ...[
            TextButton(onPressed: () => _scrollToSection(_projectsKey), child: const Text("About me")),
            TextButton(onPressed: () => _scrollToSection(_skillsKey), child: const Text("Skills")),
            TextButton(onPressed: () => _scrollToSection(_projectsKey), child: const Text("Portfolio")),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                onPressed: () => _scrollToSection(_contactKey),
                child: const Text("CONTACT ME"),
              ),
            ),
          ] else ...[
            IconButton(
              icon: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _menuController, color: Theme.of(context).iconTheme.color),
              onPressed: () async {
                if (_menuController.status == AnimationStatus.completed) {
                  _scaffoldKey.currentState?.closeEndDrawer();
                } else {
                  _scaffoldKey.currentState?.openEndDrawer();
                }
              },
              tooltip: 'Menu',
            ),
          ],
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
      endDrawer: isDesktop
          ? null
          : MyDrawer(
              scrollToProjects: () => _scrollToSection(_projectsKey),
              scrollToSkills: () => _scrollToSection(_skillsKey),
              scrollToExperience: () => _scrollToSection(_experienceKey),
              scrollToContact: () => _scrollToSection(_contactKey),
            ),
      body: SingleChildScrollView(
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
          Text('Summary', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
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
        final bool isDesktop = width >= 1024;
        final bool isTablet = width >= 700 && width < 1024;

        final EdgeInsets contentPadding = EdgeInsets.symmetric(
          horizontal: isDesktop ? 96 : isTablet ? 48 : 24,
          vertical: isDesktop ? 48 : 32,
        );

        final TextStyle titleStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.bold,
            );
        final TextStyle subtitleStyle = Theme.of(context).textTheme.titleMedium!;
        final Widget socials = _SocialsColumn();

        if (isDesktop) {
          return ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 680),
            child: Stack(
              children: [
                // Right image area (~55%)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.55,
                    heightFactor: 1.0,
                    child: Image.asset(
                      'assets/newProfile.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
                // Left diagonal panel
                Positioned.fill(
                  child: ClipPath(
                    clipper: _HeroLeftClipper(),
                    child: Container(color: Theme.of(context).cardColor),
                  ),
                ),
                // Left content
                Positioned.fill(
                  child: Padding(
                    padding: contentPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hi, I am", style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 16),
                        Text("ADETOYESE MATTHEW", style: titleStyle),
                        const SizedBox(height: 8),
                        Text("Mobile Application Developer", style: subtitleStyle),
                        const SizedBox(height: 24),
                        Row(
                          children: const [
                            _SocialIcon(icon: FontAwesomeIcons.at, url: "mailto:adetoyesematthew97@gmail.com"),
                            SizedBox(width: 16),
                            _SocialIcon(icon: FontAwesomeIcons.github, url: "https://github.com/AdetoyeseMatthew"),
                            SizedBox(width: 16),
                            _SocialIcon(icon: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/in/adetoyesematthew/"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Socials on the right bottom
                Positioned(
                  bottom: 32,
                  right: 32,
                  child: socials,
                ),
              ],
            ),
          );
        }

        // Tablet and Mobile (stacked)
        if (isTablet) {
          return Column(
            children: [
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset('assets/newProfile.png', fit: BoxFit.cover, alignment: Alignment.centerRight),
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                width: double.infinity,
                padding: contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi, I am", style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    Text("ADETOYESE MATTHEW", style: titleStyle.copyWith(fontSize: 42)),
                    const SizedBox(height: 8),
                    Text("Mobile Application Developer", style: subtitleStyle),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        _SocialIcon(icon: FontAwesomeIcons.at, url: "mailto:adetoyesematthew97@gmail.com"),
                        SizedBox(width: 16),
                        _SocialIcon(icon: FontAwesomeIcons.github, url: "https://github.com/AdetoyeseMatthew"),
                        SizedBox(width: 16),
                        _SocialIcon(icon: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/in/adetoyesematthew/"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        // Mobile: verbatim design with diagonal overlay
        final double screenH = MediaQuery.of(context).size.height;
        return SizedBox(
          height: screenH * 0.9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: Theme.of(context).scaffoldBackgroundColor),
              Positioned.fill(
                child: Image.asset('assets/newProfile.png', fit: BoxFit.cover),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: _DiagonalClipper(),
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
                                Text("Hi, I am", style: Theme.of(context).textTheme.headlineSmall),
                                const SizedBox(height: 8),
                                Text("Matthew Adetoyese", // per mockup label
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(fontWeight: FontWeight.w700)),
                                const SizedBox(height: 8),
                                Text("Software Engineer",
                                    style: Theme.of(context).textTheme.titleMedium),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              _SocialIcon(icon: FontAwesomeIcons.at, url: "mailto:adetoyesematthew97@gmail.com"),
                              SizedBox(height: 16),
                              _SocialIcon(icon: FontAwesomeIcons.github, url: "https://github.com/AdetoyeseMatthew"),
                              SizedBox(height: 16),
                              _SocialIcon(icon: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/in/adetoyesematthew/"),
                            ],
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
      },
    );
  }
}

class _SocialsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _SocialIcon(icon: FontAwesomeIcons.at, url: "mailto:adetoyesematthew97@gmail.com"),
        SizedBox(height: 16),
        _SocialIcon(icon: FontAwesomeIcons.github, url: "https://github.com/AdetoyeseMatthew"),
        SizedBox(height: 16),
        _SocialIcon(icon: FontAwesomeIcons.linkedinIn, url: "https://www.linkedin.com/in/adetoyesematthew/"),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({Key? key, required this.icon, required this.url}) : super(key: key);
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
            color: _isHovering ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.4)),
          ),
          child: Icon(widget.icon, size: 18, color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }
}

class _DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    // Create a diagonal top edge (rising to the right)
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Left hero panel with a diagonal right edge similar to the mock
class _HeroLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.62, 0);
    path.lineTo(size.width * 0.52, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _LogoLeading extends StatelessWidget {
  const _LogoLeading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}