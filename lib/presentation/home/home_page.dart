import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/category/category_bloc.dart';
import 'package:flutter_garasi_ev/presentation/product/all_product_page.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/checkout/checkout_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../auth/login_page.dart';
import '../cart/cart_page.dart';
import 'widgets/banner.dart';
import 'widgets/category_item.dart';
import 'widgets/product_item.dart';
import '../search/search_brand.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  // bool singleVendor = false;
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getAll());
    context.read<CategoryBloc>().add(const CategoryEvent.getCategory());

    super.initState();
    // loadUserName();
  }

  // String username = "";
  // Future<void> loadUserName() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final authJson = preferences.getString('auth') ?? '';
  //   final authModel = AuthResponseModel.fromJson(authJson);
  //   setState(() {
  //     username = authModel.user.name; // Set nama pengguna ke dalam state
  //   });
  // }

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
                        onPressed: () async {
                          // Cek apakah token tersedia
                          final SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          final String? authJson =
                              preferences.getString('auth');
                          if (authJson != null && authJson.isNotEmpty) {
                            // Token tersedia, navigasi ke halaman Cart
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return CartPage();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween =
                                      Tween(begin: begin, end: end).chain(
                                    CurveTween(curve: curve),
                                  );

                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 1000),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Sorry, the feature cannot be accessed. You must login now!"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }
                        },
                        icon: Stack(clipBehavior: Clip.none, children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: ColorResources.black,
                            size: 28,
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: ColorResources.red,
                              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return Text(
                                      '10',
                                      style: poppinsSemiBold.copyWith(
                                        color: ColorResources.white,
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                      ),
                                    );
                                  }, loaded: (product) {
                                    int totalQuantity = 0;
                                    product.forEach(
                                      (element) {
                                        totalQuantity += element.quantity;
                                      },
                                    );
                                    return Text(
                                      '$totalQuantity',
                                      style: poppinsSemiBold.copyWith(
                                        color: ColorResources.white,
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                      ),
                                    );
                                  });
                                },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return SearchBrand();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );

                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            transitionDuration:
                                const Duration(milliseconds: 700),
                          ),
                        );
                      },
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
                            color: const Color.fromARGB(255, 245, 245, 245),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeExtraLarge),
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
                                  // decoration: BoxDecoration(
                                  //   color: Theme.of(context).primaryColor,
                                  //   borderRadius: const BorderRadius.all(
                                  //     Radius.circular(
                                  //         Dimensions.paddingSizeExtraSmall),
                                  //   ),
                                  // ),
                                  child: Icon(Icons.search,
                                      color:
                                          const Color.fromARGB(255, 45, 44, 44),
                                      size: Dimensions.iconSizeDefault),
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
                        const BannerWidget(),
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
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return state.maybeWhen(orElse: () {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 3,
                                  ),
                                  itemCount: 3, // Tampilkan 3 placeholder
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.paddingSizeExtraLarge),
                                      ),
                                    );
                                  },
                                ),
                              );
                              // return const Center(
                              //   child: CircularProgressIndicator(),
                              // );
                            }, loaded: (model) {
                              final filteredData = model.data
                                      ?.where((item) =>
                                          item.name != "Newest" &&
                                          item.name != "Best Seller" &&
                                          item.name != "Recomendation")
                                      .toList() ??
                                  [];

                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 3,
                                ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('Recomended for you',
                                    style: titleHeader),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return AllProductPage();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween =
                                            Tween(begin: begin, end: end).chain(
                                          CurveTween(curve: curve),
                                        );

                                        var offsetAnimation =
                                            animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 1000),
                                    ),
                                  );
                                },
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                      color: ColorResources.primaryMaterial),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // BlocBuilder<ProductBloc, ProductState>(
                //   builder: (context, state) {
                //     return state.maybeWhen(
                //       orElse: () {
                //         return SliverPadding(
                //           padding: const EdgeInsets.symmetric(horizontal: 16),
                //           sliver: SliverGrid(
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 1,
                //               mainAxisSpacing: 10.0,
                //               crossAxisSpacing: 10.0,
                //               childAspectRatio: 1.5 / 2,
                //             ),
                //             delegate: SliverChildBuilderDelegate(
                //               (BuildContext context, int index) {
                //                 return const Center(
                //                   child: CircularProgressIndicator(),
                //                 );
                //               },
                //               childCount: 1,
                //             ),
                //           ),
                //         );
                //       },
                //       loaded: (model) {
                //         final products = model.data!
                //             .where((product) =>
                //                 product.category?.name == "Recomendation")
                //             .toList();

                //         return SliverPadding(
                //           padding: const EdgeInsets.symmetric(horizontal: 16),
                //           sliver: SliverGrid(
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2,
                //               mainAxisSpacing: 10.0,
                //               crossAxisSpacing: 10.0,
                //               childAspectRatio: 1.5 / 2,
                //             ),
                //             delegate: SliverChildBuilderDelegate(
                //               (BuildContext context, int index) {
                //                 return ProductItem(
                //                   product: products[
                //                       index], // Menampilkan produk dengan categoryId 4
                //                 );
                //               },
                //               childCount: products.length,
                //             ),
                //           ),
                //         );
                //       },
                //       error: (message) {
                //         return SliverPadding(
                //           padding: const EdgeInsets.symmetric(horizontal: 16),
                //           sliver: SliverGrid(
                //             gridDelegate:
                //                 const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 1,
                //               mainAxisSpacing: 10.0,
                //               crossAxisSpacing: 10.0,
                //               childAspectRatio: 1.5 / 2,
                //             ),
                //             delegate: SliverChildBuilderDelegate(
                //               (BuildContext context, int index) {
                //                 return Center(
                //                   child: Text(message),
                //                 );
                //               },
                //               childCount: 1,
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                // ),

                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0,
                              childAspectRatio: 1.5 / 2,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                              },
                              childCount: 4,
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
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6,
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
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0,
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
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.fromLTRB(
                //         Dimensions.homePagePadding,
                //         Dimensions.paddingSizeSmall,
                //         Dimensions.paddingSizeDefault,
                //         Dimensions.paddingSizeSmall),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Expanded(
                //               child: Text('Recomendation', style: titleHeader),
                //             ),
                //             InkWell(
                //               onTap: () {},
                //               child: Text(
                //                 "See All",
                //                 style: TextStyle(
                //                     color: ColorResources.primaryMaterial),
                //               ),
                //             )
                //           ],
                //         ),
                //         SizedBox(
                //           height: 500,
                //         ),
                //         BlocBuilder<ProductBloc, ProductState>(
                //           builder: (context, state) {
                //             return state.maybeWhen(
                //               orElse: () {
                //                 return const Center(
                //                   child: CircularProgressIndicator.adaptive(),
                //                 );
                //               },
                //               loaded: (model) {
                //                 final newestProducts = model.data!
                //                     .where((product) =>
                //                         product.category?.name ==
                //                         "Recomendation")
                //                     .toList();
                //                 return Expanded(
                //                   child: GridView.builder(
                //                     gridDelegate:
                //                         const SliverGridDelegateWithFixedCrossAxisCount(
                //                       crossAxisCount:
                //                           2, // Ubah jumlah kolom sesuai kebutuhan
                //                       mainAxisSpacing:
                //                           6, // Ubah spasi antar baris
                //                       crossAxisSpacing:
                //                           8, // Ubah spasi antar kolom
                //                     ),
                //                     itemCount: newestProducts.length,
                //                     itemBuilder:
                //                         (BuildContext context, int index) {
                //                       return ProductItem(
                //                           product: newestProducts[index]);
                //                     },
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
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
