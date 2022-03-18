import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleEcommerce extends StatelessWidget {
  const SimpleEcommerce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Builder(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String searchString;

  @override
  void initState() {
    searchString = '';
    super.initState();
  }

  void setSearchString(String value) => setState(() {
        searchString = value;
      });

  @override
  Widget build(BuildContext context) {
    var listViewPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 24);
    List<Widget> searchResultTiles = [];
    if (searchString.isNotEmpty) {
      searchResultTiles = recipeQuery
          .where(
              (p) => p.name.toLowerCase().contains(searchString.toLowerCase()))
          .map(
            (p) => RecipeTile(recipe: p),
          )
          .toList();
    } else {
      searchResultTiles = recipeQuery
          .map(
            (p) => RecipeTile(recipe: p),
          )
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          onChanged: setSearchString,
        ),
      ),
      body: GridView.count(
        padding: listViewPadding,
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: .78,
        children: searchResultTiles,
      ),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({required this.recipe, Key? key}) : super(key: key);
  final Recipe recipe;

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  Recipe get recipe => widget.recipe;
  String? selectedImageUrl;

  @override
  void initState() {
    selectedImageUrl = recipe.imageUrls.first;
    super.initState();
  }

  void setSelectedImageUrl(String url) {
    setState(() {
      selectedImageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    var overviewList = [];
    recipe.overview.forEach((key, value) {
      overviewList.add(key + ": " + value);
    });

    var ingredientList = [];
    recipe.ingredients.forEach((key, value) {
      ingredientList.add(value + " of " + key);
    });

    List<Widget> imagePreviews = recipe.imageUrls
        .map(
          (url) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => setSelectedImageUrl(url),
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: selectedImageUrl == url
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.75)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  url,
                ),
              ),
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recipes"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            color: kGreyBackground,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    selectedImageUrl!,
                    fit: BoxFit.cover,
                    color: kGreyBackground,
                    colorBlendMode: BlendMode.multiply,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagePreviews,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(recipe.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      color: const Color(0xfff5e0ff),
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Overview",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: overviewList
                            .map((overviewLine) => Text(overviewLine.toString()))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      color: const Color(0xfff5e0ff),
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ingredients",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: ingredientList
                            .map((ingredientLine) => Text(ingredientLine.toString()))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      color: const Color(0xfff5e0ff),
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Steps to make it",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(recipe.steps.length,(index){
                          return Text((index+1).toString() + ". " + recipe.steps[index].toString());
                        })
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeTile extends StatelessWidget {
  const RecipeTile({required this.recipe, Key? key}) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        _pushScreen(
          context: context,
          screen: RecipeScreen(recipe: recipe),
        );
      },
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RecipeImage(recipe: recipe),
            const SizedBox(
              height: 8,
            ),
            Text(
              recipe.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeImage extends StatelessWidget {
  const RecipeImage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .95,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: kGreyBackground,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          recipe.imageUrls.first,
          loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
              ? child
              : const Center(child: CircularProgressIndicator()),
          color: kGreyBackground,
          colorBlendMode: BlendMode.multiply,
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({required this.onChanged, Key? key}) : super(key: key);

  final Function(String) onChanged;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        onChanged: widget.onChanged,
        controller: _textEditingController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              kIsWeb ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          hintText: "Search for a recipe",
          suffixIconConstraints: const BoxConstraints(
            minHeight: 36,
            minWidth: 36,
          ),
          suffixIcon: IconButton(
            constraints: const BoxConstraints(
              minHeight: 36,
              minWidth: 36,
            ),
            splashRadius: 24,
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () {
              _textEditingController.clear();
              widget.onChanged(_textEditingController.text);
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      ),
    );
  }
}

void _pushScreen({required BuildContext context, required Widget screen}) {
  ThemeData themeData = Theme.of(context);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Theme(data: themeData, child: screen),
    ),
  );
}

class Recipe {
  final String name;
  final List<String> imageUrls;
  final Map<String, String> overview;
  final Map<String, String> ingredients;
  final List<String> steps;

  Recipe(
      {required this.name,
      required this.imageUrls,
      required this.overview,
      required this.ingredients,
      required this.steps});
}

final kGreyBackground = Colors.grey[200];

List<Recipe> recipeQuery = [
  Recipe(name: "Five-Ingredient Red Curry Chicken", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F3949345.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fpublic-assets-ucg.meredithcorp.io%2F1ca01c330cdaf07953a3f8f7004263e4%2F5087507.jpg&w=595&h=398&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F6264040.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9336824.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Spatchcock Chicken", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fpublic-assets-ucg.meredithcorp.io%2F1d7e43c1254da0c33e443b012553a9d9%2F3608686.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7749452.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8002619.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9169181.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Cheesy Vegetarian Enchilada Casserole", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4558217.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Skillet Chicken Bulgogi", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F2280937.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7765813.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8235573.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8319257.jpg&w=596&h=596&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Lasagna Flatbread", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4019381.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9426301.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7829719.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7742809.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Andie's Quick 'n Easy Sneaky Sloppy Joes", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4398244.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F5057330.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Speckled Trout in Capers and White Wine", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4505375.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8207196.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Grandma's Famous Salmon Cakes", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F785713.jpg&w=272&h=272&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8334524.jpg&w=596&h=792&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Klupskies (Polish Burgers)", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8594250.jpg&w=595&h=791&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8541376.jpg&w=596&h=399&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Simple Macaroni and Cheese", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9440340.jpg&w=595&h=398&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8254086.jpg&w=596&h=596&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Five-Ingredient Red Curry Chicken", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F3949345.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fpublic-assets-ucg.meredithcorp.io%2F1ca01c330cdaf07953a3f8f7004263e4%2F5087507.jpg&w=595&h=398&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F6264040.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9336824.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Spatchcock Chicken", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fpublic-assets-ucg.meredithcorp.io%2F1d7e43c1254da0c33e443b012553a9d9%2F3608686.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7749452.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8002619.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9169181.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Cheesy Vegetarian Enchilada Casserole", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4558217.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Skillet Chicken Bulgogi", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F2280937.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7765813.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8235573.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8319257.jpg&w=596&h=596&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Lasagna Flatbread", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4019381.jpg&w=596&h=596&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9426301.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7829719.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F7742809.jpg&w=595&h=595&c=sc&poi=face&q=60"
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Andie's Quick 'n Easy Sneaky Sloppy Joes", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4398244.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F5057330.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Speckled Trout in Capers and White Wine", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F4505375.jpg&w=595&h=595&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8207196.jpg&w=595&h=595&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Grandma's Famous Salmon Cakes", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F785713.jpg&w=272&h=272&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8334524.jpg&w=596&h=792&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Klupskies (Polish Burgers)", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8594250.jpg&w=595&h=791&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8541376.jpg&w=596&h=399&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
  Recipe(name: "Simple Macaroni and Cheese", imageUrls: [
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F9440340.jpg&w=595&h=398&c=sc&poi=face&q=60",
    "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8254086.jpg&w=596&h=596&c=sc&poi=face&q=60",
  ], overview: {
    "Prep": "15 mins",
    "Cook": "15 mins",
    "Total": "30 mins",
    "Servings": "10 Servings",
    "Yield": "4 Servings"
  }, ingredients: {
    "Oil": "6 Cups",
    "Sesame Seeds": "1/2 Cup",
    "Packed Brown Sugar": "3/4 Cups",
    "Water": "1 Cup",
    "Red Bean Paste": "1 Cup"
  }, steps: [
    "Gather ingredients",
    "Heat oil in a wok to 250F. Ensure at least 3 inches of oil in the wok"
  ]),
];
