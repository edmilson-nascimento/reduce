report file.abap

data tl_itab type standard table of i.

tl_itab = value #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ).

data(lv_soma) = REDUCE i( INIT x = 0 for wa in tl_itab next x = x + wa ).

break-point .


types:
  begin of ty_sum,
    id  type char10,
    qtd type i,
  end of ty_sum,
  tab_sum type table of ty_sum.

*tab_sum type sorted table of ty_sum
*with non-unique sorted key key_id components id .

data:
  tab type tab_sum .


tab =
  value #(
  ( id = '01' qtd = 1 )
  ( id = '02' qtd = 3 )
  ( id = '02' qtd = 8 )
  ( id = '02' qtd = 4 )
  ( id = '01' qtd = 1 )
  ) .

data filter type sorted table of ty_sum-id
      with unique key table_line .

filter = value #( ( conv #( '01' ) ) ) .

data(soma) =
  reduce i(
    init x = 0
    for line in

*   filter #( tab using key id where id = 'LH ' )
   filter #( tab in filter where id = table_line  )

    next x = x + line-qtd
  ).

write:/ 'Soma:', soma .



*soma =
*  reduce i(
*    init x = 0
*    for line in tab
*    next x = x + line-qtd
*  ).
*



data: lt_flights_all  type standard table of spfli
      with NON-unique sorted key carrid
      COMPONENTS carrid,
      lt_flight_final type standard table of spfli.

select *  from spfli
into table @lt_flights_all.

* Create a filter internal table with multiple values
data filter_tab  type sorted table of scarr-carrid
      with unique key table_line.
filter_tab = value #( ( 'AA ' ) ( 'LH ' ) ).

* Apply filters
lt_flight_final = FILTER #( lt_flights_all in filter_tab
where carrid = table_line ).

cl_demo_output=>write_data( lt_flights_all ).
cl_demo_output=>write_data( lt_flight_final ).
cl_demo_output=>display( ).
