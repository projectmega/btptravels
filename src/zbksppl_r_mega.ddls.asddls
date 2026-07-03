@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Root Entitiy'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBKSPPL_R_MEGA
  as select from ztbksppl_mega_a
  association        to parent ZBOOKING_R_MEGA as _Booking    on $projection.BookUUID = _Booking.BookingUUID
  association [1..1] to ZTRAVEL_R_MEGA         as _travel     on $projection.TravelUUID = _travel.TravelUUID

  association [1..1] to /DMO/I_Supplement      as _product    on $projection.BookingSupplementID = _product.SupplementID
  association [1..*] to /DMO/I_SupplementText  as _productTxt on $projection.SupplementID = _productTxt.SupplementID

{
  key booksuppl_uuid        as BooksupplUUID,
      root_uuid             as TravelUUID,
      parent_uuid           as BookUUID,
      booking_supplement_id as BookingSupplementID,
      supplement_id         as SupplementID,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,

      //Local Etag Field  -->  OData Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      _Booking,
      _travel,
      _product,
      _productTxt
}
