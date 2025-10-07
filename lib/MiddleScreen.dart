import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiddleScreen extends StatefulWidget {
  @override
  State<MiddleScreen> createState() => _MiddleScreenState();
}

class _MiddleScreenState extends State<MiddleScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  bool _pageControllerInitialized = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_pageController.page == projectWidgets.length - 1) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_pageControllerInitialized) {
      _pageController = PageController(viewportFraction: isMobile(context) ? 0.75 : 0.4);
      _pageControllerInitialized = true;
      _pageController.addListener(() {
        setState(() {
          _currentPage = _pageController.page?.round() ?? 0;
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  final List<ProjectCard> projectWidgets = [
    ProjectCard(
      title: "TrustFund Mobile | Pension Fund Management",
      description: "Secure pension management app that enables users to track and manage retirement accounts seamlessly.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "Duffle | Crypto Payment Platform",
      description: "Crypto go‑bag app that makes digital currencies as practical as cash.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "InvestNaija | Investment Platform",
      description: "All‑in‑one financial app to plan, save and invest in mutual funds, bonds and REITs.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "PrimaryOffer | Investment Platform",
      description: "NGX‑backed platform for purchasing public offers and rights issues; revamp drove a 75% surge in engagement.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "Esusu Field Collector | FinTech & POS App",
      description: "Digitized manual thrift collections for underbanked communities; mobile and POS support.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "LiteTrade | FinTech Platform",
      description: "Trading app for buying/selling gift cards, airtime and more.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: isMobile(context) ? 420 : 320,
          child: Column(
            children: [
              Text(
                "Some of My Creative Works,",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).textTheme.displaySmall?.color),
                textAlign: TextAlign.center,
              ),
              Text(
                "Selected Projects.",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.grey[600]), // Replaced AppColors.yellowAccent
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
        children: [
          Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: projectWidgets.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: projectWidgets[index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(projectWidgets.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 24.0 : 8.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? Theme.of(context).primaryColor : Theme.of(context).dividerColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? githubUrl;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    this.playStoreUrl,
    this.appStoreUrl,
    this.githubUrl,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        transform: Matrix4.identity()..translate(0.0, _isHovering ? -4.0 : 0.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  ProjectLinkButton(
                    icon: FontAwesomeIcons.apple,
                    url: widget.appStoreUrl ?? '',
                    label: "App Store",
                    enabled: widget.appStoreUrl != null && widget.appStoreUrl!.isNotEmpty,
                  ),
                  const SizedBox(width: 12),
                  ProjectLinkButton(
                    icon: FontAwesomeIcons.googlePlay,
                    url: widget.playStoreUrl ?? '',
                    label: "Google Play",
                    enabled: widget.playStoreUrl != null && widget.playStoreUrl!.isNotEmpty,
                  ),
                  if (widget.githubUrl != null) const SizedBox(width: 12),
                  if (widget.githubUrl != null)
                    ProjectLinkButton(icon: FontAwesomeIcons.github, url: widget.githubUrl!, label: "GitHub"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectLinkButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;
  final bool enabled;

  const ProjectLinkButton({
    Key? key,
    required this.icon,
    required this.url,
    required this.label,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ProjectLinkButton> createState() => _ProjectLinkButtonState();
}

class _ProjectLinkButtonState extends State<ProjectLinkButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.enabled ? () => launch(widget.url) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.enabled
                ? (_isHovering ? Theme.of(context).primaryColor : Theme.of(context).cardColor)
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: widget.enabled
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Theme.of(context).dividerColor.withOpacity(0.6),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.enabled
                    ? (_isHovering ? Colors.white : Theme.of(context).primaryColor)
                    : Theme.of(context).disabledColor,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.enabled
                          ? (_isHovering ? Colors.white : Theme.of(context).primaryColor)
                          : Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
