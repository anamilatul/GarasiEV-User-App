import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/category/category_bloc.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/product/product_bloc.dart';
import '../../data/models/auth_response_model.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'widgets/category_item.dart';
import 'widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  static final List<String> imgSlider = [
    'slide1.jpg',
    'slide2.jpg',
    'slide3.jpg',
  ];
  final CarouselSlider autoPlayImage = CarouselSlider(
      items: imgSlider.map((fileImage) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              'assets/images/$fileImage',
              width: 10000,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 210,
        autoPlay: true,
        enlargeCenterPage: true,
        // aspectRatio: 2.0,
      ));

  // bool singleVendor = false;
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getAll());
    context.read<CategoryBloc>().add(const CategoryEvent.getCategory());
    super.initState();
    loadUserName();
  }

  String username = "";
  Future<void> loadUserName() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final authJson = preferences.getString('auth') ?? '';
    final authModel = AuthResponseModel.fromJson(authJson);
    setState(() {
      username = authModel.user.name; // Set nama pengguna ke dalam state
    });
  }

  // Future<void> _loadData(bool reload) async {}

  // void passData(int index, String title) {
  //   index = index;
  //   title = title;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                expandedHeight: 50,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                // title: Text(
                //   'Hai, $username',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 20,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                title: Image.asset(Images.logo, height: 35),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Stack(clipBehavior: Clip.none, children: [
                        // Image.asset(
                        //   Images.cartArrowDownImage,
                        //   height: Dimensions.iconSizeDefault,
                        //   width: Dimensions.iconSizeDefault,
                        //   color: ColorResources.getPrimary(context),
                        // ),
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: ColorResources.primaryMaterial,
                          size: 28,
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: ColorResources.red,
                            child: Text(
                              '10',
                              style: poppinsSemiBold.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.homePagePadding,
                          vertical: Dimensions.paddingSizeSmall),
                      color: ColorResources.white,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: Dimensions.homePagePadding,
                          right: Dimensions.paddingSizeExtraSmall,
                          top: Dimensions.paddingSizeExtraSmall,
                          bottom: Dimensions.paddingSizeExtraSmall,
                        ),
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraSmall),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Search',
                                style: poppinsRegular.copyWith(
                                    color: Theme.of(context).hintColor),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.paddingSizeExtraSmall))),
                                child: Icon(Icons.search,
                                    color: Theme.of(context).cardColor,
                                    size: Dimensions.iconSizeSmall),
                              ),
                            ]),
                      ),
                    ),
                  ))),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.homePagePadding,
                      Dimensions.paddingSizeSmall,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      Container(
                        child: autoPlayImage,
                      ),
                      // const BannerWidget(),
                      const SizedBox(height: Dimensions.homePagePadding),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Categories",
                              style: titleHeader,
                            ),
                          ],
                        ),
                        // child: TitleRow(
                        //   title: 'Categories',
                        //   onTap: () {},
                        // ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.homePagePadding),
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return state.maybeWhen(orElse: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }, loaded: (model) {
                              final filteredData = model.data
                                      ?.where((item) =>
                                          item.name != "Newest" &&
                                          item.name != "Best Seller")
                                      .toList() ??
                                  [];

                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: (1 / 1.3),
                                ),
                                // itemCount: model.data!.length,
                                itemCount: filteredData.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => const CategoryProductsPage(
                                      //       isBrand: false,
                                      //       id: '1',
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    child: CategoryItem(
                                      // category: model.data![index],
                                      category: filteredData[index],
                                    ),
                                  );
                                },
                              );
                            }, error: (message) {
                              return const Center(
                                child: Text("Server Error"),
                              );
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Row(children: [
                          Expanded(child: Text('Products', style: titleHeader)),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                    loaded: (model) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ProductItem(
                                product: model.data![index],
                              );
                            },
                            childCount: model.data!.length,
                          ),
                        ),
                      );
                    },
                    error: (message) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Center(
                                child: Text(message),
                              );
                            },
                            childCount: 1,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
