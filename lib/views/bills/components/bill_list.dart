import 'package:flutter/material.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/bills.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/utils/date_formater.dart';

class BillTabs extends StatefulWidget {
  final List<Bill> bills;

  const BillTabs({super.key, required this.bills});

  @override
  _BillTabsState createState() => _BillTabsState();
}

class _BillTabsState extends State<BillTabs> {
  late List<Bill> _filteredbills;
  final TextEditingController _filterController = TextEditingController();
  final int _rowsPerPage = 20;
  int _currentPage = 0;
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Reoccurring', 'Non-recurring'];
  String _selectedStatus = 'All';
  String _selectedSortOrder = 'Descending';
  final List<String> _sortOrderOptions = ['Ascending', 'Descending'];
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _filteredbills = widget.bills;
    _filterbills();
  }

  void _filterbills() {
    setState(() {
      _filteredbills = widget.bills.where((transaction) {
        bool matchesFilter = _selectedFilter == 'All' ||
            (_selectedFilter == 'Reoccurring' && transaction.reoccurring) ||
            (_selectedFilter == 'Non-recurring' && !transaction.reoccurring);
        bool matchesType =
            _selectedStatus == 'All' || transaction.status == _selectedStatus;
        bool matchesDateRange = _selectedDateRange == null ||
            (transaction.dueDate.isAfter(_selectedDateRange!.start) &&
                transaction.dueDate.isBefore(_selectedDateRange!.end));
        return matchesFilter && matchesType && matchesDateRange;
      }).toList();
      _sortbills();
    });
  }

  void _sortbills() {
    _filteredbills.sort((a, b) {
      int comparison = _selectedSortOrder == 'Ascending'
          ? a.dueDate.compareTo(b.dueDate)
          : b.dueDate.compareTo(a.dueDate);
      return comparison;
    });
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        _filterbills();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int start = _currentPage * _rowsPerPage;
    int end = start + _rowsPerPage;
    end = end > _filteredbills.length ? _filteredbills.length : end;
    List<Bill> billsToShow = _filteredbills.sublist(start, end);

    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.colorScheme.primary.withOpacity(0.2)),
                color: AppColors.kBgWhite,
                borderRadius: BorderRadius.circular(KContents.kRadius.medium)),
            child: TabBar(
              tabs: const [
                Tab(text: 'All Bill'),
                Tab(text: 'Reoccurring '),
                Tab(text: 'Non-Reoccurring'),
              ],
              onTap: (index) {
                setState(() {
                  _selectedFilter = _filterOptions[index];
                  _filterbills();
                });
              },
            ),
          ),
          const SizedBox(
            height: KContents.kCardPadHorizontal,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: context.colorScheme.primary.withOpacity(0.2)),
                      color: AppColors.kBgWhite,
                      borderRadius:
                          BorderRadius.circular(KContents.kRadius.medium)),
                  child: TextField(
                    controller: _filterController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5)),
                      hintText: 'Search Bills',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _filterController.clear();
                          _filterbills();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _filterbills();
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: KContents.kCardPadHorizontal,
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Filter"))
            ],
          ),
          Row(
            children: [
              _buildDropdown('Type', ['All', 'Pending', 'Completed'], (value) {
                setState(() {
                  _selectedStatus = value!;
                  _filterbills();
                });
              }),
              _buildDropdown('Sort By Date', _sortOrderOptions, (value) {
                setState(() {
                  _selectedSortOrder = value!;
                  _sortbills();
                });
              }),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTransactionList(billsToShow),
                _buildTransactionList(billsToShow),
                _buildTransactionList(billsToShow),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed:
                    _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
              ),
              Text(
                  '${_currentPage + 1} / ${(_filteredbills.length / _rowsPerPage).ceil()}'),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed:
                    (_currentPage + 1) * _rowsPerPage < _filteredbills.length
                        ? () => _goToPage(_currentPage + 1)
                        : null,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(List<Bill> bills) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final transaction = bills[index];

        return ListTile(
          isThreeLine: true,
          // leading: Container(
          //   padding: const EdgeInsets.all(15),
          //   decoration: BoxDecoration(
          //     color: transaction.isPending
          //         ? Colors.green.withOpacity(0.2)
          //         : Colors.pr.withOpacity(0.2),
          //   ),
          //   child: Icon(isDebit ? Icons.arrow_outward : Icons.arrow_back),
          // ),
          title: Text(
            transaction.name,
            style: context.textTheme.titleMedium,
          ),
          subtitle: Text(
            "Due Date: ${formatDate(transaction.dueDate)}",
            style: context.textTheme.titleMedium,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '  ${appCurrency(transaction.amount)}',
                style: context.textTheme.titleMedium,
              ),
              Container(
                color: transaction.isPending
                    ? Colors.amber[100]
                    : Colors.green[100],
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Text(transaction.status),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: label == 'Type' ? _selectedStatus : _selectedSortOrder,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
