import 'package:amazing_tv/featsures/shows/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/search_box.dart';
import '../widgets/search_results_custom.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _StateSearchScreen createState() => _StateSearchScreen();
}

class _StateSearchScreen extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;

  final _searchFieldNode = FocusNode();
  final _searchFieldController = TextEditingController();

  bool isVisibleSearch = false;
  bool _showResult = false;

  String get _searchKeyword => _searchFieldController.text;

  void _onFocusChange() {
    if (_searchKeyword.isEmpty && !_searchFieldNode.hasFocus) {
      _showResult = false;
    } else {
      _showResult = !_searchFieldNode.hasFocus;
    }

    Future.delayed(const Duration(milliseconds: 120), () {
      setState(() {
        isVisibleSearch = _searchFieldNode.hasFocus;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _searchFieldNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFieldNode.dispose();
    _searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: searchWidetBar(context),),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   width: double.infinity,
              //   height: 100,
              //   color: Theme.of(context).primaryColor,
              //   child: searchWidetBar(context),
              // ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  child: buildResult(),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget searchWidetBar(BuildContext context) {
    return  Row(
        children: [
          Expanded(
            child: SearchBox(
              controller: _searchFieldController,
              focusNode: _searchFieldNode,
              onChanged: (String value) {
                _onSearchTextChange(value);
              },
              onSubmitted: (String value) {
                _onSubmit(value);
              },
              onCancel: () {
                setState(() {
                  isVisibleSearch = false;
                });
              },
            ),
          ),
        ],
      );
  }
  void _onSearchTextChange(String value, ) {
    if (value.isEmpty) {
      _showResult = false;
      setState(() {});
      return;
    }
    if (_searchFieldNode.hasFocus) {
      sl<SearchBloc>()
          .add(GetSearchEvent(quary: value));
    }
  }
  Widget buildResult() {
    return SearchResultsCustom(
      keyWord: _searchKeyword,
    );
  }

  void _onSubmit(
    String name,
  ) {
    _searchFieldController.text = name;

   sl<SearchBloc>()
        .add(GetSearchEvent(quary: name));
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
