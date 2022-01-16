import 'package:devstore_project/routes/searched_items.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class Search extends StatefulWidget {
  const Search({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _SearchSearchDelegate _delegate = _SearchSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: InkWell(
          onTap: () async {
            final int? selected = await showSearch<int>(
              context: context,
              delegate: _delegate,
            );
          },
          child: Text(
            "Search",
            style: GoogleFonts.openSans(
              color: Colors.black45,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),*/
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Padding(
                          padding: Dimen.searchBarPadding,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () => {
                                        Navigator.of(context).pop()
                                        /*
                                        if (!FocusScope.of(context).isFirstFocus ||
                                            FocusScope.of(context).hasPrimaryFocus) {
                                          Navigator.of(context).pop(),
                                        }
                                        else {
                                          FocusScope.of(context).unfocus(),
                                        }
                                         */
                                      },
                                      icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    child: TextField(
                                      controller: myController,
                                      cursorColor: AppColors.primaryColor,
                                      style: homePage_SearchBar,
                                      decoration: InputDecoration(
                                        fillColor: AppColors.secondaryColor,
                                        filled: true,
                                        hintText: "Search a product",
                                        hintStyle: homePage_SearchBar,
                                        contentPadding: EdgeInsets.all(10),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          const BoxShadow(
                                            offset: Offset(0,3),
                                            spreadRadius: 0.5,
                                            blurRadius: 10,
                                            color: AppColors.loginSearchShadow,
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    pushNewScreen(context,
                                      screen: SearchedItems(text: myController.text, analytics: widget.analytics, observer: widget.observer),
                                    );
                                  },
                                  icon: Icon(Icons.search),
                                )
                              ]
                          ),
                        ),
                      Padding(
                        padding: Dimen.emptyIllustPadding,
                        child: emptyHistory(),
                      ),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}

Widget searchBar(BuildContext context, _SearchSearchDelegate _delegate) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () => {
                Navigator.of(context).pop()
                /*
              if (!FocusScope.of(context).isFirstFocus ||
                  FocusScope.of(context).hasPrimaryFocus) {
                Navigator.of(context).pop(),
              }
              else {
                FocusScope.of(context).unfocus(),
              }
               */
              },
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: TextField(
              onTap: () => {
                showSearch(
                    context: context,
                    delegate: _delegate)
              },
              cursorColor: AppColors.primaryColor,
              style: homePage_SearchBar,
              decoration: InputDecoration(
                fillColor: AppColors.secondaryColor,
                filled: true,
                hintText: "Search a product",
                hintStyle: homePage_SearchBar,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                    offset: Offset(0,3),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    color: AppColors.loginSearchShadow,
                  ),
                ]
            ),
          ),
        )
      ]
  );
}

Widget emptyHistory() {
  return Container(
    child: Column(
        children: [
          Image.asset(
              "assets/empty_illust.png"
          ),
          SizedBox(height:10),
          Text(
            "Let me help you to buy a brand\nnew phone.",
            textAlign: TextAlign.center,
            style: searchPage_EmptySearchBold,
          ),
          SizedBox(height:5),
          Text(
            "What about the new iPhone?\nType \"iPhone 13 Pro\"",
            textAlign: TextAlign.center,
            style: searchPage_EmptySearchNormal,
          )
        ]
    ),
  );
}

class _SearchSearchDelegate extends SearchDelegate<int> {
  final List<String> _data = [
    'iPhone 13', 'Macbook Pro', 'Samsung TV', 'Xiaomi 10T', 'Beko Fridge'
  ];
  final List<String> _history = [
    'iPhone 13', 'Macbook Pro', 'Samsung TV', 'Xiaomi 10T', 'Beko Fridge'
  ];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 0);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _data.where((String i) => '$i'.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((String i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String? searched = query;
    if (searched == null || !_data.contains(searched)) {
      return Center(
        child: Text(
          'Sorry, I could not find anything with "$query".\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? SizedBox()
          : IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.integer, required this.title, required this.searchDelegate});

  final String integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, 0);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$integer',
                style: theme.textTheme.headline1!.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList(
      {required this.suggestions, required this.query, required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style:
              theme.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
