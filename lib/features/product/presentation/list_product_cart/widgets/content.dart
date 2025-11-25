part of '../list_product_cart_screen.dart';

class _Content extends StatelessWidget {
  final List<CartItem> items;
  final bool isManage;
  final List<CartItem> selectedItems;
  final int selectedCount;
  final bool isAllSelected;
  final Function(CartItem) onToggleItem;
  final Function(Product) onDeleteItem;
  final VoidCallback onSelectAll;
  final VoidCallback onRemoveSelected;
  const _Content({
    required this.items,
    required this.isManage,
    required this.selectedItems,
    required this.selectedCount,
    required this.isAllSelected,
    required this.onToggleItem,
    required this.onDeleteItem,
    required this.onSelectAll,
    required this.onRemoveSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (items.isEmpty) _EmptyCart(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedItems.contains(item);
                  return _ProductCartItem(
                    item: item,
                    isManage: isManage,
                    isSelected: isSelected,
                    onDelete: () => onDeleteItem(item.product),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoute.detailProduct,
                      arguments: item.product.id,
                    ),
                    onToggle: isManage ? () => onToggleItem(item) : null,
                  );
                },
                separatorBuilder: (_, _) => Divider(
                  height: 1.h,
                  thickness: 1.sp,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        if (isManage && selectedItems.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ButtonRemoveAll(
                isAllSelected: isAllSelected,
                selectedCount: selectedCount,
                onSelectAll: onSelectAll,
                onRemove: onRemoveSelected,
              ),
            ],
          ),
      ],
    );
  }
}
