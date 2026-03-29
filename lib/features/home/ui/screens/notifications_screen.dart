import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/theme/theme.dart';
import '../../data/models/notifications_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomerArrowBack(
              title:"Notifications" ,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/1.2,
              child: ListView.separated(
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return _NotificationCard(
                    title: item.title,
                    description: item.description,
                    time: item.time,
                    isRead: item.isRead,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isRead;

  const _NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 🌙 Theme aware

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead
            ? theme.colorScheme.surface // بدل backgroundWhite
            : AppTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead ? theme.colorScheme.secondary : theme.colorScheme.primary,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications,
            color: isRead ? AppTheme.primary : AppTheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                 color: isRead ? AppTheme.primary : AppTheme.primary,

                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
