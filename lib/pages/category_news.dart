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
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return ShowCategory(
                    image: controller.categories[index].urlToImage!,
                    desc: controller.categories[index].description!,
                    title: controller.categories[index].title!,
                    url: controller.categories[index].url!,
                  );
                },
              ),
            )),
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
      onTap: () {
        Get.to(() => ArticleView(blogUrl: url));
      },
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
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
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
