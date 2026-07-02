CLASS zcl_insertdata_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_insertdata_travel IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    out->write( 'Adding Travel Data' ).
    DELETE FROM zttravel_mega_a.

    INSERT zttravel_mega_a FROM (
    SELECT FROM /dmo/travel
    FIELDS
    "client,
    uuid( ) AS travel_uuid,
    travel_id,
    agency_id,
    customer_id,
    begin_date,
    end_date ,
    booking_fee,
    total_price,
    currency_code,
    description,
    case status when 'B' then 'A'
    when 'P' then 'O'
    when 'N' then 'A'
    ELSE 'X' END AS overall_status,
    createdby AS local_created_by,
    createdat AS local_created_at,
    lastchangedby AS local_last_changed_by,
    lastchangedat AS local_last_changed_at,
    lastchangedat AS last_changed_at

    ).


    out->write( 'Adding Booking Data' ).
    DELETE FROM ztbooking_mega_a.

    INSERT ztbooking_mega_a FROM (
    SELECT FROM /dmo/booking
     JOIN zttravel_mega_a ON /dmo/booking~travel_id = zttravel_mega_a~travel_id
     JOIN /dmo/travel ON /dmo/travel~travel_id = /dmo/booking~travel_id
    FIELDS
    "client,
    uuid( ) AS travel_uuid,
    zttravel_mega_a~travel_uuid AS parent_uuid,
    /dmo/booking~booking_id,
   /dmo/booking~booking_date,
    /dmo/booking~customer_id,
    /dmo/booking~carrier_id,
     /dmo/booking~connection_id,
     /dmo/booking~flight_date,
    /dmo/booking~flight_price,
    /dmo/booking~currency_code,
    CASE /dmo/travel~status when 'P' then 'N'
    ELSE /dmo/travel~status END AS booking_status,
     zttravel_mega_a~last_changed_at AS local_last_changed_at

    ).

 out->write( 'Adding Booking Supplements Data' ).
    DELETE FROM ztbksppl_mega_a.

    INSERT ztbksppl_mega_a FROM (
    SELECT FROM /dmo/book_suppl as supp
     JOIN zttravel_mega_a as trvl ON trvl~travel_id = supp~travel_id
     JOIN ztbooking_mega_a as book ON book~parent_uuid = trvl~travel_uuid and
           book~booking_id = supp~booking_id
    FIELDS
    "client,
    uuid( ) AS booksuppl_uuid,
    trvl~travel_uuid AS root_uuid,
    book~booking_uuid as parent_uuid,
   supp~booking_supplement_id,
   supp~supplement_id,
    supp~price,
     supp~currency_code,
    trvl~last_changed_at as local_last_changed_at

    ).

  ENDMETHOD.

ENDCLASS.
