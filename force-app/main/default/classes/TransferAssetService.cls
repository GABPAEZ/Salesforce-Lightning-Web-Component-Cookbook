public with sharing class TransferAssetService {
  public static List<LocaleWrapper> getComboboxCountries() {
    List<LocaleWrapper> countries = new List<LocaleWrapper>();
    for (AggregateResult ar : TransferAssetPersistence.getCountries()) {
      countries.add(
        new LocaleWrapper(String.valueOf(ar.get('BillingCountry')))
      );
    }
    return countries;
  }
  public static List<LocaleWrapper> getComboboxCities(String countryName) {
    List<LocaleWrapper> cities = new List<LocaleWrapper>();
    for (AggregateResult ar : TransferAssetPersistence.getCities(countryName)) {
      cities.add(new LocaleWrapper(String.valueOf(ar.get('BillingCity'))));
    }
    return cities;
  }
  public static List<AccountWrapper> getAccountsWrapper(String selectedCity) {
    List<AccountWrapper> accounts = new List<AccountWrapper>();
    for (
      Account acc : TransferAssetPersistence.getAccountsByCity(selectedCity)
    ) {
      accounts.add(new AccountWrapper(acc));
    }
    return accounts;
  }

  public static void transferWrap(AssetWrapper wrap) {
    Asset ast = new Asset(Id = wrap.assetId, AccountId = wrap.accountId);
    TransferAssetPersistence.updateAsset(ast);
  }

  public class LocaleWrapper {
    @AuraEnabled
    public string label;
    @AuraEnabled
    public string value;
    public LocaleWrapper(String locale) {
      this.label = locale == null ? 'No Locale Specified' : locale;
      this.value = locale;
    }
  }
  public class AccountWrapper {
    @AuraEnabled
    public string accountId;
    @AuraEnabled
    public string accountName;
    @AuraEnabled
    public string accountCity;
    @AuraEnabled
    public string accountState;
    public AccountWrapper(Account acc) {
      this.accountId = acc.Id;
      this.accountName = acc.Name;
      this.accountCity = acc.BillingCity;
      this.accountState = acc.BillingState;
    }
  }
  //This one look a little different, as you are going to be accepting values from de LWC rather than passing values to LWC.
  public class AssetWrapper {
    public string assetId;
    public string accountId;
    public AssetWrapper(String assetId, String accountId) {
      this.assetId = assetId;
      this.accountId = accountId;
    }
  }
}
