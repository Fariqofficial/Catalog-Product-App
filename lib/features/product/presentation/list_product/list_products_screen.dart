import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_product_app/common/route/app_route.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_summary.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'cubit/list_product_screen_cubit.dart';

part 'widgets/product_items.dart';
part 'widgets/loading.dart';
part 'widgets/not_found_screen.dart';
part 'widgets/cart_item.dart';
part 'widgets/button.dart';

class ListProductsScreen extends StatefulWidget {
  const ListProductsScreen({super.key});

  @override
  State<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends State<ListProductsScreen> {
  late final PagingController<int, Product> _pagingController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  Timer? _debounce;
  bool _showCartBanner = false;
  CartSummary? _currentCartSummary;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      int effectivePageKey = pageKey;
      if (_isSearching) {
        final query = _searchController.text.trim();
        if (query.isNotEmpty) {
          context.read<ListProductScreenCubit>().searchPage(
            query,
            effectivePageKey,
          );
        } else {
          context.read<ListProductScreenCubit>().fetchPage(effectivePageKey);
        }
      } else {
        context.read<ListProductScreenCubit>().fetchPage(effectivePageKey);
      }
    });

    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (_isSearching && query.isEmpty) {
        context.read<ListProductScreenCubit>().cancelSearch();
        _focusNode.unfocus();
        setState(() {
          _isSearching = false;
        });
        _pagingController.refresh();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListProductScreenCubit>().loadQuantities();
      _pagingController.refresh();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(() {});
    _pagingController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });

    if (_isSearching) {
      _focusNode.requestFocus();
    } else {
      _searchController.clear();
      _focusNode.unfocus();
      context.read<ListProductScreenCubit>().cancelSearch();
      _pagingController.refresh();
    }
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty && _isSearching) {
      _pagingController.refresh();
    } else if (_isSearching) {
      _toggleSearch();
    }
  }

  void _showBanner(CartSummary summary) {
    if (summary.totalItems > 0) {
      setState(() {
        _currentCartSummary = summary;
        _showCartBanner = true;
      });
    } else {
      _hideCartBanner();
    }
  }

  void _hideCartBanner() {
    setState(() {
      _showCartBanner = false;
      _currentCartSummary = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ListProductScreenCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _focusNode,
                autofocus: true,
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: IconButton(
                    icon: Icon(
                      _searchController.text.isEmpty
                          ? Icons.search
                          : Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty) {
                        _searchController.clear();
                        cubit.cancelSearch();
                        _pagingController.refresh();
                      } else {
                        _toggleSearch();
                      }
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: _toggleSearch,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
                onSubmitted: (_) => _performSearch(),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  final currentQuery = value.trim();
                  if (_isSearching) {
                    _debounce?.cancel();
                    if (currentQuery.isNotEmpty) {
                      _debounce = Timer(const Duration(milliseconds: 350), () {
                        _pagingController.refresh();
                      });
                    }
                  }
                },
              )
            : Text(
                "Catalog Product",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
        elevation: 1,
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _toggleSearch,
            ),
        ],
      ),
      body: BlocListener<ListProductScreenCubit, ListProductScreenState>(
        listener: (context, state) {
          if (state is ListProductScreenInitial ||
              state is ListProductScreenLoadingMore) {
            return;
          }
          if (state is ListProductScreenSuccess) {
            final isLastPage = !state.hasMore;
            if (isLastPage) {
              _pagingController.appendLastPage(state.data);
            } else {
              final nextPageKey = state.pageKey + 1;
              _pagingController.appendPage(state.data, nextPageKey);
            }
          } else if (state is ListProductScreenError) {
            _pagingController.error = state.errorMessage;
          }
          if (state is ListProductScreenCartSuccess) {
            _showBanner(
              CartSummary(
                totalItems: state.totalItems,
                totalPrice: state.totalPrice,
              ),
            );
          } else if (state is ListProductScreenCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    color: Colors.blueGrey[300],
                    onRefresh: () async => _pagingController.refresh(),
                    child: PagedListView<int, Product>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (_, item, __) {
                          final quantity = cubit.getQuantity(item.id);
                          return _ProductItems(
                            product: item,
                            quantity: quantity,
                            onAddToCart: () => cubit.addToCart(item),
                            onIncrement: () => cubit.addToCart(item),
                            onDecrement: () => cubit.decrementCart(item),
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoute.detailProduct,
                              arguments: item.id,
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) =>
                            const _Loading(),
                        newPageProgressIndicatorBuilder: (_) =>
                            const _Loading(),
                        noItemsFoundIndicatorBuilder: (context) {
                          return BlocBuilder<
                            ListProductScreenCubit,
                            ListProductScreenState
                          >(
                            builder: (context, state) {
                              String message;
                              if (_isSearching &&
                                  _searchController.text.trim().isNotEmpty) {
                                message =
                                    'No products found for "${_searchController.text.trim()}"';
                              } else {
                                message = 'Data Not Found';
                              }
                              return _NotFoundScreen(message: message);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (_showCartBanner) 50.verticalSpace,
              ],
            ),
            if (_showCartBanner)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _CartItems(
                    data: _currentCartSummary!,
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        AppRoute.cartProduct,
                      );
                      if (result == true) {
                        context.read<ListProductScreenCubit>().loadQuantities();
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
