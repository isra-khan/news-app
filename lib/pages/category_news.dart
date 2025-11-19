import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/category_news_controller.dart';
import 'package:newsapp/pages/article_view.dart';

class CategoryNews extends StatelessWidget {
  final String name;

  CategoryNews({required this.name});

  @override
  Widget build(BuildContext context) {
    final CategoryNewsController controller =
        Get.put(CategoryNewsController(categoryName: name));

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildBody(CategoryNewsController controller) {
    return Obx(() => controller.loading.value
        ? _buildLoadingIndicator()
        : _buildNewsList(controller));
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildNewsList(CategoryNewsController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) => _buildNewsItem(controller, index),
      ),
    );
  }

  Widget _buildNewsItem(CategoryNewsController controller, int index) {
    return ShowCategory(
      image: controller.categories[index].urlToImage!,
      desc: controller.categories[index].description!,
      title: controller.categories[index].title!,
      url: controller.categories[index].url!,
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;

  ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategoryImage(context),
            _buildCategoryContent(),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    Get.to(() => ArticleView(blogUrl: url));
  }

  Widget _buildCategoryImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        width: MediaQuery.of(context).size.width,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCategoryContent() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.0),
          _buildTitle(),
          SizedBox(height: 5.0),
          _buildDescription(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      maxLines: 2,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      desc,
      maxLines: 3,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      ),
    );
  }
}
