import 'package:flutter/material.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/model/transaction.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/utils/currency_formater.dart';
import 'package:kro_banking/utils/date_formater.dart';

class TransactionTabs extends StatefulWidget {
  final List<Transaction> transactions;

  const TransactionTabs({super.key, required this.transactions});

  @override
  _TransactionTabsState createState() => _TransactionTabsState();
}

class _TransactionTabsState extends State<TransactionTabs> {
  late List<Transaction> _filteredTransactions;
  final TextEditingController _filterController = TextEditingController();
  final int _rowsPerPage = 20;
  int _currentPage = 0;
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'In', 'Out'];
  final String _selectedStatus = 'All';
  String _selectedType = 'All';
  String _selectedSortOrder = 'Descending';
  final List<String> _sortOrderOptions = ['Ascending', 'Descending'];
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _filteredTransactions = widget.transactions;
    _filterTransactions();
  }

  void _filterTransactions() {
    setState(() {
      _filteredTransactions = widget.transactions.where((transaction) {
        bool matchesFilter = _selectedFilter == 'All' ||
            (_selectedFilter == 'In' && transaction.amount > 0) ||
            (_selectedFilter == 'Out' && transaction.amount < 0);
        bool matchesStatus = _selectedStatus == 'All' || false;
        bool matchesType =
            _selectedType == 'All' || transaction.type == _selectedType;
        bool matchesDateRange = _selectedDateRange == null ||
            (transaction.dateTime.isAfter(_selectedDateRange!.start) &&
                transaction.dateTime.isBefore(_selectedDateRange!.end));
        return matchesFilter &&
            matchesStatus &&
            matchesType &&
            matchesDateRange;
      }).toList();
      _sortTransactions();
    });
  }

  void _sortTransactions() {
    _filteredTransactions.sort((a, b) {
      int comparison = _selectedSortOrder == 'Ascending'
          ? a.dateTime.compareTo(b.dateTime)
          : b.dateTime.compareTo(a.dateTime);
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
        _filterTransactions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int start = _currentPage * _rowsPerPage;
    int end = start + _rowsPerPage;
    end =
        end > _filteredTransactions.length ? _filteredTransactions.length : end;
    List<Transaction> transactionsToShow =
        _filteredTransactions.sublist(start, end);

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
                Tab(text: 'All Transactions'),
                Tab(text: 'In Transactions'),
                Tab(text: 'Out Transactions'),
              ],
              onTap: (index) {
                setState(() {
                  _selectedFilter = _filterOptions[index];
                  _filterTransactions();
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
                      hintText: 'Search Transactions',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _filterController.clear();
                          _filterTransactions();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _filterTransactions();
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
              _buildDropdown('Type', ['All', 'Opening', 'Debit', 'Deposit'],
                  (value) {
                setState(() {
                  _selectedType = value!;
                  _filterTransactions();
                });
              }),
              _buildDropdown('Sort By Date', _sortOrderOptions, (value) {
                setState(() {
                  _selectedSortOrder = value!;
                  _sortTransactions();
                });
              }),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildTransactionList(transactionsToShow),
                _buildTransactionList(transactionsToShow),
                _buildTransactionList(transactionsToShow),
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
                  '${_currentPage + 1} / ${(_filteredTransactions.length / _rowsPerPage).ceil()}'),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: (_currentPage + 1) * _rowsPerPage <
                        _filteredTransactions.length
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

  Widget _buildTransactionList(List<Transaction> transactions) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        bool isDebit = transaction.isDebit;

        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: !isDebit
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
            ),
            child: Icon(isDebit ? Icons.arrow_outward : Icons.arrow_back),
          ),
          title: Text(
            transaction.description,
            style: context.textTheme.titleMedium,
          ),
          subtitle: Text(
            formatDate(transaction.dateTime),
            style: context.textTheme.titleMedium,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Amount:   ${appCurrency(transaction.amount)}',
                style: context.textTheme.titleMedium,
              ),
              Text(
                'Balance:  ${appCurrency(transaction.balance)}',
                style: context.textTheme.titleMedium,
              ),
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
            value: label == 'Type' ? _selectedType : _selectedSortOrder,
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
