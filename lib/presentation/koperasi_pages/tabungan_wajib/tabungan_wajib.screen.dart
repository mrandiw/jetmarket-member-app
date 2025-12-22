import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/mandatory_saving_model.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controllers/tabungan_wajib.controller.dart';
import 'widget/tabungan_wajib_card.dart';
import 'widget/tabungan_wajib_item.dart';

class TabunganWajibScreen extends GetView<TabunganWajibController> {
  const TabunganWajibScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabungan Wajib'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: CustomScrollView(
          slivers: [
            // Total Card
            SliverToBoxAdapter(
              child: Obx(() => TabunganWajibCard(
                    totalAmount: controller.totalAmount.value,
                    totalRecords: controller.totalRecords.value,
                  )),
            ),

            // History Header
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Riwayat Potongan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // History List
            PagedSliverList<int, MandatorySavingModel>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<MandatorySavingModel>(
                itemBuilder: (context, item, index) => TabunganWajibItem(
                  item: item,
                ),
                noItemsFoundIndicatorBuilder: (_) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.savings_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Belum ada riwayat tabungan wajib',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                firstPageProgressIndicatorBuilder: (_) => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
