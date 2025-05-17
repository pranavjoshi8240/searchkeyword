import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchkeyword/View/SearchScreen/search_screen_controller.dart';
import 'package:searchkeyword/utils/app_strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchScreenView extends GetView<SearchScreenController> {
  static const String routeName = "/homeScreen";

  const SearchScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D26),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                AppStrings.appTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                AppStrings.appSubtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            // Just clear the results but keep the text
                            if (value.isEmpty && controller.hasSearched) {
                              controller.clearData();
                            }
                          },
                          onSubmitted: (value) {
                            controller.updateSearchQuery();
                          },
                          decoration: const InputDecoration(
                            hintText: AppStrings.searchHint,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          style: const TextStyle(fontSize: 16),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      GetBuilder<SearchScreenController>(
                        builder: (_) => GestureDetector(
                          onTap: () {
                            if (controller.isSearching.value) {
                              // Do nothing if already searching
                              return;
                            }

                            if (controller.hasResults()) {
                              // Clear data and text field
                              controller.searchController.clear();
                              controller.clearData();
                            } else if (controller.searchController.text.trim().isNotEmpty) {
                              // Perform search if text field is not empty
                              controller.updateSearchQuery();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Enter text in above field",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 100,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Obx(() => controller.isSearching.value ?
                            // Loading state
                            const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            ) :
                            // Show "Clear" only when we have results, otherwise show "Search"
                            Center(
                              child: Text(
                                controller.hasResults()
                                    ? AppStrings.clearButtonText
                                    : AppStrings.searchButtonText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GetBuilder<SearchScreenController>(
                  builder: (_) {
                    if (controller.isSearching.value) {
                      return const Center(child: CircularProgressIndicator(color: Colors.white));
                    } else if (controller.hasSearched && !controller.hasResults()) {
                      return const Center(
                        child: Text(
                          AppStrings.noResultsFound,
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      );
                    } else if (!controller.hasSearched) {
                      // Show empty state when no search has been performed
                      return const Center(
                        child: Text(
                          AppStrings.enterSearchTerm,
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            // Original Suggestions
                            if (controller.originalSuggestions.isNotEmpty)
                              _buildSuggestionSection(AppStrings.suggestionsSectionTitle, controller.originalSuggestions),

                            // Alphabet Variations
                            if (controller.alphabetVariations.isNotEmpty)
                              _buildSuggestionSection(AppStrings.alphabetVariationsSectionTitle, controller.alphabetVariations),

                            // Question Variations
                            if (controller.questions.isNotEmpty)
                              _buildSuggestionSection(AppStrings.questionVariationsSectionTitle, controller.questions),

                            // Common Phrases
                            if (controller.commonPhrases.isNotEmpty)
                              _buildSuggestionSection(AppStrings.commonPhrasesSectionTitle, controller.commonPhrases),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionSection(String title, List<String> suggestions) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color(0xFF30354A),
              width: 1
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => controller.selectResult(suggestions[index]),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF222530),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF30354A), width: 1)
                    ),
                    child: Text(
                      suggestions[index],
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}