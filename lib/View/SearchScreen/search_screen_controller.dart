import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class SearchScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String searchQuery = '';
  List<String> originalSuggestions = [];
  List<String> alphabetVariations = [];
  List<String> questions = [];
  List<String> commonPhrases = [];
  RxBool isSearching = false.obs;
  bool hasSearched = false;

  void updateSearchQuery() {
    searchQuery = searchController.text;
    performSearch();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void clearData() {
    originalSuggestions = [];
    alphabetVariations = [];
    questions = [];
    commonPhrases = [];
    hasSearched = false; // Reset hasSearched flag when clearing data
    update(); // Add this to notify GetBuilder to rebuild the UI
  }

  void performSearch() async {
    if (searchQuery.trim().isEmpty) {
      clearData(); // Clear data if search query is empty
      return;
    }

    isSearching.value = true;
    hasSearched = true;
    update(); // Update UI state

    try {
      await fetchSuggestions(searchQuery);
    } catch (e) {
      // Clear all suggestion lists
      originalSuggestions = [];
      alphabetVariations = [];
      questions = [];
      commonPhrases = [];
      Get.snackbar(
        'Error',
        'Failed to fetch search results: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isSearching.value = false;
    update(); // Update UI state
  }

  Future<void> fetchSuggestions(String query) async {
    try {
      HttpClient client = HttpClient()
        ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      final encodedQuery = Uri.encodeComponent(query);
      final url = 'https://smart-words.vercel.app/api/suggestions?q=$encodedQuery';
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(responseBody);
        originalSuggestions = data.containsKey('originalSuggestions') && data['originalSuggestions'] is List
            ? List<String>.from(data['originalSuggestions'])
            : [];
        alphabetVariations = data.containsKey('alphabetVariations') && data['alphabetVariations'] is List
            ? List<String>.from(data['alphabetVariations'])
            : [];
        questions = data.containsKey('questions') && data['questions'] is List
            ? List<String>.from(data['questions'])
            : [];
        commonPhrases = data.containsKey('commonPhrases') && data['commonPhrases'] is List
            ? List<String>.from(data['commonPhrases'])
            : [];
      } else {
        throw Exception('Failed to load suggestions: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching suggestions: $e');
      }
      throw Exception('Error fetching suggestions: $e');
    }
  }

  void selectResult(String result) {
    searchController.text = result;
    searchQuery = result;
    performSearch();
    Get.snackbar(
      'Selected',
      'You selected: $result',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}