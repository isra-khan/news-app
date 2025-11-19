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
      appBar: AppBar(
        title: Text(
          "$news News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Obx(() => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: news == "Breaking"
                  ? controller.sliders.length
                  : controller.articles.length,
              itemBuilder: (context, index) {
                return AllNewsSection(
                  image: news == "Breaking"
                      ? controller.sliders[index].urlToImage!
                      : controller.articles[index].urlToImage!,
                  desc: news == "Breaking"
                      ? controller.sliders[index].description!
                      : controller.articles[index].description!,
                  title: news == "Breaking"
                      ? controller.sliders[index].title!
                      : controller.articles[index].title!,
                  url: news == "Breaking"
                      ? controller.sliders[index].url!
                      : controller.articles[index].url!,
                );
              },
            ),
          )),
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
      onTap: () {
        Get.to(() => ArticleView(blogUrl: url));
      },
      child: Card(
        elevation: 3.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    desc,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
