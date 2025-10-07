import 'package:flutter/material.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SectionTitle('Experience'),
          SizedBox(height: 16),
          ExperienceTile(
            company: 'Chapel Hill Denham, Ikoyi, Lagos, Nigeria',
            role: 'Mobile Engineer',
            years: 'Dec 2022 - Present',
            bullets: [
              'Designed and maintained secure, regulatory-compliant mobile apps for finance clients, driving a 70% boost in customer satisfaction.',
              'Partnered with QA, design, backend and business to deliver ahead of schedule with fewer defects through automated testing and continuous feedback loops.',
              'Streamlined CI/CD using Codemagic, Docker, Firebase, GitHub Actions and Azure DevOps; improved deployment efficiency by 75% and reduced release cycles from weeks to days.',
            ],
          ),
          SizedBox(height: 20),
          ExperienceTile(
            company: 'Nitax Technologies, Lagos, Nigeria',
            role: 'Mobile Engineer',
            years: 'Oct 2021 - Jan 2023',
            bullets: [
              'Developed and maintained apps using Dart and Java within Agile/SCRUM; increased development speed by 15% using MVC/MVVM/MVP and ensured consistent UI.',
              'Delivered quality features with product/QA/analysts; reduced time‑to‑market by 30% and boosted user retention by 60%.',
              'Improved deployment efficiency by 30% via Codemagic, Firebase, and GitHub Actions.',
            ],
          ),
          SizedBox(height: 20),
          ExperienceTile(
            company: 'Esusu Africa Technology Innovation Hub, Yaba, Lagos, NG',
            role: 'Mobile Application Developer',
            years: 'Mar 2020 - Dec 2021',
            bullets: [
              'Supported full fintech lifecycle from concept/design to testing/release.',
              'Built fully functional apps with clean, bug‑free code and deployed to official stores.',
              'Collaborated with product, users and analysts to plan features and uphold quality in new and legacy apps.',
            ],
          ),
          SizedBox(height: 20),
          ExperienceTile(
            company: 'NIIT, Lagos State, Nigeria',
            role: 'Software Developer Intern',
            years: 'Aug 2017 – Dec 2017',
            bullets: [
              'Structured and maintained multiple codebases; managed publishing/versioning on App Store and Google Play.',
              'Converted wireframes and designs into functional apps.',
              'Collaborated with creative and product teams for cohesive UX across projects.',
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold));
  }
}

class ExperienceTile extends StatelessWidget {
  final String company;
  final String role;
  final String years;
  final List<String> bullets;

  const ExperienceTile({Key? key, required this.company, required this.role, required this.years, required this.bullets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(role, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(years, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(child: Text(b, style: Theme.of(context).textTheme.bodyMedium)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
