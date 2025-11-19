import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/all_news_controller.dart';
import 'package:newsapp/pages/article_view.dart';

class AllNews extends StatelessWidget {
  final String news;

  AllNews({required this.news});

  @override
  Widget build(BuildContext context) {
    final AllNewsController controller =
        Get.put(AllNewsController(newsType: news));

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "$news News",
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  Widget _buildBody(AllNewsController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: _buildNewsList(controller),
        ));
  }

  Widget _buildNewsList(AllNewsController controller) {
    final itemCount = news == "Breaking"
        ? controller.sliders.length
        : controller.articles.length;

    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => _buildNewsItem(controller, index),
    );
  }

  Widget _buildNewsItem(AllNewsController controller, int index) {
    final isBreaking = news == "Breaking";
    final image = isBreaking
        ? controller.sliders[index].urlToImage!
        : controller.articles[index].urlToImage!;
    final desc = isBreaking
        ? controller.sliders[index].description!
        : controller.articles[index].description!;
    final title = isBreaking
        ? controller.sliders[index].title!
        : controller.articles[index].title!;
    final url = isBreaking
        ? controller.sliders[index].url!
        : controller.articles[index].url!;

    return AllNewsSection(
      image: image,
      desc: desc,
      title: title,
      url: url,
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String image, desc, title, url;

  const AllNewsSection({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewsImage(context),
            _buildNewsContent(),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    Get.to(() => ArticleView(blogUrl: url));
  }

  Widget _buildNewsImage(BuildContext context) {
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

  Widget _buildNewsContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
