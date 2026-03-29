import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import '../../../../configuration/widgets/custom_build_tile.dart';
import 'live_chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> openLink(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    }
    return ListView(
      padding:  EdgeInsets.symmetric(vertical: 8),
      children: [
        CustomBuildTile(
          icon: Icons.support_agent,
          title: "Customer Service",
          onTap: () {

            openLink("tel:+201026450812"); // رقم وهمي
          },
        ),
        CustomBuildTile(
          icon: CupertinoIcons.chat_bubble,
          colorIcon: AppTheme.secondary,
          title: "Live Chat",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiveChatScreen(),
              ),
            );
          },
        ),

        CustomBuildTile(
          icon: Icons.email_outlined,
          title: "Support Email",
          onTap: () {
            openLink("mailto:support@hirequest.ai");
          },
        ),
        CustomBuildTile(
          icon: Icons.language,
          title: "Website",
          colorIcon: Colors.grey,
          onTap: () {
            openLink("https://hirequest.ai");
          },
        ),
        CustomBuildTile(
          icon: FontAwesomeIcons.whatsapp,
          title: "WhatsApp",
          colorIcon: Colors.green,
          onTap: () {
            openLink("https://wa.me/201021521554");
          },
        ),
        CustomBuildTile(
          icon: FontAwesomeIcons.linkedin,
          title: "LinkedIn",
          colorIcon: Colors.blue,
          onTap: () {
            openLink("https://linkedin.com/company/hirequest");
          },
        ),
        CustomBuildTile(
          icon: FontAwesomeIcons.facebook,
          title: "Facebook",
          colorIcon: Colors.blue,
          onTap: () {
            openLink("https://facebook.com/hirequest");
          },
        ),
        CustomBuildTile(
          icon: FontAwesomeIcons.twitter,
          title: "X (Twitter)",
          colorIcon: Colors.blueAccent,
          onTap: () {
            openLink("https://x.com/hirequest");
          },
        ),
        CustomBuildTile(
          icon: FontAwesomeIcons.youtube,
          title: "YouTube",
          colorIcon: Colors.red,
          onTap: () {
            openLink("https://youtube.com/@hirequest");
          },
        ),
      ],
    );
  }
}
