@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZBKSPPL_C_MEGA
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
      _Booking:redirected to parent ZBOOKING_C_MEGA,
      _product,
      _productTxt,
      _travel:redirected to ZTRAVEL_C_MEGA
}
