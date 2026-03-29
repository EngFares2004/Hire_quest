import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hire_quest/configuration/widgets/customer_arrow_back.dart';
import '../../../../configuration/theme/theme.dart';
import '../widgets/faq_tab.dart';
import '../widgets/contact_tab.dart';
import '../widgets/feedback_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_fabVisible) setState(() => _fabVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_fabVisible) setState(() => _fabVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _fabVisible ? Offset.zero : const Offset(2, 0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _fabVisible ? 1 : 0,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              );
            },
            icon: const Icon(Icons.feedback,color: AppTheme.white,),
            label: const Text('Feedback',style: TextStyle(color: AppTheme.white),),
            backgroundColor: AppTheme.primary,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// 🔙 Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomerArrowBack(title: 'Support'),
            ),

            /// 🔍 Search
            _searchBox(),

            /// 🧭 Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppTheme.primary,
                labelColor: AppTheme.primary,
                unselectedLabelColor: AppTheme.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(text: "FAQ"),
                  Tab(text: "Contact Us"),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// 📦 Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  FaqTab(),
                  ContactTab(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _searchBox() {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.hintColor, // 👈 Theme Aware
          ),
          prefixIcon: Icon(
            Icons.search,
            color: theme.iconTheme.color, // 👈 Theme Aware
          ),
          filled: true,
          fillColor: theme.colorScheme.surface, // 👈 Theme Aware
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.dividerColor, // 👈 Theme Aware
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.dividerColor, // 👈 Theme Aware
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.primary, // 👈 Theme Aware
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

}
