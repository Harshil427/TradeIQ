// ignore_for_file: file_names

class TradingViewServices {
  static String realTimeChart(String name, bool toolBar) {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div id="tradingview_add7d"></div>
  <div class="tradingview-widget-copyright"><a href="https://in.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "$name",
  "interval": "30",
  "timezone": "Asia/Kolkata",
  "theme": "dark",
  "style": "2",
  "locale": "in",
  "enable_publishing": false,
  "backgroundColor": "rgba(0, 0, 0, 1)",
  "hide_top_toolbar": $toolBar,
  "allow_symbol_change": true,
  "hide_volume": true,
  "container_id": "tradingview_add7d"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->''';
  }

  static String miniChartWidget(String name) {
    return '''
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-mini-symbol-overview.js" async>
  {
  "symbol": "$name",
  "width": "180%",
  "height": "120%",
  "locale": "in",
  "dateRange": "1D",
  "colorTheme": "dark",
  "isTransparent": true,
  "largeChartUrl": "",
  "chartOnly": false
}
  </script>
</div>
<!-- TradingView Widget END -->''';
  }

  static String snaps() {
    return '''
    <div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
  {
  "feedMode": "market",
  "market": "crypto",
  "colorTheme": "dark",
  "isTransparent": false,
  "displayMode": "regular",
  "width": 480,
  "height": 830,
  "locale": "in"
  }
  </script>
  </div>
    ''';
  }

  static String symbolInfoCard(String name) {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-info.js" async>
  {
  "symbol": "$name",
  "width": 1000,
  "locale": "in",
  "colorTheme": "dark",
  "isTransparent": true
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String singleTickerWidget(String name) {
    return '''
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-single-quote.js" async>
  {
  "symbol": "$name",
  "width": "100%",
  "colorTheme": "dark",
  "isTransparent": true,
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
''';
  }

  static String companyProfileWidget(String name) {
    return '''
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-profile.js" async>
  {
  "width": "100%",
  "height": "100%",
  "colorTheme": "dark",
  "isTransparent": true,
  "symbol": "$name",
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
''';
  }

  static String technicalAnalysisWidget(String name) {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-technical-analysis.js" async>
  {
  "interval": "15m",
  "width": "100%",
  "isTransparent": true,
  "height": "100%",
  "symbol": "$name",
  "showIntervalTabs": true,
  "locale": "in",
  "colorTheme": "dark"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String fundamentalDataWidget(String name) {
    return '''
      <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-financials.js" async>
  {
  "colorTheme": "dark",
  "isTransparent": true,
  "largeChartUrl": "",
  "displayMode": "compact",
  "width": "100%",
  "height": "100%",
  "symbol": "$name",
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String snapBySymbol(String name) {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
  {
  "feedMode": "symbol",
  "symbol": "$name",
  "colorTheme": "dark",
  "isTransparent": true,
  "displayMode": "regular",
  "width": "100%",
  "height": "1000",
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String forexCrossRatesWidget() {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-forex-cross-rates.js" async>
  {
  "width": "100%",
  "height": "100%",
  "currencies": [
    "EUR",
    "USD",
    "JPY",
    "GBP"
  ],
  "isTransparent": false,
  "colorTheme": "light",
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String stockHeatmapWidget() {
    return '''
      <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-stock-heatmap.js" async>
  {
  "exchanges": [],
  "dataSource": "SENSEX",
  "grouping": "sector",
  "blockSize": "market_cap_basic",
  "blockColor": "change",
  "locale": "in",
  "symbolUrl": "",
  "colorTheme": "dark",
  "hasTopBar": true,
  "isDataSetEnabled": true,
  "isZoomEnabled": true,
  "hasSymbolTooltip": true,
  "width": "100%",
  "height": "100%"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String tickerTapeWidget() {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
  {
  "symbols": [
    {
      "description": "",
      "proName": "FOREXCOM:XAUUSD"
    },
    {
      "description": "",
      "proName": "NSE:BANKNIFTY"
    },
    {
      "description": "",
      "proName": "BINANCE:BTCUSD"
    },
    {
      "description": "",
      "proName": "NSE:NIFTY"
    },
    {
      "description": "",
      "proName": "NASDAQ:AAPL"
    },
    {
      "description": "",
      "proName": "NASDAQ:TSLA"
    },
    {
      "description": "",
      "proName": "NSE:TCS"
    }
  ],
  "showSymbolLogo": true,
  "colorTheme": "dark",
  "isTransparent": false,
  "displayMode": "compact",
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String marketOverviewWidget() {
    return '''
    
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-market-overview.js" async>
  {
  "colorTheme": "dark",
  "dateRange": "1D",
  "showChart": true,
  "locale": "in",
  "width": "100%",
  "height": "100%",
  "largeChartUrl": "",
  "isTransparent": true,
  "showSymbolLogo": true,
  "showFloatingTooltip": true,
  "plotLineColorGrowing": "rgba(41, 98, 255, 1)",
  "plotLineColorFalling": "rgba(41, 98, 255, 1)",
  "gridLineColor": "rgba(42, 46, 57, 0)",
  "scaleFontColor": "rgba(134, 137, 147, 1)",
  "belowLineFillColorGrowing": "rgba(41, 98, 255, 0.12)",
  "belowLineFillColorFalling": "rgba(41, 98, 255, 0.12)",
  "belowLineFillColorGrowingBottom": "rgba(41, 98, 255, 0)",
  "belowLineFillColorFallingBottom": "rgba(41, 98, 255, 0)",
  "symbolActiveColor": "rgba(41, 98, 255, 0.12)",
  "tabs": [
    {
      "title": "Indices",
      "symbols": [
        {
          "s": "FOREXCOM:SPXUSD",
          "d": "S&P 500"
        },
        {
          "s": "FOREXCOM:NSXUSD",
          "d": "US 100"
        },
        {
          "s": "FOREXCOM:DJI",
          "d": "Dow 30"
        },
        {
          "s": "INDEX:NKY",
          "d": "Nikkei 225"
        },
        {
          "s": "INDEX:DEU40",
          "d": "DAX Index"
        },
        {
          "s": "FOREXCOM:UKXGBP",
          "d": "UK 100"
        }
      ],
      "originalTitle": "Indices"
    },
    {
      "title": "Futures",
      "symbols": [
        {
          "s": "CME_MINI:ES1!",
          "d": "S&P 500"
        },
        {
          "s": "CME:6E1!",
          "d": "Euro"
        },
        {
          "s": "COMEX:GC1!",
          "d": "Gold"
        },
        {
          "s": "NYMEX:CL1!",
          "d": "Oil"
        },
        {
          "s": "NYMEX:NG1!",
          "d": "Gas"
        },
        {
          "s": "CBOT:ZC1!",
          "d": "Corn"
        }
      ],
      "originalTitle": "Futures"
    },
    {
      "title": "Bonds",
      "symbols": [
        {
          "s": "CME:GE1!",
          "d": "Eurodollar"
        },
        {
          "s": "CBOT:ZB1!",
          "d": "T-Bond"
        },
        {
          "s": "CBOT:UB1!",
          "d": "Ultra T-Bond"
        },
        {
          "s": "EUREX:FGBL1!",
          "d": "Euro Bund"
        },
        {
          "s": "EUREX:FBTP1!",
          "d": "Euro BTP"
        },
        {
          "s": "EUREX:FGBM1!",
          "d": "Euro BOBL"
        }
      ],
      "originalTitle": "Bonds"
    },
    {
      "title": "Forex",
      "symbols": [
        {
          "s": "FX:EURUSD",
          "d": "EUR to USD"
        },
        {
          "s": "FX:GBPUSD",
          "d": "GBP to USD"
        },
        {
          "s": "FX:USDJPY",
          "d": "USD to JPY"
        },
        {
          "s": "FX:USDCHF",
          "d": "USD to CHF"
        },
        {
          "s": "FX:AUDUSD",
          "d": "AUD to USD"
        },
        {
          "s": "FX:USDCAD",
          "d": "USD to CAD"
        }
      ],
      "originalTitle": "Forex"
    }
  ]
}
  </script>
</div>
<!-- TradingView Widget END -->
    
    ''';
  }

  static String marketDataWidget() {
    return '''
        <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-market-quotes.js" async>
  {
  "width": "100%",
  "height": "100%",
  "symbolsGroups": [
    {
      "name": "Indices",
      "originalName": "Indices",
      "symbols": [
        {
          "name": "FOREXCOM:SPXUSD",
          "displayName": "S&P 500"
        },
        {
          "name": "FOREXCOM:NSXUSD",
          "displayName": "US 100"
        },
        {
          "name": "FOREXCOM:DJI",
          "displayName": "Dow 30"
        },
        {
          "name": "INDEX:NKY",
          "displayName": "Nikkei 225"
        },
        {
          "name": "INDEX:DEU40",
          "displayName": "DAX Index"
        },
        {
          "name": "FOREXCOM:UKXGBP",
          "displayName": "UK 100"
        }
      ]
    },
    {
      "name": "Futures",
      "originalName": "Futures",
      "symbols": [
        {
          "name": "CME_MINI:ES1!",
          "displayName": "S&P 500"
        },
        {
          "name": "CME:6E1!",
          "displayName": "Euro"
        },
        {
          "name": "COMEX:GC1!",
          "displayName": "Gold"
        },
        {
          "name": "NYMEX:CL1!",
          "displayName": "Oil"
        },
        {
          "name": "NYMEX:NG1!",
          "displayName": "Gas"
        },
        {
          "name": "CBOT:ZC1!",
          "displayName": "Corn"
        }
      ]
    },
    {
      "name": "Bonds",
      "originalName": "Bonds",
      "symbols": [
        {
          "name": "CME:GE1!",
          "displayName": "Eurodollar"
        },
        {
          "name": "CBOT:ZB1!",
          "displayName": "T-Bond"
        },
        {
          "name": "CBOT:UB1!",
          "displayName": "Ultra T-Bond"
        },
        {
          "name": "EUREX:FGBL1!",
          "displayName": "Euro Bund"
        },
        {
          "name": "EUREX:FBTP1!",
          "displayName": "Euro BTP"
        },
        {
          "name": "EUREX:FGBM1!",
          "displayName": "Euro BOBL"
        }
      ]
    },
    {
      "name": "Forex",
      "originalName": "Forex",
      "symbols": [
        {
          "name": "FX:EURUSD",
          "displayName": "EUR to USD"
        },
        {
          "name": "FX:GBPUSD",
          "displayName": "GBP to USD"
        },
        {
          "name": "FX:USDJPY",
          "displayName": "USD to JPY"
        },
        {
          "name": "FX:USDCHF",
          "displayName": "USD to CHF"
        },
        {
          "name": "FX:AUDUSD",
          "displayName": "AUD to USD"
        },
        {
          "name": "FX:USDCAD",
          "displayName": "USD to CAD"
        }
      ]
    }
  ],
  "showSymbolLogo": true,
  "colorTheme": "light",
  "isTransparent": true,
  "locale": "in"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }

  static String economicCalendarWidget() {
    return '''
    <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-events.js" async>
  {
  "width": "100%",
  "height": "100%",
  "colorTheme": "dark",
  "isTransparent": true,
  "locale": "in",
  "importanceFilter": "0,1",
  "currencyFilter": "USD,EUR,ITL,NZD,CHF,AUD,FRF,JPY,ZAR,TRL,CAD,DEM,MXN,ESP,GBP"
}
  </script>
</div>
<!-- TradingView Widget END -->
    ''';
  }
}
