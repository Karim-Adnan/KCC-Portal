import 'package:KCC_Portal/components/forum_components/forum_card.dart';
import 'package:KCC_Portal/database.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchForum extends StatefulWidget {
  @override
  _SearchForumState createState() => _SearchForumState();
}

class _SearchForumState extends State<SearchForum> {
  Stream myStream;
  List<String> searchedValue = [];
  var _searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  bool isLoading = false;

  List<String> suggestions = [];
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  bool showWhichErrorText = false;

  @override
  void initState() {
    super.initState();
    getSuggestions();
  }

  getSuggestions() async {
    setState(() {
      isLoading = true;
    });
    suggestions.clear();
    final QuerySnapshot hashtagResult =
        await FirebaseFirestore.instance.collection('hashtagSuggestions').get();

    if (hashtagResult.docs.length != 0) {
      final List<DocumentSnapshot> documents = hashtagResult.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            suggestions.add(document.reference.id);
          }
        });
      }
    }

    final QuerySnapshot titleResult = await postCollection.get();

    if (titleResult.docs.length != 0) {
      final List<DocumentSnapshot> documents = titleResult.docs;
      if (this.mounted) {
        setState(() {
          for (var document in documents) {
            suggestions.add(document.data()['title']);
            if (document.data()['title'].toString().split(" ").length >= 2) {
              for (var i in document.data()['title'].toString().split(" ")) {
                suggestions.add(i);
              }
            }
          }
        });
      }
    }

    print("suggestions=$suggestions");

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.16),
                          offset: Offset(0, 3),
                          blurRadius: 6)
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: SimpleAutoCompleteTextField(
                          key: key,
                          controller: _searchController,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Add hashtag',
                            hintStyle: GoogleFonts.nunito(color: Colors.grey),
                          ),
                          textCapitalization: TextCapitalization.none,
                          suggestions: suggestions,
                          textChanged: (text) => currentText = text,
                          clearOnSubmit: false,
                          textSubmitted: (text) async {
                            if (text != "") {
                              setState(() {
                                // searchedValue = text;
                                for (var i in text.split(" ")) {
                                  searchedValue.add(i);
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.black45,
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                searchedValue.clear();
                              });
                            },
                          )
                        : Icon(
                            Icons.search,
                            color: Colors.black45,
                            size: 30,
                          )
                  ],
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: postCollection
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return snapshot.data.documents.length == 0
                      ? Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: size.height * 0.5,
                                  width: size.width * 0.7,
                                  child: Image.asset(
                                      "assets/illustrations/no_posts.png"),
                                ),
                                Text(
                                  "No Posts",
                                  style: GoogleFonts.nunito(
                                    fontSize: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot post =
                                  snapshot.data.documents[index];

                              if ((searchedValue.any((element) => post
                                          .data()['title']
                                          .toString()
                                          .toLowerCase()
                                          .contains(element
                                              .toString()
                                              .toLowerCase())) ||
                                      searchedValue.any((element) => post
                                          .data()['tags']
                                          .contains(element))) &&
                                  (searchedValue.length != 0)) {
                                return ForumCard(
                                  name: post.data()['name'],
                                  id: post.data()['id'],
                                  profilePic: post.data()['profilePic'],
                                  sem: post.data()['sem'],
                                  email: post.data()['email'],
                                  tags: post.data()['tags'],
                                  date: post.data()['date'],
                                  time: post.data()['time'],
                                  title: post.data()['title'],
                                  attachment: post.data()['attachment'],
                                  question: post.data()['question'],
                                  votes: post.data()['votes'],
                                  answers: post.data()['answers'],
                                  views: post.data()['views'],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
