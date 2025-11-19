import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/pages/home.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        _buildHeroImage(context),
        SizedBox(height: 20.0),
        _buildTitle(),
        SizedBox(height: 20.0),
        _buildSubtitle(),
        SizedBox(height: 40.0),
        _buildGetStartedButton(context),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          "images/building.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.6,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "News from around the\n        world for you",
      style: TextStyle(
        color: Colors.black,
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      "Best time to read, take your time to read\n               a little more of this world",
      style: TextStyle(
        color: Colors.black45,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: _onGetStartedTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Material(
          borderRadius: BorderRadius.circular(30),
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onGetStartedTap() {
    Get.off(() => Home());
  }
}
