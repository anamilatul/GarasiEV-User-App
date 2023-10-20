import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/presentation/my_order/widget/card_my_order.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';

import '../../bloc/my_order/my_order_bloc.dart';
import '../../data/models/my_order_response_model.dart';
import 'detail_order_page.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<MyOrderBloc>().add(const MyOrderEvent.getMyOrder());
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<MyOrderViewModel>(context, listen: false).fetchOrders();
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: ColorResources.primaryMaterial,
        title: Text(
          'My Orders',
          style: poppinsRegularLarge,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Ordered'),
            Tab(text: 'Processed'),
            Tab(text: 'Finished'),
          ],
          labelStyle: poppinsRegularLarge,
          unselectedLabelStyle: poppinsRegular,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              return state.when(
                initial: () =>
                    Center(child: CircularProgressIndicator.adaptive()),
                loading: () =>
                    Center(child: CircularProgressIndicator.adaptive()),
                error: (error) => Center(child: Text(error)),
                loaded: (data) => _buildOrderedTab(data),
              );
            },
          ),
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              return state.when(
                initial: () => CircularProgressIndicator.adaptive(),
                loading: () => CircularProgressIndicator.adaptive(),
                error: (error) => Center(child: Text(error)),
                loaded: (data) => _buildProcessedTab(data),
              );
            },
          ),
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              return state.when(
                initial: () => CircularProgressIndicator.adaptive(),
                loading: () => CircularProgressIndicator.adaptive(),
                error: (error) => Center(child: Text(error)),
                loaded: (data) => _buildFinishedTab(data),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderedTab(MyOrderResponseModel data) {
    final orderedOrders =
        data.data.where((order) => order.orderStatus == 'ordered').toList();

    if (orderedOrders.isEmpty) {
      return _listIsEmpty();
    }

    return ListView.builder(
      itemCount: orderedOrders.length,
      itemBuilder: (context, index) {
        final order = orderedOrders[index];
        final firstOrderItem =
            order.orderItems.isNotEmpty ? order.orderItems.first : null;
        if (firstOrderItem != null) {
          return CardMyOrder(
            imageUrl: firstOrderItem.product.imageUrl,
            orderNumber: '${order.number}',
            orderDate: '${order.createdAt.toString()}',
            totalPrice: '${order.totalPrice}'.priceFormat(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailOrderPage(order: order),
                ),
              );
            },
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildProcessedTab(MyOrderResponseModel data) {
    final processedOrders =
        data.data.where((order) => order.orderStatus == 'processed').toList();

    if (processedOrders.isEmpty) {
      return _listIsEmpty();
    }

    return ListView.builder(
      itemCount: processedOrders.length,
      itemBuilder: (context, index) {
        final order = processedOrders[index];
        final firstOrderItem =
            order.orderItems.isNotEmpty ? order.orderItems.first : null;
        if (firstOrderItem != null) {
          return CardMyOrder(
            imageUrl: firstOrderItem.product.imageUrl,
            orderNumber: '${order.number}',
            orderDate: '${order.createdAt.toString()}',
            totalPrice: '${order.totalPrice}'.priceFormat(),
            onTap: () {
              // Navigasi ke halaman detail pesanan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailOrderPage(order: order),
                ),
              );
            },
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildFinishedTab(MyOrderResponseModel data) {
    final finishedOrders =
        data.data.where((order) => order.orderStatus == 'finished').toList();

    if (finishedOrders.isEmpty) {
      return _listIsEmpty();
    }

    return ListView.builder(
      itemCount: finishedOrders.length,
      itemBuilder: (context, index) {
        final order = finishedOrders[index];
        final firstOrderItem =
            order.orderItems.isNotEmpty ? order.orderItems.first : null;
        if (firstOrderItem != null) {
          return CardMyOrder(
            imageUrl: firstOrderItem.product.imageUrl,
            orderNumber: '${order.number}',
            orderDate: '${order.createdAt.toString()}',
            totalPrice: '${order.totalPrice}'.priceFormat(),
            onTap: () {
              // Navigasi ke halaman detail pesanan
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailOrderPage(order: order),
                ),
              );
            },
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _listIsEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.bike_scooter_outlined,
            color: Colors.grey,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'You have not ordered anything yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
