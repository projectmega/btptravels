@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

@Search.searchable: true
@ObjectModel.semanticKey: [ 'BookingSupplementID' ]

define view entity ZBKSPPL_C_MEGA
  as projection on ZBKSPPL_R_MEGA
{
  key BooksupplUUID,
      TravelUUID,
      BookUUID,
      @Search.defaultSearchElement: true
      BookingSupplementID,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'SupplementDescription' ]
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Supplement_StdVH',
              element: 'SupplementID'
          },
          additionalBinding: [
              {
                  localElement: 'Price',
                  element: 'Price',
                  usage: #RESULT
              },
              {
                  localElement: 'CurrencyCode',
                  element: 'CurrencyCode',
                  usage: #RESULT
              }
          ],
          useForValidation: true
      }]
      SupplementID,
      _productTxt.Description as SupplementDescription:localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      @Consumption.valueHelpDefinition: [{
      entity: {
        name: 'I_CurrencyStdVH',
        element: 'Currency'
      },
      useForValidation: true
      }]
      CurrencyCode,
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZBOOKING_C_MEGA,
      _product,
      _productTxt,
      _travel  : redirected to ZTRAVEL_C_MEGA
}
