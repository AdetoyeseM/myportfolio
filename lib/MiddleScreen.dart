// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MiddleScreen extends StatefulWidget {
  @override
  State<MiddleScreen> createState() => _MiddleScreenState();
}

class _MiddleScreenState extends State<MiddleScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Timer _timer;
  bool _pageControllerInitialized = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage == projectWidgets.length - 1) {
          // Smoothly transition to first page for infinite loop
          _pageController.animateToPage(
            0,
            duration: const Duration(seconds: 2),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 600),
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
      final double screenWidth = MediaQuery.of(context).size.width;
      // Adjust viewport fraction based on screen size for better text visibility
      double viewportFraction = 0.85; // Mobile: wider cards to prevent overflow
      if (screenWidth >= 1200) {
        viewportFraction = 0.35; // Desktop: wider cards for better text display
      } else if (screenWidth >= 900) {
        viewportFraction = 0.45; // Tablet: medium view
      } else if (screenWidth >= 600) {
        viewportFraction = 0.6; // Small tablet
      }

      _pageController =
          PageController(initialPage: 0, viewportFraction: viewportFraction);
      _pageControllerInitialized = true;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  double _getResponsiveHeight(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 600) {
      // Mobile: fixed height to prevent overflow
      return 600;
    } else if (screenWidth < 900) {
      // Tablet: more height for better text visibility
      return screenHeight * 0.55;
    } else if (screenWidth < 1200) {
      // Small desktop: even more height
      return screenHeight * 0.5;
    } else {
      // Large desktop: optimal height for wide screens
      return screenHeight * 0.45;
    }
  }

  EdgeInsets _getResponsivePadding(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      // Mobile: reduced padding to prevent overflow
      return const EdgeInsets.all(12.0);
    } else if (screenWidth < 900) {
      // Tablet: slightly more padding
      return const EdgeInsets.all(24.0);
    } else if (screenWidth < 1200) {
      // Small desktop: more padding for better text visibility
      return const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0);
    } else {
      // Large desktop: maximum padding for better centering and text visibility
      return const EdgeInsets.symmetric(horizontal: 120.0, vertical: 40.0);
    }
  }

  final List<ProjectCard> projectWidgets = [
    ProjectCard(
      title: "TrustFund Mobile",
      description:
          "Designed and deployed a secure pension management app, enabling users to track and manage retirement accounts seamlessly. Android | iOS",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "Duffle | Crypto Platform",
      description:
          "Designed and developed a crypto go-bag app that makes digital currencies as practical as cash. Android | iOS",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "InvestNaija",
      description:
          "Built an all-in-one financial app that helps users plan, save, and invest in mutual funds, bonds, and REITs. Android | iOS",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "PrimaryOffer",
      description:
          "Revamped and developed an NGX-backed platform for purchasing public offers and rights issues, driving a 75% surge in user engagement. Android | iOS",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "Esusu Collector | POS App",
      description:
          "Collaborated in a 3-member team to digitize manual thrift collections for underbanked communities, with support for mobile and POS devices. Tech: Java (Android POS), Flutter, Figma, Postman, GitHub, ClickUp.",
      playStoreUrl: null,
      appStoreUrl: null,
      githubUrl: null,
    ),
    ProjectCard(
      title: "LiteTrade | FinTech Platform",
      description:
          "Developed a trading app for buying and selling gift cards, airtime, and more. Android",
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
        padding: _getResponsivePadding(context),
        child: SizedBox(
          height: _getResponsiveHeight(context),
          child: Column(
            children: [
              Text(
                "My Portfolio",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.displayLarge?.color,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Selected Projects",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  final double screenWidth = MediaQuery.of(context).size.width;
                  double fontSize = 16;

                  if (screenWidth >= 1200) {
                    fontSize = 18;
                  } else if (screenWidth >= 900) {
                    fontSize = 17;
                  }

                  return Text(
                    "A showcase of mobile applications I've designed and developed, demonstrating expertise in Flutter, cross-platform development, and fintech solutions. Each project represents a unique challenge solved through innovative technology and user-centered design.",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.6,
                          fontSize: fontSize,
                        ),
                    textAlign: TextAlign.center,
                    // Remove maxLines to show all text
                  );
                },
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Column(
        children: [
          Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: projectWidgets.length,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          var _scale = _currentPage == index ? 1.0 : 0.85;
                          return TweenAnimationBuilder(
                            tween: Tween(begin: _scale, end: _scale),
                            duration: const Duration(milliseconds: 350),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: projectWidgets[index],
                            ),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
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
                            color: _currentPage == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .dividerColor
                                    .withOpacity(0.5),
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
        transform: Matrix4.identity()..translate(0.0, _isHovering ? 0.0 : 0.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
              color: _isHovering
                  ? Colors.white
                  : Theme.of(context).dividerColor.withOpacity(0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double screenWidth = MediaQuery.of(context).size.width;
                  double horizontalPadding = 12.0; // Reduced for mobile
                  double titleFontSize = 15; // Slightly smaller for mobile
                  double descriptionFontSize = 13; // Smaller for mobile

                  if (screenWidth >= 1200) {
                    horizontalPadding = 24.0;
                    titleFontSize = 18;
                    descriptionFontSize = 15;
                  } else if (screenWidth >= 900) {
                    horizontalPadding = 20.0;
                    titleFontSize = 17;
                    descriptionFontSize = 14.5;
                  } else if (screenWidth >= 600) {
                    horizontalPadding = 16.0;
                    titleFontSize = 16;
                    descriptionFontSize = 14;
                  }

                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        horizontalPadding, screenWidth < 600 ? 16.0 : 20.0, horizontalPadding, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: titleFontSize,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          // flex: ,
                          child: SingleChildScrollView(
                            child: Text(
                              widget.description,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    // overflow: TextOverflow.ellipsis,
                                    height: 1.5,
                                    fontSize: descriptionFontSize,
                                  ),
                              // Remove maxLines to show all text
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final double screenWidth = MediaQuery.of(context).size.width;
                double horizontalPadding = 12.0; // Reduced for mobile

                if (screenWidth >= 1200) {
                  horizontalPadding = 24.0;
                } else if (screenWidth >= 900) {
                  horizontalPadding = 20.0;
                } else if (screenWidth >= 600) {
                  horizontalPadding = 16.0;
                }

                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      horizontalPadding, 8, horizontalPadding, 12),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ProjectLinkButton(
                        icon: FontAwesomeIcons.apple,
                        url: widget.appStoreUrl ?? '',
                        label: "App Store",
                        enabled: widget.appStoreUrl != null &&
                            widget.appStoreUrl!.isNotEmpty,
                      ),
                      ProjectLinkButton(
                        icon: FontAwesomeIcons.googlePlay,
                        url: widget.playStoreUrl ?? '',
                        label: "Google Play",
                        enabled: widget.playStoreUrl != null &&
                            widget.playStoreUrl!.isNotEmpty,
                      ),
                      if (widget.githubUrl != null)
                        ProjectLinkButton(
                            icon: FontAwesomeIcons.github,
                            url: widget.githubUrl ?? "",
                            enabled: false,
                            label: "GitHub"),
                    ],
                  ),
                );
              },
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
        child: AnimatedScale(
          scale: _isHovering && widget.enabled ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.enabled
                  ? (_isHovering
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor)
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: widget.enabled
                    ? (_isHovering
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.5))
                    : Theme.of(context).dividerColor.withOpacity(0.6),
              ),
              boxShadow: _isHovering && widget.enabled
                  ? [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.icon,
              size: 18,
              color: widget.enabled
                  ? (_isHovering
                      ? Colors.white
                      : Theme.of(context).primaryColor)
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),
        // child: Row(
        //   children: [
        //     Icon(
        //       widget.icon,
        //       size: 18,
        //       color: widget.enabled
        //           ? (_isHovering
        //               ? Colors.white
        //               : Theme.of(context).primaryColor)
        //           : Theme.of(context).disabledColor,
        //     ),
        //     const SizedBox(width: 8),
        //     Text(
        //       widget.label,
        //       style: Theme.of(context).textTheme.labelLarge?.copyWith(
        //             color: widget.enabled
        //                 ? (_isHovering
        //                     ? Colors.white
        //                     : Theme.of(context).primaryColor)
        //                 : Theme.of(context).disabledColor,
        //             fontWeight: FontWeight.w600,
        //           ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
