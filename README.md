# GojekAssignment
This app use GitHub Trending API 

• App app preferably support the minimum iOS 11.
• App app fetch the trending repositories from the provided by Github public API and display it to the users.
• While the data is being fetched, app show a loading state.
• If the app is not able to fetch the data, then it should show an Alert state to the user with an option to retry again and for networ error show no network screen
• Tapping any item will show DetailsView.r
•  App have 100% offline support. Once the data is fetched successfully from remote, it should be stored locally in core data and served from the cache until the cache expires.
• The cached data is only valid for a duration of 2 hours. After that,  app should attempt to refresh the data from remote and purge the cache only after successful data fetch
• App have pull-to-refresh option to the user to force fetch data from remote.
• App based on MVVM design Pattern.
• Genric code for service manager
• App follows granular, meaningful Git commit history.
• App has abstraction for Dependency Injection
• App has unit and UI test coverage.
