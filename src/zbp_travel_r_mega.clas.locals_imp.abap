CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF travel_status,
        open     TYPE c LENGTH 1 VALUE 'O', "open
        accepted TYPE c LENGTH 1 VALUE 'A', "Accepted
        rejected TYPE c LENGTH 1 VALUE 'X', "Rejected
      END OF travel_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS AcceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~AcceptTravel RESULT result.

    METHODS deductDiscount FOR MODIFY
      IMPORTING keys FOR ACTION Travel~deductDiscount RESULT result.

    METHODS reCalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~reCalcTotalPrice.

    METHODS RejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~RejectTravel RESULT result.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION Travel~Resume.

    METHODS CalcularTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~CalcularTotalPrice.

    METHODS SetStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~SetStatusToOpen.

    METHODS SetTravelNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~SetTravelNumber.

    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.
    " EML - Entity Manipulation Language
* yo puedo leer las entidades en modo local sin necesidad de instanciar en el behavior implementation
* porque estan definidas en el bahaviour definition.
    READ ENTITIES OF ztravel_r_mega IN LOCAL MODE" va leer las entidades de ztravel_r_mega
    ENTITY travel "especificamente la entidad cuyo alias es travel
    FIELDS ( OverallStatus ) " se trae el campo del status
    WITH CORRESPONDING #( keys ) "la lectura se hace con universal unique identification UUID.
  RESULT DATA(travels). "el resultado se guarda en tabla interna travels

    result = VALUE #( FOR travel IN travels (
                                        %tky = travel-%tky
                                        %field-BookingFee = COND #(
                                          WHEN travel-OverallStatus = travel_status-accepted
                                              THEN if_abap_behv=>fc-f-read_only
                                          ELSE if_abap_behv=>fc-f-unrestricted
                                         )

                                        %action-AcceptTravel = COND #(
                                          WHEN travel-OverallStatus = travel_status-accepted
                                              THEN if_abap_behv=>fc-o-disabled
                                          ELSE if_abap_behv=>fc-o-enabled
                                         )

                                        %action-RejectTravel = COND #(
                                           WHEN travel-OverallStatus = travel_status-rejected
                                                THEN if_abap_behv=>fc-o-disabled
                                           ELSE if_abap_behv=>fc-o-enabled
                                          )

                                        %action-deductDiscount = COND #(
                                            WHEN travel-OverallStatus = travel_status-accepted
                                                THEN if_abap_behv=>fc-o-disabled
                                            ELSE if_abap_behv=>fc-o-enabled
                                           )

                                        %assoc-_Booking = COND #(
                                            WHEN travel-OverallStatus = travel_status-rejected
                                                THEN if_abap_behv=>fc-o-disabled
                                            ELSE if_abap_behv=>fc-o-enabled
                                           )
                                     ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD AcceptTravel.
    " EML
    MODIFY ENTITIES OF ztravel_r_mega IN LOCAL MODE
        ENTITY Travel
        UPDATE
        FIELDS ( OverallStatus )
        WITH VALUE #( FOR key IN keys (
            %tky = key-%tky
            OverallStatus = travel_status-accepted
        ) ).

    READ ENTITIES OF ztravel_r_mega IN LOCAL MODE
        ENTITY Travel
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels (
        %tky   = travel-%tky
        %param = travel
    ) ).
  ENDMETHOD.

  METHOD deductDiscount.
  ENDMETHOD.

  METHOD reCalcTotalPrice.
  ENDMETHOD.

  METHOD RejectTravel.
  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD CalcularTotalPrice.
  ENDMETHOD.

  METHOD SetStatusToOpen.
  ENDMETHOD.

  METHOD SetTravelNumber.
  ENDMETHOD.

  METHOD validateAgency.
  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

ENDCLASS.
