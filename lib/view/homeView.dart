import 'package:flutter/material.dart';

import 'package:my_blog/routes/routesName.dart';
import 'package:provider/provider.dart';

import '../controller/homeController.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var data = context.read<ProductController>().getProducts();
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.accents[9],
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.screenMode);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Mode'),
                            Icon(
                              Icons.sunny,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('settings'),
                          Icon(
                            Icons.settings,
                            color: Colors.black38,
                          )
                        ],
                      ),
                    ),
                  ]),
        ],
        title: const Text('Blogs'),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.transparent,
      //   onPressed: () {
      //     _scrollController.animateTo(
      //       _scrollController.position.maxScrollExtent,
      //       duration: Duration(milliseconds: 500),
      //       curve: Curves.easeOut,
      //     );
      //   },
      //   child: Icon(Icons.arrow_downward),
      // ),
      backgroundColor: Colors.grey,
      body: Consumer<ProductController>(
        builder: (context, value, child) {
          return value.products.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () => data,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding:
                            const EdgeInsets.only(top: 2, left: 6, right: 6),
                        sliver: SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return Card(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 5, right: 10, bottom: 15),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(value
                                            .products[index].thumbnailUrl
                                            .toString()),
                                      ),
                                      Text(
                                        value.products[index].url.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 7, right: 7),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(value
                                                .products[index].thumbnailUrl
                                                .toString()),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text(value.products[index].id
                                            .toString()),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value.products[index].title.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ));
                          }, childCount: value.products.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const CircularProgressIndicator();
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            },
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }
}
