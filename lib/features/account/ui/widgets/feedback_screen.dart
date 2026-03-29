import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/widgets/customer_bottom.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import '../../../../configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_arrow_back.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           CustomerArrowBack(title: 'Feedback'),

            SubTitle(title:'We value your feedback!' ),

            const Text(
              'Your feedback helps us improve our service. Please rate and leave your comments below.',
              style: TextStyle(fontSize: 14, color: AppTheme.grey),
              textAlign: TextAlign.center,
            ),

            SubTitle(title:'Rating' ),

            /// ⭐ Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  iconSize: 36,
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () => setState(() => _rating = index + 1.0),
                );
              }),
            ),


            SubTitle(title:'Write Feedback' ),
            /// 📝 Feedback Input
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _feedbackController,
                maxLines: 6,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Write your feedback...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).hintColor),
                  border: InputBorder.none,
                ),
              ),
            ),


            const SizedBox(height: 24),

            /// 🔵 Send Button

            CustomBottom(
              title:'Send Feedback' ,
              onTap:() {
                String feedback = _feedbackController.text;
                print('Rating: $_rating, Feedback: $feedback');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your feedback!'),
                  ),
                );
                Navigator.pop(context);
              } ,
              textSize: 16,
            ),

          ],
        ),
      ),
    );
  }
}
