// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class CompanyInfoScreen extends StatelessWidget {
  final Map<String, dynamic> companyDataFromAlpha;

  CompanyInfoScreen(this.companyDataFromAlpha);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle('Company Information'),
        _buildInfoCard('Name', companyDataFromAlpha['Name']),
        _buildInfoCard('Description', companyDataFromAlpha['Description']),
        _buildInfoCard('Sector', companyDataFromAlpha['Sector']),
        _buildInfoCard('Industry', companyDataFromAlpha['Industry']),
        // Add more company information fields here

        _buildSectionTitle('Financial Information'),
        _buildInfoCard('Market Capitalization',
            '\$${companyDataFromAlpha['MarketCapitalization']}'),
        _buildInfoCard('EBITDA', '\$${companyDataFromAlpha['EBITDA']}'),
        _buildInfoCard('PE Ratio', companyDataFromAlpha['PERatio']),
        // Add more financial information fields here

        _buildSectionTitle('Valuation and Ratios'),
        _buildInfoCard('Analyst Target Price',
            '\$${companyDataFromAlpha['AnalystTargetPrice']}'),
        _buildInfoCard('Trailing PE Ratio', companyDataFromAlpha['TrailingPE']),
        // Add more valuation and ratios fields here

        _buildSectionTitle('52-Week Range'),
        _buildInfoCard(
            '52-Week High', '\$${companyDataFromAlpha['52WeekHigh']}'),
        _buildInfoCard('52-Week Low', '\$${companyDataFromAlpha['52WeekLow']}'),
        // Add 52-week range fields here

        _buildSectionTitle('Share Information'),
        _buildInfoCard(
            'Shares Outstanding', companyDataFromAlpha['SharesOutstanding']),
        _buildInfoCard('Dividend Date', companyDataFromAlpha['DividendDate']),
        _buildInfoCard(
            'Ex-Dividend Date', companyDataFromAlpha['ExDividendDate']),
        // Add share information fields here
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
