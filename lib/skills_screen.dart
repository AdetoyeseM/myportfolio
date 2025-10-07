// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My Skills",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).textTheme.displayMedium?.color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          _SkillGroup(
            title: 'Mobile Development',
            items: const ['Dart', 'Kotlin', 'Java', 'Flutter', 'Android (Native)', 'Swift (IOS)'],
            icon: FontAwesomeIcons.mobileAlt,
          ),
          _SkillGroup(
            title: 'Architecture & State Management',
            items: const ['Riverpod', 'BLoC', 'Provider', 'MVVM', 'Clean Architecture'],
            icon: FontAwesomeIcons.sitemap,
          ),
          _SkillGroup(
            title: 'Advanced Mobile Capabilities',
            items: const [
              'App Flavors',
              'Firebase Remote Config',
              'Push Notifications',
              'Deep Linking',
              'Method Channels (Flutter ↔ Native)',
              'Secure Storage',
              'CI/CD Automation'
            ],
            icon: FontAwesomeIcons.bolt,
          ),
          _SkillGroup(
            title: 'APIs & Integrations',
            items: const ['REST APIs', 'GraphQL', 'WebSockets', 'Payment Gateways', '3rd-party SDKs'],
            icon: FontAwesomeIcons.plug,
          ),
          _SkillGroup(
            title: 'DevOps & Tools',
            items: const [
              'Firebase',
              'Codemagic',
              'Docker',
              'Git/GitHub/GitLab',
              'GitHub Actions',
              'Postman',
              'Android Studio',
              'Xcode',
              'VS Code',
              'Figma'
            ],
            icon: FontAwesomeIcons.toolbox,
          ),
          _SkillGroup(
            title: 'AI & Productivity Tools',
            items: const ['Cursor', 'ChatGPT', 'GitHub Copilot', 'Gemini'],
            icon: FontAwesomeIcons.robot,
          ),
          _SkillGroup(
            title: 'Professional Competencies',
            items: const [
              'Agile/Scrum',
              'Cross-functional Collaboration',
              'Problem-Solving',
              'Communication',
              'Leadership',
              'Time Management'
            ],
            icon: FontAwesomeIcons.brain,
          ),
        ],
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;

  const _SkillGroup({Key? key, required this.title, required this.items, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: items.map((e) => _Chip(label: e)).toList(),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
