@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZBOOKING_C_MEGA
  as projection on ZBOOKING_R_MEGA
{
  key BookingUUID,
      TravelUUID,
      BookingID,
      BookingDate,
      CustomerID,
      CarrierID,
      ConnectionID,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LocalLastChangedAt,
      /* Associations */
      _Bksppl:redirected to composition child ZBKSPPL_C_MEGA,
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel:redirected to parent ZTRAVEL_C_MEGA
}
