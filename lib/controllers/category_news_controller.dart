import 'package:get/get.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/services/show_category_news.dart';

class CategoryNewsController extends GetxController {
  var categories = <ShowCategoryModel>[].obs;
  var loading = true.obs;
  final String categoryName;

  CategoryNewsController({required this.categoryName});

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  Future<void> getNews() async {
    try {
      ShowCategoryNews showCategoryNews = ShowCategoryNews();
      await showCategoryNews.getCategoriesNews(categoryName.toLowerCase());
      categories.value = showCategoryNews.categories;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }
}

