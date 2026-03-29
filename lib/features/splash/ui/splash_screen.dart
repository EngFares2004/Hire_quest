import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/route/route.dart';
import '../../../configuration/theme/theme.dart';
import '../../../configuration/widgets/customer_bottom.dart';
import '../../../generated/assets.dart';
import '../models/splash_model.dart';
import 'widgets/splash_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<SplashModel> pages = [
    SplashModel(
      image:Assets.imagesVirtualReality,
      title: 'Train for real interviews *“virtually”*',
      subtitle: 'Discover a smarter, immersive way to practice and grow.',
    ),
    SplashModel(
      image: Assets.imagesJobInterview,
      title: 'Practice. Improve. Succeed.',
      subtitle: 'Experience realistic mock interviews in virtual reality.',
    ),
    SplashModel(
      image:Assets.imagesHeroEmployee,
      title: 'Turn practice into confidence.',
      subtitle: 'Ready to face your next interview like a pro?',
    ),
  ];

  void _loginPage() {
    Navigator.pushReplacementNamed(context, AppRoute.login);
  }

  void _signUpPage() {
    Navigator.pushReplacementNamed(context, AppRoute.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (_, index) {
              return SplashWidget(data: pages[index]);
            },
          ),

          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: _signUpPage,
              child: Text(
                _currentPage == 2 ? "Later >" : "Skip >",
                style: TextStyle(color: AppTheme.primary, fontSize: 16),
              ),
            ),
          ),
          /// Indicators
          Positioned(
            left:  20,
            top: 68,
            child: Row(

              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 5,
                  width: _currentPage == index ? 35 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.primary
                        :AppTheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),

          /// Bottom Button
          Positioned(
            bottom: _currentPage == 2 ? 60:100,
            left: 20,
            right: 20,
            child: _currentPage == 2
                ? Column(
              children: [
                CustomBottom(
                  title: "Sign Up",
                  onTap: _signUpPage,
                  color: AppTheme.primary,
                  textColor: AppTheme.white,
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: _loginPage,
                  child:Text( "Login",
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
                : CustomBottom(
              title: "Continue",
              onTap: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
