@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Book Supplement - Interface Entitiy'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_I_MEGA
  as projection on ZBKSPPL_R_MEGA
{
  key BooksupplUUID,
      TravelUUID,
      BookUUID,
      BookingSupplementID,
      SupplementID,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZBOOKING_I_MEGA,
      _product,
      _productTxt,
      _travel  : redirected to ZTRAVEL_I_MEGA
}
