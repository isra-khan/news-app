import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/pages/all_news.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/pages/category_news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _buildAppBarTitle(),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("World"),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildBody(HomeController controller) {
    return Obx(() => controller.loading.value
        ? _buildLoadingIndicator()
        : _buildContent(controller));
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildContent(HomeController controller) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryList(controller),
            SizedBox(height: 30.0),
            _buildBreakingNewsSection(controller),
            SizedBox(height: 30.0),
            _buildTrendingNewsSection(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(HomeController controller) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 70,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return CategoryTile(
            image: controller.categories[index].image,
            categoryName: controller.categories[index].categoryName,
          );
        },
      ),
    );
  }

  Widget _buildBreakingNewsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: "Breaking News!",
          onViewAllTap: () => Get.to(() => AllNews(news: "Breaking")),
        ),
        SizedBox(height: 20.0),
        _buildCarouselSlider(controller),
        SizedBox(height: 30.0),
        _buildCarouselIndicator(controller),
      ],
    );
  }

  Widget _buildSectionHeader(
      {required String title, required VoidCallback onViewAllTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          GestureDetector(
            onTap: onViewAllTap,
            child: Text(
              "View All",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider(HomeController controller) {
    return Obx(() => controller.loading2.value
        ? Center(child: CircularProgressIndicator())
        : CarouselSlider.builder(
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              String? res = controller.sliders[index].urlToImage;
              String? res1 = controller.sliders[index].title;
              return buildImage(context, res!, index, res1!);
            },
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                controller.updateActiveIndex(index);
              },
            ),
          ));
  }

  Widget _buildCarouselIndicator(HomeController controller) {
    return Obx(() => Center(
          child: buildIndicator(controller.activeIndex.value),
        ));
  }

  Widget _buildTrendingNewsSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: "Trending News!",
          onViewAllTap: () => Get.to(() => AllNews(news: "Trending")),
        ),
        SizedBox(height: 10.0),
        _buildTrendingNewsList(controller),
      ],
    );
  }

  Widget _buildTrendingNewsList(HomeController controller) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: controller.articles.length,
        itemBuilder: (context, index) {
          return BlogTile(
            url: controller.articles[index].url!,
            desc: controller.articles[index].description!,
            imageUrl: controller.articles[index].urlToImage!,
            title: controller.articles[index].title!,
          );
        },
      ),
    );
  }

  Widget buildImage(
      BuildContext context, String image, int index, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          _buildCarouselImage(context, image),
          _buildCarouselOverlay(context, name),
        ],
      ),
    );
  }

  Widget _buildCarouselImage(BuildContext context, String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        height: 250,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        imageUrl: image,
      ),
    );
  }

  Widget _buildCarouselOverlay(BuildContext context, String name) {
    return Container(
      height: 250,
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 170.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          name,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int activeIndex) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.all(8),
        decoration: _buildCategoryDecoration(),
        child: Stack(
          children: [
            _buildCategoryImage(),
            _buildCategoryOverlay(),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    Get.to(() => CategoryNews(name: categoryName));
  }

  BoxDecoration _buildCategoryDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildCategoryImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.asset(
        image,
        width: 120,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCategoryOverlay() {
    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.black38,
      ),
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({
    required this.desc,
    required this.imageUrl,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBlogImage(),
                  SizedBox(width: 8.0),
                  _buildBlogContent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    Get.to(() => ArticleView(blogUrl: url));
  }

  Widget _buildBlogImage() {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBlogContent(BuildContext context) {
    return Column(
      children: [
        _buildBlogTitle(context),
        SizedBox(height: 7.0),
        _buildBlogDescription(context),
      ],
    );
  }

  Widget _buildBlogTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: Text(
        title,
        maxLines: 2,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 17.0,
        ),
      ),
    );
  }

  Widget _buildBlogDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: Text(
        desc,
        maxLines: 3,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
