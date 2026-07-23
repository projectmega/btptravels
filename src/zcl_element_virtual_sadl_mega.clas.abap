CLASS zcl_element_virtual_sadl_mega DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* implement the interface permit calculate virtual element
    INTERFACES: if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_element_virtual_sadl_mega IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA lt_original_data TYPE STANDARD TABLE OF ztravel_c_mega WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      <fs_original_data>-PriceWithVat = <fs_original_data>-TotalPrice * '1.21'.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_original_data ).
    CLEAR: lt_original_data.
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    CASE iv_entity.
      WHEN 'ZTRAVEL_C_MEGA'."Name Entity Consumption
        LOOP AT it_requested_calc_elements INTO DATA(ls_calc_elem).
          IF ls_calc_elem = 'PRICEWITHVAT'.
            INSERT CONV #( 'TOTALPRICE' ) INTO TABLE et_requested_orig_elements.
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
