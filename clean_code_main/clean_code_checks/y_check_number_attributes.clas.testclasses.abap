CLASS ltd_clean_code_manager DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: y_if_clean_code_manager.
ENDCLASS.

CLASS ltd_clean_code_manager IMPLEMENTATION.

  METHOD y_if_clean_code_manager~read_check_customizing.
    result = VALUE #( ( apply_on_testcode = abap_true apply_on_productive_code = abap_true prio = 'N' threshold = 2 )
                      ( apply_on_testcode = abap_true apply_on_productive_code = abap_true prio = 'E' threshold = 2 ) ).
  ENDMETHOD.

  METHOD y_if_clean_code_manager~calculate_obj_creation_date.
    result = '20190101'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ref_scan_manager DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: y_if_scan_manager PARTIALLY IMPLEMENTED.

    METHODS:
      set_data_for_ok,
      set_data_for_error,
      set_pseudo_comment_ok.

  PRIVATE SECTION.
    DATA:
      levels     TYPE slevel_tab,
      structures TYPE sstruc_tab,
      statements TYPE sstmnt_tab,
      tokens     TYPE stokesx_tab.
ENDCLASS.

CLASS ltd_ref_scan_manager IMPLEMENTATION.
  METHOD y_if_scan_manager~get_structures.
    result = structures.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_statements.
    result = statements.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_tokens.
    result = tokens.
  ENDMETHOD.

  METHOD y_if_scan_manager~get_levels.
    result = levels.
  ENDMETHOD.

  METHOD y_if_scan_manager~set_ref_scan.
    RETURN.                                       "empty for test case
  ENDMETHOD.

  METHOD y_if_scan_manager~is_scan_ok.
    result = abap_true.
  ENDMETHOD.

  METHOD set_data_for_ok.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 5 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 5 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-class_definition ) ).

    statements = VALUE #( ( level = 1 from = '1'  to = '3'  type = 'K' )
                          ( level = 1 from = '4'  to = '7'  type = 'K' )
                          ( level = 1 from = '8'  to = '11' type = 'K' )
                          ( level = 1 from = '12' to = '15' type = 'K' )
                          ( level = 1 from = '16' to = '19' type = 'K' ) ).

    tokens = VALUE #( ( str = 'DATA'    type = 'I' row = 1 )
                      ( str = 'A1'      type = 'I' row = 1 )
                      ( str = 'TYPE'    type = 'I' row = 1 )
                      ( str = 'TYPE'    type = 'I' row = 2 )
                      ( str = 'BEGIN'   type = 'I' row = 2 )
                      ( str = 'OF'      type = 'I' row = 2 )
                      ( str = 'struct1' type = 'I' row = 2 )
                      ( str = 'DATA'    type = 'I' row = 3 )
                      ( str = 'dta1'    type = 'I' row = 3 )
                      ( str = 'TYPE'    type = 'I' row = 3 )
                      ( str = 'c'       type = 'I' row = 3 )
                      ( str = 'DATA'    type = 'I' row = 4 )
                      ( str = 'dta1'    type = 'I' row = 4 )
                      ( str = 'TYPE'    type = 'I' row = 4 )
                      ( str = 'c'       type = 'I' row = 4 )
                      ( str = 'TYPE'    type = 'I' row = 5 )
                      ( str = 'END'     type = 'I' row = 5 )
                      ( str = 'OF'      type = 'I' row = 5 )
                      ( str = 'struct1' type = 'I' row = 5 ) ).
  ENDMETHOD.

  METHOD set_data_for_error.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 3 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 3 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-class_definition ) ).

    statements = VALUE #( ( level = 1 from = '1' to = '2' type = 'K' )
                          ( level = 1 from = '3' to = '4' type = 'K' )
                          ( level = 1 from = '5' to = '6' type = 'K' ) ).

    tokens = VALUE #( ( str = 'DATA'       type = 'I' row = 1 )
                      ( str = 'A1'         type = 'I' row = 1 )
                      ( str = 'CLASS-DATA' type = 'I' row = 2 )
                      ( str = 'A2'         type = 'I' row = 2 )
                      ( str = 'CLASS-DATA' type = 'I' row = 3 )
                      ( str = 'A3'         type = 'I' row = 3 ) ).
  ENDMETHOD.

  METHOD set_pseudo_comment_ok.
    levels = VALUE #( ( depth = 1 level = 0 stmnt = 0 from = 1 to = 6 name = 'ZTEST' type = 'P' ) ).

    structures = VALUE #( ( stmnt_from = 1 stmnt_to = 6 type = scan_struc_type-class stmnt_type = scan_struc_stmnt_type-class_definition ) ).

    statements = VALUE #( ( level = 1 from = '1' to = '2' type = 'K' )
                          ( level = 1 from = '3' to = '3' type = 'P' )
                          ( level = 1 from = '4' to = '5' type = 'K' )
                          ( level = 1 from = '6' to = '7' type = 'K' )
                          ( level = 1 from = '8' to = '9' type = 'K' )
                          ( level = 1 from = '10' to = '10' type = 'K' ) ).

    tokens = VALUE #( ( str = 'CLASS'            type = 'I' row = 1 )
                      ( str = 'LTC_TEST_TEST'    type = 'I' row = 1 )
                      ( str = '"#EC NUMBER_ATTR' type = 'C' row = 1 )
                      ( str = 'DATA'             type = 'I' row = 2 )
                      ( str = 'A1'               type = 'I' row = 2 )
                      ( str = 'CLASS-DATA'       type = 'I' row = 3 )
                      ( str = 'A2'               type = 'I' row = 3 )
                      ( str = 'CLASS-DATA'       type = 'I' row = 4 )
                      ( str = 'A3'               type = 'I' row = 4 )
                      ( str = 'ENDCLASS'         type = 'I' row = 5 ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_clean_code_exemption_no DEFINITION FOR TESTING
  INHERITING FROM y_exemption_handler.

  PUBLIC SECTION.
    METHODS: is_object_exempted REDEFINITION.
ENDCLASS.

CLASS ltd_clean_code_exemption_no IMPLEMENTATION.
  METHOD is_object_exempted.
    RETURN.
  ENDMETHOD.
ENDCLASS.

CLASS local_test_class DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA: cut                     TYPE REF TO y_check_number_attributes,
          ref_scan_manager_double TYPE REF TO ltd_ref_scan_manager.

    METHODS:
      setup,
      assert_errors IMPORTING err_cnt TYPE i,
      assert_pseudo_comments IMPORTING pc_cnt TYPE i,
      is_bound FOR TESTING,
      cut_ok FOR TESTING,
      cut_error FOR TESTING,
      pseudo_comment_ok FOR TESTING.
ENDCLASS.

CLASS y_check_number_attributes DEFINITION LOCAL FRIENDS local_test_class.

CLASS local_test_class IMPLEMENTATION.
  METHOD setup.
    cut = NEW y_check_number_attributes( ).
    ref_scan_manager_double = NEW ltd_ref_scan_manager( ).
    cut->ref_scan_manager ?= ref_scan_manager_double.
    cut->clean_code_manager = NEW ltd_clean_code_manager( ).
    cut->clean_code_exemption_handler = NEW ltd_clean_code_exemption_no( ).
    cut->attributes_maintained = abap_true.
  ENDMETHOD.

  METHOD is_bound.
    cl_abap_unit_assert=>assert_bound(
      EXPORTING
        act = cut ).
  ENDMETHOD.

  METHOD cut_ok.
    ref_scan_manager_double->set_data_for_ok( ).
    cut->run( ).
    assert_errors( 0 ).
    assert_pseudo_comments( 0 ).
  ENDMETHOD.

  METHOD cut_error.
    ref_scan_manager_double->set_data_for_error( ).
    cut->run( ).
    assert_errors( 1 ).
    assert_pseudo_comments( 0 ).
  ENDMETHOD.

  METHOD pseudo_comment_ok.
    ref_scan_manager_double->set_pseudo_comment_ok( ).
    cut->run( ).
    assert_errors( 0 ).
    assert_pseudo_comments( 1 ).
  ENDMETHOD.

  METHOD assert_errors.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = cut->statistics->get_number_errors( )
        exp = err_cnt ).
  ENDMETHOD.

  METHOD assert_pseudo_comments.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = cut->statistics->get_number_pseudo_comments( )
        exp = pc_cnt ).
  ENDMETHOD.
ENDCLASS.
