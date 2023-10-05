import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Infinite Scroll Pagination Example'),
        ),
        body: MyPaginatedListView(),
      ),
    );
  }
}

class MyPaginatedListView extends StatefulWidget {
  @override
  _MyPaginatedListViewState createState() => _MyPaginatedListViewState();
}

class _MyPaginatedListViewState extends State<MyPaginatedListView> {
  final PagingController<int, int> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final nextPage = await FakeRepository().fetchPage(pageKey);
      final isLastPage = nextPage.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(nextPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(nextPage, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, int>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<int>(
        itemBuilder: (context, item, index) {
          return ListTile(
            title: Text('Item $item'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class FakeRepository {
  Future<List<int>> fetchPage(int pageIndex) async {
    // Simulate fetching data from an API or database
    await Future.delayed(Duration(seconds: 2));
    final itemsPerPage = 10;
    final data = List.generate(itemsPerPage, (i) => pageIndex * itemsPerPage + i);
    return data;
  }
}


