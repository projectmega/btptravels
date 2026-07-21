@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

@Search.searchable: true
@ObjectModel.semanticKey: [ 'BookingID' ]

define view entity ZBOOKING_C_MEGA
  as projection on ZBOOKING_R_MEGA
{
  key BookingUUID,
      TravelUUID,
      @Search.defaultSearchElement: true
      BookingID,
      BookingDate,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Customer_StdVH',
              element: 'CustomerID'
          },
          useForValidation: true
      }]
      CustomerID,
      _Customer.LastName        as CustomerName,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['CarrierName']
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Flight_StdVH',
              element: 'AirlineID'
          },
          additionalBinding: [
              {
                  localElement: 'ConnectionID',
                  element: 'ConnectionID',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightDate',
                  element: 'FlightDate',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightPrice',
                  element: 'Price',
                  usage: #RESULT
              },
              {
                  localElement: 'CurrencyCode',
                  element: 'CurrencyCode',
                  usage: #RESULT
              }
          ]
      }]
      CarrierID,
      _Carrier.Name             as CarrierName,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Flight_StdVH',
              element: 'ConnectionID'
          },
          additionalBinding: [
              {
                  localElement: 'CarrierID',
                  element: 'CarrierID',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightDate',
                  element: 'FlightDate',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightPrice',
                  element: 'Price',
                  usage: #RESULT
              },
              {
                  localElement: 'CurrencyCode',
                  element: 'CurrencyCode',
                  usage: #RESULT
              }
          ]
      }]
      ConnectionID,
      @Consumption.valueHelpDefinition: [{
         entity: {
             name: '/DMO/I_Flight_StdVH',
             element: 'FlightDate'
         },
         additionalBinding: [
             {
                 localElement: 'CarrierID',
                 element: 'CarrierID',
                 usage: #RESULT
             },
             {
                 localElement: 'ConnectionID',
                 element: 'ConnectionID',
                 usage: #RESULT
             },
             {
                 localElement: 'FlightDate',
                 element: 'FlightDate',
                 usage: #RESULT
             },
             {
                 localElement: 'FlightPrice',
                 element: 'Price',
                 usage: #RESULT
             },
             {
                 localElement: 'CurrencyCode',
                 element: 'CurrencyCode',
                 usage: #RESULT
             }
         ]
      }]
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Flight_StdVH',
              element: 'Price'
          },
          additionalBinding: [
              {
                  localElement: 'CarrierID',
                  element: 'CarrierID',
                  usage: #RESULT
              },
              {
                  localElement: 'ConnectionID',
                  element: 'ConnectionID',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightDate',
                  element: 'FlightDate',
                  usage: #RESULT
              },
              {
                  localElement: 'FlightPrice',
                  element: 'Price',
                  usage: #RESULT
              },
              {
                  localElement: 'CurrencyCode',
                  element: 'CurrencyCode',
                  usage: #RESULT
              }
          ]
      }]
      FlightPrice,
      @Consumption.valueHelpDefinition: [{
      entity: {
        name: 'I_CurrencyStdVH',
        element: 'Currency'
      },
      useForValidation: true
      }]
      CurrencyCode,
      @ObjectModel.text.element: ['BookingStatusText']
      @Consumption.valueHelpDefinition: [{
          entity: {
              name: '/DMO/I_Booking_Status_VH',
              element: 'BookingStatus'
          },
          useForValidation: true
      }]
      BookingStatus,
      _BookingStatus._Text.Text as BookingStatusText : localized,
      LocalLastChangedAt,
      /* Associations */
      _Bksppl : redirected to composition child ZBKSPPL_C_MEGA,
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent ZTRAVEL_C_MEGA
}
