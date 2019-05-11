CREATE OR REPLACE FUNCTION STATUS_DESC_SF (
    P_STAGE_ID IN bb_basketstatus.IDSTAGE%type)
    RETURN VARCHAR2 AS 
  lv_status_desc varchar2(100);

BEGIN
  lv_status_desc :=  
       CASE WHEN P_STAGE_ID = 1 THEN 'Order submitted'
            WHEN P_STAGE_ID = 2 THEN 'Accepted, sent to shipping'
            WHEN P_STAGE_ID = 3 THEN 'Back-ordered'
            WHEN P_STAGE_ID = 4 THEN 'Cancelled'
			WHEN P_STAGE_ID = 5 THEN 'Shipped'
            ELSE 'Shipped' END;

  return lv_status_desc;
end;