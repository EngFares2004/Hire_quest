import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final String time;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
  });
}

// بيانات إشعارات وهمية
final List<NotificationModel> notifications = [
  NotificationModel(
    title: "Interview Scheduled",
    description: "Your interview has been scheduled for tomorrow.",
    time: "Just now",
  ),
  NotificationModel(
    title: "Interview Scheduled",
    description: "Your interview is scheduled tomorrow at 10:00 AM",
    time: "2 min ago",
  ),
  NotificationModel(
    title: "Profile Updated",
    description: "Your profile information was updated successfully",
    time: "10 min ago",
    isRead: true,
  ),
  NotificationModel(
    title: "Code Expired",
    description: "Your interview code has expired. Please request a new one.",
    time: "10 minutes ago",
    isRead: true,
  ),
  NotificationModel(
    title: "New Message",
    description: "HR sent you a new message",
    time: "1 hour ago",
  ),
  NotificationModel(
    title: "New Message",
    description: "You have received a new message from HR.",
    time: "2 hours ago",
  ),
  NotificationModel(
    title: "Application Viewed",
    description: "Your job application was viewed by the company",
    time: "3 hours ago",
  ),
  NotificationModel(
    title: "Interview Feedback",
    description: "You received feedback on your last interview",
    time: "Yesterday",
  ),


  NotificationModel(
    title: "Profile Updated",
    description: "Your profile information has been successfully updated.",
    time: "Yesterday",
    isRead: true,
  ),
  NotificationModel(
    title: "Interview Feedback",
    description: "You received feedback on your last interview",
    time: "Yesterday",
  ),
  NotificationModel(
    title: "Job Recommendation",
    description: "We found a job that matches your profile",
    time: "Yesterday",
  ),
  NotificationModel(
    title: "Reminder",
    description: "Don't forget to complete your profile setup.",
    time: "1 day ago",
  ),
  NotificationModel(
    title: "Security Alert",
    description: "New login detected from another device",
    time: "2 days ago",
  ),
  NotificationModel(
    title: "Reminder",
    description: "Don’t forget to complete your interview preparation",
    time: "3 days ago",
    isRead: true,
  ),
];

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = notifications[index];
        return ListTile(
          leading: Icon(
            Icons.notifications,
            color: item.isRead ? Colors.grey : Colors.blue,
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Text(item.description),
          trailing: Text(
            item.time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () {
          },
        );
      },
    );
  }
}
