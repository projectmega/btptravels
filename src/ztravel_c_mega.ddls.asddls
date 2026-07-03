@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZTRAVEL_C_MEGA
  provider contract transactional_query
  as projection on ZTRAVEL_R_MEGA
{
  key TravelUUID,
      TravelID,
      AgencyID,
      CustumerID,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking: redirected to composition child ZBOOKING_C_MEGA,
      _Currency,
      _Customer,
      _OverallStatus
}
