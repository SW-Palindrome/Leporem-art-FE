import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/review_repository.dart';

class ReviewController extends GetxController {
  final ReviewRepository repository;
  ReviewController({required this.repository}) : assert(repository != null);

  Rx<String> description = Rx<String>('');
  Rx<int> star = 0.obs;

  TextEditingController descriptionController = TextEditingController();

  Future<void> createReview() async {
    await repository.createReview(
        Get.arguments['order'].id, star.value, description.value);
  }
}
