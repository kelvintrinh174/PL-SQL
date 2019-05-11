create or replace FUNCTION ck_sale_sf(p_id IN NUMBER, p_date IN DATE)
  RETURN varchar2
  IS
lv_start_dat BB_PRODUCT.salestart%TYPE;
lv_end_dat   BB_PRODUCT.saleend%TYPE;
lv_msg_txt  varchar2(15);

BEGIN

  SELECT salestart, saleend
    INTO lv_start_dat, lv_end_dat
    FROM bb_product
    WHERE idProduct = p_id;

  IF p_date between lv_start_dat AND lv_end_dat THEN
        lv_msg_txt  := 'ON SALE!';
  ELSE
        lv_msg_txt  := 'Great Deal!';
  END IF;

  RETURN lv_msg_txt;
END ck_sale_sf;
/
DECLARE
  lv_msg_txt VARCHAR2(15);
BEGIN
  lv_msg_txt := ck_sale_sf(6,'12-06-08');-- date format YY-MM-DD
  DBMS_OUTPUT.PUT_LINE(lv_msg_txt);
END;
/
DECLARE
  lv_msg_txt VARCHAR2(15);
BEGIN
  lv_msg_txt := ck_sale_sf(6,'12-JUN-12');
  DBMS_OUTPUT.PUT_LINE(lv_msg_txt);
END;
/
DECLARE
  lv_msg_txt VARCHAR2(15);
BEGIN
  lv_msg_txt := ck_sale_sf(1,'12-JUL-29');
  DBMS_OUTPUT.PUT_LINE(lv_msg_txt);
END;




