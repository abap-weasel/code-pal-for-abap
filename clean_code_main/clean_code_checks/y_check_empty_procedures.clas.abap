CLASS y_check_empty_procedures DEFINITION
  PUBLIC
  INHERITING FROM y_check_base
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS c_myname TYPE sci_chk VALUE 'Y_CHECK_EMPTY_PROCEDURES' ##NO_TEXT.

    METHODS constructor .
  PROTECTED SECTION.

    METHODS inspect_tokens REDEFINITION .
  PRIVATE SECTION.

    METHODS get_next_token_from_index
      IMPORTING index         TYPE i
      RETURNING VALUE(result) TYPE stokesx.

    METHODS has_found_start_procedure
      IMPORTING statement     TYPE sstmnt
      RETURNING VALUE(result) TYPE abap_bool.

    METHODS is_next_statement_end_proc
      IMPORTING statement     TYPE sstmnt
      RETURNING VALUE(result) TYPE abap_bool.
ENDCLASS.



CLASS Y_CHECK_EMPTY_PROCEDURES IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    description = 'Empty Procedure'(001).
    category    = 'Y_CHECK_CATEGORY'.
    version     = '0000'.
    position    = '300'.
    has_documentation = abap_true.

    settings-pseudo_comment = '"#EC EMPTY_PROCEDURE' ##NO_TEXT.
    settings-disable_threshold_selection = abap_true.
    settings-threshold = 0.
    settings-prio = 'W'.
    settings-documentation = |{ c_docs_path-checks }empty-procedure.md|.

    y_message_registration=>add_message(
      EXPORTING
        check_name     = me->myname
        text           = '[Clean Code]: Empty Procedure should be removed!'(102)
        pseudo_comment = settings-pseudo_comment
      CHANGING
        messages       = me->scimessages ).
  ENDMETHOD.


  METHOD get_next_token_from_index.
    LOOP AT ref_scan_manager->get_tokens( ) ASSIGNING FIELD-SYMBOL(<token>)
      FROM index WHERE type EQ 'I'.
      IF result IS INITIAL.
        result = <token>.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD has_found_start_procedure.
    result = abap_false.
    CASE get_next_token_from_index( statement-from )-str.
      WHEN 'FORM' OR
           'METHOD' OR
           'MODULE'.
        result = abap_true.
    ENDCASE.
  ENDMETHOD.


  METHOD inspect_tokens.
    CHECK has_found_start_procedure( statement ) = abap_true AND
          is_next_statement_end_proc( statement ) = abap_true.

    statement_for_message = statement.

    DATA(check_configuration) = detect_check_configuration( threshold = 0
                                                            include = get_include( p_level = statement_for_message-level ) ).

    IF check_configuration IS INITIAL.
      RETURN.
    ENDIF.

    raise_error( p_sub_obj_type = c_type_include
                 p_level        = statement_for_message-level
                 p_position     = index + 1
                 p_from         = statement_for_message-to
                 p_kind         = check_configuration-prio
                 p_test         = me->myname
                 p_code         = get_code( check_configuration-prio ) ).
  ENDMETHOD.


  METHOD is_next_statement_end_proc.
    result = abap_false.
    CASE get_next_token_from_index( statement-to + 1 )-str.
      WHEN 'ENDFORM' OR
           'ENDMETHOD' OR
           'ENDMODULE'.
        result = abap_true.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
