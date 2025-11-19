import 'package:get/get.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/services/slider_data.dart';

class AllNewsController extends GetxController {
  var sliders = <sliderModel>[].obs;
  var articles = <ArticleModel>[].obs;
  final String newsType;

  AllNewsController({required this.newsType});

  @override
  void onInit() {
    super.onInit();
    getSlider();
    getNews();
  }

  Future<void> getNews() async {
    try {
      News newsclass = News();
      await newsclass.getNews();
      articles.value = newsclass.news;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> getSlider() async {
    try {
      Sliders slider = Sliders();
      await slider.getSlider();
      sliders.value = slider.sliders;
    } catch (e) {
      // Handle error
    }
  }
}

