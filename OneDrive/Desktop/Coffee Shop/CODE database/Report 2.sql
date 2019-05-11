/*part 1*/

CREATE OR REPLACE FUNCTION num_purch_sf --creating a function

   (p_shopper_ID IN number)

 RETURN number

 IS

   lv_count NUMBER(10);

BEGIN

   SELECT COUNT(IDBASKET)

   INTO lv_count

   FROM bb_basket

   WHERE orderplaced = 1;

   RETURN (lv_count);

END;




/*part 2*/

select NUM_PURCH_SF(23)

from bb_shopper

where idshopper=23;

