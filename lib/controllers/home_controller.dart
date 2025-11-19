import 'package:get/get.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:newsapp/services/data.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/services/slider_data.dart';

class HomeController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var sliders = <sliderModel>[].obs;
  var articles = <ArticleModel>[].obs;
  var loading = true.obs;
  var loading2 = true.obs;
  var activeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    categories.value = getCategories();
    getSlider();
    getNews();
  }

  Future<void> getNews() async {
    try {
      News newsclass = News();
      await newsclass.getNews();
      articles.value = newsclass.news;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> getSlider() async {
    try {
      Sliders slider = Sliders();
      await slider.getSlider();
      sliders.value = slider.sliders;
      loading2.value = false;
    } catch (e) {
      loading2.value = false;
    }
  }

  void updateActiveIndex(int index) {
    activeIndex.value = index;
  }
}

