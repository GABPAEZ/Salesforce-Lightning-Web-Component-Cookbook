public with sharing class TransferAssetPresentation {
  @AuraEnabled(cacheable=true)
  public static String returnCountries() {
    return JSON.serialize(TransferAssetService.getComboboxCountries());
  }
  @AuraEnabled
  public static String returnCities(String countryName) {
    return JSON.serialize(TransferAssetService.getComboboxCities(countryName));
  }

  @AuraEnabled
  public static String returnAccounts(String cityNames) {
    return JSON.serialize(TransferAssetService.getAccountsWrapper(cityNames));
  }
  @AuraEnabled
  public static void setAssetWrapper(String assetId, String accountId) {
    TransferAssetService.transferWrap(
      new TransferAssetService.AssetWrapper(assetId, accountId)
    );
  }
}
